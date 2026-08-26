-- chunkname: @modules/logic/backpack/model/BackpackMo.lua

module("modules.logic.backpack.model.BackpackMo", package.seeall)

local BackpackMo = pureTable("BackpackMo")

function BackpackMo:ctor()
	self.id = 0
	self.uid = 0
	self.type = 0
	self.subType = 0
	self.icon = ""
	self.quantity = 0
	self.icon = ""
	self.rare = 0
	self.isStackable = false
	self.isShow = false
	self.isTimeShow = 0
	self.deadline = 0
	self.expireTime = -1
end

function BackpackMo:init(info)
	self.id = info.id
	self.uid = info.uid
	self.type = info.type
	self.subType = info.subType == nil and 0 or info.subType
	self.quantity = info.quantity
	self.icon = info.icon
	self.rare = info.rare
	self.isStackable = info.isStackable == nil and 1 or info.isStackable
	self.isShow = info.isShow == nil and 1 or info.isShow
	self.isTimeShow = info.isTimeShow == nil and 0 or info.isTimeShow

	if info.expireTime then
		self.expireTime = info.expireTime or -1
	end
end

function BackpackMo:itemExpireTime()
	if self.expireTime == nil or self.expireTime == -1 or self.expireTime == "" then
		return -1
	end

	if type(self.expireTime) == "number" then
		return self.expireTime
	else
		return TimeUtil.stringToTimestamp(self.expireTime)
	end
end

return BackpackMo
