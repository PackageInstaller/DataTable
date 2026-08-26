-- chunkname: @modules/logic/critter/model/info/CritterTrainOptionInfoMO.lua

module("modules.logic.critter.model.info.CritterTrainOptionInfoMO", package.seeall)

local CritterTrainOptionInfoMO = pureTable("CritterTrainOptionInfoMO")
local _TEMP_EMPTY_TB = {}

function CritterTrainOptionInfoMO:ctor()
	self.optionId = 0
	self.addAttriButes = {}
end

function CritterTrainOptionInfoMO:init(info)
	info = info or _TEMP_EMPTY_TB
	self.optionId = info.optionId or 0
	self.addAttriButes = CritterHelper.getInitClassMOList(info.addAttributes, CritterAttributeInfoMO, self.addAttriButes)
end

function CritterTrainOptionInfoMO:getAddAttriuteInfoById(attrId)
	for _, v in pairs(self.addAttriButes) do
		if v.attributeId == attrId then
			return v
		end
	end
end

return CritterTrainOptionInfoMO
