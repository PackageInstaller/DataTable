-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/Monthcard2025View.lua

module("logic.extensions.monthcard.view.Monthcard2025View", package.seeall)

local Monthcard2025View = class("Monthcard2025View", MonthcardView)

function Monthcard2025View:_getCardId()
	return MonthCardModel.MonthCardId2024
end

function Monthcard2025View:ctor()
	Monthcard2025View.super.ctor(self)
end

function Monthcard2025View:unbindEvents()
	Monthcard2025View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJump)
end

function Monthcard2025View:bindEvents()
	Monthcard2025View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJump, self._onClickBtnJump, self)
end

function Monthcard2025View:buildUI()
	Monthcard2025View.super.buildUI(self)

	self._btnJump = self:getGo("card/btnJump")
end

function Monthcard2025View:onEnter()
	Monthcard2025View.super.onEnter(self)
end

function Monthcard2025View:_updateView()
	Monthcard2025View.super._updateView(self)

	local canShowJump = self:canShowJump()

	GameUtil.SetActive(self._btnJump, canShowJump)
end

function Monthcard2025View:canShowJump()
	local cfg = MonthCardConfig.instance:getCfgByIndex(self.index)
	local canBuy = false

	if cfg then
		local isActive = MonthCardModel.instance:isCardActive(cfg.cardId)

		canBuy = isActive and MonthCardModel.instance:getActiveCardLeftTime(cfg.cardId) <= cfg.repeatBuyDay or true
	end

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SAINT_KNIGHT_MO)

	return not canBuy and (actCfg or nil) and true
end

function Monthcard2025View:_onClickBtnJump()
	GotoMgr.gotoByString("ui#preferentialview#22")
end

return Monthcard2025View
