-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaFailSimpleView.lua

module("logic.extensions.funarena.view.FunArenaFailSimpleView", package.seeall)

local FunArenaFailSimpleView = class("FunArenaFailSimpleView", ViewComponent)

function FunArenaFailSimpleView:ctor()
	FunArenaFailSimpleView.super.ctor(self)
end

function FunArenaFailSimpleView:buildUI()
	FunArenaFailSimpleView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "top/btnClose")
	self._imgTip = goutil.findChild(self.mainGO, "imgTip")
	self._result_1 = goutil.findChild(self.mainGO, "result_1")
	self._txtWinNum_1 = goutil.findChildTextComponent(self.mainGO, "result_1/winNum/txt")
	self._txtFailNum_1 = goutil.findChildTextComponent(self.mainGO, "result_1/failNum/txt")
	self._result_2 = goutil.findChild(self.mainGO, "result_2")
	self._txtWinNum_2 = goutil.findChildTextComponent(self.mainGO, "result_2/winNum/txt")
	self._txtFailNum_2 = goutil.findChildTextComponent(self.mainGO, "result_2/failNum/txt")
	self._icon = goutil.findChild(self.mainGO, "result_2/item/icon")
	self._txtItemNum = goutil.findChildTextComponent(self.mainGO, "result_2/item/txtNum")
end

function FunArenaFailSimpleView:bindEvents()
	FunArenaFailSimpleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._imgTip, self._onClickDoubleExit, self)
end

function FunArenaFailSimpleView:unbindEvents()
	FunArenaFailSimpleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._imgTip)
end

function FunArenaFailSimpleView:onEnter()
	FunArenaFailSimpleView.super.onEnter(self)

	self._activityId = FunArenaModel.instance.activityId
	self._challengeCfg = FunArenaConfig.instance:getChallengeCfgById(self._activityId)

	if self._activityId == 0 or self._challengeCfg == nil then
		self:_onClickBtnClose()

		return
	end

	self._clickNum = 0

	self:_onUpdateUI()
end

function FunArenaFailSimpleView:onExit()
	FunArenaFailSimpleView.super.onExit(self)
end

function FunArenaFailSimpleView:_onClickBtnClose()
	local params = self:getOpenParam()

	if params == nil then
		self:close()

		return
	end

	local func = params[1]

	self:close()

	if func ~= nil and type(func) == "function" then
		func()
	end
end

function FunArenaFailSimpleView:_onClickDoubleExit()
	self._clickNum = self._clickNum + 1

	if self._clickNum >= 2 then
		self._clickNum = 0

		self:_onClickBtnClose()
	end
end

function FunArenaFailSimpleView:_onUpdateUI()
	local succNum = FunArenaController.instance:getCurSuccessNum()
	local failNum = FunArenaController.instance:getCurFailNum()
	local totalNum = self._challengeCfg.failWhenLoseTimes

	if self._txtWinNum_1 then
		self._txtWinNum_1.text = langPara("FunArena_FailSimpleView_Tips_1", succNum)
	end

	if self._txtWinNum_2 then
		self._txtWinNum_2.text = langPara("FunArena_FailSimpleView_Tips_1", succNum)
	end

	if self._txtFailNum_1 then
		self._txtFailNum_1.text = langPara("FunArena_FailSimpleView_Tips_2", "#FF5C00", failNum, totalNum)
	end

	if self._txtFailNum_2 then
		self._txtFailNum_2.text = langPara("FunArena_FailSimpleView_Tips_2", "#FF5C00", failNum, totalNum)
	end

	if self._icon then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/icon/items/%s.png", self._challengeCfg.res)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(self._icon, spriteType, spriteName, func)
	end

	if self._txtItemNum then
		local winGainLotteryScore = self._challengeCfg.winGainLotteryScore
		local num = succNum * winGainLotteryScore

		self._txtItemNum.text = "x" .. num
	end

	local isHasOutLimitFail = FunArenaController.instance:isHasOutLimitFail()
	local isHasOutLimitChallenge = FunArenaController:isHasOutLimitChallenge()
	local isHasFinishOneRound = FunArenaController.instance:isHasFinishOneRound()
	local isResultTwo = isHasOutLimitFail or isHasOutLimitChallenge or isHasFinishOneRound

	GameUtil.SetActive(self._result_1, not isResultTwo)
	GameUtil.SetActive(self._result_2, isResultTwo)
end

return FunArenaFailSimpleView
