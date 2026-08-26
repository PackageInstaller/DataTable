-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_MainBaseView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_MainBaseView", package.seeall)

local V3a9_BossRush_MainBaseView = class("V3a9_BossRush_MainBaseView", BaseView)

function V3a9_BossRush_MainBaseView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Store/#btn_Store")
	self._simageProp = gohelper.findChildImage(self.viewGO, "Store/#btn_Store/#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "Store/#btn_Store/#txt_Num")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "TopRight/#btn_Achievement")
	self._txtAchievement = gohelper.findChildText(self.viewGO, "TopRight/#txt_Achievement")
	self._gotopRight = gohelper.findChild(self.viewGO, "TopRight")
	self._goStoreTip = gohelper.findChild(self.viewGO, "Store/image_Tips")
	self._txtStore = gohelper.findChildText(self.viewGO, "Store/#btn_Store/txt_Store")
	self._txtActDesc = gohelper.findChildText(self.viewGO, "txtDescr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_MainBaseView:addEvents()
	self._btnStore:AddClickListener(self._btnStoreOnClick, self)
	self._btnAchievement:AddClickListener(self._btnAchievementOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
end

function V3a9_BossRush_MainBaseView:removeEvents()
	self._btnStore:RemoveClickListener()
	self._btnAchievement:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
end

function V3a9_BossRush_MainBaseView:_btnStoreOnClick()
	BossRushController.instance:openBossRushStoreView(self.actId)
end

function V3a9_BossRush_MainBaseView:_btnAchievementOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.actId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function V3a9_BossRush_MainBaseView:_editableInitView()
	self._txtLimitTime.text = ""

	local nameCn, nameEn = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)

	self._txtStore.text = nameCn
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	if self._animName then
		self:playAnimator(self._animName)
	end
end

function V3a9_BossRush_MainBaseView:playAnimator(animName, cb, cbobj)
	self._animName = animName

	if not self._animatorPlayer then
		return
	end

	self._animatorPlayer:Play(animName, cb, cbobj)

	self._animName = nil
end

function V3a9_BossRush_MainBaseView:_getActivityId()
	return BossRushConfig.instance:getActivityId()
end

function V3a9_BossRush_MainBaseView:onOpen()
	self.actId = self:_getActivityId()

	self:_refresh()
	self:_onRefreshDeadline()
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_refreshCurrency()
	self:_refreshStoreTag()

	local activityCfg = ActivityConfig.instance:getActivityCo(self.actId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	gohelper.setActive(self._gotopRight, achievementJumpId and achievementJumpId ~= 0)
end

function V3a9_BossRush_MainBaseView:_refreshStoreTag()
	local isNew = V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore()

	gohelper.setActive(self._goStoreTip, isNew)
end

function V3a9_BossRush_MainBaseView:playRankBtnAnim()
	if self._rankBtn then
		self._rankBtn:playAnim()
	end
end

function V3a9_BossRush_MainBaseView:onOpenFinish()
	BossRushRedModel.instance:setIsOpenActivity(false)
end

function V3a9_BossRush_MainBaseView:onClose()
	GameUtil.onDestroyViewMemberList(self, "_itemList")
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

function V3a9_BossRush_MainBaseView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	self._simagebg:UnLoadImage()
end

function V3a9_BossRush_MainBaseView:_onRefreshDeadline()
	if not self._txtLimitTime then
		return
	end

	self._txtLimitTime.text = BossRushModel.instance:getRemainTimeStr()
end

function V3a9_BossRush_MainBaseView:_refresh()
	self:_refreshLeft()
	self:_refreshRight()
end

function V3a9_BossRush_MainBaseView:_refreshLeft()
	self:_refreshLeftTop()
	self:_refreshLeftBottom()
end

function V3a9_BossRush_MainBaseView:_refreshCurrency()
	local count = V1a6_BossRush_StoreModel.instance:getCurrencyCount(self.actId)

	if count then
		self._txtNum.text = count
	end
end

function V3a9_BossRush_MainBaseView:_initItemList(dataList)
	if self._itemList then
		return
	end

	self._itemList = {}

	if not dataList then
		return
	end

	for i, mo in ipairs(dataList) do
		local go = gohelper.findChild(self.viewGO, "BOSS" .. i)
		local item = self:_getItem(go)

		item._index = i

		item:setData(mo, i)
		table.insert(self._itemList, item)
	end
end

function V3a9_BossRush_MainBaseView:_getItem(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a2_BossRush_MainItem, self.viewContainer)
end

function V3a9_BossRush_MainBaseView:_refreshRight()
	local dataList = V3a2_BossRushModel.instance:getSortStages(self.actId)

	self:_initItemList(dataList)
end

function V3a9_BossRush_MainBaseView:_refreshLeftTop()
	self:_onRefreshDeadline()
end

function V3a9_BossRush_MainBaseView:_onRewardItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
	cell_component:isShowEquipAndItemCount(false)
end

function V3a9_BossRush_MainBaseView:_refreshLeftBottom()
	return
end

return V3a9_BossRush_MainBaseView
