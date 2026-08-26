-- chunkname: @modules/logic/battlepass/view/BpBonusView.lua

module("modules.logic.battlepass.view.BpBonusView", package.seeall)

local BpBonusView = class("BpBonusView", BaseView)

function BpBonusView:onInitView()
	self._scrollRectWrap = gohelper.findChildScrollRect(self.viewGO, "root/#scroll")
	self._goKeyBonus = gohelper.findChild(self.viewGO, "root/#keyBonus")
	self._simagepaymask = gohelper.findChildSingleImage(self.viewGO, "root/left/pay/#gomask")
	self._simagescrollbg = gohelper.findChildSingleImage(self.viewGO, "root/#scroll/#simage_scrollbg")
	self._maskClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/pay/#btn_pay", AudioEnum.UI.UI_vertical_first_tabs_click)
	self._txtLeftTime = gohelper.findChildText(self.viewGO, "root/#txtLeftTime")
	self._payAnim = gohelper.findChildComponent(self.viewGO, "root/left/pay", typeof(UnityEngine.Animator))
	self._lineTr = gohelper.findChildComponent(self.viewGO, "root/#scroll/viewport/content/line", typeof(UnityEngine.Transform))
	self._gomask = self._simagepaymask.gameObject

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpBonusView:addEvents()
	self._maskClick:AddClickListener(self._onClickbtnPay, self)
	self.addEventCb(self, BpController.instance, BpEvent.ShowUnlockBonusAnim, self._playUnLockItemAnim, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnGetInfo, self._refreshView, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnGetBonus, self._refreshView, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnUpdateScore, self._refreshView, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self._onUpdatePayStatus, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnBuyLevel, self._onBuyLevel, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnTaskUpdate, self._onTaskUpdate, self)
	self.addEventCb(self, self.viewContainer, BpEvent.TapViewOpenAnimBegin, self._updatePayAnim, self)
	self._scrollRectWrap:AddOnValueChanged(self._onScrollRectValueChanged, self)
end

function BpBonusView:removeEvents()
	self._maskClick:RemoveClickListener()
	self.removeEventCb(self, BpController.instance, BpEvent.ShowUnlockBonusAnim, self._playUnLockItemAnim, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnGetInfo, self._refreshView, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnGetBonus, self._refreshView, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnUpdateScore, self._refreshView, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self._onUpdatePayStatus, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnBuyLevel, self._onBuyLevel, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnTaskUpdate, self._onTaskUpdate, self)
	self.removeEventCb(self, self.viewContainer, BpEvent.TapViewOpenAnimBegin, self._updatePayAnim, self)
	self._scrollRectWrap:RemoveOnValueChanged()
end

function BpBonusView:_editableInitView()
	self._simagescrollbg:LoadImage(ResUrl.getBattlePassBg("img_reward_bg_bot"))

	self._scrollWidth = recthelper.getWidth(self._scrollRectWrap.transform)
	self._keyBonusItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goKeyBonus, BpBonusKeyItem)
	self._cellWidth = 161
	self._cellSpaceH = 0

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/#scroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/#scroll/item"
	scrollParam.cellClass = BpBonusItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = self._cellWidth
	scrollParam.cellHeight = 596
	scrollParam.cellSpaceH = self._cellSpaceH
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.frameUpdateMs = 100
	self._scrollView = LuaListScrollView.New(BpBonusModel.instance, scrollParam)

	self:addChildView(self._scrollView)
end

function BpBonusView:onOpen()
	self:_onUpdatePayStatus()
	self:_udpateScroll()
	self:_updateBtn()
	self:_updateLeftTime()
	BpController.instance:dispatchEvent(BpEvent.SetGetAllCallBack, self._onClickbtnGetAll, self)
	TaskDispatcher.runDelay(self.scrollToLevel, self, 0)

	if BpModel.instance.preStatus then
		TaskDispatcher.runDelay(self._playUnLockItemAnim, self, 0.5)
	end
end

function BpBonusView:onDestroyView()
	self._simagescrollbg:UnLoadImage()
end

function BpBonusView:onClose()
	TaskDispatcher.cancelTask(self.scrollToLevel, self)

	if self._scrollTime then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_permit_slide)
		TaskDispatcher.cancelTask(self.checkScrollEnd, self)

		self._scrollTime = nil
	end

	if self._dotweenId then
		ZProj.TweenHelper.KillById(self._dotweenId)

		self._dotweenId = nil

		BpController.instance:dispatchEvent(BpEvent.BonusAnimEnd)
	end

	BpModel.instance.preStatus = nil
	BpModel.instance.animData = nil

	TaskDispatcher.cancelTask(self.animFinish, self)
	TaskDispatcher.cancelTask(self._playUnLockItemAnim, self)
	BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
end

function BpBonusView:_updateLeftTime()
	local leftSecond = BpModel.instance.endTime - ServerTime.now()

	if leftSecond > 0 then
		local day = math.floor(leftSecond / 86400)
		local hour = math.floor(leftSecond % 86400 / 3600)

		if day > 0 or hour > 0 then
			local tag = {
				day,
				hour
			}

			self._txtLeftTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("bp_dateLeft"), tag)
		else
			self._txtLeftTime.text = luaLang("bp_dateLeft_1h")
		end
	else
		self._txtLeftTime.text = luaLang("bp_dateLeft_timeout")
	end
end

function BpBonusView:_onClickbtnGetAll()
	BpRpc.instance:sendGetBpBonusRequest(0)
end

function BpBonusView:_onClickbtnPay()
	if BpModel.instance:isBpChargeEnd() then
		GameFacade.showToast(ToastEnum.BPChargeEnd)

		return
	end

	ViewMgr.instance:openView(BpController.instance:getBpChargeView())
end

function BpBonusView:_refreshView()
	if not self._has_onOpen then
		return
	end

	self:_udpateScroll()
	self:_updateBtn()
end

function BpBonusView:_onBuyLevel()
	self:_refreshView()
	self:scrollToLevel()
end

function BpBonusView:_onTaskUpdate()
	self:_udpateScroll()
end

function BpBonusView:_playUnLockItemAnim()
	TaskDispatcher.cancelTask(self._playUnLockItemAnim, self)

	if not BpModel.instance.preStatus then
		return
	end

	if not self._has_onOpen then
		return
	end

	if self._dotweenId then
		ZProj.TweenHelper.KillById(self._dotweenId, false)

		self._dotweenId = nil
	end

	TaskDispatcher.cancelTask(self.animFinish, self)

	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local preLv = math.floor(BpModel.instance.preStatus.score / levelScore)
	local nowLv = math.floor(BpModel.instance.score / levelScore)
	local prePayLv = preLv
	local tweenNum = nowLv - preLv

	if BpModel.instance.preStatus.payStatus == BpEnum.PayStatus.NotPay and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay then
		prePayLv = 1
		tweenNum = nowLv - 1
	end

	BpModel.instance.animData = {
		toScrollX = 0,
		preScrollX = 0,
		fromLv = preLv,
		toLv = nowLv,
		fromPayLv = prePayLv
	}

	if tweenNum > BpEnum.BonusTweenMin then
		local fromScrollX = (prePayLv - 4) * (self._cellWidth + self._cellSpaceH)
		local toScrollX = fromScrollX + tweenNum * (self._cellWidth + self._cellSpaceH)
		local maxScrollX = #BpConfig.instance:getBonusCOList(BpModel.instance.id) * (self._cellWidth + self._cellSpaceH) - self._scrollWidth

		BpModel.instance.animData.preScrollX = fromScrollX
		BpModel.instance.animData.toScrollX = math.min(maxScrollX, toScrollX)
		self._dotweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, BpEnum.BonusTweenTime, self.everyFrame, self.animFinish, self, nil, EaseType.OutQuart)
	else
		BpModel.instance.animProcess = 0

		for bonusItem in pairs(self._scrollView._cellCompDict) do
			local index = bonusItem._index

			bonusItem:playUnLockAnim(preLv < index and index <= nowLv, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and prePayLv < index and index <= nowLv)
		end

		TaskDispatcher.runDelay(self.animFinish, self, BpEnum.BonusTweenTime)
	end
end

function BpBonusView:everyFrame(value)
	local data = BpModel.instance.animData

	BpModel.instance.animProcess = value

	local csListView = self._scrollView:getCsListScroll()

	csListView.HorizontalScrollPixel = Mathf.Lerp(data.preScrollX, data.toScrollX, value)

	csListView:UpdateCells(false)
end

function BpBonusView:animFinish()
	TaskDispatcher.cancelTask(self.animFinish, self)

	BpModel.instance.preStatus = nil
	BpModel.instance.animData = nil

	for bonusItem in pairs(self._scrollView._cellCompDict) do
		bonusItem:endUnLockAnim()
	end

	BpController.instance:dispatchEvent(BpEvent.BonusAnimEnd)
end

function BpBonusView:_onUpdatePayStatus()
	self:_refreshView()
	self:_updatePayAnim(1)
end

function BpBonusView:_updatePayAnim(index)
	if index == 1 then
		if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
			self._payAnim:Play(UIAnimationName.Idle)
		else
			self._payAnim:Play(UIAnimationName.Loop)
		end
	end
end

function BpBonusView:_udpateScroll()
	BpBonusModel.instance:refreshListView()

	if self._keyBonusItem and self._keyBonusItem.mo then
		self._keyBonusItem:onUpdateMO(self._keyBonusItem.mo)
	end
end

function BpBonusView:scrollToLevel(level)
	TaskDispatcher.cancelTask(self.scrollToLevel, self)

	local selectLevel
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local curLevel = math.floor(BpModel.instance.score / levelScore)

	selectLevel = level or curLevel
	selectLevel = selectLevel - 3
	selectLevel = math.max(selectLevel, 1)

	local csListView = self._scrollView:getCsListScroll()
	local scrollPixel = (self._cellWidth + self._cellSpaceH) * (selectLevel - 1)
	local totalWidth = #BpConfig.instance:getBonusCOList(BpModel.instance.id) * (self._cellWidth + self._cellSpaceH)

	recthelper.setWidth(self._lineTr, totalWidth)
	self._lineTr:SetAsLastSibling()

	csListView.HorizontalScrollPixel = scrollPixel

	csListView:UpdateCells(false)
	self:initKeyBonusKey(scrollPixel)
end

function BpBonusView:_onScrollRectValueChanged(scrollX, scrollY)
	local csListView = self._scrollView:getCsListScroll()
	local scrollPixel = csListView.HorizontalScrollPixel

	self:initKeyBonusKey(scrollPixel)

	local cellIndex = csListView.FirstVisualCellIndex

	if not self.nowFirstCellIndex then
		self.nowFirstCellIndex = cellIndex
	elseif cellIndex ~= self.nowFirstCellIndex then
		self.nowFirstCellIndex = cellIndex

		if not self._scrollTime then
			self._scrollTime = 0
			self._scrollX = scrollX

			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_slide)
			TaskDispatcher.runRepeat(self.checkScrollEnd, self, 0)
		end
	end

	if self._scrollTime and math.abs(self._scrollX - scrollX) > 0.05 then
		self._scrollTime = 0
		self._scrollX = scrollX
	end
end

function BpBonusView:checkScrollEnd()
	self._scrollTime = self._scrollTime + UnityEngine.Time.deltaTime

	if self._scrollTime > 0.05 then
		self._scrollTime = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_permit_slide)
		TaskDispatcher.cancelTask(self.checkScrollEnd, self)
	end
end

function BpBonusView:initKeyBonusKey(scrollPixel)
	if not self._keyBonusLvs then
		self._keyBonusLvs = {}

		local bonusCOList = BpConfig.instance:getBonusCOList(BpModel.instance.id)

		for _, co in ipairs(bonusCOList) do
			if co.keyBonus == 1 then
				table.insert(self._keyBonusLvs, co.level)
			end
		end
	end

	local showKeyLv = self._keyBonusLvs[#self._keyBonusLvs]

	for _, level in ipairs(self._keyBonusLvs) do
		local keyBonusPixel = (self._cellWidth + self._cellSpaceH) * level - self._cellSpaceH

		if scrollPixel < keyBonusPixel - self._scrollWidth then
			showKeyLv = level

			break
		end
	end

	local keyMO = BpBonusModel.instance:getById(showKeyLv)

	if not keyMO then
		return
	end

	self._keyBonusItem:onUpdateMO(keyMO)
end

function BpBonusView:_updateBtn()
	local canGetAllBonus = self:_canGetAnyBonus()

	BpController.instance:dispatchEvent(BpEvent.SetGetAllEnable, canGetAllBonus)
	gohelper.setActive(self._gomask, BpModel.instance.payStatus == BpEnum.PayStatus.NotPay)
end

function BpBonusView:_canGetAnyBonus()
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local level = math.floor(BpModel.instance.score / levelScore)
	local num = 0

	for _, mo in ipairs(BpBonusModel.instance:getList()) do
		if level >= mo.level then
			local levelCO = BpConfig.instance:getBonusCO(BpModel.instance.id, mo.level)
			local freeBonusSp = string.split(levelCO.freeBonus, "|")
			local payBonusSp = string.split(levelCO.payBonus, "|")

			if not mo.hasGetfreeBonus then
				num = num + #freeBonusSp
			end

			if BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and not mo.hasGetPayBonus then
				num = num + #payBonusSp
			end

			if num >= 1 then
				return true
			end
		end
	end

	return num >= 1
end

return BpBonusView
