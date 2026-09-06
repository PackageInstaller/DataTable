-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firework/view/FireworkView.lua

module("logic.extensions.firework.view.FireworkView", package.seeall)

local FireworkView = class("FireworkView", ViewComponent)

function FireworkView:ctor()
	FireworkView.super.ctor(self)
end

function FireworkView:unbindEvents()
	FireworkView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._rankButton:RemoveClickListener()
	self._goButton:RemoveClickListener()
	self._bubbleBtn:RemoveClickListener()
end

function FireworkView:bindEvents()
	FireworkView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "fireworkrule")
	end, self)
	self._rankButton:AddClickListener(function()
		UIStateManager.instance:push(ViewName.FireworkprogressView)
	end, self)
	self._goButton:AddClickListener(function()
		UIStateManager.instance:push(ViewName.FireworklistView)
	end, self)
	self._bubbleBtn:AddClickListener(self._showBubble, self)
end

function FireworkView:buildUI()
	FireworkView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._rankButton = self:getBtn("btnRank")
	self._redPoint = self:getGo("btnRank/redPoint")
	self._goButton = self:getBtn("btnGo")
	self._openDate = self:getTxt("time/txt")
	self._curLevelTxt = self:getTxt("info/total/txt")
	self._timeTipTxt = self:getTxt("info/txtTip")
	self._useTxt = self:getTxt("btnGo/useTimes/txt")
	self._levelSlider = self:getSlider("info/scrollerview/viewport/content/progressSlider")
	self._rewardObj = self:getGo("info/scrollerview/viewport/content/reward")
	self._rewardItem = self:getGo("info/scrollerview/viewport/content/reward/item")
	self._listContent = self:getGo("info/scrollerview/viewport/content")
	self._con = self:getGo("con")
	self._bubble = self:getGo("bubble")
	self._bubbleBtn = self:getBtn("bubbleBtn")
	self._scrollRectTransform = self:getGo("info/scrollerview"):GetComponent(goutil.Type_RectTransform)
	self.rewardTab = {}
end

function FireworkView:onExit()
	FireworkView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_FIREWORK_GETINFO, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_FIREWORK_GETPRIZE, self.onRefreshUI, self)

	for _, v in pairs(self._cellList) do
		for _, w in ipairs(v) do
			MaterialMgr.clearIcon(w)
		end
	end

	for i = 1, #self.rewardTab do
		local go = goutil.findChild(self.rewardTab[i], "con")

		MaterialMgr.resetAll(go)
	end

	RoleObjectPool.instance:removeRole(self._roleModel)
	removetimer(self._hideBubble, self)

	for k, v in pairs(self._effectList) do
		UIEffectManager.instance:stopEffect(v)
	end

	table.clear(self._effectList)
end

function FireworkView:onEnter()
	FireworkView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_FIREWORK_GETINFO, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_FIREWORK_GETPRIZE, self.onRefreshUI, self)
	self:_hideBubble()

	self._effectList = {}

	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.FireWork) or 145004

	FireworkModel.instance:setActivityId(activityId)
	FireworkController.instance:getInfo()

	self._cellList = {}
	self.curActId = FireworkModel.instance.curActId
	self.planCfgs = FireworkConfig.instance:getPlanCfg(self.curActId)

	local planIdx, timeOver = FireworkModel.instance:getCurPrizePlan(self.planCfgs.normalPrizePlanId, self.planCfgs.restTime)

	self.curPrizePlan = planIdx
	self.timeOver = nil

	if timeOver and #timeOver > 0 then
		self.timeOver = GameUtil.formatTimeString("%m.%d %H:%M", timeOver)
	end

	self.prizeCfgs = FireworkConfig.instance:getPrizeCfgs(self.curActId, self.curPrizePlan)
	self.totalCount = #self.prizeCfgs
	self.maxNum = self.prizeCfgs[self.totalCount].num
	self._openDate.text = self.planCfgs.timeShow

	local siderLength = 180 * self.totalCount

	GameUtil.setWidth(self._levelSlider.gameObject, siderLength)
	GameUtil.setWidth(self._listContent, siderLength + 50)

	if #self.rewardTab == 0 then
		for i = 1, self.totalCount do
			if i == 1 then
				if not self._rewardItem then
					local obj = UGUIToolHelper.AddChild(self._rewardObj, self._rewardItem)
					local x = self.prizeCfgs[i].num / self.maxNum * siderLength

					GameUtil.setLocalPos(obj, x, 0, 0)
					table.insert(self.rewardTab, obj)
				end
			end
		end
	end

	for i = 1, self.totalCount do
		local id = self.prizeCfgs[i].id
		local prize = self.prizeCfgs[i].prize
		local num = self.prizeCfgs[i].num
		local obj = self.rewardTab[i]
		local go = goutil.findChild(obj, "con")
		local get = goutil.findChild(obj, "get")

		goutil.findChildTextComponent(obj, "txtNum").text = string.format("%d", num)

		MaterialMgr.resetAll(go)
		MaterialMgr.setCellByCfg(prize, go)
		GameUtil.addClickHandler(get, function()
			FireworkController.instance:gainNormalPrize(id)
		end)
	end

	local storyId = self.planCfgs.firstStoryId

	if checknumber(storyId) > 0 then
		local key = string.format("FireworkView%s", activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end

	self:_showSpriteRawInfo()
end

function FireworkView:onRefreshUI()
	self.curTimes = FireworkModel.instance.normalProgress
	self.useTime = FireworkModel.instance.useTime

	local sValue = self.curTimes / self.maxNum

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("%d", self.curTimes, self.maxNum)
	self._useTxt.text = string.format("今日已点燃烟花（%d/%d）次", self.useTime, self.planCfgs.dailyTimes)
	self._timeTipTxt.text = self.timeOver and string.format("将于%s重置", self.timeOver) or ""

	self._redPoint:SetActive(FireworkModel.instance:isHaveWorldPrize())

	for i = 1, #self.rewardTab do
		local id = self.prizeCfgs[i].id
		local num = self.prizeCfgs[i].num
		local isGet = FireworkModel.instance.gainednormalprizeids[id] == true
		local canGet = num <= self.curTimes and not isGet
		local effectTran = goutil.findChild(self.rewardTab[i], "get").transform

		goutil.findChild(self.rewardTab[i], "receive"):SetActive(isGet)
		goutil.findChild(self.rewardTab[i], "get"):SetActive(canGet)

		if canGet then
			if self._effectList[i] == nil then
				local _effect = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", nil, 0, 0, true, nil, nil, function(target, uiEffect)
					uiEffect:setClipping(self._scrollRectTransform)
				end)

				_effect:setParent(effectTran)
				_effect:setScale(0.7)
				_effect:setLocalPos(0, 0, 0)

				self._effectList[i] = _effect
			end
		else
			UIEffectManager.instance:stopEffect(self._effectList[i])
		end
	end
end

function FireworkView:_showSpriteRawInfo()
	local x, y, scale = 0, 0, 0.5

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, 16008, self._con, scale, function(obj)
		goutil.findChild(obj, "16008_miruike_lihui_b-ui_p"):SetActive(false)
	end, true, x, y)
end

function FireworkView:_showBubble()
	self:getTxt("bubble/txtDesc").text = FireworkConfig.randomTips[math.random(1, 3)]

	self._bubble:SetActive(true)
	removetimer(self._hideBubble, self)
	settimer(3, self._hideBubble, self, false)
end

function FireworkView:_hideBubble()
	self._bubble:SetActive(false)
end

return FireworkView
