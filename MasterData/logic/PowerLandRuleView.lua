-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/PowerLandRuleView.lua

module("logic.extensions.powerland.view.PowerLandRuleView", package.seeall)

local PowerLandRuleView = class("PowerLandRuleView", ViewComponent)

function PowerLandRuleView:ctor()
	PowerLandRuleView.super.ctor(self)
end

function PowerLandRuleView:buildUI()
	PowerLandRuleView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnL = self:getBtn("btnL")
	self._btnR = self:getBtn("btnR")
	self._imgRule = self:getGo("imgRule")
end

function PowerLandRuleView:bindEvents()
	PowerLandRuleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnL, function()
		self:_onClickChange(-1)
	end, self)
	GameUtil.addClickHandler(self._btnR, function()
		self:_onClickChange(1)
	end, self)
end

function PowerLandRuleView:unbindEvents()
	PowerLandRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnL)
	GameUtil.rmClickHandler(self._btnR)
end

function PowerLandRuleView:onEnter()
	PowerLandRuleView.super.onEnter(self)

	self._iconPathList = PowerLandRuleViewPresentor.IconPath
	self._minPageIdx = 1
	self._maxPageIdx = #self._iconPathList
	self._finishCallBack = self:getFirstParam()
	self._curPageIdx = self._minPageIdx

	self:_onUpdateImage()
end

function PowerLandRuleView:onExit()
	PowerLandRuleView.super.onExit(self)
	uGuiUtil.clearImage(self._imgRule)
end

function PowerLandRuleView:_onClickChange(delta)
	self._curPageIdx = Mathf.Clamp(self._curPageIdx + delta, self._minPageIdx, self._maxPageIdx)

	self:_onUpdateImage()
end

function PowerLandRuleView:_onUpdateImage()
	local isInHome = self._curPageIdx == self._minPageIdx
	local isInLast = self._curPageIdx == self._maxPageIdx

	GameUtil.SetActive(self._btnL, not isInHome)
	GameUtil.SetActive(self._btnR, not isInLast)

	local path = self._iconPathList[self._curPageIdx]
	local bgGo = self._imgRule

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = path

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end
end

function PowerLandRuleView:_onClickClose()
	self:close()
	GameUtil.callBack(self._finishCallBack)
end

return PowerLandRuleView
