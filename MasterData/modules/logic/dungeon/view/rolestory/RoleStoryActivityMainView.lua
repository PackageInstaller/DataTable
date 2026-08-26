-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryActivityMainView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryActivityMainView", package.seeall)

local RoleStoryActivityMainView = class("RoleStoryActivityMainView", BaseView)

function RoleStoryActivityMainView:onInitView()
	self._actViewGO = gohelper.findChild(self.viewGO, "actview")
	self._challengeViewGO = gohelper.findChild(self.viewGO, "challengeview")
	self._showActView = true
	self.btnScore = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_scorereward")
	self.txtScore = gohelper.findChildTextMesh(self.viewGO, "#btn_scorereward/score/#txt_score")
	self.scoreAnim = gohelper.findChildComponent(self.viewGO, "#btn_scorereward/ani", typeof(UnityEngine.Animator))
	self.goScoreRed = gohelper.findChild(self.viewGO, "#btn_scorereward/#go_rewardredpoint")
	self.btnProgress = gohelper.findChildButtonWithAudio(self.viewGO, "#go_progress")
	self.slider = gohelper.findChildImage(self.viewGO, "#go_progress/Background")
	self.txtProgress = gohelper.findChildTextMesh(self.viewGO, "#go_progress/#txt_schedule")
	self.imgaePower = gohelper.findChildImage(self.viewGO, "#go_progress/#icon1")
	self.simageCost = gohelper.findChildSingleImage(self.viewGO, "#go_progress/#icon2")
	self.goTips = gohelper.findChild(self.viewGO, "#go_progress/#go_ruletipdetail")
	self.btnTips = gohelper.findChildButtonWithAudio(self.goTips, "#btn_closeruletip")
	self.txtTips = gohelper.findChildTextMesh(self.goTips, "#go_rule2/rule2")
	self.vxGO1 = gohelper.findChild(self.viewGO, "#go_topright/vx_collect")
	self.vxGO2 = gohelper.findChild(self.viewGO, "#go_progress/vx_collect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryActivityMainView:addEvents()
	self.btnScore:AddClickListener(self._btnscoreOnClick, self)
	self.btnProgress:AddClickListener(self._btnprogressOnClick, self)
	self.btnTips:AddClickListener(self._btntipsOnClick, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ActStoryChange, self._onStoryChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, self._onChangeMainViewShow, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, self._onScoreUpdate, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, self._onScoreUpdate, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.UpdateInfo, self._onUpdateInfo, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ExchangeTick, self._onExchangeTick, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.PowerChange, self._onPowerChange, self)
end

function RoleStoryActivityMainView:removeEvents()
	self.btnScore:RemoveClickListener()
	self.btnProgress:RemoveClickListener()
	self.btnTips:RemoveClickListener()
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.ActStoryChange, self._onStoryChange, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, self._onChangeMainViewShow, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, self._onScoreUpdate, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, self._onScoreUpdate, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.UpdateInfo, self._onUpdateInfo, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.ExchangeTick, self._onExchangeTick, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.PowerChange, self._onPowerChange, self)
end

function RoleStoryActivityMainView:_editableInitView()
	return
end

function RoleStoryActivityMainView:_btnscoreOnClick()
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function RoleStoryActivityMainView:_onStoryChange()
	HeroStoryRpc.instance:sendGetHeroStoryRequest()
end

function RoleStoryActivityMainView:onUpdateParam()
	self:refreshView()
end

function RoleStoryActivityMainView:onOpen()
	if self.viewParam and self.viewParam[1] == 1 then
		self._showActView = false
	end

	self:refreshCurrency()
	self:refreshProgress()
	self:refreshScore()
	self:refreshView()
	gohelper.setActive(self._actViewGO, self._showActView)
	gohelper.setActive(self._challengeViewGO, not self._showActView)
end

function RoleStoryActivityMainView:onClose()
	return
end

function RoleStoryActivityMainView:_onChangeMainViewShow(showAct)
	if self._showActView == showAct then
		return
	end

	self:_btntipsOnClick()

	self._showActView = showAct

	self:refreshScore()
	self:refreshCurrency()
	self:refreshProgress(true)
	self:refreshView()
	gohelper.setActive(self._actViewGO, true)
	gohelper.setActive(self._challengeViewGO, true)
	UIBlockMgr.instance:startBlock("RoleStoryActivityMainViewSwitch")

	if showAct then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)
		self.viewContainer:playAnim("to_act", self.onAnimFinish, self)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesclose)
		self.viewContainer:playAnim("to_challege", self.onAnimFinish, self)
	end
end

function RoleStoryActivityMainView:onAnimFinish()
	gohelper.setActive(self._actViewGO, self._showActView)
	gohelper.setActive(self._challengeViewGO, not self._showActView)
	UIBlockMgr.instance:endBlock("RoleStoryActivityMainViewSwitch")
end

function RoleStoryActivityMainView:_onScoreUpdate()
	self:refreshScore()
end

function RoleStoryActivityMainView:_onUpdateInfo()
	self:refreshScore()
	self:refreshView()
end

function RoleStoryActivityMainView:refreshCurrency()
	if self._showActView then
		local currencyParam = {
			{
				isIcon = true,
				type = MaterialEnum.MaterialType.Item,
				id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
			},
			CurrencyEnum.CurrencyType.RoleStory
		}

		self.viewContainer:refreshCurrency(currencyParam)
	else
		local currencyParam = {
			{
				isIcon = true,
				type = MaterialEnum.MaterialType.Item,
				id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
			}
		}

		self.viewContainer:refreshCurrency(currencyParam)
	end
end

function RoleStoryActivityMainView:onSetVisible()
	if self.waitRefresh then
		self:refreshView()
	end
end

function RoleStoryActivityMainView:refreshView()
	if not self.viewContainer:getVisible() then
		self.waitRefresh = true

		return
	end

	self.waitRefresh = false

	if self._showActView then
		self.viewContainer.actView:refreshView()
	else
		self.viewContainer.challengeView:refreshView()
	end

	self:checkEnterActivity()
end

function RoleStoryActivityMainView:checkEnterActivity()
	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local storyConfig = RoleStoryConfig.instance:getStoryById(storyId)

	if storyConfig and storyConfig.activityId > 0 then
		ActivityEnterMgr.instance:enterActivity(storyConfig.activityId)
		ActivityRpc.instance:sendActivityNewStageReadRequest({
			storyConfig.activityId
		})
		ActivityStageHelper.recordOneActivityStage(storyConfig.activityId)
	end
end

function RoleStoryActivityMainView:refreshScore()
	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local storyMo = RoleStoryModel.instance:getById(storyId)

	if not storyMo then
		return
	end

	self.txtScore.text = storyMo:getScore()

	local red = storyMo:hasScoreReward()

	gohelper.setActive(self.goScoreRed, red)

	if red then
		self.scoreAnim:Play("loop")
	else
		self.scoreAnim:Play("idle")
	end
end

function RoleStoryActivityMainView:_btnprogressOnClick()
	gohelper.setActive(self.goTips, true)

	local tag = {
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost),
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryDayChangeNum)
	}

	self.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rolestoryactivitytips"), tag)
end

function RoleStoryActivityMainView:_btntipsOnClick()
	gohelper.setActive(self.goTips, false)
end

function RoleStoryActivityMainView:_onExchangeTick()
	self:refreshProgress()
end

function RoleStoryActivityMainView:_onPowerChange()
	self:refreshProgress()
end

function RoleStoryActivityMainView:refreshProgress()
	gohelper.setActive(self.vxGO1, false)
	gohelper.setActive(self.vxGO2, false)

	local powerCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Power)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self.imgaePower, powerCo.icon .. "_1")

	local itemId = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
	local itemIcon = ItemModel.instance:getItemSmallIcon(itemId)

	self.simageCost:LoadImage(itemIcon)

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	local cur, last = RoleStoryModel.instance:getLeftNum()

	if last ~= cur then
		UIBlockMgr.instance:startBlock(self.viewName)
		RoleStoryModel.instance:setLastLeftNum(cur)

		local max = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)

		if max <= last and max <= cur then
			self:setFinalValue()
		else
			cur = math.min(cur, max)

			local time = math.abs(cur - last) * 0.01

			self.tweenId = ZProj.TweenHelper.DOTweenFloat(last, cur, time, self.setSliderValue, self.setFinalValue, self, nil, EaseType.Linear)
		end
	else
		self:setFinalValue()
	end
end

function RoleStoryActivityMainView:setFinalValue()
	UIBlockMgr.instance:endBlock(self.viewName)

	local cur = RoleStoryModel.instance:getLeftNum()

	self:setSliderValue(cur)
	self:checkChangeTick()
end

function RoleStoryActivityMainView:setSliderValue(val)
	local max = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)

	self.slider.fillAmount = val / max

	local isChangeMax = not RoleStoryModel.instance:checkTodayCanExchange()

	self.txtProgress.text = isChangeMax and luaLang("reachUpperLimit") or string.format("%s/%s", math.floor(val), max)
end

function RoleStoryActivityMainView:checkChangeTick()
	local cost = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)
	local cur = RoleStoryModel.instance:getLeftNum()

	if cost <= cur and RoleStoryModel.instance:checkTodayCanExchange() then
		UIBlockMgr.instance:startBlock(self.viewName)
		gohelper.setActive(self.vxGO1, true)
		gohelper.setActive(self.vxGO2, true)
		TaskDispatcher.cancelTask(self.sendExchangeTicket, self)
		TaskDispatcher.runDelay(self.sendExchangeTicket, self, 1.5)
	end
end

function RoleStoryActivityMainView:sendExchangeTicket()
	UIBlockMgr.instance:endBlock(self.viewName)
	TaskDispatcher.cancelTask(self.sendExchangeTicket, self)
	HeroStoryRpc.instance:sendExchangeTicketRequest()
end

function RoleStoryActivityMainView:onDestroyView()
	UIBlockMgr.instance:endBlock(self.viewName)
	TaskDispatcher.cancelTask(self.sendExchangeTicket, self)
	self.simageCost:UnLoadImage()
end

return RoleStoryActivityMainView
