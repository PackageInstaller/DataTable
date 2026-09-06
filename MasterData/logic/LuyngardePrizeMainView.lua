-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardePrizeMainView.lua

module("logic.extensions.luyngarde.view.LuyngardePrizeMainView", package.seeall)

local LuyngardePrizeMainView = class("LuyngardePrizeMainView", TabFrameWorkMainView)

function LuyngardePrizeMainView:ctor()
	LuyngardePrizeMainView.super.ctor(self)
end

function LuyngardePrizeMainView:unbindEvents()
	LuyngardePrizeMainView.super.unbindEvents(self)
end

function LuyngardePrizeMainView:bindEvents()
	LuyngardePrizeMainView.super.bindEvents(self)
end

function LuyngardePrizeMainView:buildUI()
	LuyngardePrizeMainView.super.buildUI(self)
end

function LuyngardePrizeMainView:onExit()
	LuyngardePrizeMainView.super.onExit(self)
end

function LuyngardePrizeMainView:onEnter()
	LuyngardePrizeMainView.super.onEnter(self)
end

function LuyngardePrizeMainView:_getFrameId()
	return 13
end

function LuyngardePrizeMainView:_clickHeadTabCell(headTabIndex)
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

function LuyngardePrizeMainView:_updateSecTabCell(mainGo, headTabIndex, secTabIndex)
	LuyngardePrizeMainView.super._updateSecTabCell(self, mainGo, headTabIndex, secTabIndex)

	local onlyselect = goutil.findChild(mainGo, "onlyselect")

	GameUtil.SetActive(onlyselect, self._curHeadTabIndex == headTabIndex and self._curSecTabIndex == secTabIndex)
end

return LuyngardePrizeMainView
