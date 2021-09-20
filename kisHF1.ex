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
    @type variant :: { h :: integer, d :: integer }
    @type seatings :: { n :: integer, vs :: [ variant ] }
    @spec sit!( k :: integer ) :: r :: { m :: integer, ss :: [ seatings ] }
    # k kiskutya m-féleképpen ülhet úgy n>2 sorban, hogy a leghátsó sorban
    # h kiskutya ül, a számuk pedig soronként pontosan d-vel növekszik
    # sit! 101 -> {0, []}
    #  sit! 15 -> {5,           == hányféle variáció
    #             [{3           == hány soros a variációs
    #                 , [{1, 4}, {2, 3}, {3, 2}, {4, 1}]},  == variációk utolsó sor darabszáma és a sorok közti különbség
    #              {5,          == kövi variációs sorainak száma...
    #                  [{1, 1}]}]}
    # sit! 14 -> {1,
    #              [{4,
    #                 [{2, 1}]}]}
    # sit! 9 -> {2,     == hányféle variáció
    #              [{3, == sorok száma
    #                 [{1, 2}, {2, 1}]}]} == variánsok utolsó sor, diffi
    def sit!(k) do
        IO.puts "hello"
    end

    @spec sit_variants( k::integer, acc::{ m::integer, ss::[seatings]}, number_of_variants::integer ) :: r::{ m::integer, ss::[ seatings ] }
    defp sit_variants(k, acc, number_of_variants) do
        IO.puts "asdf"
        {0, [{1,[]}]}
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

IO.puts "hello"
