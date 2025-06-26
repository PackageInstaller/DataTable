-- chunkname: @IQIGame\\Config\\CfgMemorialLetterTable.lua

local CfgMemorialLetterTable = {
	{
		ItemId = 130001,
		Id = 1,
		Image = {
			"/MainCity/Letter/Letter_01_Page/Letter_01_Page1.png",
			"/MainCity/Letter/Letter_01_Page/Letter_01_Page2.png",
			"/MainCity/Letter/Letter_01_Page/Letter_01_Page3.png",
			"/MainCity/Letter/Letter_01_Page/Letter_01_Page4.png",
			"",
			"",
			"",
			""
		}
	},
	{
		ItemId = 130002,
		Id = 2,
		Image = {
			"/MainCity/Letter/Letter_02_Page/Letter_02_Page1.png",
			"/MainCity/Letter/Letter_02_Page/Letter_02_Page2.png",
			"/MainCity/Letter/Letter_02_Page/Letter_02_Page3.png",
			"/MainCity/Letter/Letter_02_Page/Letter_02_Page4.png",
			"/MainCity/Letter/Letter_02_Page/Letter_02_Page5.png",
			"/MainCity/Letter/Letter_02_Page/Letter_02_Page6.png",
			"/MainCity/Letter/Letter_02_Page/Letter_02_Page7.png",
			""
		}
	},
	{
		ItemId = 130003,
		Id = 3,
		Image = {
			"/MainCity/Letter/Letter_03_Page/Letter_03_Page1.png",
			"/MainCity/Letter/Letter_03_Page/Letter_03_Page2.png",
			"/MainCity/Letter/Letter_03_Page/Letter_03_Page3.png",
			"/MainCity/Letter/Letter_03_Page/Letter_03_Page4.png",
			"/MainCity/Letter/Letter_03_Page/Letter_03_Page5.png",
			"/MainCity/Letter/Letter_03_Page/Letter_03_Page6.png",
			"/MainCity/Letter/Letter_03_Page/Letter_03_Page7.png",
			"/MainCity/Letter/Letter_03_Page/Letter_03_Page8.png"
		}
	}
}

setmetatable(CfgMemorialLetterTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMemorialLetterTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ItemId = 0,
		Image = {
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			""
		}
	}
}

for i, data in pairs(CfgMemorialLetterTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMemorialLetterTable
