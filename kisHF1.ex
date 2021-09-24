defmodule Khf1 do

  @moduledoc """
  101 kiskutya
  @author "Egyetemi HallgatĂł <egy.hallg@dp.vik.bme.hu>"
  @date   "2021-09-22"
  ...
  """

  @doc """
  ...
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

  @spec mergelist(inpput::list,acc::list, length::integer):: output::list
  defp mergelist(_input, acc, 0) do
    acc
  end
  defp mergelist(input,acc,  k) do
    i = []
    output = for elem <- Enum.at(input,k-1) do
      i ++ elem
    end
    mergelist(input,acc ++ output, k-1)
  end
  @spec mergelist(input::list):: output::list
  defp mergelist(input) do
    mergelist(input,[],length(input))
  end


  @doc """
  ...
  """
  @spec good_flocks( kmax :: integer ) :: ks :: [k :: integer]
  # A ks lista elemei azoknak a kutyafalkáknak a k számossága
  # (2 < k <= kmax), amelyek a feladatban megadott feltételekkel
  # leültethetők a képernyő elé
  def good_flocks(kmax) do
    IO.puts "nothing"
  end
end

# IO.inspect Khf1.sit!(15)
