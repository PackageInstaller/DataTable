-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/components/ViewResLoadItem.lua

module("logiccommon.common.components.ViewResLoadItem", package.seeall)

local ViewResLoadItem = class("ViewResLoadItem")

function ViewResLoadItem:ctor()
	return
end

function ViewResLoadItem:clear()
	self:reset()
end

function ViewResLoadItem:reset()
	self.key = nil
	self.mainAsset = nil
	self.go = nil
	self.resPath = nil
	self.loadedCallback = nil
	self.loadedCallbackObj = nil
end

return ViewResLoadItem
