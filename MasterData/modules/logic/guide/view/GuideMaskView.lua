-- chunkname: @modules/logic/guide/view/GuideMaskView.lua

module("modules.logic.guide.view.GuideMaskView", package.seeall)

local GuideMaskView = class("GuideMaskView", BaseView)

function GuideMaskView:ctor()
	GuideMaskView.super.ctor(self)

	self._typeGOs = nil
	self._csGuideMaskHoles = nil
	self._holeImgs = nil
	self._cacheHoleImgs = nil
	self._exceptionClickCount = 0
end

function GuideMaskView:onInitView()
	self._typeGOs = self:getUserDataTb_()
	self._csGuideMaskHoles = self:getUserDataTb_()
	self._holeImgs = self:getUserDataTb_()

	for i = 1, GuideEnum.uiTypeMaxCount do
		self._typeGOs[i] = gohelper.findChild(self.viewGO, "type" .. i)

		if self._typeGOs[i] then
			local csGuideMaskHole = self._typeGOs[i]:GetComponent("GuideMaskHole")

			self._csGuideMaskHoles[i] = csGuideMaskHole

			if csGuideMaskHole then
				csGuideMaskHole.mainCamera = CameraMgr.instance:getMainCamera()
				csGuideMaskHole.uiCamera = CameraMgr.instance:getUICamera()
				csGuideMaskHole.mainCanvas = ViewMgr.instance:getUICanvas()
				self._holeImgs[i] = gohelper.findChildImage(self._typeGOs[i], "Image")
			end
		end
	end

	self._maskComponent = MonoHelper.addLuaComOnceToGo(self.viewGO, GuideMaskItem, self)
	self._cacheHoleImgs = self:getUserDataTb_()
	self._otherMasksTypeGo = gohelper.findChild(self.viewGO, "otherMasks/type_go")

	local mainMaskImg = gohelper.findChildImage(self.viewGO, "otherMasks/main_mask")

	self._mainMaskMat = mainMaskImg.material

	local otherMaskImg = gohelper.findChildImage(self.viewGO, "otherMasks/other_mask")

	self._otherMaskMat = otherMaskImg.material
end

function GuideMaskView:onOpen()
	self:_onOpenUpdateUI()

	self._exceptionClickCount = 0

	self.addEventCb(self, GuideController.instance, GuideEvent.UpdateMaskView, self._updateUI, self)
	NavigateMgr.instance:addSpace(ViewName.GuideView, self._onSpaceBtnClick, self)
end

function GuideMaskView:onClose()
	self._exceptionClickCount = 0

	self.removeEventCb(self, GuideController.instance, GuideEvent.UpdateMaskView, self._updateUI, self)
end

function GuideMaskView:onUpdateParam()
	self:_onOpenUpdateUI()
end

function GuideMaskView:_onSpaceBtnClick()
	if not self.viewParam then
		return
	end

	if self.viewParam.enableSpaceBtn then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:onClickCallback(true)
		GuideController.instance:dispatchEvent(GuideEvent.OnClickGuideMask, true)
	end

	GuideController.instance:dispatchEvent(GuideEvent.OnClickSpace)
end

function GuideMaskView:getUiInfo()
	if not self.viewParam then
		return
	end

	return self.viewParam.uiInfo
end

function GuideMaskView:_onOpenUpdateUI()
	if not self.viewParam or not self.viewParam.uiInfo then
		return
	end

	local uiInfo = self.viewParam.uiInfo

	if self._prevUIInfo and self._prevUIInfo.stepId and (uiInfo.guideId ~= self._prevUIInfo.guideId or GuideConfig.instance:getNextStepId(self._prevUIInfo.guideId, self._prevUIInfo.stepId) ~= uiInfo.stepId) then
		self._prevUIInfo = nil
	end

	self.viewParam.maskChangeAlpha = self._prevUIInfo and self._prevUIInfo.maskAlpha ~= uiInfo.maskAlpha

	self._maskComponent:setPrevUIInfo(self._prevUIInfo)
	self:_updateUI()

	self._prevUIInfo = uiInfo
end

function GuideMaskView:_updateUI()
	self:_updateMainMask()
	self:_updateOtherMasks()
end

function GuideMaskView:_updateMainMask()
	if not self.viewParam or not self.viewParam.uiInfo then
		return
	end

	self._uiType = self.viewParam.uiInfo.uiType

	local typeGO = self._typeGOs[self._uiType]

	for i, typeGO in ipairs(self._typeGOs) do
		gohelper.setActive(typeGO, i == self._uiType)
	end

	local guideViewParam = self.viewParam
	local maskHole = self._csGuideMaskHoles[self._uiType]

	if maskHole then
		maskHole.raycastTarget = not self.viewParam.hasAnyTouchAction
		maskHole.material = self._mainMaskMat
	end

	self._maskComponent:updateUI(self.viewGO, guideViewParam, maskHole, self._holeImgs[self._uiType], typeGO)
end

function GuideMaskView:_updateOtherMasks()
	if not self.viewParam then
		return
	end

	local otherMaskInfos = {}

	if self.viewParam.otherMasks then
		for i, maskInfo in ipairs(self.viewParam.otherMasks) do
			maskInfo.showMask = self.viewParam.showMask

			local uiType = maskInfo.uiInfo.uiType
			local holeImg = self:_getHoleImg(uiType, maskInfo)

			if holeImg then
				holeImg.material = self._otherMaskMat

				local maskItem = MonoHelper.addLuaComOnceToGo(holeImg.gameObject, GuideMaskItem, self)

				maskItem:updateUI(self.viewGO, maskInfo, nil, holeImg)

				otherMaskInfos[maskInfo] = true
			end
		end
	end

	for k, v in pairs(self._cacheHoleImgs) do
		if not otherMaskInfos[k] then
			gohelper.destroy(v.transform.parent.gameObject)

			self._cacheHoleImgs[k] = nil
		end
	end
end

function GuideMaskView:_getHoleImg(uiType, maskInfo)
	local holeImg = self._cacheHoleImgs[maskInfo]

	if not holeImg then
		local rawImg = self._holeImgs[uiType]

		if not rawImg then
			return
		end

		local typeGo = gohelper.cloneInPlace(self._otherMasksTypeGo, tostring(uiType))
		local clone = gohelper.clone(rawImg.gameObject, typeGo, "Image")

		holeImg = clone:GetComponent(gohelper.Type_Image)
		self._cacheHoleImgs[maskInfo] = holeImg
	end

	return holeImg
end

return GuideMaskView
