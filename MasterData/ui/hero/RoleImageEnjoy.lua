-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\RoleImageEnjoy.lua

local DOTweenComponent = typeof(Framework.EffectSystem.DOTweenComponent)
local DeviceHelper = require("Helper/DeviceHelper")
local RoleImage = require("UI/Control/Com/RoleImage")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local ResolutionWidth = 1920
local ResolutionHeight = 1080
local SCALE_SIZE_LIMIT = 2
local OUT_RANG_PX = 650
local strClassName = "RoleImageEnjoy"
local RoleImageEnjoy = Class("strClassName", UIControls.Child)

function RoleImageEnjoy:ctor()
	self:initUI()
end

function RoleImageEnjoy:initUI()
	self.enjoyPanel = UIControls.Button(self, "")

	self.enjoyPanel:addEventClick(Functor(self.onHideClick, self, true))

	self.btnHide = UIControls.Button(self, "BtnHide")

	self.btnHide:addEventClick(Functor(self.onHideClick, self, false))

	self.sharePanel = ShareAchievePanel(self, "SharePanel")

	self.sharePanel:setNoAwardInfo("HandBookHeroInfoDlg")

	self.slider = UIControls.Slider(self, "Slider")

	self.slider:addEventValueChanged(self.sliderValueChanged)
	self.sharePanel:setBeforeAction(self.onHideClick, self, false)
	self.sharePanel:setFinishAction(self.onHideClick, self, true)

	self.canvasBtnClose = self.mWindow.btnClose
end

function RoleImageEnjoy:setBtnEnjoy(parentBtn)
	self.btnEnjoy = parentBtn

	self.btnEnjoy:addEventClick(Slot(self.onEnjoyClick, self))
end

function RoleImageEnjoy:showEnjoyPanel(isShow)
	self:setVisible(isShow)
	self.btnEnjoy:setVisible(isShow)
end

function RoleImageEnjoy:addDrage(parent, roleImage, camp)
	if self.parentNode ~= parent then
		self.parentNodePosData = nil
		self.roleImageSizeData = nil
		self.parentNode = parent
		self.roleImage = roleImage
	end

	self:setRoleImageSizeData()
	self.slider:setValue(0)

	if camp and self.camp ~= camp then
		self.camp = camp
	end
end

function RoleImageEnjoy:setRoleImageSizeData()
	local roleImage = self.roleImage
	local roleImagePosData = roleImage:getPosition()
	local roleImageSize = roleImage:getSize()
	local roleImageScale = roleImage:getScale()

	if not self.parentNodePosData then
		local parentNodePos = self.parentNode:getPosition()
		local parentNodeSize = self.parentNode:getScale()

		self.parentNodePosData = {}
		self.parentNodePosData[1] = parentNodePos.x
		self.parentNodePosData[2] = parentNodePos.y
		self.parentNodePosData[3] = parentNodeSize.x
		self.parentNodePosData[4] = parentNodeSize.y
	end

	if not self.roleImageSizeData then
		self.roleImageSizeData = {}
	end

	local scaleX = roleImageScale.x

	scaleX = scaleX - scaleX % 0.01

	local scaleY = roleImageScale.y

	scaleY = scaleY - scaleY % 0.01
	self.roleImageSizeData[1] = roleImageSize.width / 2 * scaleX * self.parentNodePosData[3]
	self.roleImageSizeData[2] = roleImageSize.height / 2 * scaleY * self.parentNodePosData[4]
	self.roleImageSizeData[3] = scaleX
	self.roleImagePosData = roleImagePosData
	self.maxSize = SCALE_SIZE_LIMIT * self.roleImageSizeData[3]
	self.sliderMaxValue = (SCALE_SIZE_LIMIT - 1) * self.roleImageSizeData[3]
end

function RoleImageEnjoy:setPanelDragFunc()
	self.isAddDraged = true

	local screenWidth = DeviceHelper.screenWidth
	local screenHeight = DeviceHelper.screenHeight
	local canvasRatio = ResolutionWidth / screenWidth
	local defaultResolution = ResolutionWidth / ResolutionHeight
	local curResolution = screenWidth / screenHeight
	local realWidth, realHeight

	if defaultResolution <= curResolution then
		realWidth = screenWidth
		realHeight = ResolutionHeight
	else
		realWidth = ResolutionWidth
		realHeight = canvasRatio * screenHeight
	end

	local widthRatio = canvasRatio * realWidth
	local hightRatio = realHeight / screenHeight * ResolutionHeight
	local roleImageObj = self.roleImage

	local function onDrag(delta)
		if not self.isAppreciate then
			return
		end

		delta.x = delta.x * widthRatio / self.parentNodePosData[3]
		delta.y = delta.y * hightRatio / self.parentNodePosData[4]

		local curPos = roleImageObj:getPosition()
		local posX = curPos.x + delta.x
		local posY = curPos.y + delta.y
		local perRightX = ResolutionWidth / 2 - self.roleImageSizeData[1] - self.parentNodePosData[1]

		perRightX = perRightX / self.parentNodePosData[3] + OUT_RANG_PX

		local perLeftX = -ResolutionWidth / 2 + self.roleImageSizeData[1] - self.parentNodePosData[1]

		perLeftX = perLeftX / self.parentNodePosData[3] - OUT_RANG_PX

		local perTopY = realHeight / 2 - self.roleImageSizeData[2] - self.parentNodePosData[2]

		perTopY = perTopY / self.parentNodePosData[4] + OUT_RANG_PX

		local perBottomY = -realHeight / 2 + self.roleImageSizeData[2] - self.parentNodePosData[2]

		perBottomY = perBottomY / self.parentNodePosData[4] - OUT_RANG_PX

		if perRightX < posX or posX < perLeftX then
			posX = curPos.x
		end

		if perTopY < posY or posY < perBottomY then
			posY = curPos.y
		end

		roleImageObj:setPosition(posX, posY)
	end

	local ComponentDragPinchPanel = typeof(Framework.UI.UIDragPinchPanel)
	local go = roleImageObj:getGameObject()
	local csDragPinchPanel = go:AddComponent(ComponentDragPinchPanel)

	self.doTweenCom = go:AddComponent(DOTweenComponent)

	if csDragPinchPanel ~= nil then
		csDragPinchPanel:setDragFunc(onDrag)
		csDragPinchPanel:setPinchFunc(Slot(self.onPinchScale, self))
		csDragPinchPanel:setClickFunc(Slot(self.onClick, self))
	end
end

function RoleImageEnjoy:doMove(isStart, func)
	local endPos

	if isStart then
		endPos = Vector3(-self.parentNodePosData[1] + self.roleImagePosData.x, self.roleImagePosData.y, 0)
	else
		endPos = Vector3(self.roleImagePosData.x, self.roleImagePosData.y, 0)

		self.doTweenCom:Scale(self.roleImageSizeData[3], 1, 1)
	end

	self.doTweenCom:UITweenMove(endPos, 1, func)
end

function RoleImageEnjoy:onPinchScale(delta, sliderValue)
	if not self.isAppreciate then
		return
	end

	local roleImageObj = self.roleImage
	local curScale = roleImageObj:getScale()
	local targetScale

	if delta then
		targetScale = delta.x * 10 + curScale.x
	else
		targetScale = self.sliderMaxValue * sliderValue + self.roleImageSizeData[3]
	end

	if targetScale >= self.roleImageSizeData[3] and targetScale <= self.maxSize then
		roleImageObj:setScale(targetScale, targetScale, 1)

		local value = (targetScale - self.roleImageSizeData[3]) / self.sliderMaxValue

		self.slider:setValue(value)
	end
end

function RoleImageEnjoy:onClick()
	self:onHideClick(true)
end

function RoleImageEnjoy:sliderValueChanged(com, value)
	self:onPinchScale(nil, value)
end

function RoleImageEnjoy:showControlPanel(isShow)
	self.btnHide:setVisible(isShow)
	self.sharePanel:setVisible(isShow)
	self.slider:setVisible(isShow)
	self.btnEnjoy:setVisible(not isShow)
end

function RoleImageEnjoy:onEnjoyClick()
	self.mWindow:playAni("ShowEnjoyPanel")

	self.isAppreciate = true
	self.oldCloseName = self.canvasBtnClose:getText()

	self.canvasBtnClose:setText(Lang.get(63991))
	self:showControlPanel(true)

	if self.camp then
		if not self.bg then
			self.bg = UIControls.RawImage(self, "Bg")
		end

		self.bg:setImage("NoAlpha/HandBookRank/HandBookHeroBg/TxtGroup0" .. self.camp)
		self.bg:setVisible(true)
	end

	if not self.isAddDraged then
		self:setPanelDragFunc()
	end

	self:doMove(true)
end

function RoleImageEnjoy:outEnjoyClick()
	if self.isAning then
		return
	end

	self.isAning = true

	self.mWindow:playAni("HideEnjoyPanel", function()
		self.isAppreciate = false
		self.isAning = false
	end)
	self.canvasBtnClose:setText(self.oldCloseName)
	self.canvasBtnClose:setVisible(true)
	self.slider:setValue(0)
	self:showControlPanel(false)

	if self.bg then
		self.bg:setVisible(false)
	end

	self:doMove(false, function()
		self.isAning = false
	end)
end

function RoleImageEnjoy:onHideClick(isSHow, isShare)
	if self.btnEnjoy:getVisible() then
		return
	end

	self.btnHide:setVisible(isSHow)
	self.sharePanel:setVisible(isSHow)
	self.slider:setVisible(isSHow)
	self.canvasBtnClose:setVisible(isSHow)
end

return RoleImageEnjoy
