-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgGameEnterView.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgGameEnterView", package.seeall)

local DivinexjClgGameEnterView = class("DivinexjClgGameEnterView", ViewComponent)

function DivinexjClgGameEnterView:ctor()
	DivinexjClgGameEnterView.super.ctor(self)
end

function DivinexjClgGameEnterView:buildUI()
	DivinexjClgGameEnterView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnBuff = self:getBtn("btnBuff")
	self._btnStart = self:getBtn("btnStart")
	self._txtNum = self:getTxt("txtNum")
	self._effectGo = self:getGo("effect")
end

function DivinexjClgGameEnterView:bindEvents()
	DivinexjClgGameEnterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
end

function DivinexjClgGameEnterView:unbindEvents()
	DivinexjClgGameEnterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnStart)
end

function DivinexjClgGameEnterView:onEnter()
	DivinexjClgGameEnterView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineXingJiangClgPlayGameRes, self._onPlayGameRes, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = DivineXingJiangClgConfig.instance:getActivityCfg(self._activityId)

	self:_updateNum()
	self:_isPopupRule()
	self:_activeEffect(false)
	self:_playEffect()
end

function DivinexjClgGameEnterView:onExit()
	DivinexjClgGameEnterView.super.onExit(self)
	self:_removeEffect()
	self:_clearTween()
end

function DivinexjClgGameEnterView:_onClickTip()
	local ruleList = {}
	local info = {}

	info.url = "ui/bigbg/views/challenges/divinexingjiangclg/board_sycjxj_guize01.png"
	info.desc = ""

	local info2 = {}

	info2.url = "ui/bigbg/views/challenges/divinexingjiangclg/board_sycjxj_guize02.png"
	info2.desc = ""

	local info3 = {}

	info3.url = "ui/bigbg/views/challenges/divinexingjiangclg/board_sycjxj_guize03.png"
	info3.desc = ""

	table.insert(ruleList, info)
	table.insert(ruleList, info2)
	table.insert(ruleList, info3)
	TipsFacade.instance:openImageRuleView(ruleList)
end

function DivinexjClgGameEnterView:_onClickBuff()
	UIStateManager.instance:push(ViewName.DivinexjClgBuffView, self._activityId)
end

function DivinexjClgGameEnterView:_onClickStart()
	self:_activeEffect(true)
	self:_clearTween()

	self._tween = TweenUtil.DoDelay(0.5, function()
		self:_enterGame()
	end)
end

function DivinexjClgGameEnterView:_onPlayGameRes()
	self:_updateNum()
end

function DivinexjClgGameEnterView:_updateNum()
	local maxNum = self._cfgActivity.dailyGameCountLimit
	local curNum = DivineXingJiangClgModel.instance:getTodayHasPlayGameCount(self._activityId)
	local leftNum = Mathf.Max(0, maxNum - curNum)

	if leftNum > 0 then
		if not ColorConst.White then
			local colorStr = ColorConst.Red

			self._txtNum.text = string.format("今日剩余：<color=#%s>%d</color>/%d", colorStr, leftNum, maxNum)
		end
	end
end

function DivinexjClgGameEnterView:_isPopupRule()
	local isMarked = GameUtil.getUserData(ViewName.DivinexjClgGameEnterView .. self._activityId)

	if not isMarked then
		GameUtil.saveUserData(ViewName.DivinexjClgGameEnterView .. self._activityId, true)
		self:_onClickTip()
	end
end

function DivinexjClgGameEnterView:_enterGame()
	local maxNum = self._cfgActivity.dailyGameCountLimit
	local curNum = DivineXingJiangClgModel.instance:getTodayHasPlayGameCount(self._activityId)

	if curNum < maxNum then
		local cfgBuffList = DivineXingJiangClgConfig.instance:getBuffList(self._activityId)
		local maxProgress = cfgBuffList[#cfgBuffList].progress
		local curProgress = DivineXingJiangClgModel.instance:getBuffProgress(self._activityId)

		if curProgress < maxProgress then
			UIStateManager.instance:push(ViewName.DivinexjClgGameMainView, self._activityId)
		else
			FloatWordMgr.instance:show("星座碎片已收集完毕 游戏结束")
		end
	else
		FloatWordMgr.instance:show("游戏次数不足")
	end
end

function DivinexjClgGameEnterView:_playEffect()
	self:_removeEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, DivinexjClgGameEnterViewPresentor.EffectPath, self._effectGo.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._uiEffect = uiEffect
end

function DivinexjClgGameEnterView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function DivinexjClgGameEnterView:_activeEffect(isShow)
	if isShow then
		goutil.setActive(self._effectGo, false)
	end

	goutil.setActive(self._effectGo, isShow)
end

function DivinexjClgGameEnterView:_clearTween()
	if self._tween then
		self._tween:Kill()

		self._tween = nil
	end
end

return DivinexjClgGameEnterView
