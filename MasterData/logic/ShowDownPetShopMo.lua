-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownPetShopMo.lua

module("logic.extensions.showdown.data.ShowDownPetShopMo", package.seeall)

local ShowDownPetShopMo = class("ShowDownPetShopMo")

function ShowDownPetShopMo:ctor(activityId, roundId)
	self._activityId = activityId
	self._roundId = roundId

	self:onReset()
end

function ShowDownPetShopMo:onReset()
	local petPlandata = ShowDownConfig.instance:getSelectPetPlanData(self._activityId, self._roundId) or {}
	local refreshTimesCfg = ShowDownConfig.instance:getBuyRefreshTimesCfg(self._activityId, self._roundId) or {}

	self._maxWishPetCount = petPlandata.wishPetCount or 0
	self._maxPetCount = petPlandata.totalPetCount or 0
	self._maxRefreshTimes = petPlandata.refreshTimes
	self._curRefreshTimes = 0

	local maxRefreshTimesData = refreshTimesCfg[#refreshTimesCfg]

	if maxRefreshTimesData then
		self._maxResetTimes = maxRefreshTimesData.count or 0
	end

	self._curResetTimes = 0
	self._wishPetList = {}
	self._bagPetList = {}
	self._isHasFirstDraw = false
	self._shopPetList = {}

	if not petPlandata.wishPetPoolId then
		local wishPetPoolId = 0
		local petPoolCfg = ShowDownConfig.instance:getSystemPetPoolCfg(wishPetPoolId)

		if petPoolCfg then
			for _, data in pairs(petPoolCfg) do
				table.insert(self._shopPetList, data.creepsId)
			end
		else
			printError(string.format("petPoolCfg is nil, activityId = %d, roundId = %d, wishPetPoolId = %d", self._activityId, self._roundId, wishPetPoolId))
		end

		self._isHasConfirm = false
		self._showDownFormMoList = {}
	end
end

function ShowDownPetShopMo:updateDataByPetRepo(value)
	table.clear(self._wishPetList)
	table.insertto(self._wishPetList, value.wishListPetIds)
	table.clear(self._bagPetList)
	table.insertto(self._bagPetList, value.wishListPetIds)
	table.insertto(self._bagPetList, value.rolledPetIds)

	self._isHasFirstDraw = #value.rolledPetIds > 0
	self._isHasConfirm = checkbool(value.hasConfirm)
end

function ShowDownPetShopMo:updateDataByFormMo(formIndex, value)
	if value then
		if self._showDownFormMoList[formIndex] == nil then
			self._showDownFormMoList[formIndex] = ShowDownFormMo.New()
		end

		self._showDownFormMoList[formIndex]:updateData(value)
	else
		self._showDownFormMoList[formIndex] = nil
	end
end

function ShowDownPetShopMo:updateDataByIdFormList(value)
	table.clear(self._showDownFormMoList)

	for i, v in ipairs(value) do
		self:updateDataByFormMo(v.formIndex, v.formation)
	end
end

function ShowDownPetShopMo:getMaxWishPetCount()
	return self._maxWishPetCount
end

function ShowDownPetShopMo:getMaxPetCount()
	return self._maxPetCount
end

function ShowDownPetShopMo:getMaxRefreshTimes()
	return self._maxRefreshTimes
end

function ShowDownPetShopMo:getCurRefreshTimes()
	return self._curRefreshTimes
end

function ShowDownPetShopMo:setCurRefreshTimes(value)
	self._curRefreshTimes = checknumber(value)
end

function ShowDownPetShopMo:getMaxResetTimes()
	return self._maxResetTimes
end

function ShowDownPetShopMo:getCurResetTimes()
	return self._curResetTimes
end

function ShowDownPetShopMo:setCurResetTimes(value)
	self._curResetTimes = checknumber(value)
end

function ShowDownPetShopMo:isHasConfirm()
	return self._isHasConfirm
end

function ShowDownPetShopMo:setIsHasConfirm(value)
	self._isHasConfirm = checkbool(value)
end

function ShowDownPetShopMo:isHasFirstDraw()
	return self._isHasFirstDraw
end

function ShowDownPetShopMo:getWishPetList()
	return self._wishPetList
end

function ShowDownPetShopMo:setWishPetList(wishPetList)
	for i = 1, self._maxWishPetCount do
		self._wishPetList[i] = wishPetList[i]
	end
end

function ShowDownPetShopMo:clearWishPetList()
	table.clear(self._wishPetList)
end

function ShowDownPetShopMo:getShopPetList()
	return self._shopPetList
end

function ShowDownPetShopMo:getBagPetList()
	return self._bagPetList
end

function ShowDownPetShopMo:getShowDownFormMoList()
	return self._showDownFormMoList
end

function ShowDownPetShopMo:clearShowDownFormMoList()
	table.clear(self._showDownFormMoList)
end

return ShowDownPetShopMo
