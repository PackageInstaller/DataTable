-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/view/CommonPopSpineScreenView.lua

module("logic.extensions.spineinterface.view.CommonPopSpineScreenView", package.seeall)

local CommonPopSpineScreenView = class("CommonPopSpineScreenView", ViewComponent)
local POSITIONS = {
	[1803101000] = {
		scale = 0.71,
		x = 0,
		y = -360
	},
	[1202105000] = {
		scale = 0.71,
		x = -15,
		y = -355
	},
	[1702701000] = {
		scale = 0.71,
		x = 0,
		y = 0
	},
	[1802104000] = {
		scale = 0.71,
		x = 0,
		y = -355
	},
	[1803102000] = {
		scale = 0.72,
		x = 0,
		y = -362
	}
}

function CommonPopSpineScreenView:buildUI()
	CommonPopSpineScreenView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._blackMask = self:getGo("blackMask")
	self._con = self:getGo("con")
	self._triggerPlane = self:getGo("triggerPlane")

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._con.transform, 0, 0, 0)
	local scale = Framework.TransformUtil.GetLocalScale(self._con.transform, 0, 0, 0)

	self._defaultConSize = {
		x = x,
		y = y,
		scale = scale
	}
end

function CommonPopSpineScreenView:bindEvents()
	CommonPopSpineScreenView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, GameUtil.handler(self._onClikClose, self))
end

function CommonPopSpineScreenView:unbindEvents()
	CommonPopSpineScreenView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CommonPopSpineScreenView:onEnter()
	CommonPopSpineScreenView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._spineInterfaceComp = params[1]
	self._screenSkinId = checknumber(params[2])
	self._faceSkinId = self._spineInterfaceComp:getSkinId()

	GameUtil.SetActive(self._blackMask, true)

	self._graphicSpineLoadHelp = self._graphicSpineLoadHelp or GraphicSpineLoadHelp.New()

	self:_loadSpine()
	self.addGEvent(self, "commonpopspinescreenclose", self._commoPopSpineScreenClose, self)
	self._spineInterfaceComp:setHostSuspended(true)
end

function CommonPopSpineScreenView:onExit()
	CommonPopSpineScreenView.super.onExit(self)
	self._spineInterfaceComp:setHostSuspended(false)
	removetimer(self._setActiveBlackMaskFalse, self)
	self:_unloadSpine()
end

function CommonPopSpineScreenView:destroyUI()
	CommonPopSpineScreenView.super.destroyUI(self)

	self._graphicSpineLoadHelp = nil
end

function CommonPopSpineScreenView:_commoPopSpineScreenClose()
	self:close()
end

function CommonPopSpineScreenView:_setActiveBlackMaskFalse()
	GameUtil.SetActive(self._blackMask, false)
end

function CommonPopSpineScreenView:_loadSpine()
	local spineRoot = self._con
	local view = self
	local urlPath = SpineInterfaceConfig.instance:getSpineUrl(self._screenSkinId)

	if not POSITIONS[self._screenSkinId] then
		GameUtil.setLocalPos(spineRoot, POSITIONS[self._screenSkinId].x, POSITIONS[self._screenSkinId].y)
		GameUtil.setLocalScale(spineRoot, POSITIONS[self._screenSkinId].scale)

		self._spineCtrl = self._graphicSpineLoadHelp:loadSpine(urlPath, spineRoot, view)

		self._graphicSpineLoadHelp:regCallBackOfSpineLoaded(function()
			self:_addSpineInterface(self._screenSkinId, self._spineCtrl:getSpineGo())
			settimer(0.05, self._setActiveBlackMaskFalse, self, false)
		end)
	end
end

function CommonPopSpineScreenView:_unloadSpine()
	self:_rmSpineInterface()

	if self._graphicSpineLoadHelp then
		self._spineCtrl = nil

		self._graphicSpineLoadHelp:unloadSpine()
	end
end

function CommonPopSpineScreenView:_addSpineInterface(skinId, spineGo)
	local spineGoRect = spineGo:GetComponent(goutil.Type_RectTransform)

	self._spineComp = SpineInterfaceComp.reloadSpineGo(self._spineComp, self._triggerPlane, skinId, spineGo, spineGoRect)
end

function CommonPopSpineScreenView:_rmSpineInterface()
	if self._spineComp then
		self._spineComp:unload()
	end
end

function CommonPopSpineScreenView:_onClikClose()
	self:close()
end

return CommonPopSpineScreenView
