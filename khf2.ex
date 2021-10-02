defmodule Khf2 do
	@moduledoc """
	Szövegelő
	@author "Molnár Benedek molnar.benedek.mate@gmail.com"
	@date   "2021-09-29"
	...
	"""
  @doc """
  A maxlength segédfüggvény kiszámítja egy lista a listában adatstruktúra belső lista leghosszabb hosszát.
  Az Enum.max_by végigiterál a listán és az anonym függvénnyel nézi az elem hosszát.
  Végül vissaadja a leghosszabb elem hosszát.
  """
  @spec maxlength(list::List):: i::integer
  defp maxlength(list) do
    max = Enum.max_by(list, fn x -> length(x) end)
    length(max)
  end

  @doc """
  Addnil segédfüggvény kap egy listát és egy integert paraméterül. A paraméterben megadott számnyi nil-t ad a sorhoz.
  """
  @spec addnil(list::List, max::integer):: any()
  defp addnil(list, 0) do
    list
  end
  defp addnil(list, maxminuslength) do
    tmp = list ++ [nil]
    addnil(tmp, maxminuslength - 1 )
  end

  @doc """
  A split segédfüggvény kap egy stringet paraméterül és listát ad vissza.
  A stringből kiszedi a tab és az újsor karaktereket. Majd felosztja bárhány whitespace karakterenként a sort a String.split függvénnyel.
  Végül az üres elemeket kiszűri.
  """
  @spec split(string::String):: list::List
  defp split(s) do
    withouttab = String.replace(s, "\t", "")
    withoutnewline = String.replace(withouttab, "\n", "")

    splitted = String.split(withoutnewline, ~r/\ \ */)
    for split <- splitted, split != "" do
      split
    end
  end

  @doc """
  Szovegelo függvény beolvassa a file-t úgy, hogy soronként ellenőrzi üres-e a sor tehát ha csak whitespace
  tab vagy egy újsor karakter van a sorban akkor azt nem olvassa be a listoflines változóba.
  Ha üres a listoflines akkor visszaad egy üres tömböt.
  Ha nem üres akkor meghívja minden elemére a split függvényt.
  Kiszámítja a leghosszabb elem hosszúságát a maxlength segédfüggvénnyel.
  Végül soronként minden sorra ami rövidebb mint a max meghívja rá az addnil függvényt, ami kipótolja a szükséges nil-ekkel a sort.
  """
	@spec szovegelo(file :: String.t) :: rss:: [[String.t | nil]]
	# A file fájl tartalmából előállítja az rss szövegmátrixot.
	# A beolvasott szöveg és a szövegmátrix sorainak száma azonos.
	# A szövegmátrix oszlopainak száma megegyezik a leghosszabb
	# sor szavainak számával. A mátrix minden egyes cellájában a
	# fájl egy-egy szava vagy a nil atom van. A szavakat egy vagy
	# több szóköz-jellegű karakter választja el. A sorokba balról
	# jobbra haladva kerülnek be a szavak, a sorok végén üresen
	# maradó cellákba pedig a nil atom.
  def szovegelo(file) do
    read = File.stream!(file)
    # listoflines = for line <- read, line != "\n" do
    listoflines = for line <- read, !String.match?(line, ~r/^[\ \t\n]*\n$/) do
      line
    end
    if listoflines == [] do
      []
    else
      listofsplitlines = for line <- listoflines do
        split(line)
      end
      max = maxlength(listofsplitlines)
      ## Add nil to lines
      result = for line <- listofsplitlines do
        if length(line) < max do
          addnil(line, max - length(line))
        else
          line
        end
      end
      result
    end
  end
end

# IO.inspect Khf2.matchymatch("./test.txt")
# IO.inspect Khf2.readfile("./test.txt")
# IO.inspect Khf2.szovegelo("./test.txt")
# IO.inspect Khf2.szovegelo("./khf2_t3.txt")
# IO.inspect Khf2.split("éalskjfd  asédlfkj jfjfjf\n")
# IO.inspect Khf2.addnil(["a","b","c"],5)
