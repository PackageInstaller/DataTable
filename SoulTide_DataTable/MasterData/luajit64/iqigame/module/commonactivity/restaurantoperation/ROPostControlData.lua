-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROPostControlData.lua

local m = {}

function m.New(cid, post)
	local o = Clone(m)

	o:Init(cid, post)

	return o
end

function m:Init(cid, post)
	self.cid = cid
	self.postPOD = post
end

function m:GetMaxPosNum()
	if self.__maxNum == nil then
		local cfgMaxLvBuilding = RestaurantOperationModule.GetCfgMaxLvBuildingData()
		local index = table.indexOf(cfgMaxLvBuilding.PostId, self.cid)

		self.__maxNum = cfgMaxLvBuilding.PostNum[index]
	end

	return self.__maxNum
end

function m:GetFormation(pos)
	local unlock = false
	local playInformation

	if self.postPOD and self.postPOD.positionInformation then
		unlock = self.postPOD.positionInformation[pos] ~= nil

		if unlock then
			playInformation = self.postPOD.positionInformation[pos]
		end
	end

	return unlock, playInformation
end

function m:IsUnlock(pos)
	if self.postPOD and self.postPOD.positionInformation then
		return pos <= #self.postPOD.positionInformation
	end

	return false
end

function m:GetIdlePositions()
	local pos = 0
	local maxNum = self:GetMaxPosNum()

	for i = 1, maxNum do
		local unlock, posFormation = self:GetFormation(i)

		if unlock and posFormation and posFormation.id == 0 then
			pos = i

			break
		end
	end

	return pos
end

function m:GetCfgData()
	return CfgRestaurantOperationPostControlTable[self.cid]
end

function m:GetCfgMainAttributeData()
	return CfgRestaurantOperationAttributeTable[self:GetCfgData().MainAtt]
end

return m
