-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpGameItem.lua

module("logic.extensions.jumpgame.view.JumpGameItem", package.seeall)

local JumpGameItem = class("JumpGameItem")

function JumpGameItem.AddOnce(go)
	local component = JumpGameItem.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, JumpGameItem)

	return component
end

function JumpGameItem.Remove(go)
	Framework.LuaComponentContainer.Remove(go, JumpGameItem)
end

function JumpGameItem.Get(go)
	return (Framework.LuaComponentContainer.Get(go, JumpGameItem))
end

function JumpGameItem:ctor()
	self._itemMo = nil
	self._get = false
end

function JumpGameItem:initItem(mo)
	self._itemMo = mo
end

function JumpGameItem:getItem()
	return self._itemMo
end

function JumpGameItem:hasGet()
	self._get = true
end

function JumpGameItem:returnGetTag()
	return self._get
end

return JumpGameItem
