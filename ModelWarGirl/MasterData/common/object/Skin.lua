-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\Skin.lua

local BaseObject = require("Common/Object/BaseObject")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResSeasonSkinShow = require("clientData/ResSeasonSkinShow")
local ResItem = require("ClientData/ResItem")
local ResCommonModel = require("ClientData/ResCommonModel")
local strClassName = "Skin"
local Skin = Class(strClassName, BaseObject)

function Skin:ctor(data)
	return
end

function Skin:_initData()
	Skin.super._initData(self)

	self.id = self._serverData.id
	self.resData = ResItem[self.id]
	self.quality = self.resData.quality
	self.heroID = self.resData.extend_args1
	self.skinId = self.resData.extend_args2

	if ResItemHeroSkin[self.heroID] and ResItemHeroSkin[self.heroID][self.skinId] then
		self.clientData = ResItemHeroSkin[self.heroID][self.skinId]
	else
		self.clientData = {}
	end

	self.name = self.resData.name
	self.itemType = Const.ITEM_TYPE_SKIN
end

function Skin:isGet()
	local skinData = CurAvatar:getSkinDataByHeroId(self.heroID)

	if skinData and skinData.skin and skinData.skin[self.skinId] then
		return true
	else
		return false
	end
end

function Skin:isHeroGet()
	local heroCount = CurAvatar:getHeroCountByResId(self.heroID)

	return heroCount > 0
end

function Skin:getSkinIconPath()
	if self.clientData then
		local modelInfo = ResCommonModel[self.clientData.model_id]

		return {
			"Atlas/" .. modelInfo.skin_icon_path,
			modelInfo.skin_icon_name
		}
	end
end

function Skin:getSkinHeadIconPath()
	if self.clientData and self.clientData.model_id then
		local modelData = utils.getCommonModelData(self.clientData.model_id)

		if modelData then
			return {
				"Atlas/" .. modelData.icon_path,
				modelData.icon_name
			}
		end
	end
end

function Skin:getSkinModelId()
	if self.clientData and self.clientData.model_id then
		return self.clientData.model_id
	end
end

function Skin:getSkinBackNum()
	if self.clientData and self.clientData.back_num then
		return self.clientData.back_num
	end

	return 0
end

function Skin:getQualityIconPath()
	if self.clientData and self.clientData.quality then
		if self.clientData.quality == Const.SKIN_QUAILTY_SEASON then
			if ResSeasonSkinShow[self.id] then
				return {
					ResSeasonSkinShow[self.id].quality_icon_path,
					ResSeasonSkinShow[self.id].quality_icon_name
				}
			end
		else
			return {
				UIConst.SKIN_QUALITY_ICON_PATH,
				UIConst.SKIN_QUALITY_ICON[self.clientData.quality][1]
			}
		end
	end
end

function Skin:getQualityBgPath()
	if self.clientData and self.clientData.quality then
		if self.clientData.quality == Const.SKIN_QUAILTY_SEASON then
			if ResSeasonSkinShow[self.id] then
				return {
					ResSeasonSkinShow[self.id].bg_path,
					ResSeasonSkinShow[self.id].bg_name
				}
			end
		else
			return {
				UIConst.SKIN_QUALITY_BG_PATH,
				UIConst.SKIN_QUALITY_ICON[self.clientData.quality][2]
			}
		end
	end
end

function Skin:getQualityPath()
	if self.quality then
		return UIConst.COMMON_QUALITY_CONFIG[self.quality]
	end
end

function Skin:getQualityColor(getQuality)
	local quality = getQuality or self.quality
	local ResColor = require("ClientData/ResColor")
	local color

	if quality == Const.OBJ_QUALITY_WHITE then
		color = ResColor.QUALITYGREEN
	elseif quality == Const.OBJ_QUALITY_GREEN then
		color = ResColor.QUALITYBLUE
	elseif quality == Const.OBJ_QUALITY_BLUE then
		color = ResColor.QUALITYPURPLE
	elseif quality == Const.OBJ_QUALITY_PURPLE then
		color = ResColor.QUALITYFUCHSIA
	elseif quality == Const.OBJ_QUALITY_GOLD then
		color = ResColor.QUALITYORANGE
	elseif quality == 6 then
		color = ResColor.QUALITYPINK
	elseif quality == 7 then
		color = ResColor.QUALITYRED
	end

	return color
end

function Skin:isSkin()
	return true
end

return Skin
