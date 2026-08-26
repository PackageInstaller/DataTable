-- chunkname: @modules/logic/versionactivity1_4/act133/model/Activity133ListMO.lua

module("modules.logic.versionactivity1_4.act133.model.Activity133ListMO", package.seeall)

local Activity133ListMO = pureTable("Activity133ListMO")

function Activity133ListMO:init(co)
	self.actid = co.activityId
	self.id = co.id
	self.config = co
	self.desc = co.desc
	self.icon = co.icon
	self.bonus = co.bonus
	self.needTokens = co.needTokens
	self.title = co.title
	self.pos = co.pos
end

function Activity133ListMO:isLock()
	return false
end

function Activity133ListMO:isReceived()
	return Activity133Model.instance:checkBonusReceived(self.id)
end

function Activity133ListMO:getPos()
	local pos = string.split(self.pos, "#")

	return pos[1], pos[2]
end

return Activity133ListMO
