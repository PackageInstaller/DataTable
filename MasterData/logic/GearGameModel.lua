-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/geargame/model/GearGameModel.lua

module("logic.extensions.geargame.model.GearGameModel", package.seeall)

local GearGameModel = class("GearGameModel", BaseModel)

function GearGameModel:onInit()
	self:onReset()
end

function GearGameModel:onReset()
	self._infos = {}
	self._clientKey = {}
	self._serverKey = {}
	self._hasPassMap = {}
end

function GearGameModel:pushHasPassResult(activityId, hasPass)
	self._hasPassMap[activityId] = self._hasPassMap[activityId] or {}

	local hasPassList = self._hasPassMap[activityId]

	table.insert(hasPassList, hasPass)
end

function GearGameModel:popHasPassResult(activityId)
	local hasPassList = checktable(self._hasPassMap[activityId])

	if #hasPassList > 0 then
		return table.remove(hasPassList, #hasPassList)
	end
end

function GearGameModel:getInfo(activityId)
	return self._infos[activityId]
end

function GearGameModel:handlePM_GearGameInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	info.passStage = msg.passStage or {}
end

function GearGameModel:handlePM_GearGameStartGameRes(msg)
	self._serverKey[msg.activityId] = msg.serverKey
end

function GearGameModel:handlePM_GearGameEndGameRes(msg)
	local activityId = msg.activityId
	local info = self._infos[activityId]
	local hasPass = checkbool(self:popHasPassResult(activityId))

	if hasPass then
		info.passStage = info.passStage or {}

		if table.indexof(info.passStage, msg.stageId) == false then
			table.insert(info.passStage, msg.stageId)
		end
	end
end

function GearGameModel:getClientKey(activityId)
	local clientKey = math.random(1, ServerTime.now()) + activityId

	self._clientKey[activityId] = clientKey

	return clientKey
end

function GearGameModel:getEncryptedKey(activityId, passOrNot)
	local clientKey = self._clientKey[activityId]
	local serverKey = self._serverKey[activityId]

	return (GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		activityId,
		passOrNot
	}))
end

GearGameModel.instance = GearGameModel.New()

return GearGameModel
