-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/model/DivinehopeModel.lua

module("logic.extensions.divinehope.view.DivinehopeModel", package.seeall)

local DivinehopeModel = class("DivinehopeModel", BaseModel)

function DivinehopeModel:ctor()
	return
end

function DivinehopeModel:onInit()
	self:onReset()
end

function DivinehopeModel:onReset()
	self._msgInfos = {}
	self._fmtMo = nil
	self._selectWishId = {}
end

function DivinehopeModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].divineHopeFloorInfos = self._msgInfos[msg.activityId].divineHopeFloorInfos or {}

	for i, v in ipairs(self._msgInfos[msg.activityId].divineHopeFloorInfos) do
		v.useWishId = v.useWishId or {}
	end
end

function DivinehopeModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DivinehopeModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivinehopeFmtMo.New()

	return self._fmtMo
end

function DivinehopeModel:isFloorPass(activityId, floorId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.divineHopeFloorInfos) do
		if v.floorId == floorId and v.isFirstPass then
			return true
		end
	end

	return false
end

function DivinehopeModel:onResetFloorRes(msg)
	local info = self:getInfo(msg.activityId)

	for i, v in ipairs(info.divineHopeFloorInfos) do
		if v.floorId == msg.floorId then
			v.useWishId = {}
			v.hopeScore = 0
			v.desireScore = 0

			break
		end
	end

	self._selectWishId[msg.activityId] = 0
end

function DivinehopeModel:onNotifyChallengeRes(msg)
	if msg.isWin then
		local info = self:getInfo(msg.activityId)

		for i, v in ipairs(info.divineHopeFloorInfos) do
			if v.floorId == msg.floorId then
				local cfgs = DivinehopeConfig.instance:getStageCfgsByFloor(msg.activityId, msg.floorId)
				local floorCfg = DivinehopeConfig.instance:getFloorCfg(msg.activityId, msg.floorId)

				v.useWishId[msg.stageId] = msg.wishId
				v.hopeScore = msg.hopeScore
				v.desireScore = msg.desireScore

				if msg.stageId >= #cfgs and v.hopeScore == floorCfg.passNeedHope and v.desireScore == floorCfg.passNeedDesire then
					v.isFirstPass = true
				end

				break
			end
		end

		self._selectWishId[msg.activityId] = 0
	end
end

function DivinehopeModel:getStageWishType(activityId, floorId, stageId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.divineHopeFloorInfos) do
		if v.floorId == floorId then
			return v.useWishId[stageId]
		end
	end
end

function DivinehopeModel:getCurStageId(activityId, floorId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.divineHopeFloorInfos) do
		if v.floorId == floorId then
			return #v.useWishId
		end
	end
end

function DivinehopeModel:setSelectWishId(activityId, wishId)
	self._selectWishId[activityId] = wishId
end

function DivinehopeModel:getSelectWishId(activityId)
	return self._selectWishId[activityId] or 1
end

DivinehopeModel.instance = DivinehopeModel.New()

return DivinehopeModel
