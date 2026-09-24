-- chunkname: @modules/logic/college/view/other/CollegeStoryView.lua

module("modules.logic.college.view.other.CollegeStoryView", package.seeall)

local CollegeStoryView = class("CollegeStoryView", BaseView)
local vintageDegrees = {
	0,
	0.6,
	0.8,
	1
}

function CollegeStoryView:onInitView()
	self._btnFull = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullscreen")
	self._goHeadBg = gohelper.findChild(self.viewGO, "dialog/headbg_uicanvas")
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "dialog/#simage_Head_uicanvas")
	self._simageItem = gohelper.findChildSingleImage(self.viewGO, "dialog/#simage_Item")
	self._simageRoleLeft = gohelper.findChildSingleImage(self.viewGO, "roles_uicanvas/#simage_Role_Left")
	self._simageRoleRight = gohelper.findChildSingleImage(self.viewGO, "roles_uicanvas/#simage_Role_Right")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "dialog/#go_name/namelayout/#txt_namecn1")
	self._godialog = gohelper.findChild(self.viewGO, "dialog")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._animLeft = gohelper.findComponentAnim(self._simageRoleLeft.gameObject)
	self._animRight = gohelper.findComponentAnim(self._simageRoleRight.gameObject)
	self._goRoles = gohelper.findChild(self.viewGO, "roles_uicanvas")
	self._goEffectCapture = gohelper.findChild(self.viewGO, "#go_effectcapture")
	self._effectCapture = self._goEffectCapture:GetComponent(typeof(UrpCustom.UIBlitEffect))
	self._imageVintage = gohelper.findChildImage(self.viewGO, "#image_vintage")
	self._vintageMaterial = UnityEngine.Object.Instantiate(self._imageVintage.material)
	self._imageVintage.material = self._vintageMaterial
	self._originalLayers = self:getUserDataTb_()

	local transforms = self.viewGO:GetComponentsInChildren(typeof(UnityEngine.Transform), true)

	for i = 0, transforms.Length - 1 do
		local go = transforms[i].gameObject

		self._originalLayers[go] = go.layer
	end
end

function CollegeStoryView:addEvents()
	self._btnFull:AddClickListener(self._playNextStep, self)
	self._btnSkip:AddClickListener(self._skipStory, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._refreshMemoryMaskSize, self)
end

function CollegeStoryView:removeEvents()
	self._btnFull:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._refreshMemoryMaskSize, self)
end

function CollegeStoryView:onOpen()
	self._effectType = 0
	self._effectDegree = 0
	self._effectTime = 0
	self._effectValue = 0
	self._isClosing = false

	self:_clearScreenEffect()
	CollegeHelper.instance:setViewVisible(self.viewName, true)

	self._curStepIndex = 0
	self._txtComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._godialog, TMPFadeIn)

	gohelper.setActive(self._simageHead, false)
	gohelper.setActive(self._goHeadBg, false)
	gohelper.setActive(self._simageRoleLeft, false)
	gohelper.setActive(self._simageRoleRight, false)
	gohelper.setActive(self._simageItem, false)
	self:_playNextStep()
end

function CollegeStoryView:onClickModalMask()
	self:_skipStory()
end

function CollegeStoryView:_skipStory()
	if self._isClosing then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, self._finishStory, nil, nil, self)
end

function CollegeStoryView:_playNextStep()
	if self._isClosing then
		return
	end

	if self._txtComp:isPlaying() then
		self._txtComp:conFinished()
		self:_onTalkEnd()

		return
	end

	self._curStepIndex = self._curStepIndex + 1

	local step = self.viewParam.steps[self._curStepIndex]

	if not step then
		self:_finishStory()

		return
	end

	self:_refreshScreenEffect(step)

	local func = self["_playStep_type" .. step.type]

	if func then
		func(self, step)
	else
		logError("Unknown step type: " .. tostring(step.type))
	end
end

function CollegeStoryView:_playStep_type1(step)
	local preImage = self._curImage

	self._curAnim = nil

	if string.nilorempty(step.picture) then
		self._curImage = nil
	elseif self.viewParam.type == CollegeEnum.StoryType.ImageText2 then
		self._curImage = self._simageHead
	elseif step.position == "left" then
		self._curImage = self._simageRoleLeft
		self._curAnim = self._animLeft
	elseif step.position == "right" then
		self._curImage = self._simageRoleRight
		self._curAnim = self._animRight
	else
		self._curImage = nil
	end

	gohelper.setActive(self._goHeadBg, self._curImage == self._simageHead)
	gohelper.setActive(self._simageHead, self._curImage == self._simageHead)
	gohelper.setActive(self._simageRoleLeft, self._curImage == self._simageRoleLeft)
	gohelper.setActive(self._simageRoleRight, self._curImage == self._simageRoleRight)

	if preImage and preImage ~= self._curImage then
		preImage:UnLoadImage()
	end

	self._txtComp:playNormalText(step.desc, self._onTalkEnd, self)

	self._txtname.text = step.name

	if self._curImage then
		local pngPath = step.picture

		pngPath = self.viewParam.type == CollegeEnum.StoryType.ImageText2 and ResUrl.getCollegeSingleBg(pngPath, "headicon_small") or ResUrl.getCollegeSingleBg(pngPath, "headicon_middle")

		self._curImage:LoadImage(pngPath, self._onImageLoaded, self)
	end

	if self._curAnim then
		self._curAnim:Play("talk", 0, 1)
	end
end

function CollegeStoryView:_onImageLoaded()
	if self.viewParam.type == CollegeEnum.StoryType.ImageText1 then
		self:reSizeImage(self._curImage)
	end
end

function CollegeStoryView:reSizeImage(img)
	if img and img.isActiveAndEnabled then
		self._imgDict = self._imgDict or self:getUserDataTb_()
		self._imgDict[img] = self._imgDict[img] or img:GetComponent(gohelper.Type_Image)

		self._imgDict[img]:SetNativeSize()
	end
end

function CollegeStoryView:_playStep_type2(step)
	gohelper.setActive(self._simageItem, true)
	self._simageItem:LoadImage(ResUrl.getCollegeSingleBg(step.picture, "item"), self._onItemImageLoaded, self)

	if self._curAnim then
		self._curAnim:Play("quiet")
	end
end

function CollegeStoryView:_onItemImageLoaded()
	self:reSizeImage(self._simageItem)
end

function CollegeStoryView:_playStep_type3(step)
	gohelper.setActive(self._simageItem, false)

	if self._curAnim then
		self._curAnim:Play("talk")
	end
end

function CollegeStoryView:_onTalkEnd()
	return
end

function CollegeStoryView:_refreshScreenEffect(step)
	local effectType = step.effectType

	if self._nextEffectStep then
		self._nextEffectStep = step

		return
	end

	if self._effectType == CollegeEnum.DialogEffectType.MemoryMask then
		if effectType == self._effectType then
			return
		end

		self._nextEffectStep = step

		self:_tweenScreenEffect(0, self._effectTime)

		return
	end

	if effectType == CollegeEnum.DialogEffectType.MemoryMask then
		self:_clearScreenEffect()

		self._effectType = effectType
		self._effectTime = tonumber(step.effectParam) or 0

		self:_showMemoryMask()
		self:_tweenScreenEffect(1, self._effectTime)

		return
	end

	local params = effectType == CollegeEnum.DialogEffectType.Distress and string.splitToNumber(step.effectParam, "#") or {
		0
	}
	local degree = params[1]

	if self._effectType == effectType and self._effectDegree == degree then
		return
	end

	self._effectType = effectType
	self._effectDegree = degree
	self._effectTime = params[2] or 0

	self:_killEffectTween()

	if effectType ~= CollegeEnum.DialogEffectType.Distress then
		self:_clearScreenEffect()

		return
	end

	if self._goEffectCapture.activeSelf then
		if not self._waitEffectCapture then
			self:_tweenScreenEffect(vintageDegrees[degree + 1], self._effectTime)
		end
	elseif degree > 0 then
		gohelper.setLayer(self._goRoles, UnityLayer.UISecond, true)
		gohelper.setLayer(self._godialog, UnityLayer.UITop, true)
		gohelper.setLayer(self._simageHead.gameObject, UnityLayer.UISecond, true)
		gohelper.setLayer(self._goHeadBg, UnityLayer.UISecond, true)
		gohelper.setLayer(self._btnSkip.gameObject, UnityLayer.UITop, true)

		self._waitEffectCapture = true

		gohelper.setActive(self._goEffectCapture, true)
		UpdateBeat:Add(self._updateScreenEffect, self)
	end
end

function CollegeStoryView:_showMemoryMask()
	self._goMemoryMask = self:getResInst(CollegeEnum.MemoryMaskPath, self.viewGO, "memorymask")

	self:_refreshMemoryMaskSize()
	gohelper.setLayer(self._goMemoryMask, UnityLayer.UISecond, true)
	gohelper.setLayer(self._goRoles, UnityLayer.UISecond, true)
	gohelper.setLayer(self._godialog, UnityLayer.UITop, true)
	gohelper.setLayer(self._simageHead.gameObject, UnityLayer.UISecond, true)
	gohelper.setLayer(self._goHeadBg, UnityLayer.UISecond, true)
	gohelper.setLayer(self._btnSkip.gameObject, UnityLayer.UITop, true)

	local canvas = self.viewGO:GetComponentInParent(typeof(UnityEngine.Canvas))

	self._goMemoryMask:GetComponent(typeof(ZProj.EffectOrderContainer)):SetBaseOrder(canvas.sortingOrder)

	self._memoryMaterials = self:getUserDataTb_()

	local renderers = self._goMemoryMask:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, renderers.Length - 1 do
		local materials = renderers[i].materials

		for j = 0, materials.Length - 1 do
			table.insert(self._memoryMaterials, materials[j])
		end
	end

	self._memoryFadeHelper = StoryEffectFadeHelper.New()

	self._memoryFadeHelper:init(self._goMemoryMask)
	self:_setScreenEffectValue(0)
end

function CollegeStoryView:_refreshMemoryMaskSize()
	if not self._goMemoryMask then
		return
	end

	local uiRoot = ViewMgr.instance:getUIRoot().transform
	local top = ViewMgr.instance:getUILayer("POPUP_TOP").transform
	local width, height = recthelper.getWidth(uiRoot), recthelper.getHeight(top)

	transformhelper.setLocalScale(self._goMemoryMask.transform, width / 1920, height / 1080, 1)
end

function CollegeStoryView:_updateScreenEffect()
	local texture = self._effectCapture.capturedTexture

	if not texture then
		return
	end

	if self._effectTexture ~= texture then
		self._effectTexture = texture

		self._vintageMaterial:SetTexture("_MainTex", texture)
		self._imageVintage:SetMaterialDirty()
	end

	if self._waitEffectCapture then
		self._waitEffectCapture = false

		gohelper.setActive(self._imageVintage, true)
		self:_tweenScreenEffect(vintageDegrees[self._effectDegree + 1], self._effectTime)
	end
end

function CollegeStoryView:_tweenScreenEffect(value, duration)
	self:_killEffectTween()

	if duration > 0 then
		self._effectTweenId = ZProj.TweenHelper.DOTweenFloat(self._effectValue, value, duration, self._setScreenEffectValue, self._onEffectTweenFinished, self)
	else
		self:_setScreenEffectValue(value)
		self:_onEffectTweenFinished()
	end
end

function CollegeStoryView:_setScreenEffectValue(value)
	self._effectValue = value

	if self._memoryFadeHelper then
		self._memoryFadeHelper:setTransparency(value)
	else
		self._vintageMaterial:SetFloat("_TotalFator", value)
	end
end

function CollegeStoryView:_onEffectTweenFinished()
	self:_killEffectTween()

	if self._isClosing then
		self:closeThis()
	elseif self._effectValue == 0 then
		local nextStep = self._nextEffectStep

		self._nextEffectStep = nil

		self:_clearScreenEffect()

		if nextStep then
			self._effectType = CollegeEnum.DialogEffectType.None

			self:_refreshScreenEffect(nextStep)
		end
	end
end

function CollegeStoryView:_finishStory()
	if self._isClosing then
		return
	end

	self._isClosing = true

	if self._effectValue > 0 then
		self:_tweenScreenEffect(0, self._effectTime)
	else
		self:closeThis()
	end
end

function CollegeStoryView:_killEffectTween()
	if self._effectTweenId then
		ZProj.TweenHelper.KillById(self._effectTweenId)

		self._effectTweenId = nil
	end
end

function CollegeStoryView:_clearScreenEffect()
	self:_killEffectTween()

	self._nextEffectStep = nil

	if self._memoryFadeHelper then
		self._memoryFadeHelper:destroy()

		self._memoryFadeHelper = nil

		gohelper.destroy(self._goMemoryMask)

		self._goMemoryMask = nil

		for _, material in ipairs(self._memoryMaterials) do
			UnityEngine.Object.Destroy(material)
		end

		self._memoryMaterials = nil
	end

	UpdateBeat:Remove(self._updateScreenEffect, self)

	self._waitEffectCapture = false

	gohelper.setActive(self._imageVintage, false)
	gohelper.setActive(self._goEffectCapture, false)

	self._effectTexture = nil

	self._vintageMaterial:SetTexture("_MainTex", nil)
	self:_setScreenEffectValue(0)

	for go, layer in pairs(self._originalLayers) do
		go.layer = layer
	end
end

function CollegeStoryView:onClose()
	self:_clearScreenEffect()
	CollegeHelper.instance:setViewVisible(self.viewName, false)
end

function CollegeStoryView:onDestroyView()
	UnityEngine.Object.Destroy(self._vintageMaterial)
end

return CollegeStoryView
