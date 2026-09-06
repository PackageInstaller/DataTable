-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/view/ExploreUnderDiceView.lua

module("logic.extensions.exploreunder.view.ExploreUnderDiceView", package.seeall)

local ExploreUnderDiceView = class("ExploreUnderDiceView", ViewComponent)

function ExploreUnderDiceView:buildUI()
	ExploreUnderDiceView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._choseCells = {}

	for i = 1, 6 do
		local cell = {}

		cell.go = self:getGo("choseCells/cell_" .. i)
		cell.select = goutil.findChild(cell.go, "select")
		cell.txt = goutil.findChildTextComponent(cell.go, "txt")
		self._choseCells[i] = cell
	end
end

function ExploreUnderDiceView:bindEvents()
	ExploreUnderDiceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)

	for i = 1, 6 do
		GameUtil.addClickHandler(self._choseCells[i].go, GameUtil.handler(self._onClickChoseCell, self, i))
	end
end

function ExploreUnderDiceView:unbindEvents()
	ExploreUnderDiceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)

	for i = 1, 4 do
		GameUtil.rmClickHandler(self._choseCells[i].go)
	end
end

function ExploreUnderDiceView:onEnter()
	ExploreUnderDiceView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ExploreUnderPlayDice, self.close, self)

	self._curSelectId = 0

	for i = 1, 6 do
		self._choseCells[i].txt.text = langPara("剩余%s次", ExploreUnderModel.instance:getCurDiceLeftTime(i))
	end

	self:_onClickChoseCell(1)
end

function ExploreUnderDiceView:onExit()
	ExploreUnderDiceView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ExploreUnderPlayDice, self.close, self)
end

function ExploreUnderDiceView:_onClickSure()
	local curTimes = ExploreUnderModel.instance:getCurDiceLeftTime(self._curSelectId)

	if curTimes > 0 then
		ExploreUnderController.instance:dice(self._curSelectId)
	else
		FloatWordMgr.instance:show(lang("固定色子的次数已用完"))
	end
end

function ExploreUnderDiceView:_onClickChoseCell(id)
	self._curSelectId = id

	for i = 1, 6 do
		goutil.setActive(self._choseCells[i].select, self._curSelectId == i)
	end
end

return ExploreUnderDiceView
