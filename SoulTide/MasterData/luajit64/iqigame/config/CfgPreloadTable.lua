-- chunkname: @IQIGame\\Config\\CfgPreloadTable.lua

local CfgPreloadTable = {
	{
		Id = 1,
		FilePath = "/05_Images/Common/ArtFont/CN/_ArtFont_CN.spriteatlas"
	},
	{
		Id = 2,
		FilePath = "/05_Images/Common/ComButton/_ComButton.spriteatlas"
	},
	{
		Id = 3,
		FilePath = "/05_Images/Common/ComFrame/_ComFrame.spriteatlas"
	},
	{
		Id = 4,
		FilePath = "/05_Images/Common/ComImage/_ComImage.spriteatlas"
	},
	{
		Id = 5,
		FilePath = "/05_Images/Common/SequenceFrame/ReconnectionSequenceFrame/_ReconnectionSequenceFrame.spriteatlas"
	},
	{
		Id = 6,
		FilePath = "/05_Images/Icon/Common/_CommonIcon.spriteatlas"
	},
	{
		Id = 7,
		FilePath = "/05_Images/Icon/Item/_ItemIcon.spriteatlas"
	},
	{
		Id = 8,
		FilePath = "/05_Images/Common/SequenceFrame/DialogUISequenceFrame/_DialogUISequenceFrame.spriteatlas"
	},
	{
		Id = 9,
		FilePath = "/05_Images/MainCity/MainUI/_MainUI.spriteatlas",
		SceneID = 2
	},
	{
		Id = 10,
		FilePath = "/05_Images/Icon/Portrait/_PortraitIcon.spriteatlas",
		SceneID = 2
	},
	{
		Id = 11,
		FilePath = "/05_Images/MainCity/ChatUI/_ChatUI.spriteatlas",
		SceneID = 2
	},
	{
		Id = 12,
		FilePath = "/05_Images/Maze/MazeUI/_MazeUI.spriteatlas",
		SceneID = 3
	},
	{
		Id = 13,
		FilePath = "/05_Images/Maze/Decorate/Com/_MazeComDecorate.spriteatlas",
		SceneID = 3
	},
	{
		Id = 14,
		FilePath = "/05_Images/Battle/BattleEnergyUI/_BattleEnergyUI.spriteatlas",
		SceneID = 4
	},
	{
		Id = 15,
		FilePath = "/05_Images/Battle/BattleMainUI/_BattleMainUI.spriteatlas",
		SceneID = 4
	},
	{
		Id = 16,
		FilePath = "/05_Images/Battle/BattleRoundUI/_BattleRoundUI.spriteatlas",
		SceneID = 4
	},
	{
		Id = 17,
		FilePath = "/05_Images/Battle/BattleSettlementUI/_BattleSettlementUI.spriteatlas",
		SceneID = 4
	},
	{
		Id = 18,
		FilePath = "/05_Images/Battle/BattleWarningUI/_BattleWarningUI.spriteatlas",
		SceneID = 4
	},
	{
		Id = 19,
		FilePath = "/05_Images/Home/HomeUI/UI/ComHomeUI/_ComHomeUI.spriteatlas",
		SceneID = 5
	},
	{
		Id = 20,
		FilePath = "/05_Images/Girl/GirlUI/GirlBG/Background_07_Day/_Background_07_Day.spriteatlas",
		SceneID = 7
	},
	{
		Id = 21,
		FilePath = "/05_Images/Girl/GirlUI/GirlBG/Background_07_Night/_Background_07_Night.spriteatlas",
		SceneID = 7
	},
	{
		Id = 22,
		FilePath = "/05_Images/Girl/GirlUI/GirlBG/Background_08_Day/_Background_08_Day.spriteatlas",
		SceneID = 7
	},
	{
		Id = 23,
		FilePath = "/05_Images/Girl/GirlUI/GirlBG/Background_08_Night/_Background_08_Night.spriteatlas",
		SceneID = 7
	},
	{
		Id = 24,
		FilePath = "/05_Images/Girl/GirlUI/GirlBG/Background_204_Day/_Background_204_Day.spriteatlas",
		SceneID = 7
	},
	{
		Id = 25,
		FilePath = "/05_Images/Girl/GirlUI/GirlBG/Background_204_Night/_Background_204_Night.spriteatlas",
		SceneID = 7
	},
	{
		Id = 26,
		FilePath = "/05_Images/Girl/GirlUI/GirlBG/GirlContractShowUI_ComBg_19/_GirlContractShowUI_ComBg_19.spriteatlas",
		SceneID = 7
	},
	{
		Id = 27,
		FilePath = "/05_Images/Girl/GirlUI/GirlBG/GirlUI_ComBg_012/_GirlUI_ComBg_012.spriteatlas",
		SceneID = 7
	},
	{
		Id = 28,
		FilePath = "/05_Images/Girl/GirlUI/GirlBG/GirlUI_ComBg_06/_GirlUI_ComBg_06.spriteatlas",
		SceneID = 7
	},
	{
		Id = 29,
		FilePath = "/05_Images/Girl/GirlUI/GirlBG/GirlUI_ComBg_10/_GirlUI_ComBg_10.spriteatlas",
		SceneID = 7
	},
	{
		Id = 30,
		FilePath = "/05_Images/Girl/GirlUI/GirlBGThumbnail/_GirlBGThumbnail.spriteatlas",
		SceneID = 7
	},
	{
		Id = 31,
		FilePath = "/05_Images/Girl/GirlUI/GirlUI/_GirlUI.spriteatlas",
		SceneID = 7
	}
}

setmetatable(CfgPreloadTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPreloadTable]")
	end
})

local defaultMetaTable = {
	__index = {
		SceneID = 0,
		FilePath = ""
	}
}

for i, data in pairs(CfgPreloadTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPreloadTable
