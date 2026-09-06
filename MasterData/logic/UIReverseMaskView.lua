-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/global/view/UIReverseMaskView.lua

module("logic.extensions.global.view.UIReverseMaskView", package.seeall)

local UIReverseMaskView = class("UIReverseMaskView", ViewComponent)

function UIReverseMaskView:buildUI()
	self._image = self:getGo("Image")
	self._canvas = self.mainGO:GetComponent("Canvas")
	self._mask = self:getGo("Mask"):GetComponent("RectTransform")
	self._canvasGroup = self.mainGO:GetComponent("CanvasGroup")
	self._reverseMask = self._image:GetComponent("UIReverseMask")
	self._reverseMask.enabled = false
	self._bigImg = self._mask:GetComponent("ImageBigBG")
	self._circleMask = self:getGo("CircleMask"):GetComponent("RectTransform")
end

function UIReverseMaskView:onEnter()
	self._canvasGroup.alpha = 0
	self._reverseMask.enabled = false

	GlobalDispatcher:addListener(GlobalNotify.ReverseMaskUpdate, self._onReverseMaskUpdate, self)
	self:_startReverseMask()
end

function UIReverseMaskView:onExit()
	self._bigImg:ClearImage()
	GlobalDispatcher:removeListener(GlobalNotify.ReverseMaskUpdate, self._onReverseMaskUpdate, self)
end

function UIReverseMaskView:_startReverseMask()
	local maskTexture = UIReverseMaskMgr.instance:getMaskTexPath()

	if maskTexture then
		local bigImg = self._bigImg
		local modelObj = self

		printInfo("_startReverseMask:" .. maskTexture)
		uGuiUtil.setSpriteToImage(self._bigImg, uGuiUtil.SpriteType.BigBg, maskTexture, function(width, height)
			bigImg:GetComponent("RectTransform").sizeDelta = Vector2.New(width, height)

			modelObj:_doReverseMask()
		end)
	else
		self:_doReverseMask()
	end
end

function UIReverseMaskView:_doReverseMask()
	local uiCamera = UIReverseMaskMgr.instance:getUICamera()
	local sortingOrder = UIReverseMaskMgr.instance:getSortingOrder()

	uiCamera = uiCamera or GlobalModel.instance.uiCamera
	sortingOrder = sortingOrder or 9999
	self._canvas.worldCamera = uiCamera
	self._canvas.sortingOrder = sortingOrder

	local maskGraphic = self._mask
	local sizeX, sizeY = UIReverseMaskMgr.instance:getMaskSize()
	local style = UIReverseMaskMgr.instance:getStyle() or UIReverseMaskMgr.MaskStyle_Circle

	maskGraphic = style == UIReverseMaskMgr.MaskStyle_Circle and self._circleMask or UIReverseMaskMgr.instance:getMaskByGraphic() or self._mask

	if sizeX and sizeY then
		maskGraphic.sizeDelta = Vector2.New(width, height)
	else
		local imageComp = maskGraphic:GetComponent("Image")

		imageComp = imageComp or maskGraphic:GetComponent("RawImage")

		imageComp:SetNativeSize()
	end

	local performIngDirty = UIReverseMaskMgr.instance:isPerformIngDirty()

	if performIngDirty == nil then
		performIngDirty = false
	end

	self._reverseMask.graphic = maskGraphic
	self._reverseMask.performIngDirty = performIngDirty
	self._canvasGroup.alpha = 1

	self:_updateMaskPos()
	self._reverseMask:MaskDirty()

	self._reverseMask.enabled = true
end

function UIReverseMaskView:_updateMaskPos()
	local maskGo = UIReverseMaskMgr.instance:getMaskSceneObject()

	if maskGo then
		local gameCamera = UIReverseMaskMgr.instance:getGameCamera()

		gameCamera = gameCamera or GlobalModel.instance.mainCamera

		UGUIToolHelper.SetLocalPosUnityPositionToUGUI(gameCamera, self._canvas.worldCamera, self._reverseMask.graphic, maskGo.transform.position)
	else
		local maskWidget = UIReverseMaskMgr.instance:getMaskWidget()

		if maskWidget then
			self._reverseMask.graphic.position = maskWidget.transform.position
		else
			Framework.TransformUtil.SetLocalPos(self._reverseMask.graphic, 0, 0, 0)
		end
	end

	local ofsX, ofsY = UIReverseMaskMgr.instance:getOffset()

	if ofsX or ofsY then
		local x, y, z = Framework.TransformUtil.GetLocalPos(self._reverseMask.graphic, nil, nil, nil)

		x = x + (ofsX or 0)
		y = y + (ofsY or 0)

		Framework.TransformUtil.SetLocalPos(self._reverseMask.graphic, x, y, z)
	end
end

function UIReverseMaskView:_onReverseMaskUpdate()
	self:_startReverseMask()
end

return UIReverseMaskView
