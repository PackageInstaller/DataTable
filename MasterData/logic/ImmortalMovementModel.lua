-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/model/ImmortalMovementModel.lua

module("logic.extensions.immortalmovement.model.ImmortalMovementModel", package.seeall)

local ImmortalMovementModel = class("ImmortalMovementModel", BaseModel)

function ImmortalMovementModel:onInit()
	self:onReset()
end

function ImmortalMovementModel:onReset()
	self._baseInfoMap = {}
end

function ImmortalMovementModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoMap[info.activityId] = info
end

function ImmortalMovementModel:onUnlockScore(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self._baseInfoMap[info.activityId]

	if baseInfo then
		baseInfo.hasUnlockScore = info.hasUnlockScore or {}
	end
end

function ImmortalMovementModel:getBaseInfo(activityId)
	if not self._baseInfoMap[activityId] then
		printError("不朽乐章数据未初始化")
	end

	return self._baseInfoMap[activityId]
end

ImmortalMovementModel.instance = ImmortalMovementModel.New()

return ImmortalMovementModel
