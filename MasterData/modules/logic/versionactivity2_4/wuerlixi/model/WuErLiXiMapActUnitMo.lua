-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/model/WuErLiXiMapActUnitMo.lua

module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapActUnitMo", package.seeall)

local WuErLiXiMapActUnitMo = pureTable("WuErLiXiMapActUnitMo")

function WuErLiXiMapActUnitMo:ctor()
	self.id = 0
	self.type = 0
	self.count = 0
	self.dir = 0
end

function WuErLiXiMapActUnitMo:init(str)
	local unitCos = string.splitToNumber(str, "#")

	self.type = unitCos[1]
	self.count = unitCos[2]
	self.dir = unitCos[3]
	self.id = unitCos[4] or unitCos[1]
end

return WuErLiXiMapActUnitMo
