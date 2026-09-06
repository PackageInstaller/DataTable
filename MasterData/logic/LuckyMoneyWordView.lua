-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckymoney/view/LuckyMoneyWordView.lua

module("logic.extensions.luckymoney.view.LuckyMoneyWordView", package.seeall)

local LuckyMoneyWordView = class("LuckyMoneyWordView", ViewComponent)

LuckyMoneyWordView.LUCKY_MONEY_KEY = "LUCKY_MONEY_KEY_"
LuckyMoneyWordView.LUCKY_MONEY_KEY_SELECT_WORD = "LUCKY_MONEY_KEY_SELECT_WORD_"

function LuckyMoneyWordView:ctor()
	LuckyMoneyWordView.super.ctor(self)
end

function LuckyMoneyWordView:buildUI()
	LuckyMoneyWordView.super.buildUI(self)

	self._cell = self:getGo("cell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnWish = self:getGo("btnWish")
	self._btnClose = self:getGo("btnClose")
end

function LuckyMoneyWordView:bindEvents()
	LuckyMoneyWordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnWish, self._onClickBtnWish, self)
end

function LuckyMoneyWordView:unbindEvents()
	LuckyMoneyWordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnWish)
end

function LuckyMoneyWordView:onEnter()
	LuckyMoneyWordView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = LuckyMoneyController.instance:getActivityId()
	end

	self._choosePetId = LuckyMoneyModel.instance:getChoosePetId(self._activityId)
	self._selectWordIdx = 0
	self._wordCfg = LuckyMoneyConfig.instance:getLuckyMoneyWordData(self._activityId)
	self._selectWord = false

	self:_updateUI()
end

function LuckyMoneyWordView:onExit()
	LuckyMoneyWordView.super.onExit(self)
	self._scrollList:dispose()
end

function LuckyMoneyWordView:_updateUI()
	self._scrollList:reloadData(self._wordCfg)
	self._scrollList:MoveCellToCenter(self._selectWordIdx)
end

function LuckyMoneyWordView:_updateCell(view, cell, data)
	local selectGo = goutil.findChild(cell, "selectGo")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	txtDesc.text = data.word

	GameUtil.SetActive(selectGo, data.id == self._selectWordIdx)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, data.id), self)
end

function LuckyMoneyWordView:_clearCell(cell)
	GameUtil.rmClickHandler(cell)
end

function LuckyMoneyWordView:_onClickCell(idx)
	self._selectWordIdx = idx
	self._selectWord = true

	self:_updateUI()
end

function LuckyMoneyWordView:_onClickBtnWish()
	if not self._selectWord then
		FloatWordMgr.instance:show("还未选择寄语，请先选择寄语")

		return
	end

	local key = LuckyMoneyWordView.LUCKY_MONEY_KEY .. self._activityId
	local keySelectWord = LuckyMoneyWordView.LUCKY_MONEY_KEY_SELECT_WORD .. self._activityId

	GameUtil.saveUserData(key, self._choosePetId)
	GameUtil.saveUserData(keySelectWord, self._selectWordIdx)
	LuckyMoneyModel.instance:setChoosePetId(self._activityId, self._choosePetId)
	LuckyMoneyModel.instance:setSelectWordId(self._activityId, self._selectWordIdx)
	UIStateManager.instance:push(ViewName.CatchPropsGameView, self._choosePetId)
	CatchPropsController.instance:startCatchPropsGame()
	self:close()
end

return LuckyMoneyWordView
