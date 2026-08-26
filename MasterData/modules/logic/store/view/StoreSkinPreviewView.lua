-- chunkname: @modules/logic/store/view/StoreSkinPreviewView.lua

module("modules.logic.store.view.StoreSkinPreviewView", package.seeall)

local StoreSkinPreviewView = class("StoreSkinPreviewView", BaseView)

function StoreSkinPreviewView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gozs = gohelper.findChild(self.viewGO, "#go_zs")
	self._goskincontainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer")
	self._simageskin = gohelper.findChildSingleImage(self.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	self._simagel2d = gohelper.findChildSingleImage(self.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#simage_l2d")
	self._gobigspine = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	self._gospinecontainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer")
	self._gosmallspine = gohelper.findChild(self.viewGO, "smalldynamiccontainer/#go_smallspine")
	self._simagebgmask = gohelper.findChildSingleImage(self.viewGO, "#simage_bgmask")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "desc/#simage_signature")
	self._txtindex = gohelper.findChildText(self.viewGO, "desc/#txt_index")
	self._txtcharacterName = gohelper.findChildText(self.viewGO, "desc/#txt_characterName")
	self._txtskinName = gohelper.findChildText(self.viewGO, "desc/#txt_skinName")
	self._txtskinNameEn = gohelper.findChildText(self.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	self._txtdesc = gohelper.findChildText(self.viewGO, "desc/#txt_desc")
	self._btnshowDetail = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_showDetail")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_switch")
	self._btnvideo = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_video")
	self._txtswitch = gohelper.findChildText(self.viewGO, "desc/#btn_switch/#txt_switch")
	self._go2d = gohelper.findChild(self.viewGO, "desc/#btn_switch/#go_2d")
	self._gol2d = gohelper.findChild(self.viewGO, "desc/#btn_switch/#go_l2d")
	self._simageshowbg = gohelper.findChildSingleImage(self.viewGO, "container/#simage_showbg")
	self._scrollskinSwitch = gohelper.findChildScrollRect(self.viewGO, "container/skinSwitch/#scroll_skinSwitch")
	self._goContent = gohelper.findChild(self.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content")
	self._gopreEmpty = gohelper.findChild(self.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_preEmpty")
	self._goskinItem = gohelper.findChild(self.viewGO, "container/skinSwitch/#scroll_skinSwitch/Viewport/#go_Content/#go_skinItem")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "container/skinSwitch/dressState/#btn_buy")
	self._gotxtbuy = gohelper.findChild(self.viewGO, "container/skinSwitch/dressState/#btn_buy/#go_txtbuy")
	self._imageicon = gohelper.findChildImage(self.viewGO, "container/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#image_icon")
	self._txtprice = gohelper.findChildText(self.viewGO, "container/skinSwitch/dressState/#btn_buy/#go_txtbuy/price/#txt_price")
	self._gohas = gohelper.findChild(self.viewGO, "container/skinSwitch/dressState/#go_has")
	self._gobtntopleft = gohelper.findChild(self.viewGO, "#go_btntopleft")
	self._goskinCard = gohelper.findChild(self.viewGO, "container/skinSwitch/#go_skinCard")
	self._btntag = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_tag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinPreviewView:addEvents()
	self._btnshowDetail:AddClickListener(self._btnshowDetailOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btnvideo:AddClickListener(self._btnvideoOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btntag:AddClickListener(self._btntagOnClick, self)
end

function StoreSkinPreviewView:removeEvents()
	self._btnshowDetail:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
	self._btnvideo:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btntag:RemoveClickListener()
end

function StoreSkinPreviewView:_btnswitchOnClick()
	self._showLive2d = self._showLive2d == false

	gohelper.setActive(self._go2d, self._showLive2d)
	gohelper.setActive(self._gol2d, self._showLive2d == false)
	gohelper.setActive(self._gozs, self._showLive2d)

	self._txtswitch.text = self._showLive2d and luaLang("storeskinpreviewview_btnswitch") or "L2D"

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	self._animatorPlayer:Play("switch", self._disableClipAlpha, self)
	TaskDispatcher.runDelay(self._refreshBigSkin, self, 0.16)
	gohelper.setActive(self._gozs, self._showLive2d)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)
end

function StoreSkinPreviewView:_btnvideoOnClick()
	logNormal("播放视频,当前皮肤id:" .. self.skinCo.id)

	local url = WebViewController.instance:getVideoUrl(self.skinCo.characterId)

	WebViewController.instance:openWebView(url, false, nil, nil, 0, nil, 0, 0, nil, true)
end

local csTweenHelper = ZProj.TweenHelper

function StoreSkinPreviewView:_btnshowDetailOnClick()
	CharacterController.instance:openCharacterSkinFullScreenView(self.skinCo)
end

function StoreSkinPreviewView:_btntagOnClick()
	ViewMgr.instance:openView(ViewName.CharacterSkinTagView, {
		skinCo = self.skinCo
	})
end

function StoreSkinPreviewView:_btnbuyOnClick()
	local allSkinList = StoreClothesGoodsItemListModel.instance:getList()
	local mo = self._allSkinList[self._currentSelectSkinIndex]

	if mo and StoreModel.instance:getGoodsMO(mo.goodsId) then
		ViewMgr.instance:openView(ViewName.StoreSkinGoodsView, {
			goodsMO = mo
		})
	else
		GameFacade.showToast(ToastEnum.StoreSkinPreview)
	end
end

function StoreSkinPreviewView:_btnnotgetOnClick()
	return
end

function StoreSkinPreviewView:_editableInitView()
	self._showLive2d = true
	self._goSpine = GuiSpine.Create(self._gosmallspine, false)

	gohelper.setActive(self._go2d, self._showLive2d)
	gohelper.setActive(self._gol2d, self._showLive2d == false)

	self._txtswitch.text = self._showLive2d and "L2D" or luaLang("storeskinpreviewview_btnswitch")
	self._itemObjects = {}

	local goDrag = gohelper.findChild(self.viewGO, "drag")

	self._drag = SLFramework.UGUI.UIDragListener.Get(goDrag)

	self._drag:AddDragBeginListener(self._onViewDragBegin, self)
	self._drag:AddDragListener(self._onViewDrag, self)
	self._drag:AddDragEndListener(self._onViewDragEnd, self)

	self._preDragAnchorPositionX = 0
	self._itemWidth = recthelper.getWidth(self._goskinItem.transform)
	self._scrollOneItemTime = 0.5
	self._scrollRate = self._itemWidth / self._scrollOneItemTime
	self._tweeningId = 0
	self._currentSelectSkinIndex = 0
	self._preSelectSkinIndex = 0
	self._minAnchorPositionX = 0
	self._minChangeAnchorPositionX = 100

	self._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	self._simageshowbg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
	self._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))

	self.cardImage = gohelper.findChildSingleImage(self._goskinCard, "skinmask/skinicon")
	self._skincontainerCanvasGroup = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function StoreSkinPreviewView:onUpdateParam()
	self:refreshView()
end

function StoreSkinPreviewView:onOpen()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	self:refreshView()
end

function StoreSkinPreviewView:onOpenFinish()
	self:_disableClipAlpha()
end

function StoreSkinPreviewView:refreshView()
	self.goodsMO = self.viewParam.goodsMO

	local product = self.goodsMO.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	self.skinCo = SkinConfig.instance:getSkinCo(skinId)

	self:_refreshSkinList()
	self:_reallyRefreshView(self.skinCo)
end

function StoreSkinPreviewView:_reallyRefreshView(skinCo)
	self.skinCo = skinCo

	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	self._simageskin:UnLoadImage()
	self._simagel2d:UnLoadImage()
	StoreController.instance:dispatchEvent(StoreEvent.OnSwitchSpine, self.skinCo.id)
	gohelper.setActive(self._btnswitch, self.skinCo.showSwitchBtn == 1)

	self._showLive2d = true

	gohelper.setActive(self._go2d, self._showLive2d)
	gohelper.setActive(self._gol2d, self._showLive2d == false)

	self._txtswitch.text = self._showLive2d and luaLang("storeskinpreviewview_btnswitch") or "L2D"

	local live2dbg = skinCo.live2dbg

	if not string.nilorempty(live2dbg) then
		gohelper.setActive(self._simagel2d.gameObject, self._showLive2d)
		gohelper.setActive(self._gozs, self._showLive2d)
		self._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(live2dbg))
	else
		gohelper.setActive(self._simagel2d.gameObject, false)
		gohelper.setActive(self._gozs, false)
	end

	local isReview = VersionValidator.instance:isInReviewing()
	local showVideo = not isReview and skinCo.isSkinVideo

	logNormal("当前皮肤id:" .. " 是否可以播放视频: " .. tostring(showVideo))
	gohelper.setActive(self._btnvideo, showVideo)
	self:_refreshBigSkin()
	self:_refreshSkinInfo()
	self:_refreshSpine()
	self:_refreshStatus()
end

function StoreSkinPreviewView:_refreshBigSkin()
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
end

function StoreSkinPreviewView:_onViewDragBegin(param, pointerEventData)
	self._startPos = pointerEventData.position.x

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	self._animatorPlayer:Play(UIAnimationName.SwitchClose, self._onAnimDone, self)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
end

function StoreSkinPreviewView:_onAnimDone()
	return
end

function StoreSkinPreviewView:_onViewDrag(param, pointerEventData)
	local curPos = pointerEventData.position.x
	local moveSmooth = 1
	local curSpineRootPosX = recthelper.getAnchorX(self._goskincontainer.transform)

	curSpineRootPosX = curSpineRootPosX + pointerEventData.delta.x * moveSmooth

	recthelper.setAnchorX(self._goskincontainer.transform, curSpineRootPosX)

	local alphaSmooth = 0.007

	self._skincontainerCanvasGroup.alpha = 1 - Mathf.Abs(self._startPos - curPos) * alphaSmooth
end

function StoreSkinPreviewView:_onViewDragEnd(param, pointerEventData)
	local endPos = pointerEventData.position.x
	local newSelectSkinIndex
	local isLeftIn = true

	if endPos > self._startPos and endPos - self._startPos >= 100 then
		newSelectSkinIndex = self._currentSelectSkinIndex - 1

		if self._currentSelectSkinIndex - 1 == 0 then
			newSelectSkinIndex = #self._allSkinList
		end
	elseif endPos < self._startPos and self._startPos - endPos >= 100 then
		newSelectSkinIndex = self._currentSelectSkinIndex + 1

		if self._currentSelectSkinIndex + 1 > #self._allSkinList then
			newSelectSkinIndex = 1
		end

		isLeftIn = false
	end

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	self._skincontainerCanvasGroup.alpha = 1

	if isLeftIn then
		self._animatorPlayer:Play("switch_openleft", self._disableClipAlpha, self)
	else
		self._animatorPlayer:Play("switch_openright", self._disableClipAlpha, self)
	end

	if newSelectSkinIndex then
		self._currentSelectSkinIndex = newSelectSkinIndex

		local goodsMO = self._allSkinList[self._currentSelectSkinIndex]
		local product = goodsMO.config.product
		local productInfo = string.splitToNumber(product, "#")
		local skinId = productInfo[2]
		local skinCo = SkinConfig.instance:getSkinCo(skinId)

		self:_reallyRefreshView(skinCo)
	else
		self:_loadedImage()
	end
end

function StoreSkinPreviewView:_onDragBegin()
	csTweenHelper.KillById(self._tweeningId)

	self._preDragAnchorPositionX = recthelper.getAnchorX(self._goContent.transform)
end

function StoreSkinPreviewView:_onDrag()
	local endAnchorPositionX = recthelper.getAnchorX(self._goContent.transform)
	local distance = math.abs(endAnchorPositionX - self._preDragAnchorPositionX)
	local _currentSelectSkinIndex = self._currentSelectSkinIndex

	if distance > self._minChangeAnchorPositionX then
		if endAnchorPositionX < self._minAnchorPositionX then
			endAnchorPositionX = self._minAnchorPositionX
		end

		if endAnchorPositionX > 0 then
			endAnchorPositionX = 0
		end

		local temp = 0

		if endAnchorPositionX < self._preDragAnchorPositionX then
			temp = 1
			_currentSelectSkinIndex = math.ceil(math.abs(endAnchorPositionX) / self._itemWidth) + 1

			if _currentSelectSkinIndex > #self._itemObjects then
				_currentSelectSkinIndex = #self._itemObjects
			end
		elseif endAnchorPositionX > self._preDragAnchorPositionX then
			temp = 2
			_currentSelectSkinIndex = math.ceil(math.abs(endAnchorPositionX) / self._itemWidth)

			if _currentSelectSkinIndex < 1 then
				_currentSelectSkinIndex = 1
			end
		end
	end

	if _currentSelectSkinIndex then
		for i, v in ipairs(self._itemObjects) do
			local scale = _currentSelectSkinIndex == i and 1 or 0.8

			transformhelper.setLocalScale(v.transSkinmask, scale, scale, scale)
		end
	end
end

function StoreSkinPreviewView:_onDragEnd()
	local endAnchorPositionX = recthelper.getAnchorX(self._goContent.transform)
	local distance = math.abs(endAnchorPositionX - self._preDragAnchorPositionX)

	if distance <= self._minChangeAnchorPositionX then
		self._tweeningId = csTweenHelper.DOAnchorPosX(self._goContent.transform, self._preDragAnchorPositionX, distance / self._scrollRate, self.onCompleteTween, self)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_rolesopen)

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

				self:_reallyRefreshView(item.skinCo)

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

		self:_reallyRefreshView(item.skinCo)

		self._tweeningId = csTweenHelper.DOAnchorPosX(self._goContent.transform, -(self._currentSelectSkinIndex - 1) * self._itemWidth, distance / self._scrollRate, self.onCompleteTween, self)
	end

	if self._currentSelectSkinIndex then
		for i, v in ipairs(self._itemObjects) do
			local scale = self._currentSelectSkinIndex == i and 1 or 0.8

			transformhelper.setLocalScale(v.transSkinmask, scale, scale, scale)
		end
	end
end

function StoreSkinPreviewView:onCompleteTween()
	self._tweeningId = 0

	gohelper.setActive(self._itemObjects[self._preSelectSkinIndex].goSelectedBg, false)
	gohelper.setActive(self._itemObjects[self._preSelectSkinIndex].goNotSelectedBg, true)
	gohelper.setActive(self._itemObjects[self._currentSelectSkinIndex].goSelectedBg, true)
	gohelper.setActive(self._itemObjects[self._currentSelectSkinIndex].goNotSelectedBg, false)
end

function StoreSkinPreviewView:_refreshSkinInfo()
	local heroConfig = HeroConfig.instance:getHeroCO(self.skinCo.characterId)

	self._simagesignature:LoadImage(ResUrl.getSignature(heroConfig.signature))

	self._txtindex.text = ""
	self._txtcharacterName.text = heroConfig.name

	gohelper.setActive(self._txtskinName.gameObject, true)
	gohelper.setActive(self._txtskinNameEn.gameObject, true)

	self._txtskinName.text = "— " .. self.skinCo.characterSkin
	self._txtskinNameEn.text = self.skinCo.characterSkinNameEng
	self._txtdesc.text = self.skinCo.skinDescription

	self.cardImage:LoadImage(ResUrl.getHeadSkinSmall(self.skinCo.id))
	gohelper.setActive(self._btntag.gameObject, string.nilorempty(self.skinCo.storeTag) == false)
end

function StoreSkinPreviewView:_onUISpineLoaded()
	local offsetStr = self.skinCo.skinViewLive2dOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self.skinCo.characterViewOffset
	end

	recthelper.setAnchor(self._goskincontainer.transform, 0, 0)

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

	recthelper.setAnchor(self._gobigspine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gobigspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function StoreSkinPreviewView:_loadedImage()
	ZProj.UGUIHelper.SetImageSize(self._simageskin.gameObject)

	local offsetStr = self.skinCo.skinViewImgOffset

	recthelper.setAnchor(self._goskincontainer.transform, 0, 0)

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._simageskin.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._simageskin.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	else
		recthelper.setAnchor(self._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(self._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function StoreSkinPreviewView:_refreshSpine()
	self._goSpine:stopVoice()
	self._goSpine:setResPath(ResUrl.getSpineUIPrefab(self.skinCo.spine), self._onSpineLoaded, self, true)

	local offsets = SkinConfig.instance:getSkinOffset(self.skinCo.skinSpineOffset)

	recthelper.setAnchor(self._gosmallspine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gosmallspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function StoreSkinPreviewView:_refreshStatus()
	local goodsMO = self._allSkinList[self._currentSelectSkinIndex]
	local alreadyHas = goodsMO:alreadyHas()

	gohelper.setActive(self._btnbuy.gameObject, alreadyHas == false)
	gohelper.setActive(self._gohas, alreadyHas)

	if alreadyHas == false then
		local costInfo = string.splitToNumber(goodsMO.config.cost, "#")

		self._costType = costInfo[1]
		self._costId = costInfo[2]
		self._costQuantity = costInfo[3]
		self._txtprice.text = self._costQuantity

		local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)
		local id = costConfig.icon
		local str = string.format("%s_1", id)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageicon, str)
	end
end

function StoreSkinPreviewView:_refreshSkinList()
	self._allSkinList = StoreClothesGoodsItemListModel.instance:getList()

	for index, goodsMO in ipairs(self._allSkinList) do
		if self.goodsMO.goodsId == goodsMO.goodsId then
			self._currentSelectSkinIndex = index
		end
	end
end

function StoreSkinPreviewView:_initSkinItem(itemGo, index, goodsMO)
	local item = {}

	item.goodsMO = goodsMO

	local product = goodsMO.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	item.skinCo = SkinConfig.instance:getSkinCo(skinId)

	local itemImage = gohelper.findChildSingleImage(itemGo, "skinmask/skinicon")

	item.image = itemImage
	gohelper.findChildText(itemGo, "skinIndex/txtSkinIndex").text = string.format("%02d", index)

	itemImage:LoadImage(ResUrl.getHeadSkinSmall(item.skinCo.id))

	item.goSelectedBg = gohelper.findChild(itemGo, "skinIndex/selectBg")
	item.transSkinmask = gohelper.findChild(itemGo, "skinmask").transform
	item.goNotSelectedBg = gohelper.findChild(itemGo, "skinIndex/notSelectBg")

	local click = gohelper.getClick(itemImage.gameObject)

	click:AddClickListener(self._onItemClick, self, index)

	item.click = click

	gohelper.setActive(item.goSelectedBg, self.goodsMO == goodsMO)
	gohelper.setActive(item.goNotSelectedBg, self.goodsMO == goodsMO)

	local scale = 0.8

	if self.goodsMO == goodsMO then
		scale = 1
		self._currentSelectSkinIndex = index
		self._preSelectSkinIndex = index
	end

	transformhelper.setLocalScale(item.transSkinmask, scale, scale, scale)
	gohelper.setActive(itemGo, true)
	table.insert(self._itemObjects, item)
end

function StoreSkinPreviewView:_onItemClick(index)
	if self._currentSelectSkinIndex == index then
		return
	end

	csTweenHelper.KillById(self._tweeningId)

	self._preSelectSkinIndex = self._currentSelectSkinIndex
	self._currentSelectSkinIndex = index

	local item = self._itemObjects[self._currentSelectSkinIndex]

	self:_reallyRefreshView(item.skinCo)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_skin_switch)

	for i, v in ipairs(self._itemObjects) do
		local scale = self._currentSelectSkinIndex == i and 1 or 0.8

		transformhelper.setLocalScale(v.transSkinmask, scale, scale, scale)
	end

	self._tweeningId = csTweenHelper.DOAnchorPosX(self._goContent.transform, -(self._currentSelectSkinIndex - 1) * self._itemWidth, 0.5, self.onCompleteTween, self)
end

function StoreSkinPreviewView:_onSpineLoaded()
	return
end

function StoreSkinPreviewView:onClose()
	self._simageskin:UnLoadImage()
	self._simagesignature:UnLoadImage()
	self._simagel2d:UnLoadImage()

	for i, item in ipairs(self._itemObjects) do
		item.image:UnLoadImage()
		item.click:RemoveClickListener()
	end

	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragListener()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	TaskDispatcher.cancelTask(self._refreshBigSkin)
end

function StoreSkinPreviewView:onCloseFinish()
	self:_disableClipAlpha()
end

function StoreSkinPreviewView:onDestroyView()
	if self._goSpine then
		self._goSpine:stopVoice()

		self._goSpine = nil
	end

	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	self._simagebg:UnLoadImage()
	self._simageshowbg:UnLoadImage()
	self:_disableClipAlpha()
end

function StoreSkinPreviewView:_disableClipAlpha()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

return StoreSkinPreviewView
