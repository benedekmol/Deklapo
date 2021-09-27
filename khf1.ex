defmodule Khf1 do

  @moduledoc """
  101 kiskutya
  @author "Molnár Benedek molnar.benedek.mate@gmail.com"
  @date   "2021-09-22"
  ...
  """

  @doc """
  sit! függvény kiszámítja a lehetséges ülésrendeket. Vár egy számot paraméterként, majd minden 1-től k-ig tartó számra megnézi hogy a az 1-től k-ig tartó különbséggel
  a check függvény első értéke "true" lesz-e. Ha "true" akkor azt elmenti egy listresult változóba. Elmenti a lista méretét egy numberofvariants változóba.
  Majd a listresult még nincs jó formában mert a sorok száma szerint csoportosítani kell a jó ülésrendeket. Minden listaelem első értéke a variáció sor száma.
  E szerint csoportítom az Enum.group függvénnyel és elmentem a tail részét a listaelemeknek.
  Végül a map-ból minden elemet megformázok ahogy a kimenet elvárja. A variánsok listáját egyesítem és a numberofvariantsot a tuple elejére írom.
  """
  @type variant :: { h :: integer, d :: integer }  ##utolsó sor db, sorok közötti diff
  @type seatings :: { n :: integer, vs :: [ variant ] }  ## hány soros az ülés, variáns
  @spec sit!( k :: integer ) :: r :: { m :: integer, ss :: [ seatings ] }
  # k kiskutya m-féleképpen ülhet úgy n>2 sorban, hogy a leghátsó sorban
  # h kiskutya ül, a számuk pedig soronként pontosan d-vel növekszik
  def sit!(k) do
    checkresult = for start <- 1..k, diff <- 1..k do
      check(k,start,diff) ++ [{start, diff}]
    end
    listresult = for result <- checkresult, hd(result) do
      tl(result)
    end
    numberofvariants = length(listresult)
    mapped = listresult
    |> Enum.group_by(fn [x, _] -> x end, &Kernel.tl/1)
    result = for eqrow <- mapped  do
      { elem(eqrow,0), mergelist(elem(eqrow,1)) }
    end
    {numberofvariants, result}
  end

  @doc """
  A check függvény kiszámítja, hogy az adott utolsó sor mérettel és az adott sorok közti különbséggel megfelelő-e az ülésrend.
  Paraméternek vár egy k számot ami a kutyák száma, egy kezdőértéket, egy sorok közti különbséget. Ebből akkumulátorokkal kiszámolja, hogy a megadott
  összeállítás helyes-e.
  """
  @spec check(k::integer, start::integer, sub::integer, sub_base::integer, iteratedtimes::integer) :: any()
  defp check(k, _start, _sub, _sub_base, _iteratedtimes) when k < 0 do
    [false, -1]
  end
  defp check(0,_start,_sub, _sub_base,iteratedtimes) do
    if iteratedtimes > 2 do
      [true, iteratedtimes]
    else
      [false, -1]
    end
  end
  defp check(k, start, subbing, sub_base, 0) do
    check(k - start, start, subbing + start, sub_base, 1)
  end
  defp check(k, start, subbing, sub_base, iteratedtimes) do
    check(k - subbing, start, subbing + sub_base, sub_base, iteratedtimes + 1 )
  end

  @spec check(k::integer, start::integer, sub::integer) :: any()
  defp check(k, start, sub) do
    check(k, start, sub, sub, 0)
  end

  @doc """
  A mergelist segédfüggvény lista a listában egyesítésre. Paraméternek vár egy listát és visszaadja annak belső listáinak az egyesítését.
  """
  @spec mergelist(inpput::list,acc::list, length::integer):: output::list
  defp mergelist(_input, acc, 0) do
    acc
  end
  defp mergelist(input,acc,  k) do
    i = []
    output = for elem <- Enum.at(input,k-1) do
      i ++ elem
    end
    mergelist(input, output ++ acc, k-1)
  end

  @spec mergelist(input::list):: output::list
  defp mergelist(input) do
    mergelist(input,[],length(input))
  end


  @doc """
  A good_flocks függvény kiszámítja a lehetséges ülésrendeket a 2-től kmax értékig. Úgy, hogy minden 2-től kmax értékig meghívja
  a sit! függvényt és ha a kimenete nem {0, []} akkor azokat az értékeket visszaadja egy listában.
  """
  @spec good_flocks( kmax :: integer ) :: ks :: [k :: integer]
  # A ks lista elemei azoknak a kutyafalkáknak a k számossága
  # (2 < k <= kmax), amelyek a feladatban megadott feltételekkel
  # leültethetők a képernyő elé
  def good_flocks(kmax) do
    for k <- 2..kmax, sit!(k) != {0, []} do
      k
    end
  end
end

# r1 = IO.inspect(Khf1.sit! 101)       === {0, []}
# r2 = IO.inspect(Khf1.sit! 15)        === {5, [{3, [{1, 4}, {2, 3}, {3, 2}, {4, 1}]}, {5, [{1, 1}]}]}
# r3 = IO.inspect(Khf1.sit! 14)        === {1, [{4, [{2, 1}]}]}
# r4 = IO.inspect(Khf1.sit! 10)        === {1, [{4, [{1, 1}]}]}
# r5 = IO.inspect(Khf1.sit! 9)         === {2, [{3, [{1, 2}, {2, 1}]}]}
# r6 = IO.inspect(Khf1.sit! 5)         === {0, []}
# r7 = IO.inspect(Khf1.good_flocks 20) === [6, 9, 10, 12, 14, 15, 16, 18, 20]

# IO.puts "#{r1}, #{r2}, #{r3}, #{r4}, #{r5}, #{r6}"
# IO.puts "#{r7}"
