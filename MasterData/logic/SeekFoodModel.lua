-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/model/SeekFoodModel.lua

module("logic.extensions.seekfood.model.SeekFoodModel", package.seeall)

local SeekFoodModel = class("SeekFoodModel", BaseModel)

SeekFoodModel.FoodState = {
	CanFightBoss = 2,
	HaveCanCollect = 3,
	HasFightBoss = 5,
	HaveCanGainCollect = 1,
	NoCanCollect = 4
}
SeekFoodModel.MatState = {
	Collecting = 3,
	HasFinishCollected = 4,
	CanFinishCollect = 1,
	Normal = 2
}

function SeekFoodModel:ctor()
	return
end

function SeekFoodModel:onInit()
	self:onReset()
end

function SeekFoodModel:onReset()
	self._seekFoodInfoRes = {}
	self._foodInfos = {}
	self._matInfos = {}
	self._seekFoodCustomFmtMo = nil
end

function SeekFoodModel:handlePM_SeekFoodInfoRes(msg)
	self._seekFoodInfoRes = msg
	self._foodInfos = {}

	for _, v in ipairs(msg.foods) do
		self._foodInfos[v.foodId] = v
	end

	self._matInfos = {}

	for _, v in ipairs(msg.dispatch) do
		if self._matInfos[v.foodId] == nil then
			self._matInfos[v.foodId] = {}
		end

		self._matInfos[v.foodId][v.materialId] = v
	end
end

function SeekFoodModel:handlePM_SeekFoodDispatchRes(msg)
	return
end

function SeekFoodModel:handlePM_SeekFoodGainDispatchRes(msg)
	return
end

function SeekFoodModel:handlePM_SeekFoodFightBossRes(msg)
	return
end

function SeekFoodModel:handlePM_SeekFoodGainPrizeRes(msg)
	return
end

function SeekFoodModel:handlePM_NotifySeekFoodFightBossEndRes(msg)
	return
end

function SeekFoodModel:getSeekTimes()
	return checknumber(self._seekFoodInfoRes.seekTimes)
end

function SeekFoodModel:isHasGainPrize(prizeId)
	for _, v in ipairs(self._seekFoodInfoRes.gainedPrize) do
		if v == prizeId then
			return true
		end
	end

	return false
end

function SeekFoodModel:getCustomFmtMoAsSf()
	if self._seekFoodCustomFmtMo == nil then
		self._seekFoodCustomFmtMo = SeekFoodCustomFmtMo.New()
	end

	return self._seekFoodCustomFmtMo
end

function SeekFoodModel:isFightedBoss(foodId)
	local info = self:getInfoOfFood(foodId)

	return checkbool(info and info.fightedBoss)
end

function SeekFoodModel:getFinishMaterialIdsOfFood(foodId)
	local info = self:getInfoOfFood(foodId)

	return (info or nil) and (info.finishMaterialIds or {})
end

function SeekFoodModel:isFinishMaterialOfFood(foodId, materialId)
	local curMatIdList = self:getFinishMaterialIdsOfFood(foodId)

	return table.indexof(curMatIdList, materialId) ~= false
end

function SeekFoodModel:getInfoOfFood(foodId)
	return self._foodInfos[foodId]
end

function SeekFoodModel:getMaterialState(foodId, materialId)
	if self:isFinishMaterialOfFood(foodId, materialId) then
		return SeekFoodModel.MatState.HasFinishCollected
	end

	if self:getMatInfo(foodId, materialId) == nil then
		return SeekFoodModel.MatState.Normal
	end

	local endTimeStamp = self:getEndTimeStampOfMat(foodId, materialId)
	local leftTimeStamp = checknumber(endTimeStamp) / 1000 - ServerTime.now()

	if leftTimeStamp <= 0 then
		return SeekFoodModel.MatState.CanFinishCollect
	else
		return SeekFoodModel.MatState.Collecting
	end
end

function SeekFoodModel:getEndTimeStampOfMat(foodId, materialId)
	local info = self:getMatInfo(foodId, materialId)

	return (info or nil) and (info.endTimeMillis or "")
end

function SeekFoodModel:getPetIdsOfMat(foodId, materialId)
	local info = self:getMatInfo(foodId, materialId)

	return (info or nil) and (info.petIds or {})
end

function SeekFoodModel:getMatInfo(foodId, materialId)
	return self._matInfos[foodId] and self._matInfos[foodId][materialId]
end

SeekFoodModel.instance = SeekFoodModel.New()

return SeekFoodModel
