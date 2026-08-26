-- chunkname: @modules/logic/season/model/Activity104SelfChoiceMo.lua

local Activity104SelfChoiceMo = pureTable("Activity104SelfChoiceMo")

function Activity104SelfChoiceMo:ctor()
	return
end

function Activity104SelfChoiceMo:init(cfg)
	self.id = cfg.equipId
	self.cfg = cfg
end

return Activity104SelfChoiceMo
