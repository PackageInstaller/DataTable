-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/toptoast/CharacterTopToastTipsView.lua

module("logic.extensions.charactersystem.view.toptoast.CharacterTopToastTipsView", package.seeall)

local M = class("CharacterTopToastTipsView", ViewComponent)

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._txtContent = self:getUIComponent("charactersystem_top_item_644059898", UIComponentType.TextMeshProUGUI)
	self._imgIcon = self:getImage("charactersystem_top_item_1131505682")
end

function M:destroyUI()
	self:_releaseTween()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter(reasonTyp)
	self:_releaseTween()
	self._guiAnimation:StopTimelineAni()

	self._canvasGroup.alpha = 0

	local info = self:getFirstParam()

	self._txtContent.text = info.content

	local icon = info.topToastIcon

	if string.nilorempty(icon) then
		icon = CommEnum.CharacterTopToastIcon.Info
	end

	IconLoader.setSprite(self._imgIcon, IconType.Skinlib, icon)
	self._guiAnimation:PlayAniByName("open")

	local delayHide = info.delayHide or 1
	local isPermanent = info.isPermanent

	if not isPermanent then
		self._delayTween = DoTweenUtil.DelayedCall(delayHide, function()
			self:close()
		end)
	end
end

function M:onExit(reasonTyp)
	self:_releaseTween()
end

function M:_releaseTween()
	if self._delayTween then
		self._delayTween:Kill(false)
	end

	self._delayTween = nil
end

return M
