-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraiderdiceView.lua

module("logic.extensions.treasureraider.view.TreasureraiderdiceView", package.seeall)

local TreasureraiderdiceView = class("TreasureraiderdiceView", ViewComponent)

function TreasureraiderdiceView:buildUI()
	TreasureraiderdiceView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._choseCells = {}

	for i = 1, 6 do
		local cell = {}

		cell.go = self:getGo("choseCells/cell_" .. i)
		cell.select = goutil.findChild(cell.go, "select")
		self._choseCells[i] = cell
	end
end

function TreasureraiderdiceView:bindEvents()
	TreasureraiderdiceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)

	for i = 1, 6 do
		GameUtil.addClickHandler(self._choseCells[i].go, GameUtil.handler(self._onClickChoseCell, self, i))
	end
end

function TreasureraiderdiceView:unbindEvents()
	TreasureraiderdiceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)

	for i = 1, 4 do
		GameUtil.rmClickHandler(self._choseCells[i].go)
	end
end

function TreasureraiderdiceView:onEnter()
	TreasureraiderdiceView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureRaiderPlayDice, self.close, self)

	self._curSelectId = 0

	self:_onClickChoseCell(1)
end

function TreasureraiderdiceView:onExit()
	TreasureraiderdiceView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureRaiderPlayDice, self.close, self)
end

function TreasureraiderdiceView:_onClickSure()
	local myPlayerMo = TreasureRaiderModel.instance:getCurSceneMo().myPlayerMo
	local remainCount = myPlayerMo:getFixDiceCountRemain()

	if remainCount > 0 then
		TreasureRaiderController.instance:tryFixMove(self._curSelectId)
	else
		FloatWordMgr.instance:show(lang("固定骰子的次数已用完"))
	end
end

function TreasureraiderdiceView:_onClickChoseCell(id)
	self._curSelectId = id

	for i = 1, 6 do
		goutil.setActive(self._choseCells[i].select, self._curSelectId == i)
	end
end

return TreasureraiderdiceView
