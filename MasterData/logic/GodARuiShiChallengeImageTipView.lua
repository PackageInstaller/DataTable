-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/view/GodARuiShiChallengeImageTipView.lua

module("logic.extensions.godaruishichallenge.view.GodARuiShiChallengeImageTipView", package.seeall)

local GodARuiShiChallengeImageTipView = class("GodARuiShiChallengeImageTipView", ViewComponent)

function GodARuiShiChallengeImageTipView:buildUI()
	GodARuiShiChallengeImageTipView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnL = self:getBtn("btnL")
	self._btnR = self:getBtn("btnR")
	self._imgRule = self:getGo("imgRule")
	self._txtintro = self:getTxt("txt")
end

function GodARuiShiChallengeImageTipView:bindEvents()
	GodARuiShiChallengeImageTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnL, function()
		self:_onClickChange(-1)
	end, self)
	GameUtil.addClickHandler(self._btnR, function()
		self:_onClickChange(1)
	end, self)
end

function GodARuiShiChallengeImageTipView:unbindEvents()
	GodARuiShiChallengeImageTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnL)
	GameUtil.rmClickHandler(self._btnR)
end

function GodARuiShiChallengeImageTipView:onEnter()
	GodARuiShiChallengeImageTipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._ruleId = params[1]
	self._resourceFolder = params[2]
	self._iconPathList = GodARuiShiChallengeConfig.instance:getRuleList(self._ruleId)
	self._minPageIdx = 1
	self._maxPageIdx = #self._iconPathList
	self._curPageIdx = self._minPageIdx

	self:_onUpdateImage()
end

function GodARuiShiChallengeImageTipView:onExit()
	GodARuiShiChallengeImageTipView.super.onExit(self)
	uGuiUtil.clearImage(self._imgRule)
end

function GodARuiShiChallengeImageTipView:_onClickChange(delta)
	self._curPageIdx = Mathf.Clamp(self._curPageIdx + delta, self._minPageIdx, self._maxPageIdx)

	self:_onUpdateImage()
end

function GodARuiShiChallengeImageTipView:_onUpdateImage()
	local isInHome = self._curPageIdx == self._minPageIdx
	local isInLast = self._curPageIdx == self._maxPageIdx

	GameUtil.SetActive(self._btnL, not isInHome)
	GameUtil.SetActive(self._btnR, not isInLast)

	local path = self._iconPathList[self._curPageIdx].resName
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

function GodARuiShiChallengeImageTipView:_onClickClose()
	self:close()
end

return GodARuiShiChallengeImageTipView
