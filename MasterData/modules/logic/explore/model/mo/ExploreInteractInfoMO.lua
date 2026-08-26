-- chunkname: @modules/logic/explore/model/mo/ExploreInteractInfoMO.lua

module("modules.logic.explore.model.mo.ExploreInteractInfoMO", package.seeall)

local ExploreInteractInfoMO = pureTable("ExploreInteractInfoMO")

function ExploreInteractInfoMO:init(id)
	self.id = id
	self.step = 0
	self.status = 1
	self.status2 = ""
	self.statusInfo = {}
end

function ExploreInteractInfoMO:initNO(exploreInteract)
	local preStatus = self.status
	local preStatus2 = self.status2

	self.id = exploreInteract.id
	self.status = exploreInteract.status
	self.status2 = exploreInteract.status2
	self.type = exploreInteract.type
	self.step = exploreInteract.step
	self.posx = exploreInteract.posx
	self.posy = exploreInteract.posy
	self.dir = exploreInteract.dir

	if not self.statusInfo then
		local preStateInfo = {}

		self.statusInfo = string.nilorempty(self.status2) and {} or cjson.decode(self.status2)

		if preStatus ~= self.status then
			self:onStatusChange(preStatus, self.status)
		end

		if preStatus2 ~= self.status2 then
			self:onStatus2Change(preStateInfo, self.statusInfo)
		end
	end
end

function ExploreInteractInfoMO:updateStatus(status)
	if self.status ~= status then
		local preStatus = self.status

		self.status = status

		self:onStatusChange(preStatus, self.status)
	end
end

function ExploreInteractInfoMO:updateStatus2(status2)
	if self.status2 ~= status2 then
		self.status2 = status2

		if not self.statusInfo then
			local preStateInfo = {}

			self.statusInfo = string.nilorempty(self.status2) and {} or cjson.decode(self.status2)

			self:onStatus2Change(preStateInfo, self.statusInfo)
		end
	end
end

function ExploreInteractInfoMO:getBitByIndex(index)
	local bitVal = ExploreHelper.getBit(self.status, index)

	return bit.rshift(bitVal, index - 1)
end

function ExploreInteractInfoMO:setBitByIndex(index, v)
	local preStatus = self.status

	self.status = ExploreHelper.setBit(self.status, index, v == 1)

	if preStatus ~= self.status then
		self:onStatusChange(preStatus, self.status)
	end
end

function ExploreInteractInfoMO:onStatusChange(preStatus, nowStatus)
	local changeBit = bit.bxor(preStatus, nowStatus)

	if changeBit == 0 then
		return
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitStatusChange, self.id, changeBit)
end

function ExploreInteractInfoMO:onStatus2Change(preStatuInfo, nowStatuInfo)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitStatus2Change, self.id, preStatuInfo, nowStatuInfo)
end

return ExploreInteractInfoMO
