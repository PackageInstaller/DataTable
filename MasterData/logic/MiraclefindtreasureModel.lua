-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclefindtreasure/model/MiraclefindtreasureModel.lua

module("logic.extensions.miraclefindtreasure.view.MiraclefindtreasureModel", package.seeall)

local MiraclefindtreasureModel = class("MiraclefindtreasureModel", BaseModel)

function MiraclefindtreasureModel:ctor()
	return
end

function MiraclefindtreasureModel:onInit()
	self:onReset()
end

function MiraclefindtreasureModel:onReset()
	self._targetId = 0
	self._msgInfos = {}
	self._activityId = 0
end

function MiraclefindtreasureModel:setInfo(msg)
	self._activityId = msg.activityId
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].prizeInfoList = self._msgInfos[msg.activityId].prizeInfoList or {}
end

function MiraclefindtreasureModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function MiraclefindtreasureModel:getActiityId()
	return self._activityId
end

function MiraclefindtreasureModel:getState(activityId)
	local info = self:getInfo(activityId)

	if not info then
		return 0
	end

	return info.state
end

function MiraclefindtreasureModel:getTargetId(activityId)
	return self:getInfo(activityId).targetId
end

function MiraclefindtreasureModel:getTargetCfg(activityId)
	return MiraclefindtreasureConfig.instance:getTargetCfgById(self:getTargetId(activityId))
end

function MiraclefindtreasureModel:startDigRes(msg)
	local info = self:getInfo(msg.activityId)

	info.state = msg.state
	info.targetId = msg.targetId
end

function MiraclefindtreasureModel:updateGainPrize(activityId, prizeInfo)
	local info = self:getInfo(activityId)

	info.state = 0
	info.prizeInfoList = info.prizeInfoList or {}

	local isHit = false

	for i, v in ipairs(info.prizeInfoList) do
		if v.prizeId == prizeInfo.prizeId then
			v.gainCount = prizeInfo.gainCount
			isHit = true

			break
		end
	end

	if not hit then
		table.insert(info.prizeInfoList, {
			prizeId = prizeInfo.prizeId,
			gainCount = prizeInfo.gainCount
		})
	end
end

function MiraclefindtreasureModel:updateGainPrizeList(activityId, prizeInfos)
	for i, v in ipairs(prizeInfos) do
		self:updateGainPrize(activityId, v)
	end
end

function MiraclefindtreasureModel:finishDigRes(activityId)
	self:getInfo(activityId).state = 2
end

MiraclefindtreasureModel.instance = MiraclefindtreasureModel.New()

return MiraclefindtreasureModel
