-- chunkname: @modules/logic/summonsimulationpick/view/SummonSimulationResultView.lua

module("modules.logic.summonsimulationpick.view.SummonSimulationResultView", package.seeall)

local SummonSimulationResultView = class("SummonSimulationResultView", BaseView)

SummonSimulationResultView.SAVED_ANIM_NAME = "open"
SummonSimulationResultView.IDLE_ANIM_NAME = "idle"
SummonSimulationResultView.FIRST_SAVE_ANIM_DELAY = 0.5
SummonSimulationResultView.SUMMON_CONFIRM_TEXT = "p_summonpickresultview_txt_confirm"
SummonSimulationResultView.SUMMON_AGAIN_TEXT = "p_summonpickresultview_txt_again"

function SummonSimulationResultView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagebg0 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg0")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._simageline1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_line1")
	self._simageline2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_line2")
	self._simageline3 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_line3")
	self._goheroitem10 = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem10")
	self._goheroitem5 = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem5")
	self._goheroitem2 = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem2")
	self._goheroitem4 = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem4")
	self._goheroitem7 = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem7")
	self._goheroitem8 = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem8")
	self._goheroitem3 = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem3")
	self._goheroitem1 = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem1")
	self._goheroitem6 = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem6")
	self._goheroitem9 = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem9")
	self._btnsave = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_save")
	self._gosaved = gohelper.findChild(self.viewGO, "Btn/#go_saved")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_confirm")
	self._btnagain = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_again")
	self._btntips = gohelper.findChildButton(self.viewGO, "#btn_tips")
	self._txtresttime = gohelper.findChildText(self.viewGO, "Btn/rest/#txt_resttime")
	self._txtagain = gohelper.findChildText(self.viewGO, "Btn/#btn_again/#txt_again")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonSimulationResultView:addEvents()
	self._btnsave:AddClickListener(self._btnsaveOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnagain:AddClickListener(self._btnagainOnClick, self)
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSummonSimulation, self.onSummonSimulation, self)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSaveResult, self.onSummonSave, self)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onSelectResult, self.closeThis, self)
end

function SummonSimulationResultView:removeEvents()
	self._btnsave:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnagain:RemoveClickListener()
	self._btntips:RemoveClickListener()
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSummonSimulation, self.onSummonSimulation, self)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSaveResult, self.onSummonSave, self)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onSelectResult, self.closeThis, self)
end

function SummonSimulationResultView:_btnsaveOnClick()
	if self._cantClose then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonSimulationPickView, {
		activityId = self._activityId
	})
end

function SummonSimulationResultView:_onclickEsc()
	return
end

function SummonSimulationResultView:_btnconfirmOnClick()
	if self._cantClose then
		return
	end

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewOpenFinish, self)
	ViewMgr.instance:openView(ViewName.SummonSimulationPickView, {
		isFromMaterialTipView = true,
		activityId = self._activityId
	})
end

function SummonSimulationResultView:onViewOpenFinish(viewName)
	if viewName == ViewName.SummonSimulationPickView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewOpenFinish, self)
		self:closeThis()
	end
end

function SummonSimulationResultView:_btnagainOnClick()
	if self._cantClose then
		return
	end

	local info = SummonSimulationPickModel.instance:getActInfo(self._activityId)

	if info.leftTimes > 0 then
		SummonSimulationPickController.instance:summonSimulation(self._activityId, false)
	else
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewOpenFinish, self)
		ViewMgr.instance:openView(ViewName.SummonSimulationPickView, {
			isFromMaterialTipView = true,
			activityId = self._activityId
		})
	end
end

function SummonSimulationResultView:_btntipsOnClick()
	if self._cantClose then
		return
	end

	SummonSimulationPickController.instance:openSummonTips(self._activityId)
end

function SummonSimulationResultView:_btncloseOnClick()
	if self._cantClose then
		return
	end

	local msgId = MessageBoxIdDefine.SummonSimulationExit

	GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self._confirmExit, nil, nil, self)
end

function SummonSimulationResultView:_confirmExit()
	if self._isReprint == false then
		local instance = SummonSimulationPickController.instance

		SummonController.instance:setSummonEndOpenCallBack(instance.backHome, instance)
	end

	self.isClickBack = true

	self:closeThis()
end

function SummonSimulationResultView:onSummonSimulation()
	self.isSummon = true

	SummonSimulationPickController.instance:startBlack()
	self:closeThis()
end

function SummonSimulationResultView:_editableInitView()
	gohelper.setActive(self._goheroitem, false)

	self._heroItemTables = {}

	for i = 1, 10 do
		local heroItemTable = self:getUserDataTb_()

		heroItemTable.go = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem" .. i)
		heroItemTable.txtname = gohelper.findChildText(heroItemTable.go, "name")
		heroItemTable.txtnameen = gohelper.findChildText(heroItemTable.go, "nameen")
		heroItemTable.imagerare = gohelper.findChildImage(heroItemTable.go, "rare")
		heroItemTable.equiprare = gohelper.findChildImage(heroItemTable.go, "equiprare")
		heroItemTable.imagecareer = gohelper.findChildImage(heroItemTable.go, "career")
		heroItemTable.imageequipcareer = gohelper.findChildImage(heroItemTable.go, "equipcareer")
		heroItemTable.goHeroIcon = gohelper.findChild(heroItemTable.go, "heroicon")
		heroItemTable.simageicon = gohelper.findChildSingleImage(heroItemTable.go, "heroicon/icon")
		heroItemTable.simageequipicon = gohelper.findChildSingleImage(heroItemTable.go, "equipicon")
		heroItemTable.imageicon = gohelper.findChildImage(heroItemTable.go, "heroicon/icon")
		heroItemTable.goeffect = gohelper.findChild(heroItemTable.go, "effect")
		heroItemTable.btnself = gohelper.findChildButtonWithAudio(heroItemTable.go, "btn_self")
		heroItemTable.goluckybag = gohelper.findChild(heroItemTable.go, "luckybag")
		heroItemTable.txtluckybagname = gohelper.findChildText(heroItemTable.goluckybag, "name")
		heroItemTable.txtluckybagnameen = gohelper.findChildText(heroItemTable.goluckybag, "nameen")
		heroItemTable.simageluckgbagicon = gohelper.findChildSingleImage(heroItemTable.goluckybag, "icon")

		heroItemTable.btnself:AddClickListener(self.onClickItem, {
			view = self,
			index = i
		})
		table.insert(self._heroItemTables, heroItemTable)
	end

	self._cantClose = true
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, self._tweenFinish, self, nil, EaseType.Linear)
	self._goSaveAnimator = gohelper.findChildComponent(self._gosaved.gameObject, "", gohelper.Type_Animator)

	gohelper.setActive(self._btnconfirm, false)
	gohelper.setActive(self._btnsave, false)

	self._goRest = gohelper.findChild(self.viewGO, "Btn/rest")
end

function SummonSimulationResultView:onDestroyView()
	for i = 1, 10 do
		local heroItemTable = self._heroItemTables[i]

		if heroItemTable then
			if heroItemTable.simageicon then
				heroItemTable.simageicon:UnLoadImage()
			end

			if heroItemTable.simageequipicon then
				heroItemTable.simageequipicon:UnLoadImage()
			end

			if heroItemTable.btnself then
				heroItemTable.btnself:RemoveClickListener()
			end

			if heroItemTable.simageluckgbagicon then
				heroItemTable.simageluckgbagicon:UnLoadImage()
			end
		end
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end
end

function SummonSimulationResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_TenHero_OpenAll)

	local summonResultList = self.viewParam.summonResultList

	self._curPool = self.viewParam.curPool
	self._summonResultList = {}

	if self.viewParam.isReprint ~= nil then
		self._isReprint = self.viewParam.isReprint or false
	end

	for i, v in ipairs(summonResultList) do
		table.insert(self._summonResultList, v)
	end

	if self._curPool then
		SummonModel.sortResult(self._summonResultList, self._curPool.id)
	end

	self:_refreshUI()
	NavigateMgr.instance:addEscape(ViewName.SummonSimulationResultView, self._onclickEsc, self)
end

function SummonSimulationResultView:onClose()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewOpenFinish, self)
	TaskDispatcher.cancelTask(self.delayPlayBtnAnim, self)
end

function SummonSimulationResultView:onCloseFinish()
	if not self:_showCommonPropView() then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonResultClose)
	end
end

function SummonSimulationResultView.onClickItem(params)
	local view = params.view
	local index = params.index
	local summonReward = view._summonResultList[index]

	if summonReward.heroId and summonReward.heroId ~= 0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			showHome = false,
			heroId = summonReward.heroId
		})
	elseif summonReward.equipId and summonReward.equipId ~= 0 then
		EquipController.instance:openEquipView({
			equipId = summonReward.equipId
		})
	elseif summonReward:isLuckyBag() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagGoMainViewOpen)
	end
end

function SummonSimulationResultView:_tweenFinish()
	self._cantClose = false
end

function SummonSimulationResultView:onSummonReply()
	self:closeThis()
end

function SummonSimulationResultView:onSummonSave()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onSaveViewClose, self)
end

function SummonSimulationResultView:onSaveViewClose(viewName)
	if viewName == ViewName.SummonSimulationPickView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onSaveViewClose, self)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2SummonSimulation.play_ui_checkpoint_doom_disappear)
		self:_refreshSelectState()
	end
end

function SummonSimulationResultView:_refreshUI()
	local openSummonScene = VirtualSummonScene.instance:isOpen()

	gohelper.setActive(self._simagebg0, not openSummonScene)

	for i = 1, #self._summonResultList do
		local summonReward = self._summonResultList[i]

		if summonReward.heroId and summonReward.heroId ~= 0 then
			self:_refreshHeroItem(self._heroItemTables[i], summonReward)
		elseif summonReward.equipId and summonReward.equipId ~= 0 then
			self:_refreshEquipItem(self._heroItemTables[i], summonReward)
		elseif summonReward:isLuckyBag() then
			self:_refreshLuckyBagItem(self._heroItemTables[i], summonReward)
		else
			gohelper.setActive(self._heroItemTables[i].go, false)
		end
	end

	for i = #self._summonResultList + 1, #self._heroItemTables do
		gohelper.setActive(self._heroItemTables[i].go, false)
	end

	self:_refreshSelectState()
end

function SummonSimulationResultView:_refreshSelectState()
	local activityId = SummonSimulationPickController.instance:getCurrentSummonActivityId()

	self._activityId = activityId

	local info = SummonSimulationPickModel.instance:getActInfo(activityId)

	if not info then
		return
	end

	local maxTime = SummonSimulationPickModel.instance:getActivityMaxSummonCount(activityId)
	local remainTime = info.leftTimes

	self._txtresttime.text = string.format("<size=46><#C66030>%s</color></size>/%s", remainTime, maxTime)

	local isEnd = remainTime <= 0

	gohelper.setActive(self._goRest, not isEnd)

	self._txtagain.text = isEnd and luaLang(self.SUMMON_CONFIRM_TEXT) or luaLang(self.SUMMON_AGAIN_TEXT)

	local showAnimation = not self._isReprint
	local animator = self._goSaveAnimator

	animator.enabled = showAnimation

	if showAnimation then
		if self._isReprint == false then
			local delay = self.FIRST_SAVE_ANIM_DELAY

			TaskDispatcher.runDelay(self.delayPlayBtnAnim, self, delay)
		else
			animator:Play(self.SAVED_ANIM_NAME, 0, 0)
		end
	end
end

function SummonSimulationResultView:delayPlayBtnAnim()
	self._goSaveAnimator:Play(self.SAVED_ANIM_NAME, 0, 0)
	GameFacade.showToast(ToastEnum.SummonSimulationSaveResult)
	TaskDispatcher.cancelTask(self.delayPlayBtnAnim, self)
end

local function onImageLoaded(heroItemTable)
	if not gohelper.isNil(heroItemTable.imageicon) then
		heroItemTable.imageicon:SetNativeSize()
	end
end

function SummonSimulationResultView:_refreshEquipItem(heroItemTable, summonReward)
	gohelper.setActive(heroItemTable.goHeroIcon, false)
	gohelper.setActive(heroItemTable.simageequipicon.gameObject, true)
	gohelper.setActive(heroItemTable.goluckybag, false)
	gohelper.setActive(heroItemTable.txtname, true)
	gohelper.setActive(heroItemTable.txtnameen, true)

	local equipId = summonReward.equipId
	local equipCo = EquipConfig.instance:getEquipCo(equipId)

	heroItemTable.txtname.text = equipCo.name
	heroItemTable.txtnameen.text = equipCo.name_en

	UISpriteSetMgr.instance:setSummonSprite(heroItemTable.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[equipCo.rare]))
	UISpriteSetMgr.instance:setSummonSprite(heroItemTable.equiprare, "equiprare_" .. tostring(CharacterEnum.Color[equipCo.rare]))
	gohelper.setActive(heroItemTable.imagecareer.gameObject, false)
	gohelper.setActive(heroItemTable.simageicon.gameObject, false)
	heroItemTable.simageequipicon:LoadImage(ResUrl.getSummonEquipGetIcon(equipCo.icon), onImageLoaded, heroItemTable)
	EquipHelper.loadEquipCareerNewIcon(equipCo, heroItemTable.imageequipcareer, 1, "lssx")
	self:_refreshEffect(equipCo.rare, heroItemTable)
	gohelper.setActive(heroItemTable.go, true)
end

function SummonSimulationResultView:_refreshHeroItem(heroItemTable, summonReward)
	gohelper.setActive(heroItemTable.imageequipcareer.gameObject, false)
	gohelper.setActive(heroItemTable.goHeroIcon, true)
	gohelper.setActive(heroItemTable.goluckybag, false)
	gohelper.setActive(heroItemTable.txtname, true)
	gohelper.setActive(heroItemTable.txtnameen, true)

	local heroId = summonReward.heroId
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)
	local skinConfig = SkinConfig.instance:getSkinCo(heroConfig.skinId)

	gohelper.setActive(heroItemTable.equiprare.gameObject, false)
	gohelper.setActive(heroItemTable.simageequipicon.gameObject, false)

	heroItemTable.txtname.text = heroConfig.name
	heroItemTable.txtnameen.text = heroConfig.nameEng

	UISpriteSetMgr.instance:setSummonSprite(heroItemTable.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[heroConfig.rare]))
	UISpriteSetMgr.instance:setCommonSprite(heroItemTable.imagecareer, "lssx_" .. tostring(heroConfig.career))
	heroItemTable.simageicon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))

	if heroItemTable.effect then
		gohelper.destroy(heroItemTable.effect)

		heroItemTable.effect = nil
	end

	self:_refreshEffect(heroConfig.rare, heroItemTable)
	gohelper.setActive(heroItemTable.go, true)
end

function SummonSimulationResultView:_refreshLuckyBagItem(heroItemTable, summonReward)
	gohelper.setActive(heroItemTable.goluckybag, true)
	gohelper.setActive(heroItemTable.equiprare.gameObject, false)
	gohelper.setActive(heroItemTable.simageequipicon.gameObject, false)
	gohelper.setActive(heroItemTable.imagecareer.gameObject, false)
	gohelper.setActive(heroItemTable.simageicon.gameObject, false)
	gohelper.setActive(heroItemTable.txtname, false)
	gohelper.setActive(heroItemTable.txtnameen, false)

	local luckyBagId = summonReward.luckyBagId

	if not self._curPool then
		return
	end

	local co = SummonConfig.instance:getLuckyBag(self._curPool.id, luckyBagId)

	heroItemTable.txtluckybagname.text = co.name
	heroItemTable.txtluckybagnameen.text = co.nameEn or ""

	heroItemTable.simageluckgbagicon:LoadImage(ResUrl.getSummonCoverBg(co.icon))
	UISpriteSetMgr.instance:setSummonSprite(heroItemTable.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[SummonEnum.LuckyBagRare]))
	self:_refreshEffect(SummonEnum.LuckyBagRare, heroItemTable)
	gohelper.setActive(heroItemTable.go, true)
end

function SummonSimulationResultView:_refreshEffect(rare, heroItemTable)
	local effectPath

	if rare == 3 then
		effectPath = self.viewContainer:getSetting().otherRes[1]
	elseif rare == 4 then
		effectPath = self.viewContainer:getSetting().otherRes[2]
	elseif rare == 5 then
		effectPath = self.viewContainer:getSetting().otherRes[3]
	end

	if effectPath then
		heroItemTable.effect = self.viewContainer:getResInst(effectPath, heroItemTable.goeffect, "effect")

		local animation = heroItemTable.effect:GetComponent(typeof(UnityEngine.Animation))

		animation:PlayQueued("ssr_loop", UnityEngine.QueueMode.CompleteOthers)
	end
end

function SummonSimulationResultView:onUpdateParam()
	local paramResultList = self.viewParam.summonResultList

	self._summonResultList = {}
	self._curPool = self.viewParam.curPool

	for i, v in ipairs(paramResultList) do
		table.insert(self._summonResultList, v)
	end

	if self._curPool then
		SummonModel.sortResult(self._summonResultList, self._curPool.id)
	end

	self:_refreshUI()
end

function SummonSimulationResultView:_showCommonPropView()
	local activityId = self._activityId
	local info = SummonSimulationPickModel.instance:getActInfo(activityId)

	if info.isSelect == false then
		if VirtualSummonScene.instance:isOpen() then
			if self.isClickBack then
				return false
			elseif self.isSummon then
				return true
			end
		end

		return not self._isReprint
	end

	local heroIds = info.saveHeroIds[info.selectIndex]
	local rewards = SummonController.instance:getVirtualSummonResult(heroIds, false, true)

	if rewards == nil then
		return false
	end

	local instance = SummonSimulationPickController.instance

	SummonController.instance:setSummonEndOpenCallBack(instance.backHome, instance)

	local rewardMos = SummonModel.getRewardList(rewards, true)

	table.sort(rewardMos, SummonModel.sortRewards)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, rewardMos)

	return true
end

return SummonSimulationResultView
