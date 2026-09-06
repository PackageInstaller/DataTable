-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishihud/model/DragonKingARuiShiHUDModel.lua

module("logic.extensions.dragonkingaruishihud.model.DragonKingARuiShiHUDModel", package.seeall)

local DragonKingARuiShiHUDModel = class("DragonKingARuiShiHUDModel", BaseModel)

function DragonKingARuiShiHUDModel:onInit()
	self:onReset()
end

function DragonKingARuiShiHUDModel:onReset()
	self._baseInfoMap = {}
end

function DragonKingARuiShiHUDModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoMap[info.activityId] = info
end

function DragonKingARuiShiHUDModel:onGainPrize(msg)
	local activityId = msg.activityId
	local baseInfo = self:getBaseInfo(activityId)

	if baseInfo then
		baseInfo.gainedPrize = true
	end
end

function DragonKingARuiShiHUDModel:getBaseInfo(activityId)
	if not self._baseInfoMap[activityId] then
		print("技能对对碰数据未初始化" .. activityId)
	end

	return self._baseInfoMap[activityId]
end

DragonKingARuiShiHUDModel.instance = DragonKingARuiShiHUDModel.New()

return DragonKingARuiShiHUDModel
