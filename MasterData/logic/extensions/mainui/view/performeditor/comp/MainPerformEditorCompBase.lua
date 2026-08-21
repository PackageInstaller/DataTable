-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/comp/MainPerformEditorCompBase.lua

module("logic.extensions.mainui.view.performeditor.comp.MainPerformEditorCompBase", package.seeall)

local M = class("MainPerformEditorCompBase")

function M:ctor(mainGo)
	self.mainGO = mainGo.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	return
end

function M:destroyUI()
	self:setHandler(nil)

	self.mainGO = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:getMainGo()
	return self.mainGO
end

function M:activeView(show)
	if show and not self:canShow() then
		show = false
	end

	goutil.setActive(self:getMainGo().gameObject, show)

	if show then
		self:onEnter()
	else
		self:onExit()
	end
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getPoint()
	local handler = self:getHandler()

	if handler then
		return handler:getPoint()
	end

	return nil
end

function M:IsDataDirty()
	return false
end

function M:canShow()
	return true
end

function M:onEditHeroChange(heroId)
	return
end

return M
