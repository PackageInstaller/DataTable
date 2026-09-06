-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripehud/view/HolyStripeHudTipView.lua

module("logic.extensions.holystripehud.view.HolyStripeHudTipView", package.seeall)

local HolyStripeHudTipView = class("HolyStripeHudTipView", ViewComponent)

function HolyStripeHudTipView:buildUI()
	HolyStripeHudTipView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnL = self:getBtn("btnL")
	self._btnR = self:getBtn("btnR")
	self._imgRule = self:getGo("imgRule")
	self._txtintro = self:getTxt("txt")
end

function HolyStripeHudTipView:bindEvents()
	HolyStripeHudTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnL, function()
		self:_onClickChange(-1)
	end, self)
	GameUtil.addClickHandler(self._btnR, function()
		self:_onClickChange(1)
	end, self)
end

function HolyStripeHudTipView:unbindEvents()
	HolyStripeHudTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnL)
	GameUtil.rmClickHandler(self._btnR)
end

function HolyStripeHudTipView:onEnter()
	HolyStripeHudTipView.super.onEnter(self)

	self._iconPathList = HolyStripeConfig.instance:getHudRuleCfgs()
	self._minPageIdx = 1
	self._maxPageIdx = #self._iconPathList
	self._curPageIdx = self._minPageIdx

	self:_onUpdateImage()
end

function HolyStripeHudTipView:onExit()
	HolyStripeHudTipView.super.onExit(self)
	uGuiUtil.clearImage(self._imgRule)
end

function HolyStripeHudTipView:_onClickChange(delta)
	self._curPageIdx = Mathf.Clamp(self._curPageIdx + delta, self._minPageIdx, self._maxPageIdx)

	self:_onUpdateImage()
end

function HolyStripeHudTipView:_onUpdateImage()
	local isInHome = self._curPageIdx == self._minPageIdx
	local isInLast = self._curPageIdx == self._maxPageIdx

	GameUtil.SetActive(self._btnL, not isInHome)
	GameUtil.SetActive(self._btnR, not isInLast)

	local path = self._iconPathList[self._curPageIdx].resName
	local bgGo = self._imgRule

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = GameUrl.getBigbgFolderUrl("holystirpe", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	self._txtintro.text = self._iconPathList[self._curPageIdx].desc
end

function HolyStripeHudTipView:_onClickClose()
	self:close()
end

return HolyStripeHudTipView
