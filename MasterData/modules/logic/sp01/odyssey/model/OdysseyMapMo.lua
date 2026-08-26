-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyMapMo.lua

module("modules.logic.sp01.odyssey.model.OdysseyMapMo", package.seeall)

local OdysseyMapMo = pureTable("OdysseyMapMo")

function OdysseyMapMo:init(id)
	self.id = id
	self.config = OdysseyConfig.instance:getDungeonMapConfig(id)
end

function OdysseyMapMo:updateInfo(info)
	self.id = info.id
	self.exploreValue = info.exploreValue
end

function OdysseyMapMo:isFullExplore()
	return self.exploreValue == 1000
end

return OdysseyMapMo
