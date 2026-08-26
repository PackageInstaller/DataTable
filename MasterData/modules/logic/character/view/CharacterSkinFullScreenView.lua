-- chunkname: @modules/logic/character/view/CharacterSkinFullScreenView.lua

module("modules.logic.character.view.CharacterSkinFullScreenView", package.seeall)

local CharacterSkinFullScreenView = class("CharacterSkinFullScreenView", BaseView)

function CharacterSkinFullScreenView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goscroll = gohelper.findChild(self.viewGO, "#go_scroll")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkinFullScreenView:addEvents()
	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.AxisChange, self._onAxisChange, self)
	end
end

function CharacterSkinFullScreenView:removeEvents()
	if GamepadController.instance:isOpen() then
		self.removeEventCb(self, GamepadController.instance, GamepadEvent.AxisChange, self._onAxisChange, self)
	end
end

CharacterSkinFullScreenView.retainRate = 0.2
CharacterSkinFullScreenView.live2dRetainRate = 0.4
CharacterSkinFullScreenView.RetainRate = {
	Live2DHeight = 0.2,
	Live2DWidth = 0.4,
	Normal = 0.2
}
CharacterSkinFullScreenView.DefaultLive2dOffsetY = -350
CharacterSkinFullScreenView.DefaultLive2dCameraSize = 14

function CharacterSkinFullScreenView:_btncloseOnClick()
	self:closeThis()
end

function CharacterSkinFullScreenView:_editableInitView()
	self._changeRTSize = not CharacterVoiceEnum.RTSizeLegacy

	self._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))

	self._image = gohelper.findChildImage(self.viewGO, "#go_scroll/#simage_pic")
	self._scrollRect = SLFramework.UGUI.ScrollRectWrap.Get(self._goscroll)
	self._scrollTransform = self._goscroll.transform
	self.goInteractArea = gohelper.findChild(self.viewGO, "#go_scroll/interactable_area")
	self.goDynamicContainer = gohelper.findChild(self.viewGO, "#go_scroll/dynamicContainer")
	self.goImageContainer = gohelper.findChild(self.viewGO, "#go_scroll/dynamicContainer/#go_imagecontainer")
	self.goSpineContainer = gohelper.findChild(self.viewGO, "#go_scroll/dynamicContainer/#go_spinecontainer")
	self._spineContainerTransform = self.goSpineContainer.transform
	self.simageSkin = gohelper.findChildSingleImage(self.viewGO, "#go_scroll/dynamicContainer/#go_imagecontainer/#simage_skin")
	self.goSpineSkin = gohelper.findChild(self.viewGO, "#go_scroll/dynamicContainer/#go_spinecontainer/#go_spine")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self.goInteractArea)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)

	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self.goInteractArea)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetOnMultiDragCb(self.onScaleHandler, self)
	self._touchEventMgr:SetScrollWheelCb(self.onMouseScrollWheelChange, self)
end

function CharacterSkinFullScreenView:_onDragBegin(param, pointerEventData)
	if not self.loadDone then
		return
	end

	self._startDragPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._scrollTransform)

	local x, y = recthelper.getAnchor(self.interactTr, 0, 0)

	self._startImagePos = Vector2(x, y)

	self:_showDragEffect(false)
end

function CharacterSkinFullScreenView:_onDragEnd(param, pointerEventData)
	if not self.loadDone then
		return
	end

	self._scale = false
	self._startDragPos = nil

	self:_showDragEffect(true)
end

function CharacterSkinFullScreenView:_onDrag(param, pointerEventData)
	if not self.loadDone then
		return
	end

	if self._scale or not self._startDragPos then
		return
	end

	local endPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._scrollTransform)
	local deltaPos = endPos - self._startDragPos

	if self._changeRTSize then
		if not self.curScaleX then
			local scale = 1
			local targetX = self._startImagePos.x + deltaPos.x / scale
			local targetY = self._startImagePos.y + deltaPos.y / scale

			self:SetAnchor(targetX, targetY)
		end
	end
end

function CharacterSkinFullScreenView:onUpdateParam()
	return
end

function CharacterSkinFullScreenView:onOpen()
	self._showSkinConfig = self.viewParam.skinCo
	self._showEnum = self.viewParam.showEnum or CharacterEnum.ShowSkinEnum.Static
	self.isLive2D = not string.nilorempty(self._showSkinConfig.live2d)
	self.skinIndex = self._showSkinConfig.id - self._showSkinConfig.characterId * 100
	self._screenWidth = recthelper.getWidth(self.viewGO.transform)
	self._screenHeight = recthelper.getHeight(self.viewGO.transform)
	self.curScaleX = 1
	self.curScaleY = 1
	self._maxScale = 2
	self._minScale = 0.8
	self.initScaleX = 1
	self.initScaleY = 1
	self._deltaScale = 0.2
	self.interactTr = self.simageSkin.transform
	self.retainRateW = CharacterSkinFullScreenView.RetainRate.Normal
	self.retainRateH = CharacterSkinFullScreenView.RetainRate.Normal
	self.imageWidth = recthelper.getWidth(self.interactTr)
	self.imageHeight = recthelper.getHeight(self.interactTr)

	self:setContainerAnchor()
	self:refreshSkin()
end

function CharacterSkinFullScreenView:setContainerAnchor()
	local containerTr = self.goDynamicContainer.transform

	if self._showEnum == CharacterEnum.ShowSkinEnum.Dynamic and not self.isLive2D then
		containerTr.anchorMin = RectTransformDefine.Anchor.CenterBottom
		containerTr.anchorMax = RectTransformDefine.Anchor.CenterBottom

		recthelper.setAnchorY(containerTr, -700)
	else
		containerTr.anchorMin = RectTransformDefine.Anchor.CenterMiddle
		containerTr.anchorMax = RectTransformDefine.Anchor.CenterMiddle

		recthelper.setAnchorY(containerTr, 0)
	end
end

function CharacterSkinFullScreenView:refreshSkin()
	gohelper.setActive(self.goImageContainer, self._showEnum == CharacterEnum.ShowSkinEnum.Static)
	gohelper.setActive(self.goSpineContainer, self._showEnum == CharacterEnum.ShowSkinEnum.Dynamic)

	if self._showEnum == CharacterEnum.ShowSkinEnum.Static then
		self:refreshStaticVertical()
	elseif self._showEnum == CharacterEnum.ShowSkinEnum.Dynamic then
		self:refreshDynamicVertical()
	end
end

function CharacterSkinFullScreenView:refreshStaticVertical()
	self.simageSkin:LoadImage(ResUrl.getHeadIconImg(self._showSkinConfig.drawing), self._onLoad, self)
end

function CharacterSkinFullScreenView:_onLoad()
	ZProj.UGUIHelper.SetImageSize(self.simageSkin.gameObject)

	self.interactTr = self.simageSkin.transform
	self.imageWidth = recthelper.getWidth(self.interactTr)
	self.imageHeight = recthelper.getHeight(self.interactTr)

	local offsets = SkinConfig.instance:getSkinOffset(self._showSkinConfig.skinViewImgOffset, {
		0,
		0,
		0.8
	})

	recthelper.setAnchor(self.interactTr, 0, offsets[2])
	transformhelper.setLocalScale(self.interactTr, offsets[3], offsets[3], offsets[3])

	self.initScaleX = offsets[3]
	self.initScaleY = offsets[3]
	self.retainRateW = CharacterSkinFullScreenView.RetainRate.Normal
	self.retainRateH = CharacterSkinFullScreenView.RetainRate.Normal

	self:calculateDragBorder()

	self.loadDone = true
end

function CharacterSkinFullScreenView:refreshDynamicVertical()
	self.interactTr = self.goSpineSkin.transform
	self.imageWidth = 800
	self.imageHeight = 1400
	self._uiSpine = GuiModelAgent.Create(self.goSpineSkin, true)

	if self._changeRTSize then
		self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)

		if self.isLive2D then
			self._uiSpine:setLive2dCameraLoadedCallback(self.onLive2dCameraLoadedCallback, self)
		end

		self._uiSpine:setResPath(self._showSkinConfig, self._onUISpineLoaded, self)

		return
	end

	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.FullScreen)

	if self.isLive2D then
		self._uiSpine:setLive2dCameraLoadedCallback(self.onLive2dCameraLoadedCallback, self)
	end

	local cameraSize = self._showSkinConfig.fullScreenCameraSize

	if cameraSize <= 0 then
		cameraSize = CharacterSkinFullScreenView.DefaultLive2dCameraSize
	end

	self._uiSpine:setResPath(self._showSkinConfig, self._onUISpineLoaded, self, cameraSize)
end

function CharacterSkinFullScreenView:_showDragEffect(value)
	if self._uiSpine then
		self._uiSpine:showDragEffect(value)
	end
end

function CharacterSkinFullScreenView:_onUISpineLoaded()
	self._uiSpine:initSkinDragEffect(self._showSkinConfig.id)

	self.retainRateW = CharacterSkinFullScreenView.RetainRate.Live2DWidth
	self.retainRateH = CharacterSkinFullScreenView.RetainRate.Live2DHeight

	local offsetStr

	if self.isLive2D then
		offsetStr = self._showSkinConfig.fullScreenLive2dOffset
	end

	if string.nilorempty(offsetStr) then
		offsetStr = self._showSkinConfig.characterViewOffset
	end

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

	if self.isLive2D then
		CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	else
		recthelper.setAnchor(self.goSpineSkin.transform, offsets[1], offsets[2])
	end

	transformhelper.setLocalScale(self.goSpineSkin.transform, offsets[3], offsets[3], offsets[3])

	if not self.isLive2D then
		self.initScaleX = offsets[3]
		self.initScaleY = offsets[3]
	else
		self.initScaleX = 1
		self.initScaleY = 1
	end

	self:calculateDragBorder()

	self.loadDone = true
end

function CharacterSkinFullScreenView:onLive2dCameraLoadedCallback(live2d)
	gohelper.addChild(self.goDynamicContainer, live2d._rawImageGo)
	gohelper.setAsFirstSibling(live2d._rawImageGo)

	if self._changeRTSize then
		return
	end

	self.retainRateW = CharacterSkinFullScreenView.RetainRate.Live2DWidth
	self.retainRateH = CharacterSkinFullScreenView.RetainRate.Live2DHeight
	self.interactTr = live2d._rawImageGo.transform
	self.imageWidth = live2d._rt.width
	self.imageHeight = live2d._rt.height

	self:calculateDragBorder()
	self:SetAnchor(0, CharacterSkinFullScreenView.DefaultLive2dOffsetY)
end

function CharacterSkinFullScreenView:calculateDragBorder()
	local imageWidth = self.imageWidth * self.curScaleX
	local imageHeight = self.imageHeight * self.curScaleY

	self.maxX = self._screenWidth / 2 + imageWidth * (0.5 - self.retainRateW)
	self.minX = -self.maxX
	self.maxY = self._screenHeight / 2 + imageHeight * (0.5 - self.retainRateH)
	self.minY = -self.maxY
end

function CharacterSkinFullScreenView:onTouchDown()
	self.isFirstScaleHandle = true
end

function CharacterSkinFullScreenView:onTouchUp()
	self.isFirstScaleHandle = true
end

function CharacterSkinFullScreenView:onScaleHandler(isEnLarger, delta)
	if not self.loadDone then
		return
	end

	if self.isFirstScaleHandle then
		self.isFirstScaleHandle = false

		return
	end

	self._scale = true
	self._clickDown = false

	local deltaScale = delta * 0.01

	self.curScaleX = self.curScaleX + deltaScale
	self.curScaleY = self.curScaleY + deltaScale

	self:setLocalScale()
end

function CharacterSkinFullScreenView:_onAxisChange(key, value)
	if key == GamepadEnum.KeyCode.RightStickHorizontal then
		self:onMouseScrollWheelChange(value * 0.1)
	elseif key == GamepadEnum.KeyCode.RightStickVertical then
		self:onMouseScrollWheelChange(value * 0.1)
	end
end

function CharacterSkinFullScreenView:onMouseScrollWheelChange(deltaData)
	if not self.loadDone then
		return
	end

	self.curScaleX = self.curScaleX + deltaData
	self.curScaleY = self.curScaleY + deltaData

	self:setLocalScale()
end

function CharacterSkinFullScreenView:setLocalScale()
	self.curScaleX = math.min(self.curScaleX, self._maxScale)
	self.curScaleY = math.min(self.curScaleY, self._maxScale)
	self.curScaleX = math.max(self.curScaleX, self._minScale)
	self.curScaleY = math.max(self.curScaleY, self._minScale)

	local scaleX, scaleY = self.curScaleX * self.initScaleX, self.curScaleY * self.initScaleY

	if self._showEnum == CharacterEnum.ShowSkinEnum.Dynamic and self.isLive2D then
		transformhelper.setLocalScale(self._spineContainerTransform, scaleX, scaleY, 1)
	else
		transformhelper.setLocalScale(self.interactTr, scaleX, scaleY, 1)
	end

	self:calculateDragBorder()
	self:SetAnchor(recthelper.getAnchorX(self.interactTr), recthelper.getAnchorY(self.interactTr))
end

function CharacterSkinFullScreenView:SetAnchor(anchorX, anchorY)
	anchorX = math.min(anchorX, self.maxX)
	anchorX = math.max(anchorX, self.minX)
	anchorY = math.min(anchorY, self.maxY)
	anchorY = math.max(anchorY, self.minY)

	recthelper.setAnchor(self.interactTr, anchorX, anchorY)

	if self._showEnum == CharacterEnum.ShowSkinEnum.Dynamic and self.isLive2D and not self._changeRTSize then
		recthelper.setAnchor(self._spineContainerTransform, anchorX, anchorY)
	end
end

function CharacterSkinFullScreenView:onClose()
	recthelper.setAnchor(self._spineContainerTransform, 10000, 10000)
	Live2dRTShareController.instance:clearAllRT()
end

function CharacterSkinFullScreenView:onDestroyView()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()

	if self._touchEventMgr then
		TouchEventMgrHepler.remove(self._touchEventMgr)

		self._touchEventMgr = nil
	end

	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	self.simageSkin:UnLoadImage()
	self._simagebg:UnLoadImage()
end

return CharacterSkinFullScreenView
