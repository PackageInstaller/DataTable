-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/XiuNuoBrotherhoodTipView.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodTipView", package.seeall)

local XiuNuoBrotherhoodTipView = class("XiuNuoBrotherhoodTipView", ViewComponent)

function XiuNuoBrotherhoodTipView:buildUI()
	XiuNuoBrotherhoodTipView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnL = self:getBtn("btnL")
	self._btnR = self:getBtn("btnR")
	self._imgRule = self:getGo("imgRule")
	self._txtintro = self:getTxt("txt")
end

function XiuNuoBrotherhoodTipView:bindEvents()
	XiuNuoBrotherhoodTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnL, function()
		self:_onClickChange(-1)
	end, self)
	GameUtil.addClickHandler(self._btnR, function()
		self:_onClickChange(1)
	end, self)
end

function XiuNuoBrotherhoodTipView:unbindEvents()
	XiuNuoBrotherhoodTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnL)
	GameUtil.rmClickHandler(self._btnR)
end

function XiuNuoBrotherhoodTipView:onEnter()
	XiuNuoBrotherhoodTipView.super.onEnter(self)

	self._ruleId = 1
	self._resourceFolder = "xiunuobrotherhood"
	self._iconPathList = {
		"board_tzxn_08",
		"board_tzxn_07"
	}
	self._minPageIdx = 1
	self._maxPageIdx = #self._iconPathList
	self._curPageIdx = self._minPageIdx

	self:_onUpdateImage()
end

function XiuNuoBrotherhoodTipView:onExit()
	XiuNuoBrotherhoodTipView.super.onExit(self)
	uGuiUtil.clearImage(self._imgRule)
end

function XiuNuoBrotherhoodTipView:_onClickChange(delta)
	self._curPageIdx = Mathf.Clamp(self._curPageIdx + delta, self._minPageIdx, self._maxPageIdx)

	self:_onUpdateImage()
end

function XiuNuoBrotherhoodTipView:_onUpdateImage()
	local isInHome = self._curPageIdx == self._minPageIdx
	local isInLast = self._curPageIdx == self._maxPageIdx

	GameUtil.SetActive(self._btnL, not isInHome)
	GameUtil.SetActive(self._btnR, not isInLast)

	local path = self._iconPathList[self._curPageIdx]
	local bgGo = self._imgRule

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = GameUrl.getBigbgFolderUrl(self._resourceFolder, path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	if self._txtintro ~= nil and not string.nilorempty(self._iconPathList[self._curPageIdx].desc) then
		self._txtintro.text = self._iconPathList[self._curPageIdx].desc
	end
end

function XiuNuoBrotherhoodTipView:_onClickClose()
	self:close()
end

return XiuNuoBrotherhoodTipView
