-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewroundreport/BattleRoundReportView.lua

module("logic.extensions.battle.viewroundreport.BattleRoundReportView", package.seeall)

local BattleRoundReportView = class("BattleRoundReportView", ViewComponent)
local kDurationRound = 2
local kDurationEnemy = 1

function BattleRoundReportView:buildUI()
	self._handler = Handler.New()
	self._timerWaiter = false
	self._txtSeconds1List = {
		self:getTextByPath("round_conversion/seconds/txtSeconds1"),
		self:getTextByPath("round_conversion/seconds_1/txtSeconds1"),
		self:getTextByPath("round_conversion/seconds_2/txtSeconds1")
	}
	self._txtSeconds2List = {
		self:getTextByPath("round_conversion/seconds/txtSeconds2"),
		self:getTextByPath("round_conversion/seconds_1/txtSeconds2"),
		self:getTextByPath("round_conversion/seconds_2/txtSeconds2")
	}
	self._txtRoundHintList = {
		self:getTextByPath("round_conversion/seconds/roundHint/txtRound"),
		self:getTextByPath("round_conversion/seconds_1/roundHint/txtRound"),
		self:getTextByPath("round_conversion/seconds_2/roundHint/txtRound")
	}
	self._txtTimelineList = {}

	for index = 1, 12 do
		self._txtTimelineList[index] = goutil.findChildTextComponent(self.mainGO, string.format("round_conversion/timeLine/Image1/Text%s", index))
	end

	self._transformTimeline = goutil.findChild(self.mainGO, "round_conversion/timeLine").transform
	self._goRoundConversion = self:getGoByPath("round_conversion")
	self._goCampConversion = self:getGoByPath("camp_conversion")
	self._goEnemy = self:getGoByPath("camp_conversion/bottom/ImageEnemy")
	self._goThirdPart = self:getGoByPath("camp_conversion/bottom/ImageThird")
	self._guiTimeline = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
end

function BattleRoundReportView:destroyUI()
	self._timerWaiter = nil
	self._txtSeconds1List = nil
	self._txtSeconds2List = nil
	self._txtRoundHintList = nil
	self._txtTimelineList = nil
	self._transformTimeline = nil
	self._goRoundConversion = nil
	self._goCampConversion = nil
	self._goEnemy = nil
	self._goThirdPart = nil

	self._guiTimeline:RemoveListener()

	self._guiTimeline = nil
end

function BattleRoundReportView:onEnter()
	self:_setEvent(true)
	self:_onBattleSpeedUpdate()
	goutil.setActive(self._goCampConversion, false)
	goutil.setActive(self._goRoundConversion, false)
	BattleRoundReportViewFacade.instance:registerView(self)
end

function BattleRoundReportView:onExit()
	BattleRoundReportViewFacade.instance:unregisterView()
	self:_setEvent(false)
	self:_clearTimeWaiter()
	self._handler:clear()
end

function BattleRoundReportView:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleRoundUpdate, self._onRoundUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnBattleSpeedUpdate, self._onBattleSpeedUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleRoundUpdate, self._onRoundUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleSpeedUpdate, self._onBattleSpeedUpdate, self)
	end
end

function BattleRoundReportView:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

function BattleRoundReportView:resetReportView()
	goutil.setActive(self._goCampConversion, false)
	goutil.setActive(self._goRoundConversion, false)
end

function BattleRoundReportView:playOperateCampStartReport(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:_playRounReport()
end

function BattleRoundReportView:playOtherCampStartReport(campId, callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:_playCampReport(campId)
end

function BattleRoundReportView:hideOtherCampStartReport()
	goutil.setActive(self._goCampConversion, false)
end

function BattleRoundReportView:_playRounReport()
	BattleAudioUtil.playSEByName("ui_battle_wofanghuihe")

	self._timerWaiter = self:_getTimeWaiter()

	self._timerWaiter:start(kDurationRound, self._onRoundReportFinish, self)
	self._timerWaiter:setTimeScale(BattleTime.timeScale)
	goutil.setActive(self._goRoundConversion, true)
	self._guiTimeline:StopTimelineAni()
	self._guiTimeline:PlayAniByName("open1")
	self:_setAndPlayRoundTimelineView()
	goutil.setActive(self._goCampConversion, false)
	BattleMainViewFacade.instance:lockOperation(true)
end

local kTimelinePoints = {
	"00",
	"05",
	"10",
	"15",
	"20",
	"25",
	"30",
	"35",
	"40",
	"45",
	"50",
	"55"
}
local kPreNodeCount = 5

function BattleRoundReportView:_setAndPlayRoundTimelineView()
	local model = BattleMgr.instance:getModel()
	local round = model:getCurrentRound()
	local preRoundString = TimeUtil.instance:numberFixPre(round - 1)
	local roundString = TimeUtil.instance:numberFixPre(round)
	local preRoundIndex = #kTimelinePoints - kPreNodeCount

	for index, txtTimeline in ipairs(self._txtTimelineList) do
		if index <= kPreNodeCount then
			txtTimeline.text = string.format("%s:%s", preRoundString, kTimelinePoints[preRoundIndex + index])
		else
			local roundIndex = index - kPreNodeCount

			txtTimeline.text = string.format("%s:%s", roundString, kTimelinePoints[roundIndex])
		end
	end

	local fromItem = self._txtTimelineList[kPreNodeCount - 1].transform
	local targetItem = self._txtTimelineList[kPreNodeCount + 1].transform
	local fromX = -Astral.TransformUtil.GetLocalPosX(fromItem)
	local toX = -Astral.TransformUtil.GetLocalPosX(targetItem)

	self._transformTimeline:DOKill(true)
	Astral.TransformUtil.SetLocalPosX(self._transformTimeline, fromX)
	self._transformTimeline:DOAnchorPosX(toX, 1):SetEase(DG.Tweening.Ease.OutCirc)
end

function BattleRoundReportView:_onRoundReportFinish()
	self:_clearTimeWaiter()
	self._guiTimeline:StopTimelineAni()
	self._guiTimeline:PlayAniByName("close")
	goutil.setActive(self._goRoundConversion, false)
	BattleMainViewFacade.instance:unlockOperation()
	self._handler:callAndClear()
end

function BattleRoundReportView:_playCampReport(campId)
	local relationType = BattleCampRelationUtil.getCampRelationWithOperateCamp(campId)

	if relationType == BattleEnum.CampRelation.ENEMY then
		BattleAudioUtil.playSEByName("ui_battle_difanghuihe")

		self._timerWaiter = self:_getTimeWaiter()

		self._timerWaiter:start(kDurationEnemy, self._onCampReportFinish, self)
		self._timerWaiter:setTimeScale(BattleTime.timeScale)
		self._guiTimeline:StopTimelineAni()
		goutil.setActive(self._goRoundConversion, false)
		goutil.setActive(self._goCampConversion, true)
		goutil.setActive(self._goEnemy, true)
		goutil.setActive(self._goThirdPart, false)
		self._guiTimeline:ClearAllBinding()
		self._guiTimeline:PlayAniByName("open2")
	elseif relationType == BattleEnum.CampRelation.NORMAL then
		goutil.setActive(self._goRoundConversion, false)
		goutil.setActive(self._goCampConversion, true)
		goutil.setActive(self._goEnemy, false)
		goutil.setActive(self._goThirdPart, true)
		self:_onCampReportFinish()
	else
		goutil.setActive(self._goRoundConversion, false)
		goutil.setActive(self._goCampConversion, false)
		self:_onCampReportFinish()
	end
end

function BattleRoundReportView:_onCampReportFinish()
	self:_clearTimeWaiter()
	self._handler:callAndClear()
end

function BattleRoundReportView:_onRoundUpdate(e, currentRound, maxRound)
	local value = TimeUtil.instance:numberFixPre(currentRound)

	for _, txtContent in ipairs(self._txtSeconds1List) do
		txtContent.text = value
	end

	value = TimeUtil.instance:numberFixPre(0)

	for _, txtContent in ipairs(self._txtSeconds2List) do
		txtContent.text = value
	end

	value = string.format("第%s回合", currentRound)

	for _, txtContent in ipairs(self._txtRoundHintList) do
		txtContent.text = value
	end
end

function BattleRoundReportView:_onBattleSpeedUpdate()
	return
end

function BattleRoundReportView:_getTimeWaiter()
	if self._timerWaiter then
		self._timerWaiter:clear()

		return self._timerWaiter
	end

	return TimeWaiter:createInstance()
end

function BattleRoundReportView:_clearTimeWaiter()
	if self._timerWaiter then
		self._timerWaiter:returnSelf()

		self._timerWaiter = false
	end
end

return BattleRoundReportView
