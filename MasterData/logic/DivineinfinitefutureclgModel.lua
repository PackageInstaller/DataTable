-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/model/DivineinfinitefutureclgModel.lua

module("logic.extensions.divineinfinitefutureclg.view.DivineinfinitefutureclgModel", package.seeall)

local DivineinfinitefutureclgModel = class("DivineinfinitefutureclgModel", BaseModel)

function DivineinfinitefutureclgModel:ctor()
	return
end

function DivineinfinitefutureclgModel:onInit()
	self:onReset()
end

function DivineinfinitefutureclgModel:onReset()
	self._msgInfos = {}
	self._fmtMo = nil
end

function DivineinfinitefutureclgModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].gridId2Value = self._msgInfos[msg.activityId].gridId2Value or {}
end

function DivineinfinitefutureclgModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DivineinfinitefutureclgModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivineinfinitefutureclgFmtMo.New()

	return self._fmtMo
end

function DivineinfinitefutureclgModel:onConfirmRes(msg)
	local info = self:getInfo(msg.activityId)

	if msg.gridId2Value and #msg.gridId2Value > 0 then
		info.gridId2Value = GameUtil.pbToTable(msg.gridId2Value)
	end
end

function DivineinfinitefutureclgModel:onClgValidRes(msg)
	local info = self:getInfo(msg.activityId)

	info.curPassStageId = msg.curPassStageId

	local nextStageId = msg.curPassStageId + 1
	local nextCfg = DivineinfinitefutureclgConfig.instance:getStageCfg(msg.activityId, nextStageId)

	if nextCfg then
		info.gridId2Value = GameUtil.pbToTable(msg.gridId2Value) or {}
	end
end

DivineinfinitefutureclgModel.instance = DivineinfinitefutureclgModel.New()

return DivineinfinitefutureclgModel
