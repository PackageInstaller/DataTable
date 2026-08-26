-- chunkname: @modules/logic/main/view/MainHeroMipView.lua

module("modules.logic.main.view.MainHeroMipView", package.seeall)

local MainHeroMipView = class("MainHeroMipView", BaseView)

function MainHeroMipView:addEvents()
	self.addEventCb(self, MainController.instance, MainEvent.HeroShowInScene, self._onHeroShowInScene, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, self._onCloseFullView, self)
end

function MainHeroMipView:removeEvents()
	self.removeEventCb(self, MainController.instance, MainEvent.HeroShowInScene, self._onHeroShowInScene, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onOpenFullView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, self._onCloseFullView, self)
end

function MainHeroMipView:onOpen()
	self._showInScene = true

	self:_enableMip(true)
end

function MainHeroMipView:onClose()
	self:_enableMip(false)
end

function MainHeroMipView:_onHeroShowInScene(showInScene)
	self._showInScene = showInScene

	self:_enableMip(true)
end

function MainHeroMipView:_onOpenFullView(viewName)
	self:_enableMip(false)
end

function MainHeroMipView:_onCloseFullView(viewName)
	local hasOpenAnyFullView = false
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for _, viewName in ipairs(openViewNameList) do
		if ViewMgr.instance:isFull(viewName) then
			hasOpenAnyFullView = true

			break
		end
	end

	if not hasOpenAnyFullView then
		self:_enableMip(true)
	end
end

function MainHeroMipView:_enableMip(enable)
	if enable then
		if not self._showInScene then
			UnityEngine.Shader.EnableKeyword("_USE_SIMULATE_HIGH_MIP")
		else
			UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_HIGH_MIP")
		end

		if self._showInScene then
			UnityEngine.Shader.EnableKeyword("_USE_SIMULATE_MIP")
		else
			UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_MIP")
		end

		logNormal(self._showInScene and "开启Mip" or "开启HighMip")
	else
		UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_HIGH_MIP")
		UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_MIP")
		logNormal("关闭所有Mip")
	end
end

return MainHeroMipView
