-- chunkname: @modules/logic/fight/model/data/FightBuffInfoData.lua

module("modules.logic.fight.model.data.FightBuffInfoData", package.seeall)

local FightBuffInfoData = FightDataClass("FightBuffInfoData")

function FightBuffInfoData:onConstructor(proto, entityId)
	local uid = proto.uid

	self.time = tonumber(uid)
	self.entityId = entityId
	self.buffId = proto.buffId
	self.duration = proto.duration
	self.uid = uid
	self.id = uid
	self.exInfo = proto.exInfo
	self.fromUid = proto.fromUid
	self.count = proto.count
	self.actCommonParams = proto.actCommonParams
	self.layer = proto.layer
	self.type = proto.type
	self.actInfo = {}

	local protoActInfo = proto.actInfo

	if protoActInfo then
		for i = 1, #protoActInfo do
			self.actInfo[i] = FightBuffActInfoData.New(protoActInfo[i])
		end
	end

	local config = self:getCO()

	if not config then
		logError("buff表找不到id:" .. self.buffId)
	end

	if config then
		self.name = config.name or ""
	end

	self.clientNum = 0
end

function FightBuffInfoData:clone()
	local cloneData = FightBuffInfoData.New(self, self.entityId)

	cloneData.clientNum = self.clientNum

	return cloneData
end

function FightBuffInfoData:getCO()
	return lua_skill_buff.configDict[self.buffId]
end

function FightBuffInfoData:setClientNum(num)
	self.clientNum = num
end

return FightBuffInfoData
