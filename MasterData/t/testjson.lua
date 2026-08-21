
local json = require "cjson"

local items = {}

for i = 1, 500 do
	table.insert(items, { id = i, level = i, practice = i })
end

-- print(json.encode(items))

if true then
	local iconv = require("luaiconv")
	local togbk = iconv.new("gb2312", "utf-8")
	local str, err = togbk:iconv("中文.txt")
	print(str)
	-- io.open(str,"w")
	-- io.close()

	return
end
