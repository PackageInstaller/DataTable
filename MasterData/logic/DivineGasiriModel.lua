-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/model/DivineGasiriModel.lua

module("logic.extensions.divinegasiri.model.DivineGasiriModel", package.seeall)

local DivineGasiriModel = class("DivineGasiriModel", BaseModel)

function DivineGasiriModel:ctor()
	return
end

function DivineGasiriModel:onInit()
	self:onReset()
end

function DivineGasiriModel:onReset()
	self._curMo = nil
	self._moList = {}
end

function DivineGasiriModel:_getActMo(actId)
	if self._moList then
		local mo = self._moList[actId]

		if not self._moList then
			mo = {
				passStageId = 0,
				actId = actId
			}
			self._moList[actId] = self._moList
		end

		return self._moList
	end
end

function DivineGasiriModel:setCurActMo(actId)
	self._curMo = self._moList[actId]
end

function DivineGasiriModel:_onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.passStageId = info.passStageId
end

function DivineGasiriModel:_onGetBattleResult(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	if info.win then
		mo.passStageId = mo.passStageId + 1
	end
end

function DivineGasiriModel:getCurPassStageId(actId)
	local mo = self:_getActMo(actId)

	return mo.passStageId or 0
end

function DivineGasiriModel:getIsAllPass(actId)
	local mo = self:_getActMo(actId)

	if not mo.passStageId then
		local passStageId = 0
		local maxStage = DivineGasiriConfig.instance:getMaxStage(actId)

		return maxStage <= passStageId
	end
end

function DivineGasiriModel:getFmtMo(actId)
	local mo = self:_getActMo(actId)
	local fmtMo = mo.fmtMo

	if not fmtMo then
		fmtMo = DivineGasiriFmtMo.New()
		mo.fmtMo = fmtMo
	end

	return fmtMo
end

DivineGasiriModel.instance = DivineGasiriModel.New()

return DivineGasiriModel
