-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/model/ThroneMo.lua

module("logic.extensions.throne.model.ThroneMo", package.seeall)

local ThroneMo = class("ThroneMo", MaterialMo)

function ThroneMo:ctor()
	ThroneMo.super.ctor(self)

	self.level = 0
	self.quality = 0
end

function ThroneMo:initData(matType, id, num)
	ThroneMo.super.initData(self, matType, id, num)

	local cfg = ThroneConfig.instance:getThroneCfg(id)

	self.quality = cfg.quality
end

function ThroneMo:setLevel(lv)
	self.level = lv
end

function ThroneMo:getLevel()
	return self.level
end

function ThroneMo:clone()
	local item = ThroneMo.New()

	item:initData(self.type, self.id, self.num)
	item:setLevel(self.level)

	return item
end

return ThroneMo
