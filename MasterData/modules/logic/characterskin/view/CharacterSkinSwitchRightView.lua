-- chunkname: @modules/logic/characterskin/view/CharacterSkinSwitchRightView.lua

module("modules.logic.characterskin.view.CharacterSkinSwitchRightView", package.seeall)

local CharacterSkinSwitchRightView = class("CharacterSkinSwitchRightView", BaseView)

function CharacterSkinSwitchRightView:onInitView()
	self._goskincontainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer")
	self._simageskinSwitchBg = gohelper.findChildSingleImage(self.viewGO, "container/#simage_skinSwitchBg")
	self._scrollskinSwitch = gohelper.findChildScrollRect(self.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch")
	self._goContent = gohelper.findChild(self.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	self._gopreEmpty = gohelper.findChild(self.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	self._goskinItem = gohelper.findChild(self.viewGO, "container/normal/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	self._btndress = gohelper.findChildButtonWithAudio(self.viewGO, "container/normal/skinSwitch/dressState/#btn_dress")
	self._btnnotget = gohelper.findChildButtonWithAudio(self.viewGO, "container/normal/skinSwitch/dressState/#btn_notget")
	self._btnrank = gohelper.findChildButtonWithAudio(self.viewGO, "container/normal/skinSwitch/dressState/#btn_rank")
	self._btnskinstore = gohelper.findChildButtonWithAudio(self.viewGO, "container/normal/skinSwitch/dressState/#btn_skinstore")
	self._btngotogetskin = gohelper.findChildButtonWithAudio(self.viewGO, "container/normal/skinSwitch/dressState/#btn_GO")
	self._godressing = gohelper.findChild(self.viewGO, "container/normal/skinSwitch/dressState/#go_dressing")
	self._goactivityget = gohelper.findChild(self.viewGO, "container/normal/skinSwitch/dressState/#go_activityget")
	self._txtapproach = gohelper.findChildText(self.viewGO, "container/normal/skinSwitch/dressState/#go_activityget/txt")
	self._txtapproachEN = gohelper.findChildText(self.viewGO, "container/normal/skinSwitch/dressState/#go_activityget/txt/txtEn")
	self._gobtntopleft = gohelper.findChild(self.viewGO, "#go_btntopleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkinSwitchRightView:addEvents()
	self._btndress:AddClickListener(self._btndressOnClick, self)
	self._btnnotget:AddClickListener(self._btnnotgetOnClick, self)
	self._btnrank:AddClickListener(self._btnrankOnClick, self)
	self._btnskinstore:AddClickListener(self._btnskinstoreOnClick, self)
	self._btngotogetskin:AddClickListener(self._btngotoOnClick, self)
end

function CharacterSkinSwitchRightView:removeEvents()
	self._btndress:RemoveClickListener()
	self._btnnotget:RemoveClickListener()
	self._btnrank:RemoveClickListener()
	self._btnskinstore:RemoveClickListener()
	self._btngotogetskin:RemoveClickListener()
end

local csTweenHelper = ZProj.TweenHelper

CharacterSkinSwitchRightView.SkinStoreId = 500
CharacterSkinSwitchRightView.RealSkinStoreId = 510
CharacterSkinSwitchRightView.TweenTime = 0.2
CharacterSkinSwitchRightView.NormalAnimationTimeDuration = 0.33

function CharacterSkinSwitchRightView:_btndressOnClick()
	HeroRpc.instance:sendUseSkinRequest(self.heroMo.heroId, self._itemObjects[self._currentSelectSkinIndex].skinCo.id)
end

function CharacterSkinSwitchRightView:_btnnotgetOnClick()
	local skinCO = self._itemObjects[self._currentSelectSkinIndex].skinCo

	if skinCO and skinCO.jump and skinCO.jump > 0 then
		GameFacade.jump(skinCO.jump)
	end
end

function CharacterSkinSwitchRightView:_btnrankOnClick()
	CharacterController.instance:openCharacterRankUpView(self.heroMo)
end

function CharacterSkinSwitchRightView:_btnskinstoreOnClick()
	if not StoreModel.instance:isTabOpen(CharacterSkinSwitchRightView.SkinStoreId) then
		return
	end

	StoreController.instance:openStoreView(CharacterSkinSwitchRightView.SkinStoreId)
end

function CharacterSkinSwitchRightView:_btngotoOnClick()
	local selectItem = self._itemObjects[self._currentSelectSkinIndex]
	local skinCfg = selectItem.skinCo
	local gainApproach = skinCfg.gainApproach

	if gainApproach == CharacterEnum.SkinGainApproach.BPReward then
		local curBpId = BpModel.instance.id
		local curBpSkinId = BpConfig.instance:getCurSkinId(curBpId)

		if skinCfg.id == curBpSkinId then
			JumpController.instance:jump(48)
		end
	elseif ActivityModel.instance:getActMO(gainApproach) then
		if skinCfg and skinCfg.jump and skinCfg.jump > 0 then
			GameFacade.jump(skinCfg.jump)
		end
	elseif gainApproach == CharacterEnum.SkinGainApproach.Permanent and skinCfg and skinCfg.jump and skinCfg.jump > 0 then
		GameFacade.jump(skinCfg.jump)
	end
end

function CharacterSkinSwitchRightView:refreshRightContainer()
	self.goSkinNormalContainer = gohelper.findChild(self.viewGO, "container/normal")
	self.goSkinTipContainer = gohelper.findChild(self.viewGO, "container/skinTip")
	self.goSkinStoreContainer = gohelper.findChild(self.viewGO, "container/skinStore")

	gohelper.setActive(self.goSkinNormalContainer, true)
	gohelper.setActive(self.goSkinTipContainer, false)
	gohelper.setActive(self.goSkinStoreContainer, false)
end

function CharacterSkinSwitchRightView:_editableInitView()
	self:refreshRightContainer()
	gohelper.setActive(self._goskinItem, false)

	self.goDesc = gohelper.findChild(self.viewGO, "desc")
	self._itemObjects = {}
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollskinSwitch.gameObject)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)

	self._preDragAnchorPositionX = 0
	self._itemWidth = recthelper.getWidth(self._goskinItem.transform)
	self._scrollOneItemTime = 0.5
	self._scrollRate = self._itemWidth / self._scrollOneItemTime
	self._tweeningId = 0
	self._currentSelectSkinIndex = 0
	self._hadSkinDict = {}
	self._minAnchorPositionX = 0
	self._minChangeAnchorPositionX = 100
	self._skincontainerCanvasGroup = self._goskincontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.halfAnimationTime = CharacterSkinSwitchRightView.TweenTime / 2
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self.animationEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self.animationEventWrap:AddEventListener("refreshUI", self.refreshUI, self)
	self:_clearBtnStatus()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._successDressUpSkin, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self.onOpen, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.GainSkin, self.onGainSkin, self)
end

function CharacterSkinSwitchRightView:initViewParam()
	self.heroMo = self.viewParam
	self._isFromHandbook = self.viewParam and self.viewParam.handbook
end

function CharacterSkinSwitchRightView:onUpdateParam()
	return
end

function CharacterSkinSwitchRightView:onOpen()
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, self.viewName)
	self:initViewParam()
	self:refreshHadSkinDict()
	self:initSkinItem()
	self:refreshUI()
end

function CharacterSkinSwitchRightView:refreshUI()
	self:_refreshDressBtnStatus()
	self:refreshLeftUI()
	self:_refreshSkinRightBg()
end

function CharacterSkinSwitchRightView:refreshHadSkinDict()
	self._hadSkinDict = {}

	local skinCoList = SkinConfig.instance:getCharacterSkinCoList(self.viewParam.heroId)

	for _, skinCo in ipairs(skinCoList) do
		self._hadSkinDict[skinCo.id] = HeroModel.instance:checkHasSkin(skinCo.id)
	end
end

function CharacterSkinSwitchRightView:initSkinItem()
	local skinCoList = SkinConfig.instance:getCharacterSkinCoList(self.heroMo.heroId)

	if skinCoList == nil or #skinCoList == 0 then
		logError("get skin config list failed,, heroid is : " .. tostring(self.heroMo.heroId))
	end

	self.skinCount = #skinCoList

	local skinItem, scale

	for index, skinCo in ipairs(skinCoList) do
		skinItem = self._itemObjects[index] or self:createSkinItem()

		skinItem.image:LoadImage(ResUrl.getHeadSkinSmall(skinCo.id))

		skinItem.index = index
		skinItem.skinCo = skinCo

		if self.heroMo.skin == skinCo.id then
			scale = 1
			self._currentSelectSkinIndex = index
		else
			scale = 0.9
		end

		transformhelper.setLocalScale(skinItem.transSkinmask, scale, scale, scale)
	end

	self._minAnchorPositionX = -((self.skinCount - 1) * self._itemWidth)

	gohelper.cloneInPlace(self._gopreEmpty, "suffixEmpty")

	if self._currentSelectSkinIndex == 0 then
		logError("init view error, not selected skin")

		self._currentSelectSkinIndex = 1
	end

	self.selectSkinCo = self._itemObjects[self._currentSelectSkinIndex].skinCo

	if not self._isFromHandbook then
		self:_refreshDressedSkin(self.heroMo.skin)
	end

	recthelper.setAnchorX(self._goContent.transform, -(self._currentSelectSkinIndex - 1) * self._itemWidth)
end

function CharacterSkinSwitchRightView:_refreshDressedSkin(dressSkinId)
	for _, item in ipairs(self._itemObjects) do
		gohelper.setActive(item.goNewSelect, item.skinCo.id == dressSkinId)
	end
end

function CharacterSkinSwitchRightView:refreshLeftUI()
	self:_refreshSkinInfo()
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkin, self.selectSkinCo, self.viewName)
end

function CharacterSkinSwitchRightView:_refreshSkinInfo()
	if self.selectSkinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and not self._hadSkinDict[self.selectSkinCo.id] then
		gohelper.setActive(self.goDesc, false)

		return
	end

	gohelper.setActive(self.goDesc, true)
end

function CharacterSkinSwitchRightView:_onDragBegin()
	csTweenHelper.KillById(self._tweeningId)

	self._preDragAnchorPositionX = recthelper.getAnchorX(self._goContent.transform)
	self.playAnimation = false
	self.dragging = true

	self:setShaderKeyWord()
end

function CharacterSkinSwitchRightView:_onDrag()
	local offset = self._preDragAnchorPositionX - recthelper.getAnchorX(self._goContent.transform)
	local absOffset = Mathf.Abs(offset)
	local alphaSmooth = 0.005

	self._skincontainerCanvasGroup.alpha = 1 - absOffset * alphaSmooth

	if self.playAnimation then
		return
	end

	self.playAnimation = self._currentSelectSkinIndex == 1 and offset > 0 or self._currentSelectSkinIndex == self.skinCount and offset < 0 or true

	if self.playAnimation then
		self:playAnim("skinclose")
	end
end

function CharacterSkinSwitchRightView:_onDragEnd()
	if self.playAnimation then
		self:playAnim("skinopen")
	end

	self._skincontainerCanvasGroup.alpha = 1

	local endAnchorPositionX = recthelper.getAnchorX(self._goContent.transform)
	local distance = math.abs(endAnchorPositionX - self._preDragAnchorPositionX)

	if distance <= self._minChangeAnchorPositionX then
		self:killTween()

		self._tweeningId = csTweenHelper.DOAnchorPosX(self._goContent.transform, self._preDragAnchorPositionX, distance / self._scrollRate, self.onCompleteTween, self)
	else
		CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, self.viewName)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

		if endAnchorPositionX < self._minAnchorPositionX then
			endAnchorPositionX = self._minAnchorPositionX
		end

		if endAnchorPositionX > 0 then
			endAnchorPositionX = 0
		end

		distance = 0

		if endAnchorPositionX < self._preDragAnchorPositionX then
			self._currentSelectSkinIndex = math.ceil(math.abs(endAnchorPositionX) / self._itemWidth) + 1

			if self._currentSelectSkinIndex > #self._itemObjects then
				self._currentSelectSkinIndex = #self._itemObjects
			end

			distance = math.abs(endAnchorPositionX) % self._itemWidth

			if distance == 0 then
				self:onCompleteTween()

				local item = self._itemObjects[self._currentSelectSkinIndex]

				self.selectSkinCo = item.skinCo

				self:refreshUI()

				return
			end

			distance = self._itemWidth - distance
		elseif endAnchorPositionX > self._preDragAnchorPositionX then
			self._currentSelectSkinIndex = math.ceil(math.abs(endAnchorPositionX) / self._itemWidth)

			if self._currentSelectSkinIndex < 1 then
				self._currentSelectSkinIndex = 1
			end

			distance = math.abs(endAnchorPositionX) % self._itemWidth
		end

		local item = self._itemObjects[self._currentSelectSkinIndex]

		self.selectSkinCo = item.skinCo

		self:refreshUI()
		self:killTween()

		self._tweeningId = csTweenHelper.DOAnchorPosX(self._goContent.transform, -(self._currentSelectSkinIndex - 1) * self._itemWidth, distance / self._scrollRate, self.onCompleteTween, self)
	end

	if self._currentSelectSkinIndex then
		for i, v in ipairs(self._itemObjects) do
			local scale = self._currentSelectSkinIndex == i and 1 or 0.9

			transformhelper.setLocalScale(v.transSkinmask, scale, scale, scale)
		end
	end

	self.dragging = false

	self:setShaderKeyWord()
end

function CharacterSkinSwitchRightView:createSkinItem()
	local item = self:getUserDataTb_()
	local itemGo = gohelper.cloneInPlace(self._goskinItem, "skinItem")

	item.image = gohelper.findChildSingleImage(itemGo, "skinmask/skinicon")
	item.transSkinmask = gohelper.findChild(itemGo, "skinmask").transform
	item.goNewSelect = gohelper.findChild(itemGo, "skinmask/#go_select")

	gohelper.setActive(item.goNewSelect, false)

	local click = gohelper.getClick(item.image.gameObject)

	click:AddClickListener(self._onItemClick, self, item)

	item.click = click

	gohelper.setActive(itemGo, true)
	table.insert(self._itemObjects, item)

	return item
end

function CharacterSkinSwitchRightView:_onItemClick(skinItem)
	local index = skinItem.index

	if self._currentSelectSkinIndex == index then
		return
	end

	self._currentSelectSkinIndex = index

	local item = self._itemObjects[self._currentSelectSkinIndex]

	self.selectSkinCo = item.skinCo

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

	for i, v in ipairs(self._itemObjects) do
		local scale = self._currentSelectSkinIndex == i and 1 or 0.9

		transformhelper.setLocalScale(v.transSkinmask, scale, scale, scale)
	end

	self.startAnchorPositionX = self._goContent.transform.anchoredPosition.x
	self.endAnchorPositionX = -(self._currentSelectSkinIndex - 1) * self._itemWidth

	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, false, self.viewName)
	self:killTween()

	self._tweeningId = csTweenHelper.DOTweenFloat(0, 1, CharacterSkinSwitchRightView.TweenTime, self.tweenFrameCallback, self.onCompleteTween, self)

	self:playAnim(UIAnimationName.Switch)
end

function CharacterSkinSwitchRightView:tweenFrameCallback(value)
	recthelper.setAnchorX(self._goContent.transform, Mathf.Lerp(self.startAnchorPositionX, self.endAnchorPositionX, value))
end

function CharacterSkinSwitchRightView:onCompleteTween()
	self._tweeningId = 0
end

function CharacterSkinSwitchRightView:_refreshDressBtnStatus()
	self:_clearBtnStatus()

	local selectItem = self._itemObjects[self._currentSelectSkinIndex]
	local skinCo = selectItem.skinCo
	local gainApproach = skinCo.gainApproach

	if skinCo.id == self.heroMo.skin and not self._isFromHandbook then
		gohelper.setActive(self._godressing, true)
	elseif self._hadSkinDict[skinCo.id] then
		gohelper.setActive(self._btndress.gameObject, true)
	elseif gainApproach == CharacterEnum.SkinGainApproach.Rank then
		gohelper.setActive(self._btnrank.gameObject, true)
	elseif gainApproach == CharacterEnum.SkinGainApproach.Activity then
		gohelper.setActive(self._goactivityget, true)

		self._txtapproach.text = luaLang("skin_gain_approach_activity_zh")
		self._txtapproachEN.text = luaLang("skin_gain_approach_activity_en")
	elseif gainApproach == CharacterEnum.SkinGainApproach.Store then
		if StoreModel.instance:isStoreSkinChargePackageValid(skinCo.id) then
			gohelper.setActive(self._btnskinstore.gameObject, true)
		else
			gohelper.setActive(self._goactivityget, true)

			self._txtapproach.text = luaLang("skin_gain_approach_store_zh")
			self._txtapproachEN.text = luaLang("skin_gain_approach_store_en")
		end
	elseif gainApproach == CharacterEnum.SkinGainApproach.BPReward then
		local curBpId = BpModel.instance.id
		local curBpSkinId = BpConfig.instance:getBpSkinBonusId(curBpId)

		if curBpSkinId and skinCo.id == curBpSkinId then
			gohelper.setActive(self._btngotogetskin.gameObject, true)
		else
			gohelper.setActive(self._goactivityget, true)

			self._txtapproach.text = luaLang("skin_gain_approach_bp_zh")
			self._txtapproachEN.text = luaLang("skin_gain_approach_bp_en")
		end
	elseif gainApproach == CharacterEnum.SkinGainApproach.Permanent then
		gohelper.setActive(self._btngotogetskin.gameObject, true)
	elseif ActivityModel.instance:getActMO(gainApproach) then
		local activityId = gainApproach
		local status = ActivityHelper.getActivityStatus(activityId)
		local activityOpen = status == ActivityEnum.ActivityStatus.Normal

		if activityOpen then
			gohelper.setActive(self._btngotogetskin.gameObject, true)
		else
			gohelper.setActive(self._goactivityget, true)

			self._txtapproach.text = luaLang("skin_gain_approach_activity_zh")
			self._txtapproachEN.text = luaLang("skin_gain_approach_activity_en")
		end
	else
		gohelper.setActive(self._btnnotget.gameObject, true)
	end
end

function CharacterSkinSwitchRightView:_refreshSkinRightBg()
	local selectItem = self._itemObjects[self._currentSelectSkinIndex]
	local skinCo = selectItem.skinCo
	local skinId = skinCo.id
	local skinSuitId = HandbookConfig.instance:getSkinSuitIdBySkinId(skinId)

	if skinSuitId then
		self._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinSwitchBg(skinSuitId))
	else
		self._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
	end
end

function CharacterSkinSwitchRightView:skinHasOnLine(skinId)
	if not skinId then
		return false
	end

	local storeMo = StoreModel.instance:getStoreMO(CharacterSkinSwitchRightView.RealSkinStoreId)

	if not storeMo then
		return
	end

	for _, goodsMo in ipairs(storeMo:getGoodsList()) do
		local goodsCo = goodsMo.config
		local productList = string.splitToNumber(goodsCo.product, "#")
		local materialType = productList[1]

		if materialType == MaterialEnum.MaterialType.HeroSkin and productList[2] == skinId then
			return true
		end
	end

	return false
end

function CharacterSkinSwitchRightView:_clearBtnStatus()
	gohelper.setActive(self._btndress.gameObject, false)
	gohelper.setActive(self._btnnotget.gameObject, false)
	gohelper.setActive(self._btnrank.gameObject, false)
	gohelper.setActive(self._btnskinstore.gameObject, false)
	gohelper.setActive(self._btngotogetskin.gameObject, false)
	gohelper.setActive(self._godressing, false)
	gohelper.setActive(self._goactivityget, false)
end

function CharacterSkinSwitchRightView:killTween()
	if self._tweeningId and self._tweeningId ~= 0 then
		csTweenHelper.KillById(self._tweeningId)
	end
end

function CharacterSkinSwitchRightView:onGainSkin(skinId)
	local selectItem = self._itemObjects[self._currentSelectSkinIndex]
	local skinCo = selectItem.skinCo

	if skinId ~= skinCo.id then
		return
	end

	self:refreshHadSkinDict()
	self:_refreshSkinInfo()
	self:_refreshDressBtnStatus()
	self:_refreshSkinRightBg()
end

function CharacterSkinSwitchRightView:_successDressUpSkin(msg)
	if msg.heroId ~= self.heroMo.heroId then
		return
	end

	self:_refreshSkinRightBg()
	self:_refreshDressBtnStatus()
	self:_refreshDressedSkin(msg.skinId)
end

function CharacterSkinSwitchRightView:playAnim(animName)
	self._isAnim = true

	self:setShaderKeyWord()
	self._animatorPlayer:Play(animName, self.onAnimDone, self)
end

function CharacterSkinSwitchRightView:onAnimDone()
	self._isAnim = false

	self:setShaderKeyWord()
end

function CharacterSkinSwitchRightView:setShaderKeyWord()
	if not self.dragging then
		if self.dragging then
			UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
		else
			UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
		end
	end
end

function CharacterSkinSwitchRightView:onClose()
	for i, item in ipairs(self._itemObjects) do
		item.image:UnLoadImage()
		item.click:RemoveClickListener()
	end

	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragListener()
end

function CharacterSkinSwitchRightView:onDestroyView()
	self:killTween()
	self.animationEventWrap:RemoveAllEventListener()
	self._simageskinSwitchBg:UnLoadImage()
end

return CharacterSkinSwitchRightView
