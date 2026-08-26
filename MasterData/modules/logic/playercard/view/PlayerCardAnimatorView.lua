-- chunkname: @modules/logic/playercard/view/PlayerCardAnimatorView.lua

module("modules.logic.playercard.view.PlayerCardAnimatorView", package.seeall)

local PlayerCardAnimatorView = class("PlayerCardAnimatorView", BaseView)

function PlayerCardAnimatorView:onInitView()
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goBottom = gohelper.findChild(self.viewGO, "Bottom")
	self.goBg = gohelper.findChild(self.goBottom, "bg")
end

function PlayerCardAnimatorView:addEvents()
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.CloseLayout, self.onCloseLayout, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.ShowTheme, self.onShowTheme, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
end

function PlayerCardAnimatorView:removeEvents()
	return
end

function PlayerCardAnimatorView:onShowTheme()
	self.animator:Play("switch1", 0, 0)

	self._inThemeView = true

	gohelper.setActive(self.goBottom, true)
end

function PlayerCardAnimatorView:closeThemeView()
	self.animator:Play("switch2", 0, 0)

	self._inThemeView = false

	gohelper.setActive(self.goBottom, false)
end

function PlayerCardAnimatorView:onOpenView(viewName)
	if viewName == ViewName.PlayerCardLayoutView then
		self.animator:Play("layout1", 0, 0)
	end
end

function PlayerCardAnimatorView:onCloseLayout()
	self.animator:Play("layout2", 0, 0)
end

function PlayerCardAnimatorView:isInThemeView()
	return self._inThemeView
end

function PlayerCardAnimatorView:onClose()
	return
end

return PlayerCardAnimatorView
