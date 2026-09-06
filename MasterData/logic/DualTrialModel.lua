-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/model/DualTrialModel.lua

module("logic.extensions.dualtrial.model.DualTrialModel", package.seeall)

local DualTrialModel = class("DualTrialModel", BaseModel)

function DualTrialModel:ctor()
	return
end

function DualTrialModel:onInit()
	self:onReset()
end

function DualTrialModel:onReset()
	self._baseInfoMap = {}
end

function DualTrialModel:getInfoByActId(actId)
	if not self._baseInfoMap[actId] then
		printInfo("双生审判基础数据未初始化")
	end

	return self._baseInfoMap[actId]
end

function DualTrialModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoMap[info.activityId] = info
end

function DualTrialModel:onBeginEvent(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getInfoByActId(info.activityId)

	if baseInfo then
		baseInfo.event = info.event
	end
end

function DualTrialModel:onEndEvent(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getInfoByActId(info.activityId)

	if baseInfo then
		baseInfo.event = info.event
		baseInfo.todayFinishBlockTimes = info.todayFinishBlockTimes
		baseInfo.finishVisiteBlockIds = info.finishVisiteBlockIds
	end
end

function DualTrialModel:onVisitBlock(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getInfoByActId(info.activityId)

	if baseInfo then
		baseInfo.event = info.event
		baseInfo.curBlockId = info.curBlockId
	end
end

function DualTrialModel:onNotifyFight(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getInfoByActId(info.activityId)

	if baseInfo then
		baseInfo.event = info.event
	end
end

function DualTrialModel:onGainPrize(msg)
	local baseInfo = self:getInfoByActId(msg.activityId)

	if baseInfo then
		baseInfo.gainPrizeIds = baseInfo.gainPrizeIds or {}

		table.insert(baseInfo.gainPrizeIds, checknumber(msg.prizeId))
	end
end

DualTrialModel.instance = DualTrialModel.New()

return DualTrialModel
