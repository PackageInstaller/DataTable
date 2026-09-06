-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/model/DivineKingOrderClgModel.lua

module("logic.extensions.divinekingorderclg.model.DivineKingOrderClgModel", package.seeall)

local DivineKingOrderClgModel = class("DivineKingOrderClgModel", BaseModel)

function DivineKingOrderClgModel:ctor()
	return
end

function DivineKingOrderClgModel:onInit()
	self:onReset()
end

function DivineKingOrderClgModel:onReset()
	self._curActId = 0
	self._curMaxStage = 0
	self._curStageId = 0
	self._historyStageId = 0
	self._soulInfo = nil
	self._isLastFightWin = false
	self._confirmNum = nil
	self._fightSoulInfos = nil
	self._saveFightResult = false
	self._fmtMo = nil
end

function DivineKingOrderClgModel:onGetInfo(msg)
	self._saveFightResult = false

	local info = msg.clgInfo

	self._curStageId = info.curStageId
	self._historyStageId = info.historyStageId
	self._soulInfos = {}

	for _, raceInfo in ipairs(info.raceSoulInfo) do
		local data = {
			raceId = raceInfo.left,
			kongSoulCount = raceInfo.mid,
			waterSoulCount = raceInfo.right
		}

		self._soulInfos[data.raceId] = data
	end
end

function DivineKingOrderClgModel:onFight(msg)
	return
end

function DivineKingOrderClgModel:onNotifyFightResult(msg)
	self._confirmNum = nil
	self._fightSoulInfos = nil
	self._isLastFightWin = msg.win

	if self._isLastFightWin then
		if not msg.curFightRaceSoulInfo then
			self._fightSoulInfos = {}

			for _, raceInfo in ipairs(msg.curFightRaceSoulInfo) do
				local data = {
					raceId = raceInfo.left,
					kongSoulCount = raceInfo.mid,
					waterSoulCount = raceInfo.right
				}

				self._fightSoulInfos[data.raceId] = data
			end

			self._confirmNum = msg.confirmNum
		end
	end
end

function DivineKingOrderClgModel:onConfirmSave(msg)
	if self._saveFightResult then
		local info = msg.clgInfo

		self._curStageId = info.curStageId
		self._historyStageId = info.historyStageId
		self._soulInfos = {}

		for _, raceInfo in ipairs(info.raceSoulInfo) do
			local data = {
				raceId = raceInfo.left,
				kongSoulCount = raceInfo.mid,
				waterSoulCount = raceInfo.right
			}

			self._soulInfos[data.raceId] = data
		end
	end

	self._saveFightResult = false
end

function DivineKingOrderClgModel:onResetFight(msg)
	local info = msg.clgInfo

	self._curStageId = info.curStageId
	self._historyStageId = info.historyStageId
	self._soulInfos = {}

	for _, raceInfo in ipairs(info.raceSoulInfo) do
		self._soulInfos[raceInfo.race] = {
			raceId = raceInfo.left,
			kongSoulCount = raceInfo.mid,
			waterSoulCount = raceInfo.right
		}
	end
end

function DivineKingOrderClgModel:setActivityId(actId)
	self._curActId = actId
	self._curMaxStage = DivineKingOrderClgConfig.instance:getMaxStage(actId)
end

function DivineKingOrderClgModel:getActivityId()
	return self._curActId
end

function DivineKingOrderClgModel:isChallengePass()
	return self._curMaxStage < self._historyStageId
end

function DivineKingOrderClgModel:isHistoryPassStage(stageId)
	return stageId < self._historyStageId
end

function DivineKingOrderClgModel:isPassStage(stageId)
	return stageId < self._curStageId
end

function DivineKingOrderClgModel:getCurStageId()
	return self._curStageId
end

function DivineKingOrderClgModel:saveFightResult(isSave)
	self._saveFightResult = isSave
end

function DivineKingOrderClgModel:getCurSoulInfos()
	return self._soulInfos
end

function DivineKingOrderClgModel:getCurSoulInfoByRaceId(raceId)
	return self._soulInfos and self._soulInfos[raceId]
end

function DivineKingOrderClgModel:getCurFightSoulInfos()
	return self._fightSoulInfos
end

function DivineKingOrderClgModel:getLastBattleResult()
	return self._isLastFightWin
end

function DivineKingOrderClgModel:getConfirmNum()
	return self._confirmNum
end

function DivineKingOrderClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivineKingOrderClgFmtMo.New()

	return self._fmtMo
end

DivineKingOrderClgModel.instance = DivineKingOrderClgModel.New()

return DivineKingOrderClgModel
