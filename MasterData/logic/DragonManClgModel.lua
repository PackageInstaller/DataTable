-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/model/DragonManClgModel.lua

module("logic.extensions.dragonmanclg.model.DragonManClgModel", package.seeall)

local DragonManClgModel = class("DragonManClgModel", BaseModel)

function DragonManClgModel:onInit()
	self:onReset()
end

function DragonManClgModel:onReset()
	self._infoMap = {}
end

function DragonManClgModel:getInfoByActId(activityId)
	local info = self._infoMap[activityId]

	if not info then
		printInfo("炎龙侠数据不存在，activityId=%d", activityId)
	end

	return self._infoMap[activityId]
end

function DragonManClgModel:handlePM_DragonManClgInfoRes(msg)
	local activityId = msg.activityId

	self._infoMap[activityId] = msg
end

function DragonManClgModel:handleNotifyChallenge(msg)
	local activityId = msg.activityId
	local isWin = msg.isWin

	if isWin then
		local info = self._infoMap[activityId]

		if info then
			local stageId = msg.stageId

			if stageId > info.maxPassedStageId then
				info.maxPassedStageId = stageId
			end
		end
	end
end

DragonManClgModel.instance = DragonManClgModel.New()

return DragonManClgModel
