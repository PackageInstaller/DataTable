-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeRankMainView.lua

module("logic.extensions.luyngarde.view.LuyngardeRankMainView", package.seeall)

local LuyngardeRankMainView = class("LuyngardeRankMainView", TabFrameWorkMainView)

function LuyngardeRankMainView:ctor()
	LuyngardeRankMainView.super.ctor(self)
end

function LuyngardeRankMainView:unbindEvents()
	LuyngardeRankMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPrize)
end

function LuyngardeRankMainView:bindEvents()
	LuyngardeRankMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
end

function LuyngardeRankMainView:buildUI()
	LuyngardeRankMainView.super.buildUI(self)

	self._btnPrize = self:getGo("btnPrize")
	self._redPoint = self:getGo("btnPrize/redPoint")
end

function LuyngardeRankMainView:onExit()
	LuyngardeRankMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPoint)
end

function LuyngardeRankMainView:onEnter()
	LuyngardeRankMainView.super.onEnter(self)
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_Luyngarde_AreaKill_Prize)
end

function LuyngardeRankMainView:_getFrameId()
	return 14
end

function LuyngardeRankMainView:_clickHeadTabCell(headTabIndex)
	local headInfo = self:_getHeadTabViewInfo(headTabIndex)

	if not headInfo.isUnlock then
		FloatWordMgr.instance:show(self:_getHeadTabLockTips(headTabIndex))

		return
	end

	self:_trySetRed(headInfo.data.headTabId)

	if self._curHeadTabIndex == headTabIndex then
		self:_setSpread(headTabIndex, not headInfo.isSpread)
		self:_onUpdateTabColUI()
	else
		self:_setSpread(self._curHeadTabIndex, false)

		self._curHeadTabIndex = headTabIndex

		self:_setSpread(headTabIndex, true)

		self._curSecTabIndex = 1

		if self:_getSecTabTabCount(headTabIndex) <= 0 then
			self._curSecTabIndex = 0
		end

		self:_onUpdateUI()
	end
end

function LuyngardeRankMainView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.LuyngardePrizeMainView, 466001, 1, 1)
end

function LuyngardeRankMainView:_updateSecTabCell(mainGo, headTabIndex, secTabIndex)
	LuyngardeRankMainView.super._updateSecTabCell(self, mainGo, headTabIndex, secTabIndex)

	local onlyselect = goutil.findChild(mainGo, "onlyselect")

	GameUtil.SetActive(onlyselect, self._curHeadTabIndex == headTabIndex and self._curSecTabIndex == secTabIndex)
end

return LuyngardeRankMainView
