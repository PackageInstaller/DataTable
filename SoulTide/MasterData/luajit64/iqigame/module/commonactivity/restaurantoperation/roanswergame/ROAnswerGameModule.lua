-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROAnswerGame\\ROAnswerGameModule.lua

local m = {
	callBack = Queue.New()
}
local ROAnswerQuestionData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROAnswerGame.ROAnswerQuestionData")

function m.Reload()
	m.callBack = Queue.New()

	m.AddListeners()
end

function m.InitData()
	if RestaurantOperationModule.GlobalCid > 0 then
		m.cfgAnswerControlData = CfgRestaurantOperationAnswerControlTable[RestaurantOperationModule.GlobalCid]
	end
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.StartAnswerGame()
	m.GetProblem(false, function()
		UIModule.Open(Constant.UIControllerName.RestaurantGameAnswerUI, Constant.UILayer.UI)
	end)
end

function m.Shutdown()
	m.RemoveListeners()
	m.callBack:Clear()

	m.answerQuestionData = nil
end

function m.GetProblem(getNew, callBack)
	if callBack then
		m.callBack:Enqueue(callBack)
	end

	net_restaurant.getProblem(getNew)
end

function m.Answer(option)
	local status = false

	if option then
		status = option.isRightOption
		m.answerQuestionData.playerSelectID = option.id
	end

	log("上报答案.." .. tostring(status) .. " cid = " .. m.answerQuestionData.cid)
	net_restaurant.answer(status, m.answerQuestionData.cid)
end

function m.GetProblemResult(restaurantOperationQuestion)
	if m.answerQuestionData and m.answerQuestionData.cid == restaurantOperationQuestion.id then
		m.answerQuestionData.questionPOD = restaurantOperationQuestion
	else
		m.answerQuestionData = ROAnswerQuestionData.New(restaurantOperationQuestion.id, restaurantOperationQuestion)
	end

	if m.callBack.Size > 0 then
		local callBack = m.callBack:Dequeue()

		callBack()
	end
end

function m.AnswerResult(restaurantOperationQuestion, items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end

	if m.answerQuestionData and m.answerQuestionData.cid == restaurantOperationQuestion.id then
		m.answerQuestionData.questionPOD = restaurantOperationQuestion
	else
		m.answerQuestionData = ROAnswerQuestionData.New(restaurantOperationQuestion.id, restaurantOperationQuestion)
	end

	EventDispatcher.Dispatch(EventID.ROUpdateAnswerGameEvent)
end

ROAnswerGameModule = m
