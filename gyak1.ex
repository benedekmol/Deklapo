defmodule Gyak1 do
  @spec print( a::String ) :: b::String
  def print(a) do
    IO.puts a
  end

  @spec lnko(a :: integer, b :: integer) :: d :: integer
  # a és b legnagyobb közös osztója d
  def lnko(a,0) do
    a
  end
  def lnko(a,b) do
    lnko(b,rem(a,b))
  end

  ##----------------------------------------------------------- 1.
  @spec len(xs :: [any]) :: n :: integer
  # Az xs lista hossza n
  def len([]) do
    0
  end
  def len(x) do
    len(tl(x)) + 1
  end


  ##---------------------------------------------------------- 2.
  @spec leni(xs :: [any]) :: n :: integer
  # Az xs lista hossza n
  @spec leni(xs :: [any], acc :: integer) :: n :: integer
  # az xs lista hossza + acc = n
  def leni(xs) do
    leni(xs, 0)
  end
  defp leni([] , acc) do
    acc
  end
  defp leni(xs, acc ) do
    leni(tl(xs), acc + 1)
  end

  ##--------------------------------------------------------- 3.
  @spec pi(i :: integer) :: pi :: float
  @spec pi(i :: integer, acc :: integer) :: pi :: float
  # A pi i-edik közelítő értéke pi
  def pi(i) do
    pi(i - 1, 1)
  end
  def pi(0, acc) do
    acc * 4
  end
  def pi(i, acc) do
    if rem(i, 2) == 0 do
      pi( i - 1, acc + 1 / (2 * i + 1))
    else
      pi( i - 1, acc - 1 /  (2 * i + 1))
    end
  end

  ##-------------------------------------------------------- 4.
  @spec dec2rad(r :: integer, i :: integer) :: ds :: [integer]
  # Az i egész szám r alapú számrendszerbe konvertált, decimális számként
  # megadott számjegyeinek listája ds
  @spec dec2rad(r::integer, i::integer, acc::integer) :: ds :: [integer]
  def dec2rad(r, i) do
    dec2rad(r,i,[])

  end
  defp dec2rad(_r, 0, acc) do
    acc
  end
  defp dec2rad(r,i,acc) do
    IO.inspect acc
    dec2rad( r, div(i,r), [ rem(i,r) | acc ] )
  end



end

# IO.puts Gyak1.lnko(3,9)
# IO.puts Gyak1.len([])
# IO.puts Gyak1.len(["asdf", "asdf", "asdfasdf"])
# IO.puts Gyak1.len([])
# IO.puts "hello"
# IO.puts Gyak1.pi(3)
# IO.puts  abs(Gyak1.pi(10000000) - :math.pi) < 1.0e-6
IO.inspect Gyak1.dec2rad(2, 13)

# IO.puts Gyak1.leni([])
# IO.puts Gyak1.leni(["asdf", "asdfasdfasdf"])
# IO.puts Gyak1.leni('hosszasdfasdflkjaésdlkfj')

# @spec lnko( a::integer, b::integer) :: b::integer
# # a és b legnagyobb közös osztója d
# def lnko(a,b), do
