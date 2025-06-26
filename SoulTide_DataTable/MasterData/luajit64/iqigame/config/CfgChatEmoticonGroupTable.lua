-- chunkname: @IQIGame\\Config\\CfgChatEmoticonGroupTable.lua

local CfgChatEmoticonGroupTable = {
	{
		Id = 1,
		Icon = "/MainCity/ChatUI/ChatUI_ComButton_424.png",
		Name = getI18NValue(180144594)
	},
	{
		Id = 2,
		Icon = "/MainCity/ChatUI/ChatUI_ComButton_425.png",
		Name = getI18NValue(180144595)
	},
	{
		Id = 3,
		Icon = "/MainCity/ChatEmotionSequenceFrame/Emoticon_Common_Lovely/Emoticon_Common_Lovely00.png",
		Name = getI18NValue(180144596)
	},
	{
		Id = 4,
		Icon = "/MainCity/ChatEmotionSequenceFrame/Emoticon_Benten_Happy/Emoticon_Benten_Happy01.png",
		Name = getI18NValue(180144597)
	},
	{
		Id = 5,
		Icon = "/MainCity/ChatEmotionSequenceFrame/Emoticon_MonsterAcademy_Chang_Happy/Emoticon_MonsterAcademy_Chang_Happy00.png",
		Name = getI18NValue(180145758)
	}
}

setmetatable(CfgChatEmoticonGroupTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgChatEmoticonGroupTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		Icon = ""
	}
}

for i, data in pairs(CfgChatEmoticonGroupTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgChatEmoticonGroupTable
