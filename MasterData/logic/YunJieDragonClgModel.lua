-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/model/YunJieDragonClgModel.lua

module("logic.extensions.yunjiedragonclg.model.YunJieDragonClgModel", package.seeall)

local YunJieDragonClgModel = class("YunJieDragonClgModel", BaseModel)

function YunJieDragonClgModel:onInit()
	self:onReset()
end

function YunJieDragonClgModel:onReset()
	self._infos = {}
	self._customFmtMoPool = {}
end

function YunJieDragonClgModel:getInfo(activityId)
	return self._infos[activityId]
end

function YunJieDragonClgModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = YunJieDragonClgFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function YunJieDragonClgModel:handlePM_YunJieDragonClgGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function YunJieDragonClgModel:handlePM_Notify_YunJieDragonClgChallengeEndRes(msg)
	local info = self._infos[msg.activityId]

	if msg.win then
		info.passedStageIds = info.passedStageIds or {}

		table.insert(info.passedStageIds, msg.stageId)
	end
end

function YunJieDragonClgModel:handlePM_YunJieDragonClgOneKeyPassRes(msg)
	local info = self._infos[msg.activityId]

	info.oneKeyPass = true
end

YunJieDragonClgModel.instance = YunJieDragonClgModel.New()

return YunJieDragonClgModel
