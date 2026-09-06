-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/ItemServerArea.lua

module("logic.extensions.login.view.ItemServerArea", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemServerArea = class("ItemServerArea")
local areaName = {
	"天空之城"
}

function ItemServerArea:ctor(cell)
	self._go = cell
	self._imgSpriteChange = cell:GetComponent("UIImageSpriteChange")
	self._txtArea = goutil.findChildComponent(cell, "txtArea", "Text")
	self._shadow = goutil.findChildComponent(cell, "txtArea", "Shadow")
	self._uigradient = goutil.findChildComponent(cell, "txtArea", "UIGradient")

	Framework.ButtonAdapter.Get(cell.gameObject):AddClickListener(self._onClickSelf, self)
end

function ItemServerArea.AddOnce(go)
	local component = LuaComponentContainer.Get(go, ItemServerArea)

	component = component or LuaComponentContainer.Add(go, ItemServerArea)

	return component
end

function ItemServerArea.Remove(go)
	LuaComponentContainer.Remove(go, ItemServerArea)
end

function ItemServerArea:refresh(index)
	if index == 0 then
		self._txtArea.text = "推荐岛"
	elseif index <= #areaName then
		self._txtArea.text = areaName[index] or tostring(index)
	end

	self:setSeleted(false)
end

function ItemServerArea:setSeleted(selected)
	self._imgSpriteChange:SetState(selected and 0 or 1)

	self._shadow.enabled = selected
	self._uigradient.enabled = not selected
end

function ItemServerArea:_onClickSelf()
	self:setSeleted(true)
end

return ItemServerArea
