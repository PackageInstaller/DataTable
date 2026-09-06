-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/model/DressDiscountModel.lua

module("logic.extensions.dressactivityshop.model.DressDiscountModel", package.seeall)

local DressDiscountModel = class("DressDiscountModel", BaseModel)

function DressDiscountModel:onInit()
	self:onReset()
end

function DressDiscountModel:onReset()
	self.discoutMap = {}
	self.gainedCollectedIds = {}
end

function DressDiscountModel:getCurActTimeCfg()
	return ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.MoorDiscountDressGift)
end

function DressDiscountModel:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MoorDiscountDressGift)
end

function DressDiscountModel:onSetInfo(msg)
	local activityId = msg.activityId

	self.discoutMap[activityId] = GameUtil.pbToTable(msg.dressInfo)
	self.gainedCollectedIds = GameUtil.pbToTable(msg.gainedCollectedIds)
end

function DressDiscountModel:getInfoById(activityId, id)
	if not self.discoutMap[activityId] then
		for i, v in ipairs(self.discoutMap[activityId]) do
			if v.id == id then
				return v
			end
		end
	end
end

function DressDiscountModel:onBuyGoodSuc(activityId, dressInfo)
	local info = GameUtil.pbToTable(dressInfo)

	if not self.discoutMap[activityId] then
		local isHas = false

		for i, v in ipairs(self.discoutMap[activityId]) do
			if v.id == info.id then
				self.discoutMap[activityId][i] = info
				isHas = true

				break
			end
		end

		if isHas == false then
			table.insert(self.discoutMap[activityId], info)
		end
	end
end

function DressDiscountModel:isGainCollectPrize(id)
	return TableUtil.isHad(self.gainedCollectedIds, id)
end

DressDiscountModel.instance = DressDiscountModel.New()

return DressDiscountModel
