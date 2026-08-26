-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_MainView.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_MainView", package.seeall)

local V3a2_BossRush_MainView = class("V3a2_BossRush_MainView", BaseView)

function V3a2_BossRush_MainView:onInitView()
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
	self._gotopRight = gohelper.findChild(self.viewGO, "TopRight")
	self._goStoreTip = gohelper.findChild(self.viewGO, "Store/image_Tips")
	self._txtStore = gohelper.findChildText(self.viewGO, "Store/#btn_Store/txt_Store")
	self._txtActDesc = gohelper.findChildText(self.viewGO, "txtDescr")
	self._gorank = gohelper.findChild(self.viewGO, "#go_rankbtn")
	self._gohandbook = gohelper.findChild(self.viewGO, "#go_handbook")
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "#go_handbook/#btn_handbook")
	self._gohandbookreddot = gohelper.findChild(self.viewGO, "#go_handbook/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_MainView:addEvents()
	self._btnStore:AddClickListener(self._btnStoreOnClick, self)
	self._btnAchievement:AddClickListener(self._btnAchievementOnClick, self)
	self._btnhandbook:AddClickListener(self._btnhandbookOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
end

function V3a2_BossRush_MainView:removeEvents()
	self._btnStore:RemoveClickListener()
	self._btnAchievement:RemoveClickListener()
	self._btnhandbook:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
end

function V3a2_BossRush_MainView:_btnStoreOnClick()
	BossRushController.instance:openBossRushStoreView(self.actId)
end

function V3a2_BossRush_MainView:_btnAchievementOnClick()
	local activityCfg = ActivityConfig.instance:getActivityCo(self.actId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	JumpController.instance:jump(achievementJumpId)
end

function V3a2_BossRush_MainView:_editableInitView()
	self._txtLimitTime.text = ""
	self._txtAchievement.text = luaLang("achievement_name")

	local nameCn, nameEn = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)

	self._txtStore.text = nameCn

	self:_initRankBtn()
	RedDotController.instance:addRedDot(self._gohandbookreddot, RedDotEnum.DotNode.BossRushHankBookBossMainView)
end

function V3a2_BossRush_MainView:onOpen()
	self.actId = BossRushConfig.instance:getActivityId()

	if self.viewParam and self.viewParam.isOpenLevelDetail then
		local stage = self.viewParam.stage
		local layer = self.viewParam.layer
		local viewParam = {
			stage = stage,
			layer = layer
		}

		BossRushController.instance:openV3a2LevelDetailView(viewParam)
	end

	self:_refresh()
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	self:_refreshCurrency()
	self:_refreshStoreTag()

	local activityCfg = ActivityConfig.instance:getActivityCo(self.actId)
	local achievementJumpId = activityCfg and activityCfg.achievementJumpId

	gohelper.setActive(self._gotopRight, achievementJumpId and achievementJumpId ~= 0)
end

function V3a2_BossRush_MainView:_refreshStoreTag()
	local isNew = V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore()

	gohelper.setActive(self._goStoreTip, isNew)
end

function V3a2_BossRush_MainView:playRankBtnAnim()
	if self._rankBtn then
		self._rankBtn:playAnim()
	end
end

function V3a2_BossRush_MainView:onOpenFinish()
	BossRushRedModel.instance:setIsOpenActivity(false)
end

function V3a2_BossRush_MainView:onClose()
	GameUtil.onDestroyViewMemberList(self, "_itemList")
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

function V3a2_BossRush_MainView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	self._simagebg:UnLoadImage()
end

function V3a2_BossRush_MainView:_onRefreshDeadline()
	self._txtLimitTime.text = BossRushModel.instance:getRemainTimeStr()
end

function V3a2_BossRush_MainView:_refresh()
	self:_refreshLeft()
	self:_refreshRight()
end

function V3a2_BossRush_MainView:_refreshLeft()
	self:_refreshLeftTop()
	self:_refreshLeftBottom()
end

function V3a2_BossRush_MainView:_btnhandbookOnClick()
	BossRushController.instance:openV3a2HankBookView()
end

function V3a2_BossRush_MainView:_refreshCurrency()
	local count = V1a6_BossRush_StoreModel.instance:getCurrencyCount(self.actId)

	if count then
		self._txtNum.text = count
	end
end

function V3a2_BossRush_MainView:_initItemList(dataList)
	if self._itemList then
		return
	end

	self._itemList = {}

	if not dataList then
		return
	end

	for i, mo in ipairs(dataList) do
		local go = gohelper.findChild(self.viewGO, "BOSS" .. i)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a2_BossRush_MainItem, self.viewContainer)

		item._index = i

		item:setData(mo, i)

		item.viewContainer = self.viewContainer

		table.insert(self._itemList, item)
	end
end

function V3a2_BossRush_MainView:_refreshRight()
	local dataList = V3a2_BossRushModel.instance:getSortStages(self.actId)

	self:_initItemList(dataList)
end

function V3a2_BossRush_MainView:_refreshLeftTop()
	self:_onRefreshDeadline()
end

function V3a2_BossRush_MainView:_onRewardItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
	cell_component:isShowEquipAndItemCount(false)
end

function V3a2_BossRush_MainView:_initRankBtn()
	local itemClass = V3a2_BossRush_RankBtn
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v3a2_bossrush_rankbtn, self._gorank, itemClass.__cname)

	self._rankBtn = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._rankBtn:refreshUI()
end

function V3a2_BossRush_MainView:_refreshLeftBottom()
	return
end

return V3a2_BossRush_MainView
