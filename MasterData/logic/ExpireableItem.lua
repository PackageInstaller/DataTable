-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeditem/model/ExpireableItem.lua

module("logic.extensions.timeditem.model.ExpireableItem", package.seeall)

local ExpireableItem = class("ExpireableItem", MaterialMo)

function ExpireableItem:ctor()
	ExpireableItem.super.ctor(self)

	self.id = -1
	self.defineId = -1
	self.expiredTimeMillis = -1
end

function ExpireableItem:setData(data)
	if data then
		self:initData(MatType.ExpirableItem, data.id, 1)

		self.defineId = data.defineId
		self.expiredTimeMillis = data.expiredTimeMillis
	end
end

function ExpireableItem:getDefineId()
	return self.defineId
end

function ExpireableItem:getExpiredTimeMillis()
	return checkint(self.expiredTimeMillis)
end

return ExpireableItem
