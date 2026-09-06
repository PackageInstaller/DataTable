-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaSuccessView.lua

module("logic.extensions.funarena.view.FunArenaSuccessView", package.seeall)

local FunArenaSuccessView = class("FunArenaSuccessView", ViewComponent)

function FunArenaSuccessView:ctor()
	FunArenaSuccessView.super.ctor(self)
end

function FunArenaSuccessView:buildUI()
	FunArenaSuccessView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "top/btnClose")
	self._imgTip = goutil.findChild(self.mainGO, "imgTip")
	self._icon = goutil.findChild(self.mainGO, "item/icon")
	self._txtItemNum = goutil.findChildTextComponent(self.mainGO, "item/txtNum")
	self._txtWinNum = goutil.findChildTextComponent(self.mainGO, "winNum/txt")
	self._txtFailNum = goutil.findChildTextComponent(self.mainGO, "failNum/txt")
end

function FunArenaSuccessView:bindEvents()
	FunArenaSuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._imgTip, self._onClickDoubleExit, self)
end

function FunArenaSuccessView:unbindEvents()
	FunArenaSuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._imgTip)
end

function FunArenaSuccessView:onEnter()
	FunArenaSuccessView.super.onEnter(self)

	self._activityId = FunArenaModel.instance.activityId
	self._challengeCfg = FunArenaConfig.instance:getChallengeCfgById(self._activityId)

	if self._activityId == 0 or self._challengeCfg == nil then
		self:_onClickBtnClose()

		return
	end

	self._clickNum = 0

	self:_onUpdateUI()
end

function FunArenaSuccessView:onExit()
	FunArenaSuccessView.super.onExit(self)
end

function FunArenaSuccessView:_onClickBtnClose()
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

function FunArenaSuccessView:_onClickDoubleExit()
	self._clickNum = self._clickNum + 1

	if self._clickNum >= 2 then
		self._clickNum = 0

		self:_onClickBtnClose()
	end
end

function FunArenaSuccessView:_onUpdateUI()
	local succNum = FunArenaController.instance:getCurSuccessNum()
	local failNum = FunArenaController.instance:getCurFailNum()
	local totalNum = self._challengeCfg.failWhenLoseTimes

	if self._txtWinNum then
		self._txtWinNum.text = langPara("FunArena_FailSimpleView_Tips_1", succNum)
	end

	if self._txtFailNum then
		self._txtFailNum.text = langPara("FunArena_SuccessView_Tips_1", failNum, totalNum)
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
		local num = self._challengeCfg.winGainLotteryScore

		self._txtItemNum.text = "x" .. num
	end
end

return FunArenaSuccessView
