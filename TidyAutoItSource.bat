for %%f in (*.au3) do (
	"C:\Program Files (x86)\AutoIt3\AutoIt3.exe" "C:\Program Files (x86)\AutoIt3\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.au3" /Tidy /in "%%f"
)

for %%f in (.\Lib\*.au3) do (
	"C:\Program Files (x86)\AutoIt3\AutoIt3.exe" "C:\Program Files (x86)\AutoIt3\SciTE\AutoIt3Wrapper\AutoIt3Wrapper.au3" /Tidy /in "%%f"
)