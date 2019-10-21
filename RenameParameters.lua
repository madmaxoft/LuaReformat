-- RenameParameters.lua

-- Renames all parameters in the input file (1st param) from "a_Param" to "aParam", saves it back to the input file





local args = {...}
local fnam = args[1]
local out = {}
local f = assert(io.open(fnam, "r"))
local n = 1
for line in f:lines() do
	out[n] = string.gsub(line, "([^a-zA-Z0-9_])a_(%w*)", "%1a%2")
	n = n + 1
end
f:close()

f = io.open(fnam, "w")
f:write(table.concat(out, "\n"))
f:write("\n")
f:close()
