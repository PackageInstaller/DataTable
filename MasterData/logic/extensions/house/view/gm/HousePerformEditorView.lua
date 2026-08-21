-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/gm/HousePerformEditorView.lua

module("logic.extensions.house.view.gm.HousePerformEditorView", package.seeall)

local M = class("HousePerformEditorView", ViewComponent)

function M:buildUI()
	self._btnBreak = self:getBtn("house_perform_editor_-1664799026")
	self._toggle = self:getUIComponent("house_perform_editor_882531277", UIComponentType.SpaceXToggle)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnBreak:AddClickListener(self._onClickBtnBreak, self)
	self._toggle:AddListener(self._onToggle, self)
end

function M:unbindEvents()
	self._btnBreak:RemoveClickListener()
	self._toggle:RemoveListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:_onClickBtnBreak()
	HouseEditorHelper.instance:breakCurrPerform()
end

function M:_onToggle(toggle, isOn)
	HouseEditorHelper.instance:setSignVisible(isOn)
end

return M
