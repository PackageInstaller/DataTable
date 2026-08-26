-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchMainView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchMainView", package.seeall)

local RoleStoryDispatchMainView = class("RoleStoryDispatchMainView", BaseView)

function RoleStoryDispatchMainView:onInitView()
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "Right/Title/#txt_Title")
	self.txtTitleen = gohelper.findChildTextMesh(self.viewGO, "Right/Title/#txt_Titleen")
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "Right/#txt_LimitTime")
	self.btnProgress = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_progress")
	self.slider = gohelper.findChildImage(self.viewGO, "Right/#go_progress/Background")
	self.txtProgress = gohelper.findChildTextMesh(self.viewGO, "Right/#go_progress/#txt_schedule")
	self.imgaePower = gohelper.findChildImage(self.viewGO, "Right/#go_progress/#icon1")
	self.simageCost = gohelper.findChildSingleImage(self.viewGO, "Right/#go_progress/#icon2")
	self.goTips = gohelper.findChild(self.viewGO, "Right/#go_progress/#go_ruletipdetail")
	self.btnTips = gohelper.findChildButtonWithAudio(self.goTips, "#btn_closeruletip")
	self.txtTips = gohelper.findChildTextMesh(self.goTips, "#go_rule2/rule2")
	self.vxGO1 = gohelper.findChild(self.viewGO, "#go_topright/vx_collect")
	self.vxGO2 = gohelper.findChild(self.viewGO, "Right/#go_progress/vx_collect")
	self.btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self.goEnterRed = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#image_reddot")

	RedDotController.instance:addRedDot(self.goEnterRed, RedDotEnum.DotNode.RoleStoryDispatch)

	self.btnScore = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_scorereward")
	self.txtScore = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_scorereward/score/#txt_score")
	self.scoreAnim = gohelper.findChildComponent(self.viewGO, "Right/#btn_scorereward/ani", typeof(UnityEngine.Animator))
	self.goScoreRed = gohelper.findChild(self.viewGO, "Right/#btn_scorereward/#go_rewardredpoint")
	self.btnRead = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_read")
	self.itemPos = gohelper.findChild(self.viewGO, "Middle/#go_rolestoryitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryDispatchMainView:addEvents()
	self.addClickCb(self, self.btnProgress, self.onClickBtnProgress, self)
	self.addClickCb(self, self.btnTips, self.onClickBtnTips, self)
	self.addClickCb(self, self.btnEnter, self.onClickBtnEnter, self)
	self.addClickCb(self, self.btnScore, self.onClickBtnScore, self)
	self.addClickCb(self, self.btnRead, self.onClickBtnRead, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ActStoryChange, self._onStoryChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, self._onScoreUpdate, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, self._onScoreUpdate, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.UpdateInfo, self._onUpdateInfo, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ExchangeTick, self._onExchangeTick, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.PowerChange, self._onPowerChange, self)
end

function RoleStoryDispatchMainView:removeEvents()
	return
end

function RoleStoryDispatchMainView:_editableInitView()
	return
end

function RoleStoryDispatchMainView:onClickBtnProgress()
	gohelper.setActive(self.goTips, true)

	local tag = {
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost),
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryDayChangeNum)
	}

	self.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rolestoryactivitytips"), tag)
end

function RoleStoryDispatchMainView:onClickBtnTips()
	gohelper.setActive(self.goTips, false)
end

function RoleStoryDispatchMainView:onClickBtnEnter()
	local storyId = RoleStoryModel.instance:getCurActStoryId()

	RoleStoryController.instance:openDispatchView(storyId)
end

function RoleStoryDispatchMainView:onClickBtnScore()
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function RoleStoryDispatchMainView:onClickBtnRead()
	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local storyMo = RoleStoryModel.instance:getById(storyId)

	if not storyMo then
		return
	end

	if storyMo.hasUnlock then
		RoleStoryController.instance:enterRoleStoryChapter(storyId)
	end
end

function RoleStoryDispatchMainView:_onStoryChange()
	HeroStoryRpc.instance:sendGetHeroStoryRequest()
end

function RoleStoryDispatchMainView:_onScoreUpdate()
	self:refreshScore()
end

function RoleStoryDispatchMainView:_onUpdateInfo()
	self:refreshScore()
	self:refreshView()
end

function RoleStoryDispatchMainView:onOpen()
	self:refreshProgress()
	self:refreshScore()
	self:refreshView()

	if self.viewParam and self.viewParam.clickItem and self.roleItem then
		self.roleItem:onClickItem()
	end
end

function RoleStoryDispatchMainView:onUpdateParam()
	self:refreshProgress()
	self:refreshScore()
	self:refreshView()
end

function RoleStoryDispatchMainView:checkEnterActivity()
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

function RoleStoryDispatchMainView:refreshScore()
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

function RoleStoryDispatchMainView:refreshView()
	self:refreshRoleItem()
	self:refreshLeftTime()
	self:refreshTitle()
	TaskDispatcher.cancelTask(self.refreshLeftTime, self)
	TaskDispatcher.runRepeat(self.refreshLeftTime, self, 1)
	self:checkEnterActivity()
end

function RoleStoryDispatchMainView:refreshTitle()
	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local storyMo = RoleStoryModel.instance:getById(storyId)

	if not storyMo then
		return
	end

	local name = storyMo.cfg.name
	local strLen = GameUtil.utf8len(name)
	local first = GameUtil.utf8sub(name, 1, 1)
	local second = ""

	if strLen > 1 then
		second = GameUtil.utf8sub(name, 2, 2)
	end

	self.txtTitle.text = string.format("<size=100>%s</size><size=70>%s</size>%s", first, second, (strLen > 3 or nil) and GameUtil.utf8sub(name, 4, strLen - 3))
	self.txtTitleen.text = storyMo.cfg.nameEn
end

function RoleStoryDispatchMainView:refreshRoleItem()
	if not self.roleItem then
		local go = self:getResInst(self.viewContainer:getSetting().otherRes.itemRes, self.itemPos)

		self.roleItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoleStoryItem)

		self.roleItem:initInternal(go, self)
	end

	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local storyMo = RoleStoryModel.instance:getById(storyId)

	self.roleItem:onUpdateMO(storyMo)
	gohelper.setActive(self.btnRead, storyMo and storyMo.hasUnlock)
end

function RoleStoryDispatchMainView:refreshProgress()
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

function RoleStoryDispatchMainView:_onExchangeTick()
	self:refreshProgress()
end

function RoleStoryDispatchMainView:_onPowerChange()
	self:refreshProgress()
end

function RoleStoryDispatchMainView:setFinalValue()
	UIBlockMgr.instance:endBlock(self.viewName)

	local cur = RoleStoryModel.instance:getLeftNum()

	self:setSliderValue(cur)
	self:checkChangeTick()
end

function RoleStoryDispatchMainView:setSliderValue(val)
	local max = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)

	self.slider.fillAmount = val / max

	local isChangeMax = not RoleStoryModel.instance:checkTodayCanExchange()

	self.txtProgress.text = isChangeMax and luaLang("reachUpperLimit") or string.format("%s/%s", math.floor(val), max)
end

function RoleStoryDispatchMainView:checkChangeTick()
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

function RoleStoryDispatchMainView:sendExchangeTicket()
	UIBlockMgr.instance:endBlock(self.viewName)
	TaskDispatcher.cancelTask(self.sendExchangeTicket, self)
	HeroStoryRpc.instance:sendExchangeTicketRequest()
end

function RoleStoryDispatchMainView:refreshLeftTime()
	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local mo = RoleStoryModel.instance:getById(storyId)

	if not mo then
		return
	end

	local startTime, endTime = mo:getActTime()
	local leftTime = endTime - ServerTime.now()

	if leftTime > 0 then
		local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(leftTime)
		local timeFormat

		if day > 0 then
			timeFormat = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
				string.format("<color=#f09a5a>%s</color>", day),
				string.format("<color=#f09a5a>%s</color>", hour)
			})
		elseif hour > 0 then
			timeFormat = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
				string.format("<color=#f09a5a>%s</color>", hour),
				string.format("<color=#f09a5a>%s</color>", min)
			})
		elseif min > 0 then
			timeFormat = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
				string.format("<color=#f09a5a>%s</color>", 0),
				string.format("<color=#f09a5a>%s</color>", min)
			})
		elseif sec > 0 then
			timeFormat = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
				string.format("<color=#f09a5a>%s</color>", 0),
				string.format("<color=#f09a5a>%s</color>", 1)
			})
		end

		self.txtTime.text = formatLuaLang("summonmainequipprobup_deadline", timeFormat)
	else
		TaskDispatcher.cancelTask(self.refreshLeftTime, self)
	end
end

function RoleStoryDispatchMainView:onClose()
	return
end

function RoleStoryDispatchMainView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshLeftTime, self)
end

return RoleStoryDispatchMainView
