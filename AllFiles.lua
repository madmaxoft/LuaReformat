-- AllFiles.lua

-- Runs the specified Lua script on each .cpp, .h and .hpp file in the current folder / folder specified
-- Usage: AllFiles.lua <script> [[-r] <folder>]




require("lfs")




local function processFolder(aFilter, aFolder, aShouldRecurse)
	assert(type(aFilter) == "function")
	assert(type(aFolder) == "string")
	assert(type(aShouldRecurse) == "boolean")

	for fnam in lfs.dir(aFolder) do
		local fullName = aFolder .. "/" .. fnam
		if (
			fnam:match(".+%.cpp$") or
			fnam:match(".+%.hpp$") or
			fnam:match(".+%.h$")
		) then
			print(fullName)
			aFilter(fullName)
		elseif ((fnam ~= ".") and (fnam ~= "..")) then
			-- If it is a folder and we're recursing, go there:
			if (aShouldRecurse) then
				if (lfs.attributes(fullName, "mode") == "directory") then
					processFolder(aFilter, fullName, true)
				end
			end
		end
	end
end





local args = {...}
local script = args[1]
if not(script) then
	print("Usage: AllFiles <scriptName> [[-r] <folder>]")
	return
end
local filter = assert(loadfile(script))
local folderIdx = 2
local shouldRecurse = false
if ((args[2] == "-r") or (args[2] == "-R")) then
	shouldRecurse = true
	folderIdx = 3
end
local folder = args[folderIdx] or "."
print("Running " .. script .. " on all files in " .. folder .. (shouldRecurse and " recursive." or " only."))

processFolder(filter, folder, shouldRecurse)

print("All done")
