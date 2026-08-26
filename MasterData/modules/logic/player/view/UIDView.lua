-- chunkname: @modules/logic/player/view/UIDView.lua

module("modules.logic.player.view.UIDView", package.seeall)

local UIDView = class("UIDView", UserDataDispose)
local minRate = 1.7777777777777777
local maxRate = 2.25
local rateRange = maxRate - minRate
local minRateAnchorX = 56
local maxRateAnchor = 135

function UIDView.getInstance()
	if not UIDView.instance then
		UIDView.instance = UIDView.New()

		UIDView.instance:__onInit()
	end

	return UIDView.instance
end

function UIDView:hidePlayerId()
	if self._txtId then
		self._txtId.text = ""
	end
end

function UIDView:showPlayerId()
	if not self._txtId then
		self:loadPrefab()

		return
	end

	self._txtId.text = "ID : " .. PlayerModel.instance:getMyUserId()
end

function UIDView:loadPrefab()
	if self.loader then
		return
	end

	local path = "ui/viewres/common/uid.prefab"
	local goIDPopup = gohelper.find("IDCanvas/POPUP")

	self.loader = PrefabInstantiate.Create(goIDPopup)

	self.loader:startLoad(path, self.loadedCallback, self)
end

function UIDView:loadedCallback()
	self.tr = self.loader:getInstGO().transform
	self._txtId = gohelper.findChildText(self.loader:getInstGO(), "#txt_id")

	self:showPlayerId()
	self:setAnchorPos()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.setAnchorPos, self)
end

function UIDView:setAnchorPos()
	local width, height = GameGlobalMgr.instance:getScreenState():getScreenSize()
	local rate = width / height
	local lerpValue = (rate - minRate) / rateRange
	local anchorX = Mathf.Lerp(minRateAnchorX, maxRateAnchor, lerpValue)

	recthelper.setAnchorX(self.tr, anchorX)
end

return UIDView
