-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/performeditor/MainUIDetectView.lua

module("logic.extensions.mainui.view.performeditor.MainUIDetectView", package.seeall)

local M = class("MainUIDetectView", ViewComponent)
local officalGameScale = 1
local officalResolutionWidth = 2340
local officalResolutionHeight = 1080
local officalResolutionWidth2 = 1624
local officalResolutionHeight2 = 750
local officalGameQualityLv = 1

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._goRoot = self:getGo("main_ui_detect_1455832827")

	goutil.setActive(self._goRoot, true)

	self._goUnofficialNode = self:getGo("main_ui_detect_-608898296")
	self._txtStatusInSide = self:getText("main_ui_detect_1738529959")
	self._goStatusOffical = self:getGo("main_ui_detect_1157767990")
	self._goStatusUnoffical = self:getGo("main_ui_detect_-1878517657")
	self._goUnofficalEyeOpen = self:getGo("main_ui_detect_191160913")
	self._goUnofficalEyeClose = self:getGo("main_ui_detect_-1091703252")
	self._goUnofficalDetailView = self:getGo("main_ui_detect_-43010068")
	self._toggleUnofficalGameScale = self:getUIComponent("main_ui_detect_-1449402888", UIComponentType.SpaceXToggle)
	self._toggleUnofficalGameResolution = self:getUIComponent("main_ui_detect_-538672347", UIComponentType.SpaceXToggle)
	self._toggleUnofficalGameQualityLv = self:getUIComponent("main_ui_detect_-53559973", UIComponentType.SpaceXToggle)
	self._transfUnofficalShow = self:getRectTransform("main_ui_detect_-608898296")
	self.raycastProxy = RaycastProxy.Get(self:getGo("main_ui_detect_-608898296"))

	self.raycastProxy:SetClickListener(self._onClickUnofficalShow, self)
	self.raycastProxy:SetBeginDragListener(self._onBeginDrag, self)
	self.raycastProxy:SetDragListener(self._onDrag, self)
	self.raycastProxy:SetEndDragListener(self._onEndDrag, self)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	if not Astral.OSDef.isEditor then
		self:close()

		return
	end

	self:setEvent(true)
	self:refreshUnOffical()
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickUnofficalShow()
	local show = not self._UnofficalShow

	self._UnofficalShow = show

	goutil.setActive(self._goUnofficalDetailView, show)
	goutil.setActive(self._goUnofficalEyeOpen, not show)
	goutil.setActive(self._goUnofficalEyeClose, show)

	if show then
		self._toggleUnofficalGameScale.IsOn = not self:_checkUnofficalGameScale()
		self._toggleUnofficalGameResolution.IsOn = not self:_checkUnofficalGameResolution()
		self._toggleUnofficalGameQualityLv.IsOn = not self:_checkUnofficalGameQualityLv()

		local isUnoffical = self:checkUIUnoffical()

		self._txtStatusInSide.text = isUnoffical and "非正式UI效果" or "正式UI效果"

		goutil.setActive(self._goStatusOffical, not isUnoffical)
		goutil.setActive(self._goStatusUnoffical, isUnoffical)
	end
end

function M:refreshUnOffical()
	local isUnoffical = self:checkUIUnoffical()

	self._txtStatusInSide.text = isUnoffical and "非正式UI效果" or "正式UI效果"

	goutil.setActive(self._goStatusOffical, not isUnoffical)
	goutil.setActive(self._goStatusUnoffical, isUnoffical)
	goutil.setActive(self._goUnofficalDetailView, false)
	goutil.setActive(self._goUnofficalEyeOpen, true)
	goutil.setActive(self._goUnofficalEyeClose, false)
end

function M:checkUIUnoffical()
	local isUnoffical = false

	if self:_checkUnofficalGameScale() then
		isUnoffical = true
	end

	if not isUnoffical and self:_checkUnofficalGameResolution() then
		isUnoffical = true
	end

	if not isUnoffical and self:_checkUnofficalGameQualityLv() then
		isUnoffical = true
	end

	return isUnoffical
end

function M:_checkUnofficalGameScale()
	local isUnoffical = false
	local scale = EditorHelperUtils.GetGameViewScale(0)

	if scale ~= officalGameScale then
		isUnoffical = true
	end

	return isUnoffical
end

function M:_checkUnofficalGameResolution()
	local isUnoffical = false
	local screenWidth, screenHeight = EditorHelperUtils.GetGameViewSize(0, 0)

	if (screenWidth ~= officalResolutionWidth or screenHeight ~= officalResolutionHeight) and (screenWidth ~= officalResolutionWidth2 or screenHeight ~= officalResolutionHeight2) then
		isUnoffical = true
	end

	return isUnoffical
end

function M:_checkUnofficalGameQualityLv()
	local isUnoffical = false
	local dpiQuality = PlayerLocalStorageModel.instance:getResolutionRatioQuality()

	if dpiQuality ~= 3 then
		isUnoffical = true
	end

	local effectQuality = PlayerLocalStorageModel.instance:getEffectQuality()

	if effectQuality ~= 3 then
		isUnoffical = true
	end

	return isUnoffical
end

function M:_onBeginDrag(posX, posY, pointerId)
	self._beginDragX = posX
	self._beginDragY = posY
	self._goBeginDragX = self._transfUnofficalShow.localPosition.x
	self._goBeginDragY = self._transfUnofficalShow.localPosition.y
end

function M:_onDrag(posX, posY, pointerId)
	local deltaX = posX - self._beginDragX
	local deltaY = posY - self._beginDragY
	local x = self._goBeginDragX + deltaX
	local y = self._goBeginDragY + deltaY

	Astral.TransformUtil.SetLocalPos(self._transfUnofficalShow, x, y, 0)
end

function M:_onEndDrag(posX, posY, pointerId)
	return
end

return M
