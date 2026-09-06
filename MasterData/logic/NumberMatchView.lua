-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberMatchView.lua

module("logic.extensions.numberbomb.view.NumberMatchView", package.seeall)

local NumberMatchView = class("NumberMatchView", ViewComponent)

function NumberMatchView:ctor()
	NumberMatchView.super.ctor(self)

	self._isSendMsg = false
	self._waitTime = 2
	self._sussTime = 0
end

function NumberMatchView:bindEvents()
	NumberMatchView.super.bindEvents(self)
	self._cancleBtn:AddClickListener(self._onClickCancleBtn, self)
end

function NumberMatchView:unbindEvents()
	NumberMatchView.super.unbindEvents(self)
	self._cancleBtn:RemoveClickListener()
end

function NumberMatchView:onExit()
	NumberMatchView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.NumberGameMatch, self._updataGameMatchState, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataPlayerGameInfo, self._startNumberGame, self)
end

function NumberMatchView:destroyUI()
	NumberMatchView.super.destroyUI(self)
end

function NumberMatchView:buildUI()
	NumberMatchView.super.buildUI(self)

	self._cancleBtn = self:getBtn("cancleBtn")
	self._cancleTxt = goutil.findChildTextComponent(self.mainGO, "cancleBtn/cancleTxt")
	self._supTimeTxt = goutil.findChildTextComponent(self.mainGO, "supTimeTxt")
end

function NumberMatchView:onEnter()
	NumberMatchView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.NumberGameMatch, self._updataGameMatchState, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataPlayerGameInfo, self._startNumberGame, self)

	local commonInfo = NumberGameConfig.instance:getCommonInfo()

	self._timer = commonInfo.matchTime
	self._supTimeTxt.text = "00：" .. self._timer
	self._waitTime = 2
	self._sussTime = 0
	self._cancleTxt.text = "取消匹配"

	settimer(1, self._calculationSurplusTime, self, true)

	local effPath = "fx_ui_zdsz/fx_ui_zdsz_pipei.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function NumberMatchView:_onClickCancleBtn()
	if self._sussTime > 0 then
		return
	end

	if not self._isSendMsg then
		removetimer(self._calculationSurplusTime, self)
		self:_updataGameMatchState(2)

		return
	end

	NumberGameController.instance:csCancelMatchGameReq()
end

function NumberMatchView:_calculationSurplusTime()
	self._timer = self._timer - 1

	if self._timer <= 0 then
		self._supTimeTxt.text = "未匹配到玩家"

		if self._timer < 0 then
			removetimer(self._calculationSurplusTime, self)
			self:_updataGameMatchState(3)
			NumberGameController.instance:csCancelMatchGameReq(true)
		end

		return
	end

	self._supTimeTxt.text = "00：" .. self._timer

	if self._waitTime > 0 then
		self._waitTime = self._waitTime - 1

		if self._waitTime <= 0 then
			NumberGameController.instance:csBeginMatchGameReq()
		end
	end

	if self._sussTime > 0 then
		self._sussTime = self._sussTime - 1

		if self._sussTime <= 0 then
			self:close()
			UIStateManager.instance:push(ViewName.NumberGame)
		end
	end
end

function NumberMatchView:_updataGameMatchState(state)
	state = checknumber(state)

	if state == 1 then
		self._isSendMsg = true
	elseif state == 2 then
		FloatWordMgr.instance:show("取消匹配")
		self:close()
	else
		FloatWordMgr.instance:show("匹配失败")
		self:close()
	end
end

function NumberMatchView:_startNumberGame(opType, sortIndex, param)
	if opType == nil or sortIndex == nil then
		self._sussTime = 2
		self._cancleTxt.text = "匹配成功"

		print("sr---炸弹数字 NumberMatchView:_startNumberGame()       游戏开始！")

		local callBack = NumberGameModel.instance:getFinishCallBack(NumberGameModel.CallBackTypes_MathSuccess)

		GameUtil.callBack(callBack)
	end
end

return NumberMatchView
