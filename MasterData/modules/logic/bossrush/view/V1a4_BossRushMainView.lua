-- chunkname: @modules/logic/bossrush/view/V1a4_BossRushMainView.lua

module("modules.logic.bossrush.view.V1a4_BossRushMainView", package.seeall)

local V1a4_BossRushMainView = class("V1a4_BossRushMainView", BaseView)

function V1a4_BossRushMainView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "LimitTime/#txt_LimitTime")
	self._scrollRewards = gohelper.findChildScrollRect(self.viewGO, "Rewards/#scroll_Rewards")
	self._goRewards = gohelper.findChild(self.viewGO, "Rewards/#scroll_Rewards/Viewport/#go_Rewards")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Store/#btn_Store")
	self._simageProp = gohelper.findChildImage(self.viewGO, "Store/#btn_Store/#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "Store/#btn_Store/#txt_Num")
	self._scrollChapterList = gohelper.findChildScrollRect(self.viewGO, "#scroll_ChapterList")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_ChapterList/Viewport/#go_Content")
	self._btnAchievement = gohelper.findChildButtonWithAudio(self.viewGO, "TopRight/#btn_Achievement")
	self._txtAchievement = gohelper.findChildText(self.viewGO, "TopRight/#txt_Achievement")
	self._goStoreTip = gohelper.findChild(self.viewGO, "Store/image_Tips")
	self._txtStore = gohelper.findChildText(self.viewGO, "Store/#btn_Store/txt_Store")
	self._txtActDesc = gohelper.findChildText(self.viewGO, "txtDescr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRushMainView:addEvents()
	self._btnStore:AddClickListener(self._btnStoreOnClick, self)
	self._btnAchievement:AddClickListener(self._btnAchievementOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
end

function V1a4_BossRushMainView:removeEvents()
	self._btnStore:RemoveClickListener()
	self._btnAchievement:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
end

function V1a4_BossRushMainView:_btnStoreOnClick()
	BossRushController.instance:openBossRushStoreView(self.actId)
end

function V1a4_BossRushMainView:_btnAchievementOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.actId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function V1a4_BossRushMainView:_editableInitView()
	self._txtLimitTime.text = ""
	self._txtAchievement.text = luaLang("achievement_name")

	local nameCn, nameEn = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)

	self._txtStore.text = nameCn
end

function V1a4_BossRushMainView:onUpdateParam()
	return
end

function V1a4_BossRushMainView:onOpen()
	self.actId = BossRushConfig.instance:getActivityId()

	if self.viewParam and self.viewParam.isOpenLevelDetail then
		local stage = self.viewParam.stage
		local layer = self.viewParam.layer
		local viewParam = {
			stage = stage,
			layer = layer
		}

		BossRushController.instance:openLevelDetailView(viewParam)
	end

	self:_refresh()
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_refreshCurrency()
	self:_refreshStoreTag()
end

function V1a4_BossRushMainView:_refreshStoreTag()
	local isNew = V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore()

	gohelper.setActive(self._goStoreTip, isNew)
end

function V1a4_BossRushMainView:onOpenFinish()
	BossRushRedModel.instance:setIsOpenActivity(false)
end

function V1a4_BossRushMainView:onClose()
	GameUtil.onDestroyViewMemberList(self, "_itemList")
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

function V1a4_BossRushMainView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	self._simagebg:UnLoadImage()
end

function V1a4_BossRushMainView:_onRefreshDeadline()
	self._txtLimitTime.text = BossRushModel.instance:getRemainTimeStr()
end

function V1a4_BossRushMainView:_refresh()
	self:_refreshLeft()
	self:_refreshRight()
end

function V1a4_BossRushMainView:_refreshLeft()
	self:_refreshLeftTop()
	self:_refreshLeftBottom()
end

function V1a4_BossRushMainView:_refreshCurrency()
	local count = V1a6_BossRush_StoreModel.instance:getCurrencyCount(self.actId)

	if count then
		self._txtNum.text = count
	end
end

function V1a4_BossRushMainView:_create_V1a4_BossRushMainItem()
	local itemClass = V1a4_BossRushMainItem
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrushmainitem, self._goContent, itemClass.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
end

function V1a4_BossRushMainView:_initItemList(dataList)
	if self._itemList then
		return
	end

	self._itemList = {}

	for i, mo in ipairs(dataList) do
		local item = self:_create_V1a4_BossRushMainItem()

		item._index = i

		item:setData(mo, true)
		table.insert(self._itemList, item)
	end
end

function V1a4_BossRushMainView:_refreshRight()
	local dataList = BossRushModel.instance:getStagesInfo()

	self:_initItemList(dataList)
end

function V1a4_BossRushMainView:_refreshLeftTop()
	self:_onRefreshDeadline()
end

function V1a4_BossRushMainView:_refreshLeftBottom()
	local str = BossRushConfig.instance:getActivityRewardStr()
	local item_list = ItemModel.instance:getItemDataListByConfigStr(str)

	IconMgr.instance:getCommonPropItemIconList(self, self._onRewardItemShow, item_list, self._goRewards)
end

function V1a4_BossRushMainView:_onRewardItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
	cell_component:isShowEquipAndItemCount(false)
end

return V1a4_BossRushMainView
