

# IO.puts("reminder: " <> to_string(rem(15,4)))
# IO.puts("divided: " <> to_string(div(15,4)))



# IO.puts("reminder: " <> to_string(rem(14,1)))
# IO.puts("divided: " <> to_string(div(14,1)))

# def iterate(k::integer, i::integer, diff::integer, tmp::integer) do
#   ## if tmp >= k
#   iterate(k, i, tmp+diff)
# end

defmodule Kaki do
  # @spec timer(f::Function, ps::integer) :: t::String
  # def timer(f, ps) do
  #   :erlang.garbage_collect() # collect garbage now not during measurement
  #   {t, _} = :timer.tc(f, ps) # get measured runtime, ignore result
  #   "#{round t/1000} ms" # show runtime in millisecs
  # end



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
    # if iteratedtimes > 2 do
    #   {iteratedtimes, start, sub_base}
    #   start
    #   # IO.puts "rowcount: " <> to_string(iteratedtimes)
    # end
  end
  defp check(k, start, subbing, sub_base, 0) do
    check(k - start, start, subbing + start, sub_base, 1)
  end
  defp check(k, start, subbing, sub_base, iteratedtimes) do
    check(k - subbing, start, subbing + sub_base, sub_base, iteratedtimes + 1 )
  end

  @spec check(k::integer, start::integer, sub::integer) :: any()
  def check(k, start, sub) do
    check(k, start, sub, sub, 0)
  end

  # @spec startiter(k::integer, start::integer, sub::integer) :: any()
  # defp startiter(k, start, sub) when start >= k do
  #   :ok
  # end
  # defp startiter(k, start, sub) do
  #   check(k,start,sub)
  #   startiter(k, start + 1, sub)
  # end
  # @spec startiter(k::integer, sub::integer) :: any()
  # def startiter(k, sub) do
  #   startiter(k, 1, sub)
  # end

  # @spec diffiter(k::integer, sub::integer) ::any()
  # def diffiter(k, sub) when sub > k do
  #   :ok
  # end
  # def diffiter(k, sub) do
  #   startiter(k, sub)
  #   diffiter(k, sub + 1)
  # end
  # @spec diffiter(k::integer) :: any()
  # def diffiter(k) do
  #   diffiter(k, 1)
  # end

  # @type variant :: { h :: integer, d :: integer }  ##utolsó sor db, sorok közötti diff
  # @type seatings :: { n :: integer, vs :: [ variant ] }  ## hány soros az ülés, variáns
  # @spec sit!( k :: integer ) :: r :: { m :: integer, ss :: [ seatings ] }
  # def sit!(k) do

  # end

  # @spec chekker(k::integer, start::integer, diff::integer) :: any()


  @spec asdf(k::integer) :: any()
  def asdf(k) do
    # for start <- 1..k, diff <- 1..k, check(k,start,diff) do
    checkresult = for start <- 1..k, diff <- 1..k do
      # {start, diff, check(k,start,diff)}
      # Map.merge(%{startpoint: start, rowdiff: diff },check(k,start,diff))
      check(k,start,diff) ++ [{start, diff}]
    end
    listresult = for result <- checkresult, hd(result) do
      tl(result)
    end
    numberofvariants = length(listresult)
    # :lists.usort(listresult)
    # listresult
    mapped = listresult
    |> Enum.group_by(fn [x, _] -> x end, &Kernel.tl/1)
    # |> Enum.reduce(%{}, &Kernel.tl/1)
    # |> Enum.map(fn [x, y] -> {y} end)
    # mergelist(elem(Enum.at(mapped, 0),1)) ### variánsok
    # elem(Enum.at(mapped,0),0) ### sorok száma
    result = for eqrow <- mapped  do
      { elem(eqrow,0), mergelist(elem(eqrow,1)) }
    end
    {numberofvariants, result}
  end

  @spec mergelist(inpput::list,acc::list, length::integer):: output::list
  def mergelist(_input, acc, 0) do
    acc
  end
  def mergelist(input,acc,  k) do
    i = []
    output = for elem <- Enum.at(input,k-1) do
      i ++ elem
    end
    mergelist(input,acc ++ output, k-1)
  end
  @spec mergelist(input::list):: output::list
  def mergelist(input) do
    mergelist(input,[],length(input))
  end

  # @spec test(k::integer, x::integer):: any()
  # def test(k,x) do
  #   x = k
  # end

end

# defmodule EnumHelpers do

#   defp group_one({key, val}, categories) do
#     Dict.update(categories, key, [val], &[val|&1])
#   end

#   def map_col_fast(coll) do
#     Enum.reduce(coll, %{}, &group_one/2)
#   end
# end

# IO.inspect EnumHelpers.map_col_fast([a: 2, a: 3, b: 3])


# Kaki.check(9,1,2,2,0)
# Kaki.check(9,1,2)
# Kaki.kaki("aéslkdjfaésdlkjf")
# Kaki.startiter(9,2)
# Kaki.startiter(15,4)

# IO.inspect Kaki.diffiter(15)
IO.inspect Kaki.asdf(5)

# IO.inspect is_truthy(1)

# IO.inspect Kaki.test(3,x)
