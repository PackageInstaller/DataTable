-- chunkname: @modules/logic/season/model/Activity104SpecialMo.lua

local Activity104SpecialMo = pureTable("Activity104SpecialMo")

function Activity104SpecialMo:ctor()
	self.layer = 0
	self.state = 0
end

function Activity104SpecialMo:init(info)
	self.layer = info.layer
	self.state = info.state
end

function Activity104SpecialMo:reset(info)
	self.layer = info.layer
	self.state = info.state
end

return Activity104SpecialMo
