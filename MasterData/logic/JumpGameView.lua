-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpGameView.lua

module("logic.extensions.jumpgame.view.JumpGameView", package.seeall)

local JumpGameView = class("JumpGameView", ViewComponent)

function JumpGameView:ctor()
	JumpGameView.super.ctor(self)
end

function JumpGameView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	GlobalDispatcher:addListener(GlobalNotify.JumpItemVisible, self._onUpdateCollect, self)
	GlobalDispatcher:addListener(GlobalNotify.JumpPause, self._onPause, self)
end

function JumpGameView:unbindEvents()
	self._closeButton:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.JumpItemVisible, self._onUpdateCollect, self)
	GlobalDispatcher:removeListener(GlobalNotify.JumpPause, self._onPause, self)
end

function JumpGameView:buildUI()
	self._closeButton = self:getBtn("Btn_Close")
	self._txtTip = self:getGo("imgScore/Txt_Tip"):GetComponent(goutil.Type_UIText)
	self._Txt_targetNum = self:getGo("imgScore/Txt_Num"):GetComponent(goutil.Type_UIText)
	self._Txt_Time = self:getGo("imgTitle/Txt_Time"):GetComponent(goutil.Type_UIText)
	self._Txt_Count = self:getGo("Txt_Count/imgTime"):GetComponent("UIImageSpriteChange")
	self._imgType = self:getGo("imgScore/img"):GetComponent("UIImageSpriteChange")
end

function JumpGameView:destroyUI()
	return
end

function JumpGameView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.ChallengeTeamExtOperationRes, self._onChallengeTeamExtOperationRes, self)
	self:getGo("Txt_Count").gameObject:SetActive(false)

	self._pause = false
	self._countTime = JumpGameConfig.instance:getGameInfoCfgByKey("countTime")
	self._Txt_Time.text = "剩余时间：" .. self._countTime
	self._Txt_targetNum.text = JumpGameModel.instance:returnCollect()
	self.gameType = JumpGameModel.instance:getInitCollectParams()[1]

	JumpGameModel.instance:setGameType(self.gameType)

	if self.gameType == 1 then
		self._imgType:ChangeStateNow(self.gameType - 1)
	elseif self.gameType == 2 then
		self._imgType:ChangeStateNow(self.gameType - 1)
	end

	local desc = {
		"梅花之证",
		"八卦之证"
	}

	self._txtTip.text = langPara("本次游戏\n共获得\n%s", desc[self.gameType])

	self:_deductGameTimes()
end

function JumpGameView:onEnterFinished()
	return
end

function JumpGameView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.ChallengeTeamExtOperationRes, self._onChallengeTeamExtOperationRes, self)
	JumpGameModel.instance:onReset()
	removetimer(self._onStartCountDown, self)
	removetimer(self._onCountDown, self)
end

function JumpGameView:onExitFinished()
	return
end

function JumpGameView:_onClickClose()
	self._pause = true

	UIStateManager.instance:open("jumpResultView", false, JumpGameModel.instance:getInitCollectParams(), GameUtil.handler(self.close, self))
end

function JumpGameView:_onUpdateCollect()
	self._Txt_targetNum.text = JumpGameModel.instance:returnCollect()
end

function JumpGameView:_onCountDown()
	if JumpGameModel.instance:isOver() then
		return nil
	end

	if self._pause == true then
		return nil
	end

	self._countTime = self._countTime - 1
	self._Txt_Time.text = "剩余时间：" .. self._countTime

	if self._countTime == 0 then
		JumpGameModel.instance:gameOver()
		UIStateManager.instance:open("jumpResultView", true, JumpGameModel.instance:getInitCollectParams(), GameUtil.handler(self.close, self))
		removetimer(self._onCountDown, self)
	end
end

function JumpGameView:_onStartCountDown()
	self._startCountTime = self._startCountTime - 1

	if self._startCountTime > 0 then
		self._Txt_Count:ChangeStateNow(self._startCountTime - 1)
	end

	if self._startCountTime == 0 then
		self:getGo("Txt_Count").gameObject:SetActive(false)
		removetimer(self._onStartCountDown, self)
		settimer(1, self._onCountDown, self)
	end
end

function JumpGameView:_onPause(pause)
	self._pause = pause
end

function JumpGameView:_deductGameTimes()
	local reqExtParams = "{\"starGame\":\"true\"}"

	ChallengeController.instance:extTeamOpt(ChallengeModel.instance:getCurId(), 3, "17_Accumulate", reqExtParams, nil)
end

function JumpGameView:_onChallengeTeamExtOperationRes()
	self._startCountTime = 3

	self:getGo("Txt_Count").gameObject:SetActive(true)
	self._Txt_Count:ChangeStateNow(self._startCountTime - 1)
	settimer(1, self._onStartCountDown, self)
end

return JumpGameView
