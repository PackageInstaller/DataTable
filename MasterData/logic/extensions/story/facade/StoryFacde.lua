-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/facade/StoryFacde.lua

module("logic.extensions.story.facade.StoryFacde", package.seeall)

local M = class("StoryFacde", BaseFacade)

function M:ctor()
	return
end

function M:registerView(view)
	local views = view._viewPresentor._views

	self._isRegistered = true
	self._uiElementView = views[1]
	self._afflatuseEffectView = views[2]
	self._operateView = views[4]
	self._radioView = views[6]
end

function M:unregisterView()
	if not self:_checkView() then
		return false
	end

	self._isRegistered = false
	self._uiElementView = false
	self._afflatuseEffectView = false
end

function M:_checkView()
	if not self._isRegistered then
		printWarn("StoryMainView:need to register view first!")

		return false
	end

	return true
end

function M:tryNextShot()
	if self:_checkView() then
		self._operateView:tryNextShot()
	end
end

function M:showAll(key)
	self:setElementVisible(StoryUIElement.All, true, key)
end

function M:hideAll(key)
	self:setElementVisible(StoryUIElement.All, false, key)
end

function M:setElementVisible(elementEnum, visible, key)
	if self:_checkView() then
		self._uiElementView:setElementVisible(elementEnum, visible, key)
	else
		StoryViewStateModel.instance:setUIElementVisible(elementEnum, visible, key)
	end
end

function M:setAfflatuseEffect(visible)
	if self:_checkView() then
		self._afflatuseEffectView:setVisible(visible)
	end
end

function M:closeAfflatuseMask(isClose)
	if self:_checkView() then
		self._afflatuseEffectView:closeAfflatuseMask(isClose)
	end
end

function M:hasAfflastuseEffect()
	if self:_checkView() then
		return self._afflatuseEffectView:hasAfflastuseEffect()
	end

	return false
end

function M:hasAttrOption()
	if self:_checkView() then
		return self._radioView:hasAttrOption()
	end

	return false
end

function M:setSkipState(enable)
	if self:_checkView() then
		self._operateView:setSkipState(enable)
	end
end

M.instance = M.New()

return M
