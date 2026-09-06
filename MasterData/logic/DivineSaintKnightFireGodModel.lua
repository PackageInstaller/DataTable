-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/DivineSaintKnightFireGod/model/DivineSaintKnightFireGodModel.lua

module("logic.extensions.divinesaintknightfiregod.view.DivineSaintKnightFireGodModel", package.seeall)

local DivineSaintKnightFireGodModel = class("DivineSaintKnightFireGodModel", BaseModel)

function DivineSaintKnightFireGodModel:ctor()
	return
end

function DivineSaintKnightFireGodModel:onInit()
	self:onReset()
end

function DivineSaintKnightFireGodModel:onReset()
	self._msgInfos = {}
	self._fmtMos = {}
	self._stageClickTimes = {}
	self._curStageId = 1
end

function DivineSaintKnightFireGodModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].passStageId = self._msgInfos[msg.activityId].passStageId or {}
end

function DivineSaintKnightFireGodModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DivineSaintKnightFireGodModel:getFmtMo(activityId)
	local fmtMo = self._fmtMos[activityId]

	if not fmtMo then
		fmtMo = DivineSaintKnightFireGodFmtMo.New()
		self._fmtMos[activityId] = fmtMo
	end

	return fmtMo
end

function DivineSaintKnightFireGodModel:onChallengeRes(msg)
	if msg.isPass then
		local info = self:getInfo(msg.activityId)

		table.insert(info.passStageId, msg.stageId)
	end
end

function DivineSaintKnightFireGodModel:getStageClicTimes(activityId)
	local clickTimes = self._stageClickTimes[activityId]

	if not clickTimes then
		clickTimes = {}

		local stageCfgs = DivineSaintKnightFireGodConfig.instance:getStageCfgs(activityId)

		for i, v in ipairs(stageCfgs) do
			clickTimes[v.stageId] = {
				1,
				1,
				1
			}
		end

		self._stageClickTimes[activityId] = clickTimes
	end

	return clickTimes
end

function DivineSaintKnightFireGodModel:getCurrStageId()
	return self._curStageId
end

function DivineSaintKnightFireGodModel:setCurrStageId(stageId)
	self._curStageId = stageId
end

DivineSaintKnightFireGodModel.instance = DivineSaintKnightFireGodModel.New()

return DivineSaintKnightFireGodModel
