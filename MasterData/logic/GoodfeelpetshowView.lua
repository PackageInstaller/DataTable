-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelpetshowView.lua

module("logic.extensions.goodfeel.view.GoodfeelpetshowView", package.seeall)

local GoodfeelpetshowView = class("GoodfeelpetshowView", ViewComponent)
local TabType = {
	Story = 3,
	Info = 2,
	Voice = 4,
	Attr = 5
}

function GoodfeelpetshowView:ctor()
	GoodfeelpetshowView.super.ctor(self)
end

function GoodfeelpetshowView:buildUI()
	GoodfeelpetshowView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._hudongBtn = self:getBtn("hudongBtn")
	self._rewardBtn = self:getBtn("feelBg/btnReward")
	self._rewardBtnDot = self:getGo("feelBg/redpoint")
	self._leftBtn = self:getBtn("leftBtn")
	self._rightBtn = self:getBtn("rightBtn")
	self._rightBtnTween = self._rightBtn.gameObject:GetComponent(UnityTweensType.TweenPosition)
	self._infoBtn = self:getBtn("rightTabs/infoBtn")
	self._storyBtn = self:getBtn("rightTabs/storyBtn")
	self._voiceBtn = self:getBtn("rightTabs/voiceBtn")
	self._arrtBtn = self:getBtn("rightTabs/arrtBtn")
	self._storyBtnDot = self:getGo("rightTabs/storyBtn/dot")
	self._infoBtnChange = goutil.findChild(self._infoBtn.gameObject, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
	self._storyBtnChange = goutil.findChild(self._storyBtn.gameObject, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
	self._voiceBtnChange = goutil.findChild(self._voiceBtn.gameObject, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
	self._attrBtnChange = goutil.findChild(self._arrtBtn.gameObject, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
	self._lvText = goutil.findChildTextComponent(self.mainGO, "feelBg/lvText")
	self._ratioImg = self:getGo("feelBg/heartSlider"):GetComponent(goutil.Type_UIImage)
	self._subCon = self:getGo("subCon")

	local dragContent = self:getGo("role/dragContent")

	self._dragContent = Framework.UIDragTrigger.Get(dragContent)

	local rawImg = goutil.findChild(dragContent, "role_image_1")

	self._rawImgDrag = RawImageDrag.New(dragContent, rawImg)

	self._rawImgDrag:setUpdateCallback(self._updateRoleCell, self)
	self._rawImgDrag:setClickCallback(self._onClickCell, self)

	self._fillText = goutil.findChildTextComponent(self.mainGO, "feelBg/text")
	self._bubblePos = self:getGo("role/bubble").transform.position
	self._effectGo = self:getGo("effect")
	self._giftEffectGo = self:getGo("giftEffect")
	self._lvupEffectGo = self:getGo("lvupEffect")
	self._giftConGo = self:getGo("giftCon")
end

function GoodfeelpetshowView:bindEvents()
	GoodfeelpetshowView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._hudongBtn:AddClickListener(self._onClickHudong, self)
	self._rewardBtn:AddClickListener(self._onClickReward, self)
	self._leftBtn:AddClickListener(self._onClickLeftBtn, self)
	self._rightBtn:AddClickListener(self._onClickRightBtn, self)
	self._infoBtn:AddClickListener(self._onClickInfoTab, self)
	self._storyBtn:AddClickListener(self._onClickStoryTab, self)
	self._voiceBtn:AddClickListener(self._onClickVoiceTab, self)
	self._arrtBtn:AddClickListener(self._onClickArrtBtn, self)
end

function GoodfeelpetshowView:unbindEvents()
	GoodfeelpetshowView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._hudongBtn:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
	self._infoBtn:RemoveClickListener()
	self._storyBtn:RemoveClickListener()
	self._voiceBtn:RemoveClickListener()
	self._arrtBtn:RemoveClickListener()
end

function GoodfeelpetshowView:destroyUI()
	GoodfeelpetshowView.super.destroyUI(self)
end

function GoodfeelpetshowView:onEnter()
	GoodfeelpetshowView.super.onEnter(self)
	GoodFeelModel.instance:setJumpMainViewTab(GoodfeelmainView.TabType.AdressList)
	GlobalDispatcher:addListener(GoodFeelModel.ChangePetShow, self._onChangePetShow, self)
	GlobalDispatcher:addListener(GoodFeelModel.DoSendGiftAni, self._playAddGoodFeelExp, self)
	GlobalDispatcher:addListener(GoodFeelController.PM_GFViewStoryRes, self._checkRedDot, self)
	GlobalDispatcher:addListener(GoodFeelController.PM_GFGainPrizeRes, self._checkRedDot, self)
	GlobalDispatcher:addListener(GoodFeelController.UpdateSendGifeUpLvDot, self._checkRedDot, self)
	GlobalDispatcher:addListener(GoodFeelController.UseGiftError, self._updateGoodFeelExp, self)
	GlobalDispatcher:addListener(GoodFeelController.RealUseGift, self._updateGoodFeelExp, self)
	GlobalDispatcher:addListener(GoodFeelController.PlayLvUpEffect, self._playLvupEffect, self)
	GlobalDispatcher:addListener(GoodFeelController.PlayVoiceCv, self._playCv, self)
	GlobalDispatcher:addListener(GoodFeelController.PM_GFGetEventInfoRes, self._onGFGetEventInfoRes, self)

	self._giftNeedPlayEffectCount = {}
	self._isFirstEnter = true
	self._addExpIndex = 0
	self._raceId, self._skinId = GoodFeelModel.instance:getPetShowViewCurrRaceId()
	self._raceInfoList = GoodFeelModel.instance:getPetShowViewCurrRaceIdList()
	self._idx = 1

	for i, raceId in ipairs(self._raceInfoList) do
		if raceId == self._raceId then
			self._idx = i

			break
		end
	end

	self._rawImgDrag:setMaxNum(#self._raceInfoList)
	self:_switchTab(TabType.Info, true)
	self:_centerOnIndex(self._idx, false, false)
	self:_setEffect()
end

function GoodfeelpetshowView:onEnterFinished()
	GoodfeelpetshowView.super.onEnterFinished(self)
end

function GoodfeelpetshowView:onExit()
	GoodfeelpetshowView.super.onExit(self)
	self._rightBtnTween:Stop()
	GlobalDispatcher:removeListener(GoodFeelModel.ChangePetShow, self._onChangePetShow, self)
	GlobalDispatcher:removeListener(GoodFeelModel.DoSendGiftAni, self._playAddGoodFeelExp, self)
	GlobalDispatcher:removeListener(GoodFeelController.PM_GFViewStoryRes, self._checkRedDot, self)
	GlobalDispatcher:removeListener(GoodFeelController.PM_GFGainPrizeRes, self._checkRedDot, self)
	GlobalDispatcher:removeListener(GoodFeelController.UpdateSendGifeUpLvDot, self._checkRedDot, self)
	GlobalDispatcher:removeListener(GoodFeelController.UseGiftError, self._updateGoodFeelExp, self)
	GlobalDispatcher:removeListener(GoodFeelController.PlayLvUpEffect, self._playLvupEffect, self)
	GlobalDispatcher:removeListener(GoodFeelController.PlayVoiceCv, self._playCv, self)
	GlobalDispatcher:removeListener(GoodFeelController.RealUseGift, self._updateGoodFeelExp, self)
	GlobalDispatcher:removeListener(GoodFeelController.PM_GFGetEventInfoRes, self._onGFGetEventInfoRes, self)
	UIEffectManager.instance:stopEffect(self._effectHandle)
	UIEffectManager.instance:stopEffect(self._giftEffectHandle)
	UIEffectManager.instance:stopEffect(self._lvEffectHandler)
	removetimer(self._giftEffectFinish, self)
	PetCvController.instance:turnOffCurCv(nil, nil, true)

	self._isPlayEffect = false
	self._effectHandle = nil
	self._giftEffectHandle = nil
	self._lvEffectHandler = nil
end

function GoodfeelpetshowView:onExitFinished()
	GoodfeelpetshowView.super.onExitFinished(self)
end

function GoodfeelpetshowView:_onClickHudong()
	if GoodFeelModel.instance:getTodayInteractLeftCount() <= 0 then
		FloatWordMgr.instance:show("今日互动次数已用尽")

		return
	end

	GoodFeelingAgent.instance:sendPM_GFGetEventInfoReq(self._raceId)
end

function GoodfeelpetshowView:_onClickReward()
	UIStateManager.instance:push(ViewName.GoodfeelrewardView, self._raceId)
end

function GoodfeelpetshowView:_onClickLeftBtn()
	self:_onClickChangeShow(true)
end

function GoodfeelpetshowView:_onClickRightBtn()
	self:_onClickChangeShow(false)
end

function GoodfeelpetshowView:_onClickChangeShow(isClickLeft)
	local dataLen = #self._raceInfoList

	if isClickLeft then
		self._idx = self._idx - 1 or self._idx + 1
	end

	self._idx = math.min(self._idx, dataLen)
	self._idx = math.max(self._idx, 1)

	self:_centerOnIndex(self._idx, true, isClickLeft)
end

function GoodfeelpetshowView:_onClickInfoTab()
	self:_switchTab(TabType.Info)
end

function GoodfeelpetshowView:_onClickStoryTab()
	self:_switchTab(TabType.Story)
end

function GoodfeelpetshowView:_onClickVoiceTab()
	self:_switchTab(TabType.Voice)
end

function GoodfeelpetshowView:_onClickArrtBtn()
	self:_switchTab(TabType.Attr)
end

function GoodfeelpetshowView:_switchTab(tab, force)
	if tab == self._currTabType and not force then
		return
	end

	self._currTabType = tab

	self:_updateRightBtnTween(tab)
	self:_updateTabState(tab)
	self:_updateView(tab)
end

function GoodfeelpetshowView:_updateRightBtnTween(tab)
	self._rightBtnTween:Stop()

	local v2 = GameUtil.getAnchoredPos(self._rightBtnTween.gameObject)

	self._rightBtnTween.from = Vector2.New(v2.x, v2.y)
	self._rightBtnTween.time = self._isFirstEnter and 0 or 0.1
	self._isFirstEnter = false
	self._rightBtnTween.to = tab == TabType.Gift and Vector2.New(-206, currY) or Vector2.New(-500, currY)

	self._rightBtnTween:Begin()
end

function GoodfeelpetshowView:_updateTabState(tab)
	self._voiceBtnChange:SetState(tab == TabType.Voice and 1 or 0)
	self._storyBtnChange:SetState(tab == TabType.Story and 1 or 0)
	self._infoBtnChange:SetState(tab == TabType.Info and 1 or 0)
	self._attrBtnChange:SetState(tab == TabType.Attr and 1 or 0)
end

function GoodfeelpetshowView:_updateView(tab)
	local viewName = ""

	if tab == TabType.Info then
		viewName = ViewName.GoodfeelpetinfoView
	elseif tab == TabType.Story then
		viewName = ViewName.GoodfeelstroyView
	elseif tab == TabType.Voice then
		viewName = ViewName.GoodfeelvoiceView
	elseif tab == TabType.Attr then
		viewName = ViewName.GoodfeelattrView
	end

	local isFromGift = not self._lastTab or self._lastTab == TabType.Gift and tab ~= TabType.Gift

	self._lastTab = tab

	self:_doRoleAnim(tab)

	if not string.nilorempty(viewName) then
		self:showTabAt(self._subCon, viewName, isFromGift)
	end
end

function GoodfeelpetshowView:_doRoleAnim(tab, noTween)
	if self._petPhotoShow then
		self._targetScale = {
			z = 1,
			x = 1,
			y = 1
		}
		self._targetposX = 0
		self._targetposY = 0

		local duration = noTween and 0 or 0.15

		if tab == TabType.Gift then
			self._targetScale = 1
			self._targetposX = 0
			self._targetposY = 0
		else
			self._targetScale.x = -1
			self._targetposX = -0.5
			self._targetposY = 0
		end

		self._petPhotoShow:doTargetContainerScaleTween(self._targetScale, duration)
		self._petPhotoShow:doTargetContainerPosTween(self._targetposX, self._targetposY, duration)
	end
end

function GoodfeelpetshowView:_playGiftEffect()
	local sendNum = table.remove(self._giftNeedPlayEffectCount, 1)
	local effectName = "fx_ui_zhuzhuyangcheng/fx_ui_zhuzhuyangcheng_03.prefab"
	local posx = 0
	local posy = 0

	if sendNum and sendNum > 1 then
		effectName = "fx_ui_haogandu/fx_ui_haogandu01.prefab"
		posx = 36
		posy = -146
	end

	self._isPlayEffect = true
	self._giftEffectHandle = UIEffectManager.instance:playEffect(self, effectName, nil, nil, nil, false)

	self._giftEffectHandle:setParent(self._giftEffectGo.transform)
	self._giftEffectHandle:setScale(1)
	self._giftEffectHandle:setLocalPos(posx, posy, 0)

	self._giftEffectHandle.hideEffWhileNotOnTop = false

	settimer(0.4, self._giftEffectFinish, self, false)
end

function GoodfeelpetshowView:_giftEffectFinish()
	self._isPlayEffect = false

	if #self._giftNeedPlayEffectCount > 0 then
		self:_playGiftEffect()
	end
end

function GoodfeelpetshowView:_playAddGoodFeelExp(addValue, sendNum)
	if addValue and addValue > 0 then
		table.insert(self._giftNeedPlayEffectCount, sendNum)

		if not ViewMgr.instance:isOpen(ViewName.FavorChange) then
			UIStateManager.instance:open(ViewName.FavorChange, addValue)
		else
			GlobalDispatcher:dispatch(GlobalNotify.PigFavorChange, addValue)
		end

		if not self._isPlayEffect then
			self:_playGiftEffect(sendNum)
		end
	end

	self:_updateGoodFeelExp()
end

function GoodfeelpetshowView:_updateGoodFeelExp()
	local exp = GoodFeelModel.instance:getGoodFeelExp(self._raceId)
	local lv = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId, exp)
	local cfg = GoodFeelConfig.instance:getGoodFeelExpCfg(lv + 1)
	local ratio = 0

	if cfg then
		local currCfg = GoodFeelConfig.instance:getGoodFeelExpCfg(lv)
		local hasExp = exp - currCfg.exp
		local base = cfg.exp - currCfg.exp

		ratio = hasExp / base
		self._fillText.text = hasExp .. "/" .. base
	else
		ratio = 1
		self._fillText.text = "最高级"
	end

	self._lvText.text = lv
	self._ratioImg.fillAmount = ratio
end

function GoodfeelpetshowView:_checkRedDot()
	local rewardDot = GoodFeelModel.instance:checkCanGainLvReward(self._raceId)

	goutil.setActive(self._rewardBtnDot, rewardDot)

	local storyDot = GoodFeelModel.instance:checkHasNewStory(self._raceId)

	goutil.setActive(self._storyBtnDot, storyDot)
end

function GoodfeelpetshowView:_onChangePetShow()
	self:_updateGoodFeelExp()
end

function GoodfeelpetshowView:_centerOnIndex(idx, isSpring, isLeft)
	self._rawImgDrag:centerOnIndex(idx, isSpring, isLeft)
end

function GoodfeelpetshowView:_updateRoleCell(idx, cell)
	self._petPhotoShow = PetPhotoShow.Get(cell.gameObject)

	local raceId = self._raceInfoList[idx]

	GoodFeelModel.instance:changeSetPetShowViewCurrRaceId(raceId)

	self._raceId, self._skinId = GoodFeelModel.instance:getPetShowViewCurrRaceId()

	self:_updateGoodFeelExp()
	self:_checkRedDot()
	self:_checkBtnActive(idx)
	GlobalDispatcher:dispatch(GoodFeelModel.ChangePetShow)
	self._petPhotoShow:showPetEffect(self._skinId, true, nil)
	self:_doRoleAnim(self._lastTab, true)
	PetCvController.instance:turnOffCurCv(nil, nil, true)
end

function GoodfeelpetshowView:_checkBtnActive(idx)
	self._idx = idx

	local dataLen = #self._raceInfoList

	goutil.setActive(self._leftBtn.gameObject, self._idx > 1)
	goutil.setActive(self._rightBtn.gameObject, dataLen > self._idx)
end

function GoodfeelpetshowView:_onClickCell()
	local list = GoodFeelModel.instance:getRandomBubbleList(self._raceId, self._skinId)

	if #list > 0 then
		local index = math.random(1, #list)
		local cfg = list[index]

		self:_playCv(cfg)
	end
end

function GoodfeelpetshowView:_setEffect()
	return
end

function GoodfeelpetshowView:_playLvupEffect()
	UIEffectManager.instance:stopEffect(self._lvEffectHandler)

	self._lvEffectHandler = UIEffectManager.instance:playEffect(self, "fx_ui_zhuzhuyangcheng/fx_ui_zhuzhuyangcheng_01.prefab", nil, 0, 0, false, false)

	self._lvEffectHandler:setParent(self._lvupEffectGo.transform)
	self._lvEffectHandler:setScale(1)
	self._lvEffectHandler:setLocalPos(0, 0, 0)

	self._lvEffectHandler.hideEffWhileNotOnTop = false
end

function GoodfeelpetshowView:_playCv(cvCfg)
	PetCvController.instance:_playPetCvByCfg(cvCfg, true, self._bubblePos)
end

function GoodfeelpetshowView:_onGFGetEventInfoRes(msg)
	local eventInfo = msg.eventInfo
	local cfg = GoodFeelConfig.instance:getHudongEvent(eventInfo.eventId)

	if cfg.eventType == 1 then
		if eventInfo.eventFinished then
			FloatWordMgr.instance:show("今天该精灵的互动事件已全部完成")

			return
		end

		UIStateManager.instance:push(ViewName.GoodfeelhudongView, msg.eventInfo.raceId, cfg)
	end
end

return GoodfeelpetshowView
