-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/model/DivinekingjiclgModel.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgModel", package.seeall)

local DivinekingjiclgModel = class("DivinekingjiclgModel", BaseModel)

function DivinekingjiclgModel:ctor()
	return
end

function DivinekingjiclgModel:onInit()
	self:onReset()
end

function DivinekingjiclgModel:onReset()
	self._msgInfos = {}
	self._fmtMo = nil
	self._tempChangeSetId = 0
end

function DivinekingjiclgModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].lockRaceIds = self._msgInfos[msg.activityId].lockRaceIds or {}
end

function DivinekingjiclgModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DivinekingjiclgModel:onResetClg(activityId)
	local info = self:getInfo(activityId)

	info.curPassStageId = 0
	info.lockRaceIds = {}
end

function DivinekingjiclgModel:onConfirmRes(msg)
	if msg.confirm then
		local info = self:getInfo(msg.activityId)

		info.lockRaceIds = info.lockRaceIds or {}

		local newLockRaceIds = GameUtil.pbToTable(msg.lockRaceIds)

		if newLockRaceIds then
			table.insertto(info.lockRaceIds, newLockRaceIds)
		end

		info.curPassStageId = msg.stageId

		if msg.changeSetId > 0 then
			self:saveChangeSetId(msg.changeSetId)
		end
	end
end

function DivinekingjiclgModel:getLockRaceIds(activityId)
	return self:getInfo(activityId).lockRaceIds
end

function DivinekingjiclgModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivinekingjiFmtMo.New()

	return self._fmtMo
end

function DivinekingjiclgModel:saveChangeSetId(changeSetId)
	self._tempChangeSetId = changeSetId

	MaterialController.instance:saveChangeSetToTemp(changeSetId)
end

function DivinekingjiclgModel:getSaveChangeSetId()
	return self._tempChangeSetId
end

DivinekingjiclgModel.instance = DivinekingjiclgModel.New()

return DivinekingjiclgModel
