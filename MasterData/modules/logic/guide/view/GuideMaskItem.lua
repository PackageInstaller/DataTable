-- chunkname: @modules/logic/guide/view/GuideMaskItem.lua

module("modules.logic.guide.view.GuideMaskItem", package.seeall)

local GuideMaskItem = class("GuideMaskItem", LuaCompBase)
local Vector2Zero = Vector2.zero
local _rectangleOffsetX = 16
local _rectangleOffsetY = 16

function GuideMaskItem:ctor(maskView)
	self._maskView = maskView
	self._viewTrs = nil
	self._targetGO = nil
	self._targetTrs = nil
	self._targetIs2D = false
	self._globalTouch = nil
	self._root2DTrs = nil
	self._uiCamera = nil
	self._maskOpenTime = 0
	self._exceptionClickCount = 0
end

function GuideMaskItem:onDestroy()
	TaskDispatcher.cancelTask(self._updateMaskPosAndSize, self)
	TaskDispatcher.cancelTask(self._showArrow, self)
	self.removeEventCb(self, GuideController.instance, GuideEvent.SetMaskOffset, self._setMaskOffset, self)
	self.removeEventCb(self, GuideController.instance, GuideEvent.SetMaskPosition, self._setMaskCustomPos, self)
end

function GuideMaskItem:init(go)
	self._cacheEffects = self:getUserDataTb_()

	self:onInitView()
	self.addEventCb(self, GuideController.instance, GuideEvent.SetMaskOffset, self._setMaskOffset, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.SetMaskPosition, self._setMaskCustomPos, self)
end

function GuideMaskItem:onInitView()
	self._uiCamera = CameraMgr.instance:getUICamera()
	self._unitCamera = CameraMgr.instance:getUnitCamera()
	self._mainCamera = CameraMgr.instance:getMainCamera()
	self._root2DTrs = ViewMgr.instance:getTopUICanvas().transform
end

function GuideMaskItem:addEventListeners()
	if self._csGuideMaskHole then
		self._csGuideMaskHole:InitPointerLuaFunction(self._onPointerClick, self)
	end
end

function GuideMaskItem:removeEventListeners()
	if self._csGuideMaskHole then
		self._csGuideMaskHole:InitPointerLuaFunction(nil, nil)
	end
end

function GuideMaskItem:initTargetGo()
	self._targetGO = gohelper.find(self._goPath)

	if self._targetGO then
		self._targetTrs = self._targetGO.transform
		self._targetIs2D = self._targetGO:GetComponent("RectTransform") ~= nil

		local tr = self._targetGO.transform.parent

		while self._targetIs2D and not gohelper.isNil(tr) do
			if tr:GetComponent("RectTransform") == nil then
				self._targetIs2D = false

				break
			end

			tr = tr.parent
		end
	end
end

function GuideMaskItem:setPrevUIInfo(info)
	self._prevUIInfo = info
end

function GuideMaskItem:updateUI(go, viewParam, csGuideMaskHole, holeImg, typeGo)
	self._maskOpenTime = ServerTime.now()

	local uiInfo = viewParam.uiInfo

	self._uiType = uiInfo.uiType
	self._rotation = uiInfo.rotation
	self._width = uiInfo.width
	self._height = uiInfo.height
	self._arrowOffsetX = uiInfo.arrowOffsetX
	self._arrowOffsetY = uiInfo.arrowOffsetY
	self._maskAlpha = uiInfo.maskAlpha
	self._imgAlpha = uiInfo.imgAlpha
	self._goPath = viewParam.goPath
	self._posX = viewParam.uiOffset[1] or 0
	self._posY = viewParam.uiOffset[2] or 0
	self._touchGoPath = viewParam.touchGOPath
	self._enableClick = viewParam.enableClick
	self._enableDrag = viewParam.enableDrag
	self._enablePress = viewParam.enablePress
	self._enableHoleClick = viewParam.enableHoleClick
	self._showMask = viewParam.showMask
	self._isStepEditor = viewParam._isStepEditor

	self:removeEventListeners()

	self._csGuideMaskHole = csGuideMaskHole

	self:addEventListeners()

	self._holeImg = holeImg
	self._typeGo = typeGo
	self._viewTrs = go.transform

	self:initTargetGo()

	self._globalTouch = not string.nilorempty(self._touchGoPath) and gohelper.find(self._touchGoPath) or nil

	TaskDispatcher.cancelTask(self._updateMaskPosAndSize, self)
	TaskDispatcher.runRepeat(self._updateMaskPosAndSize, self, 0.01)
	self:_updateMaskPosAndSize()
	self:_updateMaskAlpha()
	self:_updateEnableClick()
	self:_updateEnableDrag()
	self:_updateEnablePress()
	self:_updateEnableTargetClick()
end

function GuideMaskItem:_getHoleEffect(isRed)
	local path = self._maskView.viewContainer:getSetting().otherRes[isRed and 1 or 2]
	local holeEffect = self._cacheEffects[path]

	if not holeEffect then
		local holeGo = self._maskView:getResInst(path)

		holeEffect = MonoHelper.addLuaComOnceToGo(holeGo, GuideHoleEffect)
		self._cacheEffects[path] = holeEffect
	end

	holeEffect:setVisible(false)

	return holeEffect
end

function GuideMaskItem:_updateHoleAlpha(color)
	if self._holeEffect then
		self._holeEffect:setVisible(false)

		self._holeEffect = nil
	end

	local holeImg = self._holeImg

	if holeImg then
		color = color or holeImg.color
		color.a = 0
		holeImg.color = color

		self:_setArrow(holeImg)

		if self._imgAlpha > 0 then
			self._holeEffect = self:_getHoleEffect(self._showMask)
			self._holeEffect.showMask = self._showMask

			self._holeEffect:addToParent(self._holeImg.gameObject)
		end
	end
end

function GuideMaskItem:_updateHoleTrans(width, height, posX, posY)
	local holeImg = self._holeImg

	if holeImg then
		local holeImgTrs = holeImg.transform
		local isRectangle = self:_isRectangle()
		local w = isRectangle and width - _rectangleOffsetX
		local h = isRectangle and height - _rectangleOffsetY

		recthelper.setSize(holeImgTrs, w, h)
		transformhelper.setLocalPosXY(holeImgTrs, posX, posY)
	end

	if self._holeEffect then
		self._holeEffect:setSize(width, height, self._isStepEditor)
	end
end

function GuideMaskItem:_updateMaskAlpha()
	local csGuideMaskHole = self._csGuideMaskHole
	local color

	if csGuideMaskHole then
		if self._prevUIInfo and self._prevUIInfo.maskAlpha ~= self._maskAlpha then
			self._fadeId = ZProj.TweenHelper.DoFade(csGuideMaskHole, self._prevUIInfo.maskAlpha, self._maskAlpha, 0.3)
			self._prevUIInfo = nil
		else
			color = csGuideMaskHole.color
			color.a = self._maskAlpha
			csGuideMaskHole.color = color
		end
	end

	self:_updateHoleAlpha(color)
end

function GuideMaskItem:_updateEnableClick()
	local csGuideMaskHole = self._csGuideMaskHole

	if csGuideMaskHole then
		csGuideMaskHole.enableClick = self._enableClick
	end
end

function GuideMaskItem:_updateEnableTargetClick()
	local csGuideMaskHole = self._csGuideMaskHole

	if csGuideMaskHole then
		csGuideMaskHole.enableTargetClick = self:_hasArrow()
	end
end

function GuideMaskItem:_updateEnableDrag()
	local csGuideMaskHole = self._csGuideMaskHole

	if csGuideMaskHole then
		csGuideMaskHole.enableDrag = self._enableDrag
	end
end

function GuideMaskItem:_updateEnablePress()
	local csGuideMaskHole = self._csGuideMaskHole

	if csGuideMaskHole then
		csGuideMaskHole.enablePress = self._enablePress
	end
end

function GuideMaskItem:_setArrow(holeImg)
	if not self:_hasArrow() then
		return
	end

	self._arrow = gohelper.findChild(holeImg.gameObject, "arrow")

	if self._arrow then
		transformhelper.setLocalPosXY(self._arrow.transform, self._arrowOffsetX, self._arrowOffsetY)
		transformhelper.setLocalRotation(self._arrow.transform, 0, 0, self._rotation)
		TaskDispatcher.cancelTask(self._showArrow, self)
		gohelper.setActive(self._arrow, false)
		TaskDispatcher.runDelay(self._showArrow, self, 0.5)
	end
end

function GuideMaskItem:_showArrow()
	gohelper.setActive(self._arrow, true)
end

function GuideMaskItem:_hasArrow()
	return self._uiType == GuideEnum.uiTypeArrow or self._uiType == GuideEnum.uiTypePressArrow
end

function GuideMaskItem:_isRectangle()
	return self._uiType == GuideEnum.uiTypeRectangle or self._uiType == GuideEnum.uiTypeArrow or self._uiType == GuideEnum.uiTypePressArrow
end

function GuideMaskItem:_updateMaskPosAndSize()
	local width = self._width
	local height = self._height
	local posX = self._posX
	local posY = self._posY
	local csGuideMaskHole = self._csGuideMaskHole

	if csGuideMaskHole and csGuideMaskHole.customAdjustSize then
		local sizeOffset = csGuideMaskHole.sizeOffset

		posX = sizeOffset.x
		posY = sizeOffset.y

		local size = csGuideMaskHole.size

		width = size.x
		height = size.y
	end

	local isRectangle = self:_isRectangle()

	if not gohelper.isNil(self._targetGO) then
		if width == -1 then
			width = recthelper.getWidth(self._targetGO.transform)

			if isRectangle then
				width = width + _rectangleOffsetX
			end
		end

		if height == -1 then
			height = recthelper.getHeight(self._targetGO.transform)

			if isRectangle then
				height = height + _rectangleOffsetY
			end
		end
	else
		width = math.max(width, 0)
		height = math.max(height, 0)
	end

	if not gohelper.isNil(self._targetGO) then
		if self._targetIs2D then
			if not gohelper.isNil(self._root2DTrs) and not gohelper.isNil(self._targetTrs) then
				local bounds = ZProj.GuideMaskHole.CalculateRelativeRectTransformBounds(self._root2DTrs, self._targetTrs)

				posX = posX + bounds.center.x
				posY = posY + bounds.center.y
			end
		else
			self._pos = self._pos or Vector3.New()
			self._pos.x, self._pos.y, self._pos.z = transformhelper.getPos(self._targetTrs)

			local localPos = recthelper.worldPosToAnchorPos(self._pos, self._viewTrs, self._uiCamera, (GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MaskUseMainCamera) or nil) and self._mainCamera)

			posX = posX + localPos.x + ((self._externalOffset or nil) and (self._externalOffset.x or 0))
			posY = posY + localPos.y + ((self._externalOffset or nil) and (self._externalOffset.y or 0))
		end

		if self._customPos then
			posX = self._customPos.x
			posY = self._customPos.y
		end

		self:_updateHoleTrans(width, height, posX, posY)
	else
		self:initTargetGo()
	end

	if csGuideMaskHole then
		csGuideMaskHole:SetTarget(self._targetTrs, self:getTempVector2(posX, posY), Vector2Zero, self._globalTouch)

		if self._enableHoleClick then
			if isRectangle then
				width = math.max(0, width - _rectangleOffsetX)
				height = math.max(0, height - _rectangleOffsetY)
			end

			csGuideMaskHole.size = self:getTempVector2(width, height)

			if self._lastPosX ~= posX or self._lastPosY ~= posY then
				self._lastPosX = posX
				self._lastPosY = posY

				self._csGuideMaskHole:RefreshMesh()
			end
		else
			csGuideMaskHole.size = Vector2Zero
		end
	else
		local typeGO = self._typeGo

		if not gohelper.isNil(typeGO) then
			recthelper.setAnchor(typeGO.transform, posX, posY)
		end
	end
end

function GuideMaskItem:getTempVector2(x, y)
	self._tempVec2 = self._tempVec2 or Vector2.New()
	self._tempVec2.x = x
	self._tempVec2.y = y

	return self._tempVec2
end

function GuideMaskItem:_onClickOutside()
	if self._uiType ~= GuideEnum.uiTypeArrow or self._maskAlpha ~= 0 or not self._arrow then
		return
	end

	self._animator = self._animator or self._arrow:GetComponentInChildren(typeof(UnityEngine.Animator))

	if self._animator then
		self._animator:Play("guide_shark")
	end
end

function GuideMaskItem:_onPointerClick(isInside)
	if GuideController.EnableLog then
		logNormal("guidelog: GuideMaskItem._onPointerClick " .. (isInside and "true" or "false") .. debug.traceback("", 2))
	end

	if not gohelper.isNil(self._targetGO) and not GuideUtil.isGOShowInScreen(self._targetGO) then
		self._exceptionClickCount = self._exceptionClickCount + 1

		local uiInfo = self._maskView:getUiInfo()
		local guideId = uiInfo and uiInfo.guideId
		local stepId = uiInfo and uiInfo.stepId

		if self._exceptionClickCount >= 5 and ServerTime.now() - self._maskOpenTime > 5 then
			self._exceptionClickCount = 0

			logError(string.format("目标GameObject不在视野，跳过指引 %s_%s", tostring(guideId), tostring(stepId)))
			GuideController.instance:disableGuides()
			GameFacade.showMessageBox(MessageBoxIdDefine.GuideSureToSkip, MsgBoxEnum.BoxType.Yes_No, function()
				self:_onClickYes()
			end, function()
				self:_onClickNo()
			end)
		end

		logError(string.format("目标GameObject不在视野，直接响应点击 %s_%s", tostring(guideId), tostring(stepId)))
		GuideViewMgr.instance:onClickCallback(true)
		GuideController.instance:dispatchEvent(GuideEvent.OnClickGuideMask, true)

		return
	end

	if isInside then
		GuideViewMgr.instance:disableHoleClick()
	end

	GuideViewMgr.instance:onClickCallback(isInside)
	GuideController.instance:dispatchEvent(GuideEvent.OnClickGuideMask, isInside)
end

function GuideMaskItem:_onClickNo()
	GuideController.instance:enableGuides()
end

function GuideMaskItem:_onClickYes()
	local doingGuideId = GuideModel.instance:getDoingGuideId()

	if doingGuideId then
		GuideController.instance:oneKeyFinishGuide(doingGuideId, true)
		GuideStepController.instance:clearStep()
	end

	GuideController.instance:enableGuides()
end

function GuideMaskItem:_setMaskOffset(offset)
	self._externalOffset = offset

	self:_updateMaskPosAndSize()
end

function GuideMaskItem:_setMaskCustomPos(pos, isWorldPos)
	if isWorldPos then
		local uiCamera = CameraMgr.instance:getUICamera()
		local mainCamera = CameraMgr.instance:getMainCamera()

		pos = recthelper.worldPosToAnchorPos(pos, self._viewTrs, uiCamera, mainCamera)
	end

	self._customPos = pos

	self:_updateMaskPosAndSize()
end

return GuideMaskItem
