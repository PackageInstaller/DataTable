-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiSelectView.lua

module("logic.extensions.shenjichallenge.view.ShenJiSelectView", package.seeall)

local ShenJiSelectView = class("ShenJiSelectView", ViewComponent)

function ShenJiSelectView:buildUI()
	ShenJiSelectView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtScore = self:getTxt("main/score/txtScore")
	self._scoreIcon = self:getGo("main/score/icon")
	self._levelList = {}

	local levels = self:getGo("main/levels")

	for i = 1, 3 do
		local element = {}
		local go = goutil.findChild(levels, "level" .. i)

		element.go = go
		element.txtName = goutil.findChildTextComponent(go, "node/bg/txt")
		element.btn = Framework.ButtonAdapter.GetFrom(go, "node/bg")
		element.node = goutil.findChild(go, "node")
		element.nodeRect = goutil.findChildRectTransformComponent(go, "node")

		table.insert(self._levelList, element)
	end

	local prefix = "main/levels/tab/node/"

	self._tab = self:getGo("main/levels/tab")
	self._txtDesc1 = self:getTxt(prefix .. "txtDesc1")
	self._rewardIcon = self:getGo(prefix .. "reward/node/icon")
	self._txtRewardDesc = self:getTxt(prefix .. "reward/node/txtDesc")
	self._btnReward = self:getBtn(prefix .. "reward/node")
	self._txtNum = self:getTxt(prefix .. "txtNum")
	self._btnChallenge = self:getBtn(prefix .. "btnChallenge")
	self._btnTask = self:getBtn("main/btnTask")
	self._btnSlider = self:getBtn("main/btnSlider")
	self._gridLayoutGroup = self:getGo("main/levels"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
end

function ShenJiSelectView:bindEvents()
	ShenJiSelectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnSlider:AddClickListener(self._onClickSlider, self)
	self._btnReward:AddClickListener(self._onClickReward, self)

	for i, v in ipairs(self._levelList) do
		v.btn:AddClickListener(function()
			self:_onClickLevel(i)
		end)
	end
end

function ShenJiSelectView:unbindEvents()
	ShenJiSelectView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnSlider:RemoveClickListener()
	self._btnReward:RemoveClickListener()

	for i, v in ipairs(self._levelList) do
		v.btn:RemoveClickListener()
	end
end

function ShenJiSelectView:onEnter()
	ShenJiSelectView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = ShenJiChallengeConfig.instance:getActivityCfg(self._activityId)
	self._dailySelectTimes = self._cfgActivity.dailySelectTimes
	self._curStageId = 0

	self:_initGos()
	self:_initCurLevel()
	self:_updateScore()
	self:_updateLevels()
	self:_updateChallengeTimes()
	self:_initLevelsLayout()
	self:_popupTipViewFirst()
end

function ShenJiSelectView:onExit()
	ShenJiSelectView.super.onExit(self)
	self:_clearIcon()
end

function ShenJiSelectView:_onClickTip()
	local ruleCfg = ShenJiChallengeConfig.instance:getRuleCfgs(self._activityId, 1)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList)
end

function ShenJiSelectView:_onClickChallenge()
	ShenJiChallengeModel.instance:getTodayChallengeTimes()

	local maxNum = self._dailySelectTimes
	local curNum = ShenJiChallengeModel.instance:getTodayChallengeTimes()

	if maxNum <= curNum then
		FloatWordMgr.instance:show("今日无挑战次数")

		return
	end

	if self._curStageId > 0 then
		ShenJiChallengeController.instance:openSelectMissionView(self._activityId, self._curStageId)
	end
end

function ShenJiSelectView:_onClickTask()
	UIStateManager.instance:push(ViewName.ShenJiTaskView, self._activityId)
end

function ShenJiSelectView:_onClickSlider()
	UIStateManager.instance:push(ViewName.ShenJiBuffView, self._activityId)
end

function ShenJiSelectView:_onClickReward()
	local mo = InstructionMo.New()

	mo.name = ShenJiChallengeConfig.instance:getCommonValue(self._activityId, "rewardName")
	mo.desc = ShenJiChallengeConfig.instance:getCommonValue(self._activityId, "rewardDesc")
	mo.iconPath = ShenJiChallengeConfig.instance:getCommonValue(self._activityId, "rewardIconPath")
	mo.posGo = self._rewardIcon

	TipsFacade.instance:openInstructionView(mo)
end

function ShenJiSelectView:_onClickLevel(index)
	goutil.setActive(self._tab, true)
	self._tab.transform:SetSiblingIndex(index)
	self:_updateCurLevel(index)
	self:_updateLevelsLayout(index)

	if index == 3 then
		local cell = self._levelList[index]

		Framework.TransformUtil.SetAnchoredPos(cell.nodeRect, 65, -100)
	end
end

function ShenJiSelectView:_initGos()
	goutil.setActive(self._tab, false)
end

function ShenJiSelectView:_updateScore()
	self._txtScore.text = ShenJiChallengeModel.instance:getBuffValue()
end

function ShenJiSelectView:_updateLevels()
	local stageIds = ShenJiChallengeModel.instance:getOptionalStageIds()

	for i, id in ipairs(stageIds) do
		local element = self._levelList[i]

		if element then
			local cfg = ShenJiChallengeConfig.instance:getSelectStage(self._activityId, id)

			if cfg then
				element.txtName.text = cfg.stageDesc
			end
		end
	end
end

function ShenJiSelectView:_initCurLevel()
	local iconPath = ShenJiChallengeConfig.instance:getCommonValue(self._activityId, "rewardIconPath")

	uGuiUtil.setSpriteToImage(self._rewardIcon, uGuiUtil.SpriteType.BigBg, iconPath)
	uGuiUtil.setSpriteToImage(self._scoreIcon, uGuiUtil.SpriteType.BigBg, iconPath)
end

function ShenJiSelectView:_clearIcon()
	uGuiUtil.clearImage(self._rewardIcon)
	uGuiUtil.clearImage(self._scoreIcon)
end

function ShenJiSelectView:_updateCurLevel(index)
	local stageIds = ShenJiChallengeModel.instance:getOptionalStageIds()
	local stageId = stageIds[index]

	printInfo("test ShenJiSelectView:_updateCurLevel", stageId)

	local cfgSelectStage = ShenJiChallengeConfig.instance:getSelectStage(self._activityId, stageId)

	if cfgSelectStage then
		self._curStageId = stageId
		self._txtRewardDesc.text = cfgSelectStage.rewardDesc

		local cfgMaster = ShenJiChallengeConfig.instance:getMaster(cfgSelectStage.creepsMasterId)

		if cfgMaster then
			self._txtDesc1.text = cfgMaster.ruleDesc
		end
	end
end

function ShenJiSelectView:_updateChallengeTimes()
	local maxNum = self._dailySelectTimes
	local curNum = ShenJiChallengeModel.instance:getTodayChallengeTimes()

	self._txtNum.text = string.format("今日剩余挑战次数：%d/%d", Mathf.Max(maxNum - curNum, 0), maxNum)
end

function ShenJiSelectView:_initLevelsLayout()
	self._gridLayoutGroup.spacing = Vector2.New(135, 0)

	for i, v in ipairs(self._levelList) do
		GameUtil.setLocalScale(v.node, 1, 1, 1)
		GameUtil.setAnchoredPos(v.node, 0, i == 2 and -20 or -50)
	end
end

function ShenJiSelectView:_updateLevelsLayout(showIndex)
	self._gridLayoutGroup.spacing = Vector2.New(20, 0)

	for i, v in ipairs(self._levelList) do
		local fromScale = GameUtil.getLocalScale(v.node)
		local scale = i == showIndex and 1 or 0.8
		local toScale = Vector3.New(scale, scale, scale)

		UnityTweens.TweenScale.StartTween(v.node, fromScale, toScale, 0.1, UnityTweens.EaseType.linear)
		GameUtil.setAnchoredPos(v.node, 0, -50)
	end
end

function ShenJiSelectView:_popupTipViewFirst()
	local key = ViewName.ShenJiSelectView .. self._activityId
	local isMarkedFirst = GameUtil.getUserData(key)

	if not isMarkedFirst then
		GameUtil.saveUserData(key, true)
		self:_onClickTip()
	end
end

return ShenJiSelectView
