-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightPickupideagameView.lua

module("logic.extensions.originfight.view.OriginFightPickupideagameView", package.seeall)

local OriginFightPickupideagameView = class("OriginFightPickupideagameView", PickupideagameView)

OriginFightPickupideagameView.TipsKey = "OriginFightPickupideagameView.TipsKey"

function OriginFightPickupideagameView:ctor()
	OriginFightPickupideagameView.super.ctor(self)

	self._lowBubbleId = 4
	self._highBubbleId = 5
end

function OriginFightPickupideagameView:buildUI()
	OriginFightPickupideagameView.super.buildUI(self)

	self._waitingStartText = self:getTxt("gamestartTip/waitingStartText")
end

function OriginFightPickupideagameView:onEnter()
	self.addGEvent(self, GlobalNotify.PickUpIdeaBlockActive, self._onPickUpIdeaBlockActive, self)
	self.addGEvent(self, GlobalNotify.PickUpIdeaReliveRes, self._relive, self)
	self.addGEvent(self, GlobalNotify.PickUpIdeaBubbleMoveEnd, self._onPickUpIdeaBubbleMoveEnd, self)
	self.addGEvent(self, GlobalNotify.PM_OriginFightCommonGodFavorRes, self._onGodFavorRes, self)
	self._joystickCtrl.gameObject:SetActive(true)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = 525001
	end

	self._godFavorId = checknumber(params[2])
	self._actCfg = OriginFightConfig.instance:getPickUpActCfg(self._activityId)
	self._lowBubbleId = 0

	goutil.setActive(self._joystickbackgroundFakeGo, true)
	goutil.setActive(self._startTip, true)
	self:_initGamePlan()
	self:_initGameData()
	self:_updateScore()
	self:_setTime()
	self:_buildMapBg()
	self:_calMainRoleMoveLimit()
	self:_setMainRolePos(1, 1)
	self:_buildBubbles(true)
	self:_showTipsView()

	self._waitingStartText.text = string.format("点击屏幕任意空白位置开始游戏，\n按住左下角轮盘即可操纵小奥奇行走~%d分即可通关", self._actCfg.passScore)
end

function OriginFightPickupideagameView:_initGameData()
	self._animationScale = 1
	self._mapSize = self._actCfg.size
	self._score = 0
	self._tickedTime = 0
	self._isRunning = false
	self._maxTime = self._actCfg.gameTime
	self._vector2Cache = Vector2.New(0, 0)
	self._isJoystickDown = false
	self._radius = 37.5
	self._bgCellOffsetX = -self._mapSize[2] * self._bgCellSpaceX / 2 - self._bgCellSpaceX / 2 - 5
	self._bgCellOffsetY = self._mapSize[1] * self._bgCellSpaceY / 2 + self._bgCellSpaceY / 2
	self._roundBlockTime = self._actCfg.timeBlock
	self._roundSpiderTime = self._actCfg.timeSpider
	self._blockObjList = {}
	self._protectedTime = 0
	self._isCanMoving = true
end

function OriginFightPickupideagameView:_initGamePlan()
	local ids = OriginFightConfig.instance:getGamePlanIds()

	self._gamePlanId = math.random(1, #ids)
	self._gamePlanCfgs = OriginFightConfig.instance:getPickUpGamePlanCfgs(self._gamePlanId)
	self._roundTime = 5
end

function OriginFightPickupideagameView:_getActorPath()
	return {
		"character/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"
	}
end

function OriginFightPickupideagameView:_setNeedBubbleIds()
	if self._lowBubbleId > 0 then
		return
	end

	self._lowBubbleId = 4
	self._highBubbleId = 5

	self._bubble1Change:SetState(self._lowBubbleId - 1)
	self._bubble2Change:SetState(self._highBubbleId - 1)
end

function OriginFightPickupideagameView:_checkScoreMax()
	if self._score >= 500 then
		self._score = 500

		self:_updateScore()

		self._isRunning = false

		local text = string.format("已达到单局积分上限%s分，恭喜通关~", self._score)

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			OriginFightController.instance:sendPM_OriginFightCommonGdFavorReq(self._activityId, self._godFavorId)
		end)
	end
end

function OriginFightPickupideagameView:_onGodFavorRes()
	local godFavorCfg = OriginFightConfig.instance:getGodFavorCfgById(self._activityId, self._godFavorId)

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, godFavorCfg.storyId, StoryModel.StoryType.SCCopy)
	self:_stopGame()
end

function OriginFightPickupideagameView:_stopGame()
	self:_removeTimer()

	for k, v in pairs(self._bubbleList) do
		v.class:onExit()
	end

	if self._score >= self._actCfg.passScore then
		OriginFightController.instance:sendPM_OriginFightCommonGodFavorReq(self._activityId, self._godFavorId)
	else
		FloatWordMgr.instance:show("未达到通关要求积分，请重新尝试")
	end

	self:close()
end

function OriginFightPickupideagameView:_deadGame()
	self:_removeTimer()

	for k, v in pairs(self._bubbleList) do
		v.class:onExit()
	end

	FloatWordMgr.instance:show("死亡，请重新尝试")
	self:close()
end

function OriginFightPickupideagameView:_isHitBubble(id)
	local cfg = OriginFightConfig.instance:getPickUpBubbleCfg(id)
	local score = 0

	score = self:_checkIsNeedBubbleId(id) and cfg.score or -cfg.score
	self._score = self._score + score
	self._score = math.max(self._score, 0)

	self:_updateScore()
	self:_showScoreChangeAnim(score)
	self:_checkScoreMax()
end

function OriginFightPickupideagameView:_buildBlock()
	if not self._isRunning then
		return
	end

	self:_resetBgCells()

	local planId = OriginFightConfig.instance:getPickUpRandomBlockPlanId()
	local cfgs = OriginFightConfig.instance:getPickUpBlockCfgs(planId)
	local row, col = 0, 0

	self._blockObjList = {}

	for i, v in ipairs(cfgs) do
		local obj = self._mapBgCellObjs[v.pos[1]][v.pos[2]]

		obj:playWarning()
		table.insert(self._blockObjList, obj)
	end
end

function OriginFightPickupideagameView:_playDeadEffect()
	if self._isRunning then
		self:_setTime()
		self._joystickCtrl:StopJoystickMove()

		local deadUrl = "xiaoyouxi/xiaoanlongyouxi/fx_xiaoyouxi_siwang_02.prefab"

		self._towerDeadEffect = UIEffectManager.instance:playEffect(self, deadUrl, self.mainGO, 0, 0, false, nil, function()
			return
		end, function(o, eff)
			return
		end)

		self._towerDeadEffect:setParent(self.mainGO.transform)
		self._towerDeadEffect:setLocalPos(0, 0, 0)
		self._towerDeadEffect:setScale(20)

		self._isRunning = false

		local isOver = self:_isTimeOver()

		if isOver then
			self:_stopGame()
		else
			self:_deadGame()
		end
	end
end

return OriginFightPickupideagameView
