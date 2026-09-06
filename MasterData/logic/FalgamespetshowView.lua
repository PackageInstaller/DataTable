-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalgamespetshowView.lua

module("logic.extensions.landlords.view.FalgamespetshowView", package.seeall)

local FalgamespetshowView = class("FalgamespetshowView", ViewComponent)

function FalgamespetshowView:ctor()
	FalgamespetshowView.super.ctor(self)
end

function FalgamespetshowView:unbindEvents()
	FalgamespetshowView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function FalgamespetshowView:bindEvents()
	FalgamespetshowView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function FalgamespetshowView:buildUI()
	FalgamespetshowView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("txtTime")
end

function FalgamespetshowView:onExit()
	FalgamespetshowView.super.onExit(self)
	self._scrollerList:dispose()
	removetimer(self._tickTime, self)
end

function FalgamespetshowView:onEnter()
	FalgamespetshowView.super.onEnter(self)

	self._isFirstEnter = self:getFirstParam()
	self._autoClose = self._isFirstEnter

	local gameMo = FightAgainstLandlordsController.instance:getFalGameMo()

	self._creepsIds = gameMo:getAllCreepsIds()

	self:_updateUI()

	self._canCloseTime = ServerTime.now()

	if self._isFirstEnter then
		settimer(1, self._tickTime, self, true)

		self._canCloseTime = ServerTime.now() + 10
	end

	self:_tickTime()
end

function FalgamespetshowView:_updateUI()
	self._scrollerList:reloadData(self._creepsIds)
end

function FalgamespetshowView:_updateCell(view, cell, creepsId, tag)
	local creepsCfg = FightAgainstLandlordsConfig.instance:getFalCreepsData(creepsId)
	local faceId = checknumber(creepsCfg.faceId)
	local skinId = faceId > 0 and faceId or creepsCfg.raceId

	MaterialMgr.setCell(MatType.Pet, skinId, cell.gameObject)
end

function FalgamespetshowView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function FalgamespetshowView:_onClickbtnClose()
	local now = ServerTime.now()
	local leftTime = self._canCloseTime - now

	if leftTime > 0 then
		FloatWordMgr.instance:show("展示中")

		return
	end

	self:close()
end

function FalgamespetshowView:_tickTime()
	local now = ServerTime.now()
	local leftTime = self._canCloseTime - now

	if leftTime > 0 then
		self._txtTime.text = string.format("展示倒计时：%s", leftTime)
	else
		if self._autoClose then
			self:close()
		end

		self._txtTime.text = ""

		removetimer(self._tickTime, self)
	end
end

return FalgamespetshowView
