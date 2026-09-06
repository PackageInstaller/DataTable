-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternriddle/model/LanternRiddleModel.lua

module("logic.extensions.guesslantern.model.LanternRiddleModel", package.seeall)

local LanternRiddleModel = class("LanternRiddleModel", BaseModel)

LanternRiddleModel.PICK_DIFFERENCE = 1
LanternRiddleModel.LANTERN_RIDDLE = 2

function LanternRiddleModel:ctor()
	return
end

function LanternRiddleModel:onInit()
	self:onReset()
end

function LanternRiddleModel:onReset()
	self._infos = {}
end

function LanternRiddleModel:getInfo(activityId)
	if self._infos[activityId] == nil then
		self._infos[activityId] = {}
	end

	return self._infos[activityId]
end

function LanternRiddleModel:handlePM_LanternRiddleGetInfoRes(msg)
	if not self._infos[msg.activityId] then
		local info = {}

		info = GameUtil.pbToTable(msg, self._infos[msg.activityId])
		self._infos[msg.activityId].passedStageId = msg.passedStageId or 0
		self._infos[msg.activityId].gainPrizeIds = msg.gainPrizeIds or {}
	end
end

function LanternRiddleModel:handlePM_LanternRiddleStartGameRes(msg)
	if not self._infos[msg.activityId] then
		local info = {}

		info = GameUtil.pbToTable(msg, self._infos[msg.activityId])
	end
end

function LanternRiddleModel:handlePM_LanternRiddleEndGameRes(msg)
	if not self._infos[msg.activityId] then
		local info = {}

		info = GameUtil.pbToTable(msg, self._infos[msg.activityId])

		if msg.pass then
			self._infos[msg.activityId].passedStageId = msg.stageId
		end
	end
end

function LanternRiddleModel:handlePM_LanternRiddleGainPrizeRes(msg)
	if not self._infos[msg.activityId] then
		self._infos[msg.activityId].gainPrizeIds = self._infos[msg.activityId].gainPrizeIds or {}

		table.insert(self._infos[msg.activityId].gainPrizeIds, msg.prizeId)
	end
end

function LanternRiddleModel:getClientKey(activityId)
	local clientKey = math.random(1, ServerTime.now()) + activityId
	local info = self._infos[activityId]

	info.clientKey = clientKey

	return clientKey
end

function LanternRiddleModel:getEncryptedKey(activityId, stageId, pass, problemId)
	local info = self:getInfo(activityId)
	local passTypeNum = pass and 1 or 0

	if checknumber(problemId) ~= 0 then
		return (GameUtil.getClientEncryptedKey(info.clientKey, info.encryptedKey, {
			activityId,
			stageId,
			problemId,
			passTypeNum
		}))
	else
		return (GameUtil.getClientEncryptedKey(info.clientKey, info.encryptedKey, {
			activityId,
			stageId,
			passTypeNum
		}))
	end
end

LanternRiddleModel.instance = LanternRiddleModel.New()

return LanternRiddleModel
