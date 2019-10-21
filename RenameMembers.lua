-- RenameMembers.lua

-- Renames all members in the input file (1st param) from "m_Member" to "mMember", saves it back to the input file





local args = {...}
local fnam = args[1]
local out = {}
local f = assert(io.open(fnam, "r"))
local n = 1
for line in f:lines() do
	out[n] = string.gsub(line, "([^a-zA-Z0-9_])m_(%w*)", "%1m%2")
	n = n + 1
end
f:close()

f = io.open(fnam, "w")
f:write(table.concat(out, "\n"))
f:write("\n")
f:close()
