-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/mainhud/SeasonS1TopBossView.lua

module("logic.extensions.season.view.mainhud.SeasonS1TopBossView", package.seeall)

local SeasonS1TopBossView = class("SeasonS1TopBossView", ViewComponent)

function SeasonS1TopBossView:ctor()
	SeasonS1TopBossView.super.ctor(self)
end

function SeasonS1TopBossView:unbindEvents()
	SeasonS1TopBossView.super.unbindEvents(self)
	self._btn_tip:RemoveClickListener()
	self._btnBoss:RemoveClickListener()
end

function SeasonS1TopBossView:bindEvents()
	SeasonS1TopBossView.super.bindEvents(self)
	self._btn_tip:AddClickListener(self._onClickHelp, self)
	self._btnBoss:AddClickListener(self._onClickBoss, self)
end

function SeasonS1TopBossView:buildUI()
	SeasonS1TopBossView.super.buildUI(self)

	self._btn_tip = self:getBtn("btn_tip")
	self._btnBoss = self:getBtn("bossGuide/btnBoss")
	self._bossHead = self:getGo("bossGuide/btnBoss/head")
	self._bubble = self:getGo("bossGuide/bubble")
	self._txtDesc = self:getTxt("bossGuide/bubble/txtDesc")
	self._bossRedpoint = self:getGo("bossGuide/btnBoss/redpoint")
end

function SeasonS1TopBossView:onExit()
	SeasonS1TopBossView.super.onExit(self)
	removetimer(self.onTimer, self)
	self._loaderHead:clear()
end

function SeasonS1TopBossView:onEnter()
	SeasonS1TopBossView.super.onEnter(self)
	GameUtil.SetActive(self._bossRedpoint, false)
	self:hideBubble()
	self:onRefreshUI()
	self:loadHeadSpine()
end

function SeasonS1TopBossView:_onClickHelp()
	TipsFacade.instance:openRulesView("seasonmainview_rules")
end

function SeasonS1TopBossView:_onClickBoss()
	UIStateManager.instance:push(ViewName.SeasonbossguideView)
end

function SeasonS1TopBossView:onRefreshUI()
	self.timeIndex = 0

	removetimer(self.onTimer, self)
	settimer(1, self.onTimer, self, true)
end

function SeasonS1TopBossView:onTimer()
	self.timeIndex = self.timeIndex + 1

	if self.curState == STATE_HIDE then
		if self.timeIndex >= self.bubbleShowGap then
			self:showBubble()
		end
	else
		local holdTime = SeasonConfig.instance:getCommonValue("BOSS_SPEAK_HOLD_TIME", true)

		if holdTime <= self.timeIndex then
			self:hideBubble()
		end
	end
end

function SeasonS1TopBossView:loadHeadSpine()
	local path = GameUrl.getHeadSpineUIUrl("17012_sada")

	self._loaderHead = PrefabLoader.Get(self._bossHead)

	self._loaderHead:load(path, nil, self, true)
end

function SeasonS1TopBossView:showBubble()
	self.timeIndex = 0
	self.curState = STATE_SAY

	SeasonModel.instance:addBubbleTimes()
	GameUtil.SetActive(self._bubble, true)

	local bossMo = SeasonModel.instance.bossMo
	local phaseId = bossMo.phaseId
	local cfg = SeasonConfig.instance:getBossRandSpeak(phaseId) or {}

	self._txtDesc.text = cfg.desc
end

function SeasonS1TopBossView:hideBubble()
	self.timeIndex = 0
	self.curState = STATE_HIDE

	local fixTime = SeasonConfig.instance:getCommonValue("BOSS_SPEAK_FIX_TIME", true)
	local randTime = SeasonConfig.instance:getCommonValue("BOSS_SPEAK_RAND_TIME", true)

	self.bubbleShowGap = fixTime + math.random(0, randTime)

	GameUtil.SetActive(self._bubble, false)

	local bubbleTimes = SeasonModel.instance:getBubbleTimes()
	local limit = SeasonConfig.instance:getCommonValue("BOSS_SPEAK_TIME_DAY_LIMIT", true)

	if limit <= bubbleTimes then
		removetimer(self.onTimer, self)

		return
	end
end

return SeasonS1TopBossView
