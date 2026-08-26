-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyItemMo.lua

module("modules.logic.sp01.odyssey.model.OdysseyItemMo", package.seeall)

local OdysseyItemMo = pureTable("OdysseyItemMo")

function OdysseyItemMo:init(id)
	self.id = id
	self.config = OdysseyConfig.instance:getItemConfig(id)
	self.addCount = 0
	self.count = 0
end

function OdysseyItemMo:updateInfo(info, isPush)
	self.uid = info.uid
	self.id = info.id

	if isPush then
		self.count = self.count + info.count
		self.addCount = info.count
	else
		self.count = info.count
	end

	self.newFlag = info.newFlag
end

function OdysseyItemMo:isNew()
	return self.newFlag
end

function OdysseyItemMo:cleanAddCount()
	self.addCount = 0
end

return OdysseyItemMo
