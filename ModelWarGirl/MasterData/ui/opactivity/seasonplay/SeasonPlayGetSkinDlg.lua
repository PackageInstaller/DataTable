-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlayGetSkinDlg.lua

local GetNewSkinDlg = require("UI/Hero/GetNewSkinDlg")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResItem = require("ClientData/ResItem")
local ResHero = require("ClientData/ResHero")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local ResSeasonSkinShow = require("ClientData/ResSeasonSkinShow")
local SeasonPlayGetSkinDlg = Class("SeasonPlayGetSkinDlg", GetNewSkinDlg)

function SeasonPlayGetSkinDlg:ctor(...)
	return
end

function SeasonPlayGetSkinDlg:setSkinItemId(itemId)
	if itemId and ResItem[itemId] then
		self:addOneSkin(ResItem[itemId].extend_args1, ResItem[itemId].extend_args2)
	end
end

return SeasonPlayGetSkinDlg
