-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/model/PetCardLotteryModel.lua

module("logic.extensions.petcardlottery.model.PetCardLotteryModel", package.seeall)

local PetCardLotteryModel = class("PetCardLotteryModel", BaseModel)

function PetCardLotteryModel:ctor()
	return
end

function PetCardLotteryModel:onInit()
	self:onReset()
end

function PetCardLotteryModel:onReset()
	self.petCardLotteryInfo = {}
	self.recordList = {}
	self.selectedPetIds = {}
	self.activityId = 268001
	self.yesterday = 0
end

function PetCardLotteryModel:setPetCardInfo(msg)
	table.clear(self.petCardLotteryInfo)

	self.petCardLotteryInfo = msg
	self.recordList = self.petCardLotteryInfo.recordList or {}
	self.dateInt = PetCardLotteryController.instance:getTodayDateInt()
	self.selectedPetIds = self:getDaySelectedPetIds(self.dateInt)
end

function PetCardLotteryModel:setActivityId(actId)
	self.activityId = actId
end

function PetCardLotteryModel:getActivityId()
	return self.activityId
end

function PetCardLotteryModel:getYesterdayDateInt(dateInt)
	local record = self:getRecordList()
	local recordCount = #record

	if recordCount <= 1 then
		return 0
	end

	for i = 1, recordCount do
		if record[i].dateInt == dateInt then
			return record[i - 1].dateInt
		end
	end
end

function PetCardLotteryModel:getDaySelectedPetIds(dateInt)
	local selectedPetIds = {}

	for _, v in pairs(self.recordList) do
		if v.dateInt == dateInt then
			selectedPetIds = v.selectedPetIds
		end
	end

	return selectedPetIds or {}
end

function PetCardLotteryModel:getTodaySelectPetIds()
	return self.selectedPetIds
end

function PetCardLotteryModel:getDayPrizePetIds(dateInt)
	local prizePetIds = {}

	for _, v in pairs(self.recordList) do
		if v.dateInt == dateInt then
			prizePetIds = v.prizePetIds
		end
	end

	return prizePetIds or {}
end

function PetCardLotteryModel:getCountOfPrizeGetter()
	return self.petCardLotteryInfo.countOfPrizeGetter
end

function PetCardLotteryModel:isGainPrize(dateInt)
	for _, v in pairs(self.recordList) do
		if v.dateInt == dateInt then
			return v.gainPrize
		end
	end
end

function PetCardLotteryModel:getRecordList()
	table.sort(self.recordList, function(a, b)
		return a.dateInt < b.dateInt
	end)

	return self.recordList
end

PetCardLotteryModel.instance = PetCardLotteryModel.New()

return PetCardLotteryModel
