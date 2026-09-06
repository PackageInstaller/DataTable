-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/knowledgeanswer/view/KnowledgeAnswerView.lua

module("logic.extensions.knowledgeanswer.view.KnowledgeAnswerView", package.seeall)

local KnowledgeAnswerView = class("KnowledgeAnswerView", ViewComponent)

function KnowledgeAnswerView:ctor()
	KnowledgeAnswerView.super.ctor(self)
end

function KnowledgeAnswerView:unbindEvents()
	KnowledgeAnswerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRid)

	for i = 0, 4 do
		GameUtil.rmClickHandler(self._zonelist[i].btn)
	end
end

function KnowledgeAnswerView:bindEvents()
	KnowledgeAnswerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRid, self._onClickRid, self)

	for i = 0, 4 do
		GameUtil.addClickHandler(self._zonelist[i].btn, GameUtil.handler(self._onClickSelectZone, self, i))
	end
end

function KnowledgeAnswerView:buildUI()
	KnowledgeAnswerView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._nodeResultCounting = self:getGo("nodeResultCounting")
	self._txtNextTime = self:getTxt("nodeResultCounting/nextTime")
	self._nodeQuestion = self:getGo("nodeQuestion")
	self._answerItems = {}

	for i = 1, 4 do
		self._answerItems[i] = self:buildAnswerItem("nodeQuestion/question/options/answerItem_" .. i)
	end

	self._imgDowncountAnswer = self:getGo("nodeQuestion/imgDowncount"):GetComponent(typeof(UIImgNumeralText))
	self._txtQuestion = self:getTxt("nodeQuestion/question/txtQuestion")
	self._txtScore = self:getTxt("nodeQuestion/score/txt")
	self._btnRid = self:getGo("nodeQuestion/btnRid")
	self._txtNumHelp1 = self:getTxt("nodeQuestion/btnRid/useNum/txtNum")
	self._txtNameHelp1 = self:getTxt("nodeQuestion/btnRid/txtName")
	self._btnTip = self:getGo("nodeQuestion/btnTip")
	self._txtNameHelp2 = self:getTxt("nodeQuestion/btnTip/txtName")
	self._tipHelp2 = self:getGo("nodeQuestion/btnTip/tip")
	self._txtDescTipHelp2 = self:getTxt("nodeQuestion/btnTip/tip/txtDesc")
	self._txtNumHelp2 = self:getTxt("nodeQuestion/btnTip/useNum/txtNum")
	self._wrong = self:getGo("nodeQuestion/wrong")
	self._bingo = self:getGo("nodeQuestion/bingo")
	self._txtWrong = self:getTxt("nodeQuestion/wrong/txtNum")
	self._txtBingo = self:getTxt("nodeQuestion/bingo/txtNum")
	self._nodeNextCounting = self:getGo("nodeNextCounting")
	self._imgNumNextCount = self:getGo("nodeNextCounting/downCount/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._zonelist = {}

	for i = 0, 4 do
		local cell = {}

		cell.playersCon = self:getGo("zones/playerLayer/zone_" .. i)
		cell.btn = self:getGo("zones/clickLayer/zone_" .. i)
		self._zonelist[i] = cell
	end

	self._mainPlayer = self:getGo("zones/mainPlayer")
	self._headMainPlayer = self:getGo("zones/mainPlayer/head")
	self._player = self:getGo("player")
end

function KnowledgeAnswerView:buildAnswerItem(path)
	local cell = {}

	cell.go = self:getGo(path)
	cell.right = goutil.findChild(cell.go, "right")
	cell.error = goutil.findChild(cell.go, "error")
	cell.select = goutil.findChild(cell.go, "select")
	cell.txtAnswer = goutil.findChildTextComponent(cell.go, "answer")

	return cell
end

function KnowledgeAnswerView:onExit()
	KnowledgeAnswerView.super.onExit(self)
	removetimer(self._onCountDownEnterRoom, self)
	removetimer(self._onCountDownAnswer, self)
	removetimer(self._onCountDownWait, self)
	removetimer(self._doSettleAni, self)
	HeadItemController.instance:resetHeadCell(self._headMainPlayer)

	for _, go in ipairs(self._memberGoList) do
		local head = goutil.findChild(go, "head")

		HeadItemController.instance:resetHeadCell(head)
		goutil.setActive(go, false)
	end

	KnowledgeAnswerController.instance:leaveRoom(self._activityId)
end

function KnowledgeAnswerView:onEnter()
	KnowledgeAnswerView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KnowledgeAnswerUpdateMemberInfo, self._onUpdateMemberInfo, self)
	self.addGEvent(self, GlobalNotify.KnowledgeAnswerPuzzlesSettlement, self._onSettlementLastPuzzle, self)
	self.addGEvent(self, GlobalNotify.KnowledgeAnswerPuzzlesRefresh, self._onRefreshPuzzle, self)
	self.addGEvent(self, GlobalNotify.KnowledgeAnswerSeekHelp, self._onSeekHelp, self)
	self.addGEvent(self, GlobalNotify.KnowledgeAnswerSendAnswer, self._onSendAnswer, self)

	local param = self:getFirstParam()

	self:_onEnterRoom(param)
	GameUtil.setAnchoredPos(self._mainPlayer, 0, 0)

	self._curSelectId = nil
	self._isTimeCanAnswer = false

	HeadItemController.instance:setMyHeadCell(self._headMainPlayer)
end

function KnowledgeAnswerView:_onClickClose()
	KnowledgeAnswerController.instance:leaveRoom(self._activityId)
end

function KnowledgeAnswerView:_onClickTip()
	if not self._isTimeCanAnswer then
		return
	end

	local helpType = 2
	local times = KnowledgeAnswerModel.instance:getRemainingHelpTimes(self._activityId, helpType)

	if times <= 0 then
		FloatWordMgr.instance:show(lang("answerscene_helptip_notimes"))

		return
	end

	if self._isUseTipsHelp then
		FloatWordMgr.instance:show(lang("answerscene_help_tips_used"))

		return
	end

	KnowledgeAnswerController.instance:seekHelp(self._activityId, helpType)
end

function KnowledgeAnswerView:_onClickRid()
	if not self._isTimeCanAnswer then
		return
	end

	local helpType = 1
	local times = KnowledgeAnswerModel.instance:getRemainingHelpTimes(self._activityId, helpType)

	if times <= 0 then
		FloatWordMgr.instance:show(lang("answerscene_help_excep_error_notimes"))

		return
	end

	if self._isUseExceptErrorHelp then
		FloatWordMgr.instance:show(lang("answerscene_help_excep_error"))

		return
	end

	KnowledgeAnswerController.instance:seekHelp(self._activityId, helpType)
end

function KnowledgeAnswerView:_onClickSelectZone(id)
	if self._curSelectId ~= id and self._isTimeCanAnswer == true then
		self._curSelectId = id

		local optionId = checknumber(self._curSelectId)

		if optionId == 0 then
			optionId = -1
		end

		KnowledgeAnswerController.instance:sendAnswer(self._activityId, self._curQuestionCfg.questionId, optionId)
	end

	if self._isTimeCanAnswer == true then
		self._mainPlayer.transform.position = uGuiUtil.GetTouchWorldPosition()
	end
end

function KnowledgeAnswerView:_onEnterRoom(info)
	self._activityId = info.activityId
	self._actCfg = KnowledgeAnswerConfig.instance:getActivityCfgById(self._activityId)
	self._helpCfg1 = KnowledgeAnswerConfig.instance:getHelpCfgByType(self._activityId, 1)
	self._helpCfg2 = KnowledgeAnswerConfig.instance:getHelpCfgByType(self._activityId, 2)
	self._txtNameHelp1.text = self._helpCfg1.name
	self._txtNameHelp2.text = self._helpCfg2.name

	goutil.setActive(self._nodeResultCounting, false)
	goutil.setActive(self._nodeQuestion, false)
	goutil.setActive(self._nodeNextCounting, false)
	goutil.setActive(self._nodeNextCounting, true)

	self.nextQuestionTime = math.floor(info.nextQuestionTime / 1000)

	self:_onCountDownEnterRoom()
	settimer(1, self._onCountDownEnterRoom, self)

	local info = KnowledgeAnswerModel.instance:getBaseInfoByActId(self._activityId)
	local report = info.report

	self._txtScore.text = string.format("得分：%s", report.score)

	self:_onUpdateMemberInfo(info.members)
end

function KnowledgeAnswerView:_onCountDownEnterRoom()
	local remainTime = self.nextQuestionTime - ServerTime.now()

	self._imgNumNextCount:SetNum(math.max(remainTime, 0))
end

function KnowledgeAnswerView:_onRefreshPuzzle(msg)
	removetimer(self._onCountDownWait, self)
	removetimer(self._onCountDownEnterRoom, self)
	goutil.setActive(self._nodeResultCounting, false)
	goutil.setActive(self._nodeQuestion, false)
	goutil.setActive(self._nodeNextCounting, false)
	goutil.setActive(self._nodeQuestion, true)
	goutil.setActive(self._wrong, false)
	goutil.setActive(self._bingo, false)

	local info = GameUtil.pbToTable(msg)
	local questionId = info.questionId

	self.answerTime = math.floor(info.answerTime / 1000) + self._actCfg.playerQuestionTime - 1
	self.refreshTime = math.floor(info.answerTime / 1000) + self._actCfg.questionInterval
	self._isUseTipsHelp = false
	self._isUseExceptErrorHelp = false

	self:_updateHelpPart()

	self._curExistResult = false
	self._isTimeCanAnswer = true

	local optionId = checknumber(self._curSelectId)

	if optionId == 0 then
		optionId = -1
	end

	self:_onCountDownAnswer()
	settimer(1, self._onCountDownAnswer, self)

	self._curQuestionCfg = KnowledgeAnswerConfig.instance:getQuestionCfgById(self._activityId, questionId)
	self._txtQuestion.text = self._curQuestionCfg.question
	self._txtDescTipHelp2.text = self._curQuestionCfg.helpTips

	for i = 1, 4 do
		local itemCell = self._answerItems[i]
		local key = "option" .. i

		itemCell.txtAnswer.text = self._curQuestionCfg[key]

		goutil.setActive(itemCell.go, true)
		goutil.setActive(itemCell.right, false)
		goutil.setActive(itemCell.error, false)
		goutil.setActive(itemCell.select, false)
	end

	goutil.setActive(self._bingo, false)
	goutil.setActive(self._wrong, false)

	local correctKey = "option" .. self._curQuestionCfg.correctOptionId

	self._txtWrong.text = string.format("正确答案：%s", self._curQuestionCfg[correctKey])
	self._txtBingo.text = string.format("+%s分", self._actCfg.addScore)

	self:_onUpdateMemberInfo(info.members)

	if not self._isLastPuzzle then
		KnowledgeAnswerController.instance:sendAnswer(self._activityId, self._curQuestionCfg.questionId, -1)
	end

	GameUtil.setAnchoredPos(self._mainPlayer, 0, -30)

	for i, memberGo in ipairs(self._memberGoList) do
		goutil.setActive(memberGo, false)

		local parent = self._zonelist[0].playersCon

		goutil.addChildToParent(memberGo, parent)
		GameUtil.setAnchoredPos(memberGo, Mathf.Random(-60, 60), Mathf.Random(-100, 10))
		goutil.setActive(memberGo, true)
	end
end

function KnowledgeAnswerView:_onCountDownAnswer()
	local remainTime = self.answerTime - ServerTime.now()

	goutil.setActive(self._imgDowncountAnswer.gameObject, true)
	self._imgDowncountAnswer:SetNum(math.max(remainTime, 0))

	if remainTime < 0 then
		self:_onWaitNextPuzzles()
		self:_checkOpenTime()
	end
end

function KnowledgeAnswerView:_onWaitNextPuzzles()
	removetimer(self._onCountDownAnswer, self)
	goutil.setActive(self._nodeResultCounting, false)
	goutil.setActive(self._nodeQuestion, true)
	goutil.setActive(self._nodeNextCounting, false)
	goutil.setActive(self._nodeResultCounting, true)
	goutil.setActive(self._imgDowncountAnswer.gameObject, false)

	self._isTimeCanAnswer = false

	self:_onCountDownWait()
	settimer(1, self._onCountDownWait, self)

	local correctId = self._curQuestionCfg.correctOptionId

	for i = 1, 4 do
		local itemCell = self._answerItems[i]

		goutil.setActive(itemCell.right, i == correctId)
		goutil.setActive(itemCell.error, i ~= correctId)
	end
end

function KnowledgeAnswerView:_onCountDownWait()
	local remainTime = self.refreshTime - ServerTime.now()

	self._txtNextTime.text = string.format("下一题:%d秒", math.max(remainTime, 0))

	if remainTime < 0 then
		self:_checkOpenTime()
	end
end

function KnowledgeAnswerView:_onSettlementLastPuzzle(msg)
	self._isLastPuzzle = false
	self._curExistResult = true

	local info = GameUtil.pbToTable(msg)
	local report = info.report

	self._txtScore.text = string.format("得分：%s", report.score)

	goutil.setActive(self._bingo, info.right)
	goutil.setActive(self._wrong, not info.right)
	goutil.setActive(self._nodeQuestion, true)

	local correctId = self._curQuestionCfg.correctOptionId

	for i = 1, 4 do
		local itemCell = self._answerItems[i]

		goutil.setActive(itemCell.right, i == correctId)
		goutil.setActive(itemCell.error, i ~= correctId)
	end

	self._isLastPuzzle = info.isLast or info.isFinish

	removetimer(self._doSettleAni, self)
	settimer(3, self._doSettleAni, self, false)
end

function KnowledgeAnswerView:_doSettleAni()
	goutil.setActive(self._bingo, false)
	goutil.setActive(self._wrong, false)
	goutil.setActive(self._nodeQuestion, false)

	if self._isLastPuzzle then
		removetimer(self._onCountDownEnterRoom, self)
		removetimer(self._onCountDownAnswer, self)
		removetimer(self._onCountDownWait, self)
		removetimer(self._doSettleAni, self)
		TipsFacade.instance:openTipWindowNoX("提示", "今日考核已结束", function()
			self:_onClickClose()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)
	end
end

function KnowledgeAnswerView:_onUpdateMemberInfo(members)
	self._memberGoList = self._memberGoList or {}

	for i, memberGo in ipairs(self._memberGoList) do
		goutil.setActive(memberGo, false)
	end

	local curMembers = members or {}

	for i, memberInfo in ipairs(curMembers) do
		if memberInfo.userId ~= RoleModel.instance:getUserId() then
			self:_updateMemberInfo(i, memberInfo)
		end
	end

	local addNums = self._actCfg.playerLimit - #curMembers

	if addNums > 0 then
		for i = 1, addNums do
			local fakeData = {
				headFrameId = 1,
				headIconId = 1,
				optionId = Mathf.Random(0, 4)
			}

			self:_updateMemberInfo(i + #curMembers, fakeData)
		end
	end
end

function KnowledgeAnswerView:_updateMemberInfo(id, memberInfo)
	self._memberGoList = self._memberGoList or {}

	if not self._memberGoList[id] then
		local memberGo = goutil.cloneAndSetParent(self._player, self.mainGO.transform)

		table.insert(self._memberGoList, memberGo)

		local head = goutil.findChild(memberGo, "head")

		HeadItemController.instance:resetHeadCell(head)
		HeadItemController.instance:resetHeadCell(memberGo)
		HeadItemController.instance:setHeadCell(head, memberInfo.headIconId, memberInfo.headFrameId)

		local posId = memberInfo.optionId

		if posId == -1 then
			posId = 0
		end

		local parent = self._zonelist[posId].playersCon

		goutil.addChildToParent(memberGo, parent)
		GameUtil.setAnchoredPos(memberGo, Mathf.Random(-60, 60), Mathf.Random(-100, 10))
		goutil.setActive(memberGo, true)
	end
end

function KnowledgeAnswerView:_onSeekHelp(msg)
	local info = GameUtil.pbToTable(msg)
	local type = info.type

	if type == 2 then
		self._isUseTipsHelp = true
	elseif type == 1 then
		self._isUseExceptErrorHelp = true

		local rmErrorId = Mathf.Random(1, 3)
		local checkId = 0

		for i = 1, 4 do
			if i ~= self._curQuestionCfg.correctOptionId then
				checkId = checkId + 1
			end

			if checkId == rmErrorId then
				goutil.setActive(self._answerItems[i].right, false)
				goutil.setActive(self._answerItems[i].error, true)

				break
			end
		end
	end

	self:_updateHelpPart()
end

function KnowledgeAnswerView:_updateHelpPart()
	goutil.setActive(self._tipHelp2, self._isUseTipsHelp)

	self._txtNumHelp1.text = KnowledgeAnswerModel.instance:getRemainingHelpTimes(self._activityId, 1)
	self._txtNumHelp2.text = KnowledgeAnswerModel.instance:getRemainingHelpTimes(self._activityId, 2)
end

function KnowledgeAnswerView:_onSendAnswer(msg)
	local info = GameUtil.pbToTable(msg)
	local optionId = info.optionId

	for i = 1, 4 do
		local itemCell = self._answerItems[i]

		goutil.setActive(itemCell.select, i == optionId)
	end
end

function KnowledgeAnswerView:_checkOpenTime()
	local startTime = self._actCfg.startTime
	local endTime = self._actCfg.endTime

	if not GameUtil.checkIsInTimePeriod(startTime, endTime, true) then
		removetimer(self._onCountDownAnswer, self)
		removetimer(self._onCountDownWait, self)
		TipsFacade.instance:openTipWindowNoX("提示", string.format("每日开放时间：%s - %s", startTime, endTime), function()
			self:_onClickClose()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)
	end
end

return KnowledgeAnswerView
