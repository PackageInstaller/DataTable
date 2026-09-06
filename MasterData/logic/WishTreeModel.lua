-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/model/WishTreeModel.lua

module("logic.extensions.wishtree.model.WishTreeModel", package.seeall)

local WishTreeModel = class("WishTreeModel", BaseModel)

function WishTreeModel:ctor()
	return
end

function WishTreeModel:onInit()
	self:onReset()
end

function WishTreeModel:onReset()
	self._activityId = 0
	self._isRecharge = nil
	self._items = {}
	self._isAddValue = nil
end

function WishTreeModel:getActivityId()
	return self._activityId
end

function WishTreeModel:isRecharge()
	return self._isRecharge
end

function WishTreeModel:getItems()
	return self._items
end

function WishTreeModel:getIsAddValue()
	return self._isAddValue
end

function WishTreeModel:setIsAddValue(value)
	self._isAddValue = value
end

function WishTreeModel:handleWishTreeInfoRes(msg)
	self._activityId = msg.activityId
	self._isRecharge = msg.isRecharge
	self._items = msg.items
end

WishTreeModel.instance = WishTreeModel.New()

return WishTreeModel
