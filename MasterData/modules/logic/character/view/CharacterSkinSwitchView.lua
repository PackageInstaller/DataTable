-- chunkname: @modules/logic/character/view/CharacterSkinSwitchView.lua

module("modules.logic.character.view.CharacterSkinSwitchView", package.seeall)

local CharacterSkinSwitchView = class("CharacterSkinSwitchView", BaseView)

function CharacterSkinSwitchView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gozs = gohelper.findChild(self.viewGO, "#go_zs")
	self._gosmallspine = gohelper.findChild(self.viewGO, "smalldynamiccontainer/#go_smallspine")
	self._goskincontainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer")
	self._simageskin = gohelper.findChildSingleImage(self.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	self._simagel2d = gohelper.findChildSingleImage(self.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#simage_l2d")
	self._gobigspine = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	self._gospinecontainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer")
	self._simagebgmask = gohelper.findChildSingleImage(self.viewGO, "#simage_bgmask")
	self._gogetIcno = gohelper.findChild(self.viewGO, "desc/#go_getIcno")
	self._gonotgetIcno = gohelper.findChild(self.viewGO, "desc/#go_notgetIcno")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "desc/#simage_signature")
	self._simagesignatureicon = gohelper.findChildSingleImage(self.viewGO, "desc/#simage_signatureicon")
	self._txtindex = gohelper.findChildText(self.viewGO, "desc/#txt_index")
	self._txtcharacterName = gohelper.findChildText(self.viewGO, "desc/#txt_characterName")
	self._txtskinName = gohelper.findChildText(self.viewGO, "desc/#txt_skinName")
	self._txtskinNameEn = gohelper.findChildText(self.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	self._txtdesc = gohelper.findChildText(self.viewGO, "desc/#txt_desc")
	self._btnshowDetail = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#txt_characterName/#btn_showDetail")
	self._simageskinSwitchBg = gohelper.findChildSingleImage(self.viewGO, "container/#simage_skinSwitchBg")
	self._scrollskinSwitch = gohelper.findChildScrollRect(self.viewGO, "container/skinSwitch/#scroll_skinSwitch")
	self._goContent = gohelper.findChild(self.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	self._gopreEmpty = gohelper.findChild(self.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	self._goskinItem = gohelper.findChild(self.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	self._btndress = gohelper.findChildButtonWithAudio(self.viewGO, "container/skinSwitch/dressState/#btn_dress")
	self._btnnotget = gohelper.findChildButtonWithAudio(self.viewGO, "container/skinSwitch/dressState/#btn_notget")
	self._btnrank = gohelper.findChildButtonWithAudio(self.viewGO, "container/skinSwitch/dressState/#btn_rank")
	self._btnskinstore = gohelper.findChildButtonWithAudio(self.viewGO, "container/skinSwitch/dressState/#btn_skinstore")
	self._godressing = gohelper.findChild(self.viewGO, "container/skinSwitch/dressState/#go_dressing")
	self._goactivityget = gohelper.findChild(self.viewGO, "container/skinSwitch/dressState/#go_activityget")
	self._gobtntopleft = gohelper.findChild(self.viewGO, "#go_btntopleft")
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._btntag = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_tag")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_switch")
	self._txtswitch = gohelper.findChildText(self.viewGO, "desc/#btn_switch/#txt_switch")
	self._go2d = gohelper.findChild(self.viewGO, "desc/#btn_switch/#go_2d")
	self._gol2d = gohelper.findChild(self.viewGO, "desc/#btn_switch/#go_l2d")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkinSwitchView:addEvents()
	self._btnshowDetail:AddClickListener(self._btnshowDetailOnClick, self)
	self._btndress:AddClickListener(self._btndressOnClick, self)
	self._btnnotget:AddClickListener(self._btnnotgetOnClick, self)
	self._btnrank:AddClickListener(self._btnrankOnClick, self)
	self._btnskinstore:AddClickListener(self._btnskinstoreOnClick, self)
	self._btntag:AddClickListener(self._btntagOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
end

function CharacterSkinSwitchView:removeEvents()
	self._btnshowDetail:RemoveClickListener()
	self._btndress:RemoveClickListener()
	self._btnnotget:RemoveClickListener()
	self._btnrank:RemoveClickListener()
	self._btnskinstore:RemoveClickListener()
	self._btntag:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
end

local csTweenHelper = ZProj.TweenHelper

CharacterSkinSwitchView.SkinStoreId = 500
CharacterSkinSwitchView.TweenTime = 0.2
CharacterSkinSwitchView.NormalAnimationTimeDuration = 0.33

function CharacterSkinSwitchView:_btnswitchOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)

	self._showLive2d = self._showLive2d == false

	gohelper.setActive(self._go2d, self._showLive2d)
	gohelper.setActive(self._gol2d, self._showLive2d == false)

	self._txtswitch.text = self._showLive2d and luaLang("storeskinpreviewview_btnswitch") or "L2D"

	self._viewAnim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(self._refreshStaticVertical, self, 0.16)
end

function CharacterSkinSwitchView:_btnshowDetailOnClick()
	CharacterController.instance:openCharacterSkinFullScreenView(self.skinCo, false, (self._showLive2d or nil) and (CharacterEnum.ShowSkinEnum.Dynamic or CharacterEnum.ShowSkinEnum.Static))
end

function CharacterSkinSwitchView:_btndressOnClick()
	HeroRpc.instance:sendUseSkinRequest(self.viewParam.heroId, self._itemObjects[self._currentSelectSkinIndex].skinCo.id)
end

function CharacterSkinSwitchView:_btnnotgetOnClick()
	local skinCO = self._itemObjects[self._currentSelectSkinIndex].skinCo

	if skinCO and skinCO.jump and skinCO.jump > 0 then
		GameFacade.jump(skinCO.jump)
	end
end

function CharacterSkinSwitchView:_btnrankOnClick()
	local heroMo = HeroModel.instance:getByHeroId(self.skinCo.characterId)

	CharacterController.instance:openCharacterRankUpView(heroMo)
end

function CharacterSkinSwitchView:_btntagOnClick()
	ViewMgr.instance:openView(ViewName.CharacterSkinTagView, {
		skinCo = self.skinCo
	})
end

function CharacterSkinSwitchView:_btnskinstoreOnClick()
	if not StoreModel.instance:isTabOpen(CharacterSkinSwitchView.SkinStoreId) then
		return
	end

	StoreController.instance:openStoreView(CharacterSkinSwitchView.SkinStoreId)
end

function CharacterSkinSwitchView:_onOpenView(viewName)
	if self._showLive2d and viewName == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(self._gospinecontainer, false)
	end
end

function CharacterSkinSwitchView:_onCloseView(viewName)
	if self._showLive2d and viewName == ViewName.CharacterSkinFullScreenView then
		gohelper.setActive(self._gospinecontainer, true)
	end
end

function CharacterSkinSwitchView:_editableInitView()
	self._showLive2d = true

	gohelper.setActive(self._go2d, self._showLive2d)
	gohelper.setActive(self._gol2d, self._showLive2d == false)

	self._txtswitch.text = self._showLive2d and "L2D" or luaLang("storeskinpreviewview_btnswitch")
	self.goDesc = gohelper.findChild(self.viewGO, "desc")
	self.goDynamicContainer = gohelper.findChild(self.viewGO, "smalldynamiccontainer")
	self._goSpine = GuiSpine.Create(self._gosmallspine, false)
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
	self._preSelectSkinIndex = 0
	self._hadSkinDict = {}
	self._minAnchorPositionX = 0
	self._minChangeAnchorPositionX = 100

	self._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	self._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))
	self._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))

	self._skincontainerCanvasGroup = self._goskincontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.halfAnimationTime = CharacterSkinSwitchView.TweenTime / 2

	self:_clearBtnStatus()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function CharacterSkinSwitchView:onUpdateParam()
	self._hadSkinDict = {}

	self:refreshView()
end

function CharacterSkinSwitchView:onOpen()
	self._simagesignature:LoadImage(ResUrl.getSignature(self.viewParam.config.signature, "characterget"))
	self:refreshView()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successDressUpSkin, self._successDressUpSkin, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self.refreshView, self)
end

function CharacterSkinSwitchView:onOpenFinish()
	self._viewAnim.enabled = true
end

function CharacterSkinSwitchView:refreshView()
	self.skinCo = SkinConfig.instance:getSkinCo(self.viewParam.skin)
	self._hadSkinDict[self.viewParam.config.skinId] = true

	for i, skin in ipairs(self.viewParam.skinInfoList) do
		self._hadSkinDict[skin.skin] = true
	end

	self._simagesignature:LoadImage(ResUrl.getSignature(self.viewParam.config.signature, "characterget"))
	self._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"))
	gohelper.setActive(self._simagesignatureicon.gameObject, self.viewParam.config.signature == "3011")
	self:_refreshSkinList()
	self:_reallyRefreshView()
end

function CharacterSkinSwitchView:_reallyRefreshView()
	self:_resetRes()
	self:_refreshStaticVertical()
	self:_refreshSkinInfo()
	self:_refreshSpine()
	self:_refreshDressBtnStatus()
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSkinSwitchSpine, self.skinCo.id)
end

function CharacterSkinSwitchView:_resetRes()
	gohelper.setActive(self._btnswitch, self.skinCo.showSwitchBtn == 1)

	self._showLive2d = false

	gohelper.setActive(self._go2d, self._showLive2d)
	gohelper.setActive(self._gol2d, self._showLive2d == false)

	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	self._simageskin:UnLoadImage()
	self._simagel2d:UnLoadImage()
end

function CharacterSkinSwitchView:_refreshStaticVertical()
	gohelper.setActive(self._gospinecontainer, self._showLive2d)
	gohelper.setActive(self._simageskin.gameObject, self._showLive2d == false)

	if self._showLive2d then
		if self._uiSpine == nil then
			self._uiSpine = GuiModelAgent.Create(self._gobigspine, true)

			self._uiSpine:setResPath(self.skinCo, self._onUISpineLoaded, self)
		else
			self:_onUISpineLoaded()
		end

		self._txtswitch.text = luaLang("storeskinpreviewview_btnswitch")
	else
		self._simageskin:LoadImage(ResUrl.getHeadIconImg(self.skinCo.id), self._loadedImage, self)

		self._txtswitch.text = "L2D"
	end

	local live2dbg = self.skinCo.live2dbg

	if not string.nilorempty(live2dbg) then
		gohelper.setActive(self._simagel2d.gameObject, self._showLive2d)
		self._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(live2dbg))
		gohelper.setActive(self._gozs, self._showLive2d)
	else
		gohelper.setActive(self._simagel2d.gameObject, false)
		gohelper.setActive(self._gozs, false)
	end
end

function CharacterSkinSwitchView:_refreshSelectSkin()
	local preSelectSkinItem = self._itemObjects[self._preSelectSkinIndex]
	local curSelectSkinItem = self._itemObjects[self._currentSelectSkinIndex]

	gohelper.setActive(preSelectSkinItem.goNewSelect, false)
	gohelper.setActive(curSelectSkinItem.goNewSelect, true)
end

function CharacterSkinSwitchView:_successDressUpSkin()
	self:_refreshDressBtnStatus()
	self:_refreshSelectSkin()
end

function CharacterSkinSwitchView:_onDragBegin()
	csTweenHelper.KillById(self._tweeningId)

	self._preDragAnchorPositionX = recthelper.getAnchorX(self._goContent.transform)
	self.playAnimation = false
end

function CharacterSkinSwitchView:_onDrag()
	local offset = self._preDragAnchorPositionX - recthelper.getAnchorX(self._goContent.transform)
	local absOffset = Mathf.Abs(offset)
	local alphaSmooth = 0.005

	self._skincontainerCanvasGroup.alpha = 1 - absOffset * alphaSmooth

	if self.playAnimation then
		return
	end

	self.playAnimation = self._currentSelectSkinIndex == 1 and offset > 0 or self._currentSelectSkinIndex == self.skinCount and offset < 0 or true

	if self.playAnimation then
		self._viewAnim:Play(UIAnimationName.SwitchClose, 0, 0)
	end
end

function CharacterSkinSwitchView:_onDragEnd()
	if self.playAnimation then
		self._viewAnim:Play(UIAnimationName.SwitchOpen, 0, 0)
	end

	self._skincontainerCanvasGroup.alpha = 1

	local endAnchorPositionX = recthelper.getAnchorX(self._goContent.transform)
	local distance = math.abs(endAnchorPositionX - self._preDragAnchorPositionX)

	if distance <= self._minChangeAnchorPositionX then
		self:killTween()

		self._tweeningId = csTweenHelper.DOAnchorPosX(self._goContent.transform, self._preDragAnchorPositionX, distance / self._scrollRate, self.onCompleteTween, self)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

		if endAnchorPositionX < self._minAnchorPositionX then
			endAnchorPositionX = self._minAnchorPositionX
		end

		if endAnchorPositionX > 0 then
			endAnchorPositionX = 0
		end

		distance = 0
		self._preSelectSkinIndex = self._currentSelectSkinIndex

		if endAnchorPositionX < self._preDragAnchorPositionX then
			self._currentSelectSkinIndex = math.ceil(math.abs(endAnchorPositionX) / self._itemWidth) + 1

			if self._currentSelectSkinIndex > #self._itemObjects then
				self._currentSelectSkinIndex = #self._itemObjects
			end

			distance = math.abs(endAnchorPositionX) % self._itemWidth

			if distance == 0 then
				self:onCompleteTween()

				local item = self._itemObjects[self._currentSelectSkinIndex]

				self.skinCo = item.skinCo

				self:_reallyRefreshView()

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

		self.skinCo = item.skinCo

		self:_reallyRefreshView()
		self:killTween()

		self._tweeningId = csTweenHelper.DOAnchorPosX(self._goContent.transform, -(self._currentSelectSkinIndex - 1) * self._itemWidth, distance / self._scrollRate, self.onCompleteTween, self)
	end

	if self._currentSelectSkinIndex then
		for i, v in ipairs(self._itemObjects) do
			local scale = self._currentSelectSkinIndex == i and 1 or 0.9

			transformhelper.setLocalScale(v.transSkinmask, scale, scale, scale)
		end
	end
end

function CharacterSkinSwitchView:getSkinIndex()
	for i, itemObj in ipairs(self._itemObjects) do
		if itemObj.skinCo.id == self.skinCo.id then
			return i
		end
	end

	return 0
end

function CharacterSkinSwitchView:_refreshSkinInfo()
	if self.skinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and not self._hadSkinDict[self.skinCo.id] then
		gohelper.setActive(self.goDesc, false)

		return
	end

	gohelper.setActive(self.goDesc, true)

	local index = self:getSkinIndex()

	self._txtindex.text = string.format("%02d", index)
	self._txtcharacterName.text = self.viewParam.config.name

	if index == 1 then
		gohelper.setActive(self._txtskinName.gameObject, false)
		gohelper.setActive(self._txtskinNameEn.gameObject, false)
	else
		self._txtskinName.text = "— " .. self.skinCo.characterSkin
		self._txtskinNameEn.text = self.skinCo.characterSkinNameEng

		gohelper.setActive(self._txtskinName.gameObject, true)
		gohelper.setActive(self._txtskinNameEn.gameObject, true)
	end

	self._txtdesc.text = self.skinCo.skinDescription

	gohelper.setActive(self._btntag.gameObject, string.nilorempty(self.skinCo.storeTag) == false)
end

function CharacterSkinSwitchView:_onUISpineLoaded()
	self._skincontainerCanvasGroup.alpha = 1

	local offsetStr = self.skinCo.skinViewLive2dOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self.skinCo.characterViewOffset
	end

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

	recthelper.setAnchor(self._gobigspine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gobigspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function CharacterSkinSwitchView:_loadedImage()
	ZProj.UGUIHelper.SetImageSize(self._simageskin.gameObject)

	self._skincontainerCanvasGroup.alpha = 1

	local offsetStr = self.skinCo.skinViewImgOffset

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._simageskin.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._simageskin.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	else
		recthelper.setAnchor(self._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(self._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function CharacterSkinSwitchView:_refreshSpine()
	if self.skinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank and not self._hadSkinDict[self.skinCo.id] then
		gohelper.setActive(self.goDynamicContainer, false)

		return
	end

	gohelper.setActive(self.goDynamicContainer, true)
	self._goSpine:stopVoice()
	self._goSpine:setResPath(ResUrl.getSpineUIPrefab(self.skinCo.spine), self._onSpineLoaded, self, true)

	local offsets = SkinConfig.instance:getSkinOffset(self.skinCo.skinSpineOffset)

	recthelper.setAnchor(self._gosmallspine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gosmallspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function CharacterSkinSwitchView:_refreshSkinList()
	local skinCoList = SkinConfig.instance:getCharacterSkinCoList(self.viewParam.heroId)

	if skinCoList == nil or #skinCoList == 0 then
		logError("get skin config list failed,, heroid is : " .. tostring(self.viewParam.heroId))
	end

	self.skinCount = #skinCoList

	gohelper.setActive(self._goskinItem, false)

	local skinItem, scale

	for index, skinCo in ipairs(skinCoList) do
		skinItem = self._itemObjects[index] or self:createSkinItem()

		skinItem.image:LoadImage(ResUrl.getHeadSkinSmall(skinCo.id))

		skinItem.index = index
		skinItem.skinCo = skinCo

		if self.viewParam.skin == skinCo.id then
			scale = 1
			self._currentSelectSkinIndex = index
			self._preSelectSkinIndex = index
		else
			scale = 0.9
		end

		transformhelper.setLocalScale(skinItem.transSkinmask, scale, scale, scale)
	end

	self._minAnchorPositionX = -((#skinCoList - 1) * self._itemWidth)

	gohelper.cloneInPlace(self._gopreEmpty, "suffixEmpty")

	if self._currentSelectSkinIndex == 0 then
		logError("init view error, not selected skin")

		self._currentSelectSkinIndex = 1
	end

	self:_refreshSelectSkin()
	recthelper.setAnchorX(self._goContent.transform, -(self._currentSelectSkinIndex - 1) * self._itemWidth)
end

function CharacterSkinSwitchView:createSkinItem()
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

function CharacterSkinSwitchView:_onItemClick(skinItem)
	local index = skinItem.index

	if self._currentSelectSkinIndex == index then
		return
	end

	self._preSelectSkinIndex = self._currentSelectSkinIndex
	self._currentSelectSkinIndex = index

	local item = self._itemObjects[self._currentSelectSkinIndex]

	self.skinCo = item.skinCo

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

	for i, v in ipairs(self._itemObjects) do
		local scale = self._currentSelectSkinIndex == i and 1 or 0.9

		transformhelper.setLocalScale(v.transSkinmask, scale, scale, scale)
	end

	self.startAnchorPositionX = self._goContent.transform.anchoredPosition.x
	self.endAnchorPositionX = -(self._currentSelectSkinIndex - 1) * self._itemWidth

	self:killTween()

	self._tweeningId = csTweenHelper.DOTweenFloat(0, 1, CharacterSkinSwitchView.TweenTime, self.tweenFrameCallback, self.onCompleteTween, self)

	self:destroyFlow()

	self.workFlow = FlowSequence.New()

	self.workFlow:addWork(DelayFuncWork.New(self.beforeFlow, self, 0))
	self.workFlow:addWork(DelayFuncWork.New(self.playCloseAnimation, self, 0.16))
	self.workFlow:addWork(DelayFuncWork.New(self._reallyRefreshView, self, 0))
	self.workFlow:addWork(DelayFuncWork.New(self.playOpenAnimation, self, 0.33))
	self.workFlow:registerDoneListener(self.onFlowDone, self)
	self.workFlow:start()
end

function CharacterSkinSwitchView:beforeFlow()
	self._viewAnim.speed = CharacterSkinSwitchView.NormalAnimationTimeDuration / self.halfAnimationTime
end

function CharacterSkinSwitchView:playCloseAnimation()
	self._viewAnim:Play("clickclose", 0, 0)
end

function CharacterSkinSwitchView:playOpenAnimation()
	self._viewAnim:Play(UIAnimationName.SwitchOpen, 0, 0)
end

function CharacterSkinSwitchView:onFlowDone()
	self._viewAnim.speed = 1
end

function CharacterSkinSwitchView:tweenFrameCallback(value)
	recthelper.setAnchorX(self._goContent.transform, Mathf.Lerp(self.startAnchorPositionX, self.endAnchorPositionX, value))
end

function CharacterSkinSwitchView:onCompleteTween()
	self._tweeningId = 0
end

function CharacterSkinSwitchView:_refreshDressBtnStatus()
	self:_clearBtnStatus()

	local selectItem = self._itemObjects[self._currentSelectSkinIndex]
	local skinCo = selectItem.skinCo

	if skinCo.id == self.viewParam.skin then
		gohelper.setActive(self._godressing, true)
	elseif self._hadSkinDict[skinCo.id] then
		gohelper.setActive(self._btndress.gameObject, true)
	elseif skinCo.gainApproach == CharacterEnum.SkinGainApproach.Rank then
		gohelper.setActive(self._btnrank.gameObject, true)
	elseif skinCo.gainApproach == CharacterEnum.SkinGainApproach.Activity then
		gohelper.setActive(self._goactivityget, true)
	elseif skinCo.gainApproach == CharacterEnum.SkinGainApproach.Store then
		if not StoreModel.instance:isTabOpen(CharacterSkinSwitchView.SkinStoreId) then
			gohelper.setActive(self._goactivityget, true)
		else
			gohelper.setActive(self._btnskinstore.gameObject, true)
		end
	else
		gohelper.setActive(self._btnnotget.gameObject, true)
	end
end

function CharacterSkinSwitchView:_clearBtnStatus()
	gohelper.setActive(self._btndress.gameObject, false)
	gohelper.setActive(self._btnnotget.gameObject, false)
	gohelper.setActive(self._btnrank.gameObject, false)
	gohelper.setActive(self._btnskinstore.gameObject, false)
	gohelper.setActive(self._godressing, false)
	gohelper.setActive(self._goactivityget, false)
end

function CharacterSkinSwitchView:_onSpineLoaded()
	return
end

function CharacterSkinSwitchView:killTween()
	if self._tweeningId and self._tweeningId ~= 0 then
		csTweenHelper.KillById(self._tweeningId)
	end
end

function CharacterSkinSwitchView:destroyFlow()
	if self.workFlow then
		self.workFlow:destroy()

		self.workFlow = nil
	end
end

function CharacterSkinSwitchView:onClose()
	self:killTween()
	self._simageskin:UnLoadImage()
	self._simagesignature:UnLoadImage()
	self._simagesignatureicon:UnLoadImage()
	self._simagel2d:UnLoadImage()

	for i, item in ipairs(self._itemObjects) do
		item.image:UnLoadImage()
		item.click:RemoveClickListener()
	end

	if self._uiSpine then
		self._uiSpine:setModelVisible(false)
	end

	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragListener()
end

function CharacterSkinSwitchView:onDestroyView()
	self:destroyFlow()

	if self._goSpine then
		self._goSpine:stopVoice()

		self._goSpine = nil
	end

	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	self._simagebg:UnLoadImage()
	self._simagebgmask:UnLoadImage()
	self._simageskinSwitchBg:UnLoadImage()
end

return CharacterSkinSwitchView
