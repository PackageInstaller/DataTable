-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkAnswerGame\\AmusementParkAnswerGameModule.lua

local m = {
	answerErrorTime = 0,
	rightCount = 0,
	callBack = Queue.New()
}
local AmusementParkAnswerQuestionData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkAnswerGame.AmusementParkAnswerQuestionData")

function m.Reload()
	m.callBack = Queue.New()

	m.AddListeners()
end

function m.InitData()
	if AmusementParkModule.GlobalCid > 0 then
		m.cfgAnswerControlData = CfgAmusementParkAnswerControlTable[AmusementParkModule.GlobalCid]
	end
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.CreateQuestion()
	m.answerQuestionData = nil

	if m.rightCount < #m.cfgAnswerControlData.QuestionBank then
		local nextQuestion = m.cfgAnswerControlData.QuestionBank[m.rightCount + 1]

		m.answerQuestionData = AmusementParkAnswerQuestionData.New(nextQuestion)
	end
end

function m.GetCoolDownTime()
	local cd = math.floor(m.cfgAnswerControlData.CoolDownTime - (PlayerModule.GetServerTime() - m.answerErrorTime))

	return cd
end

function m.StartAnswerGame()
	m.AnswerInfo(function()
		UIModule.Open(Constant.UIControllerName.AmusementParkGameAnswerUI, Constant.UILayer.UI)
	end)
end

function m.Shutdown()
	m.RemoveListeners()
	m.callBack:Clear()

	m.answerQuestionData = nil
end

function m.AnswerInfo(callBack)
	if callBack then
		m.callBack:Enqueue(callBack)
	end

	net_amusementPark.answerInfo()
end

function m.Answer(option)
	local status = false

	if option then
		status = option.isRightOption
		m.answerQuestionData.playerSelectID = option.id
	end

	if status then
		net_amusementPark.answer(m.answerQuestionData.cid)
	else
		NoticeModule.ShowNotice(21045115)

		m.answerErrorTime = PlayerModule.GetServerTime()

		EventDispatcher.Dispatch(EventID.APUpdateAnswerGameEvent)
	end
end

function m.AnswerInfoResult(score)
	m.rightCount = score

	m.CreateQuestion()

	if m.callBack.Size > 0 then
		local callBack = m.callBack:Dequeue()

		callBack()
	end
end

function m.AnswerResult(score, items)
	m.rightCount = score

	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end

	m.answerQuestionData:SetQuestionState(true)
	AmusementParkModule.GetLittleGameInfo()
	EventDispatcher.Dispatch(EventID.APUpdateAnswerGameEvent)
end

AmusementParkAnswerGameModule = m
