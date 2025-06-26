-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROPlayerData.lua

local m = {}

function m.New(cid, dataPOD)
	local o = Clone(m)

	o:Init(cid, dataPOD)

	return o
end

function m:Init(cid, dataPOD)
	self.cid = cid
	self.posInfo = dataPOD
end

function m:IsUnlock()
	return self.posInfo ~= nil and self.posInfo.id > 0
end

function m:GetAttrValue(attrID)
	local value = 0

	if self.posInfo and self.posInfo.att then
		value = self.posInfo.att[attrID]
	end

	value = value or 0

	return value
end

function m:GetTotalAttrValue()
	local totalAttr = 0

	if self.posInfo and self.posInfo.att then
		for i, v in pairs(self.posInfo.att) do
			totalAttr = totalAttr + v
		end
	end

	return totalAttr
end

function m:GetAreaType()
	local postType = 0

	if self:GetCfgData().Type == RestaurantOperationConstant.RoleType.worker then
		if self:IsWorker() then
			postType = CfgRestaurantOperationPostControlTable[self.posInfo.postType].WalkArea
		end
	elseif self:GetCfgData().Type == RestaurantOperationConstant.RoleType.npc then
		postType = self:GetCfgData().WalkArea
	end

	return postType
end

function m:GetCfgData()
	return CfgRestaurantOperationPlayerTable[self.cid]
end

function m:IsWorker()
	local isUnlock = self:IsUnlock()
	local postType = false

	if self.posInfo then
		postType = self.posInfo.postType > 0
	end

	return isUnlock and postType
end

function m:GetCfgPostControlData()
	if self:IsWorker() then
		return CfgRestaurantOperationPostControlTable[self.posInfo.postType]
	end

	return nil
end

return m
