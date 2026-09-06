-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameMainView.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameMainView", package.seeall)

local NumberPuzzleGameMainView = class("NumberPuzzleGameMainView", ViewComponent)

function NumberPuzzleGameMainView:buildUI()
	NumberPuzzleGameMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._btnNor = goutil.findChild(self.mainGO, "btnNormal")
	self._btnNor_btn = goutil.findChild(self.mainGO, "btnNormal/btn")
	self._btnNorl_redPoint = goutil.findChild(self.mainGO, "btnNormal/btn/redPoint")
	self._btnNorl_bubble = goutil.findChild(self.mainGO, "btnNormal/bubble")
	self._btnNorl_bubble_item = goutil.findChild(self.mainGO, "btnNormal/bubble/item")
	self._btnExt = goutil.findChild(self.mainGO, "btnExt")
	self._btnExt_btn = goutil.findChild(self.mainGO, "btnExt/btn")
	self._btnExt_redPoint = goutil.findChild(self.mainGO, "btnExt/btn/redPoint")
end

function NumberPuzzleGameMainView:bindEvents()
	NumberPuzzleGameMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnNor_btn, self._onClickBtnNor, self)
	GameUtil.addClickHandler(self._btnExt_btn, self._onClickBtnExt, self)
end

function NumberPuzzleGameMainView:unbindEvents()
	NumberPuzzleGameMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._btnNor_btn)
	GameUtil.rmClickHandler(self._btnExt_btn)
end

function NumberPuzzleGameMainView:onEnter()
	NumberPuzzleGameMainView.super.onEnter(self)

	self._activityId = NumberPuzzleGameController.instance:getActivityId()
	self._activityType = NumberPuzzleGameController.instance:getActivityType()

	local isInTime = NumberPuzzleGameController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = NumberPuzzleGameConfig.instance:getNpgActData(self._activityId)

	NumberPuzzleGameController.instance:sendPM_2048InfoReq(self._activityId)
	self:_onSetUI()
end

function NumberPuzzleGameMainView:onExit()
	NumberPuzzleGameMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._btnNorl_redPoint)
	MaterialMgr.resetAll(self._btnNorl_bubble_item)
end

function NumberPuzzleGameMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	RedPointController.instance:regRedPoint(self._btnNorl_redPoint, RedPointModel.ID_NumberPuzzleGame_Nor)

	local prize = self._actData.bubbleItemOfNor

	if string.nilorempty(prize) then
		GameUtil.SetActive(self._btnNorl_bubble, false)
	else
		GameUtil.SetActive(self._btnNorl_bubble, true)
		MaterialMgr.setCellByCfg(prize, self._btnNorl_bubble_item)
	end
end

function NumberPuzzleGameMainView:_onClickBtnJump(key)
	local jumpToStr = NumberPuzzleGameConfig.instance:getNpgActValue(self._activityId, key)

	GotoMgr.gotoByString(jumpToStr)
end

function NumberPuzzleGameMainView:_onClickBtnNor()
	UIStateManager.instance:push(ViewName.NumberPuzzleGameNorStageSelectView)
end

function NumberPuzzleGameMainView:_onClickBtnExt()
	local result, tips = NumberPuzzleGameController.instance:getTryStartExtStageResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	NumberPuzzleGameController.instance:startNumberPuzzleGameOfExt(self._activityId)
end

function NumberPuzzleGameMainView:_onClickBtnTip()
	local key = NumberPuzzleGameConfig.instance:getNpgActValue(self._activityId, "ruleKey")

	TipsFacade.instance:openRulesView(key)
end

return NumberPuzzleGameMainView
