-- chunkname: @IQIGame\\Module\\Cooking\\CookingQueueData.lua

CookingQueueData = {
	finishTime = 0,
	items = {
		0,
		0,
		0,
		0
	}
}

function CookingQueueData.New()
	local o = Clone(CookingQueueData)

	return o
end

function CookingQueueData:Init(id)
	self.id = id
end

function CookingQueueData:Update(cid, status, finishTime, unlock, costs, culinaryPOD)
	self.cid = cid
	self.status = status
	self.culinaryPOD = culinaryPOD

	if finishTime ~= nil then
		self.finishTime = finishTime
	else
		self.finishTime = 0
	end

	self.unlock = unlock

	if #costs > 0 then
		self.items = costs
	end

	if self.status == 0 then
		self:CleanItem()
	end
end

function CookingQueueData:CanGetNum()
	local num = 0

	if self.culinaryPOD then
		local passTime = PlayerModule.GetServerTime() - self.culinaryPOD.startTime
		local completeCount = math.floor(passTime / self.culinaryPOD.singleCookTime)

		num = completeCount - self.culinaryPOD.receiveNum
	end

	return num
end

function CookingQueueData:CookingNum()
	local num = 1

	if self.culinaryPOD then
		num = self.culinaryPOD.num - self.culinaryPOD.receiveNum
	end

	return num
end

function CookingQueueData:RemoveItem(index)
	if self.items[index] > 0 then
		self.items[index] = 0
	end
end

function CookingQueueData:CleanItem()
	self.items = {
		0,
		0,
		0,
		0
	}
end

function CookingQueueData:AddItem(itemID)
	for i = 1, #self.items do
		local value = self.items[i]

		if value == 0 then
			self.items[i] = itemID

			break
		end
	end
end

function CookingQueueData:IsFullItem()
	for i = 1, #self.items do
		if self.items[i] == 0 then
			return false
		end
	end

	return true
end

return CookingQueueData
