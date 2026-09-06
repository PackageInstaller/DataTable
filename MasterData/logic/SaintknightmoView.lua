-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightmo/view/SaintknightmoView.lua

module("logic.extensions.saintknightmo.view.SaintknightmoView", package.seeall)

local SaintknightmoView = class("SaintknightmoView", ViewComponent)

function SaintknightmoView:ctor()
	SaintknightmoView.super.ctor(self)
end

function SaintknightmoView:unbindEvents()
	SaintknightmoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnWay1Goto)
	GameUtil.rmClickHandler(self._btnReceive)
	GameUtil.rmClickHandler(self._btnWay2Goto)
	GameUtil.rmClickHandler(self._btnBubble)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnRank)
end

function SaintknightmoView:bindEvents()
	SaintknightmoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnWay1Goto, function()
		local cardId = self._saintknightmoCfg.monthCardId
		local monthCardCfg = MonthCardConfig.instance:getCfgById(cardId)

		PayController.instance:pay(monthCardCfg.payGoodsId, GameEnum.PaySubGoodsType.MONTH_CARD, monthCardCfg.cardId)
	end, self)
	GameUtil.addClickHandler(self._btnReceive, self._onClickReceive, self)
	GameUtil.addClickHandler(self._btnWay2Goto, function()
		self:_onClickGoto("mibao#shengqituandui3", 201088)
	end, self)
	GameUtil.addClickHandler(self._btnBubble, self._onClickBubble, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnInfo_1, function()
		self:_onClickInfo(self._raceId_1)
	end, self)
	GameUtil.addClickHandler(self._btnSkill_1, function()
		self:_onClickSkill(self._raceId_1)
	end, self)
	GameUtil.addClickHandler(self._btnInfo_2, function()
		self:_onClickInfo(self._raceId_2)
	end, self)
	GameUtil.addClickHandler(self._btnSkill_2, function()
		self:_onClickSkill(self._raceId_2)
	end, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function SaintknightmoView:buildUI()
	SaintknightmoView.super.buildUI(self)

	self._effect = self:getGo("effect")
	self._txtTime = self:getTxt("time/txt")
	self._way1 = self:getGo("right/way_1")
	self._progress = self:getSlider("right/way_1/progress/slider")
	self._txtProgress = goutil.findChildTextComponent(self._way1, "progress/txtProgress")
	self._recieve = goutil.findChild(self._way1, "receive")
	self._btnReceive = goutil.findChildButtonComponent(self._way1, "btnReceive")
	self._btnWay1Goto = goutil.findChildButtonComponent(self._way1, "btnGoto")
	self._itemsList1 = {}

	for i = 1, 4 do
		local item = goutil.findChild(self._way1, "item_" .. i)

		if item then
			table.insert(self._itemsList1, item)
		end
	end

	self._way2 = self:getGo("right/way_2")
	self._itemsList2 = {}

	for i = 1, 3 do
		local item = goutil.findChild(self._way2, "item_" .. i)

		if item then
			table.insert(self._itemsList2, item)
		end
	end

	self._btnWay2Goto = goutil.findChildButtonComponent(self._way2, "btnGoto")
	self._bubblePos = self:getGo("con/bubblePos")
	self._btnBubble = self:getBtn("raycast")
	self._btnClose = self:getBtn("btnClose")
	self._btnInfo_1 = self:getBtn("btnInfo_1")
	self._btnSkill_1 = self:getBtn("btnSkill_1")
	self._btnInfo_2 = self:getBtn("btnInfo_2")
	self._btnSkill_2 = self:getBtn("btnSkill_2")
	self._btnRank = self:getBtn("btnRank")
end

function SaintknightmoView:onExit()
	SaintknightmoView.super.onExit(self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	PetCvController.instance:turnOffCurCv()

	if #self._itemsList1 > 0 then
		for i = 1, 4 do
			MaterialMgr.resetAll(self._itemsList1[i])
		end
	end

	if #self._itemsList2 > 0 then
		for i = 1, 3 do
			MaterialMgr.resetAll(self._itemsList2[i])
		end
	end

	MaterialMgr.resetAll(self._icon)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	GlobalDispatcher:removeListener(GlobalNotify.SaintKnightMoInfoRes, self._setWay1Info, self)
	GlobalDispatcher:removeListener(GlobalNotify.SaintKnightMoGainPrizeRes, self._updateWay1Info, self)
end

function SaintknightmoView:onEnter()
	SaintknightmoView.super.onEnter(self)
	self:_onEffectPlay()
	GlobalDispatcher:addListener(GlobalNotify.SaintKnightMoInfoRes, self._setWay1Info, self)
	GlobalDispatcher:addListener(GlobalNotify.SaintKnightMoGainPrizeRes, self._updateWay1Info, self)
	self.addGEvent(self, PayAgent.NotifyPayResultRes, self._onPayResult, self)
	SaintKnightMoAgent.instance:sendPM_SaintKnightMoInfoReq()

	self._raceId_1 = 14041
	self._raceId_2 = 14041
	self._activityId = checknumber(self:getFirstParam()) or 179001

	self:_activityTime(self._activityId)

	self._saintknightmoCfg = SaintknightmoConfig.instance:getCfgById(self._activityId)

	self:_setWay1ShowItem()
	self:_setWay2ShowItem()
	SaintknightmoController.instance:saveUserWeekRedPoint()
end

function SaintknightmoView:_init()
	return
end

function SaintknightmoView:_animDayPlay()
	local animPath = "storyconfig/animations/liexin_dengchang.txt"

	local function onAnimPlashFinish()
		ViewBlockMgr.instance:blockClick(false, ViewName.SaintknightmoView)
	end

	local function onAnimPlashStart()
		ViewBlockMgr.instance:blockClick(true, ViewName.SaintknightmoView)
	end

	AnimationPlayer.play(animPath, onAnimPlashFinish, onAnimPlashStart, self)
	GameUtil.saveUserDayData(ViewName.SaintknightmoView, true)
end

function SaintknightmoView:_onEffectPlay()
	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self._effect, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self._effect.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function SaintknightmoView:_activityTime(id)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SAINT_KNIGHT_MO, id)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function SaintknightmoView:_setWay1Info(msg)
	local info = msg or {}

	self._state = 0

	local totalProgress = self._saintknightmoCfg.progress

	if totalProgress > info.num then
		if not info.num then
			local curProgress = totalProgress

			if curProgress > 2 then
				-- block empty
			end

			self._txtProgress.text = string.format("进度  <color=#FA8D7DFF>%s</color>/%s", curProgress, totalProgress)

			self._progress:SetValue(curProgress / totalProgress)

			self._state = totalProgress > info.num and 0 or totalProgress <= info.num and not info.gainedPrize and 1 or 2

			self:_updateWay1Info()
		end
	end
end

function SaintknightmoView:_updateWay1Info()
	goutil.setActive(self._btnWay1Goto.gameObject, self._state == 0)
	goutil.setActive(self._btnReceive.gameObject, self._state == 1)
	goutil.setActive(self._recieve.gameObject, self._state == 2)
end

function SaintknightmoView:_onClickReceive()
	SaintKnightMoAgent.instance:sendPM_SaintKnightMoGainPrizeReq()

	self._state = 2
end

function SaintknightmoView:_setWay1ShowItem()
	local content = self._saintknightmoCfg.prize
	local arrCon = string.split(content, "#")
end

function SaintknightmoView:_setWay2ShowItem()
	local content = self._saintknightmoCfg.showItemId
	local arrCon = string.split(content, "#")

	for i = 1, #arrCon do
		MaterialMgr.setCellByCfg(arrCon[i], self._itemsList2[i])
	end
end

function SaintknightmoView:_onPayResult()
	SaintKnightMoAgent.instance:sendPM_SaintKnightMoInfoReq()
end

function SaintknightmoView:_onClickGoto(str, id)
	GotoMgr.gotoByString(str)
	SurveyController.instance:reportBehavior(id)
end

function SaintknightmoView:_onClickBubble()
	if self._raceId_1 == nil then
		return
	end

	self._cvDate = self._cvDate or self:_getCvDetail(self._raceId_1)

	local cvIs = self._cvDate[math.random(#self._cvDate)]

	PetCvController.instance:_playPetCvByIndex(self._raceId_1, cvIs, true, self._bubblePos.transform.position)
end

function SaintknightmoView:_getCvDetail(raceId)
	local cfgs = CharacterConfig.instance:getPetCvCfg(raceId) or {}
	local playCvIds = {}

	for i = 1, #cfgs do
		table.insert(playCvIds, i)
	end

	return playCvIds
end

function SaintknightmoView:_onClickClose()
	self:close()
end

function SaintknightmoView:_onClickInfo(raceId)
	if raceId == nil then
		return
	end

	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:openPetinfoView(raceId)
end

function SaintknightmoView:_onClickSkill(raceId)
	if raceId == nil then
		return
	end

	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(raceId)
end

function SaintknightmoView:_onClickRank()
	SurveyController.instance:reportBehavior(201089)
	GotoMgr.gotoByString("func#618#14018")
end

return SaintknightmoView
