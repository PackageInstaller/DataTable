-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanfixeddiceView.lua

module("logic.extensions.richmanxplan.view.RmxplanfixeddiceView", package.seeall)

local RmxplanfixeddiceView = class("RmxplanfixeddiceView", ViewComponent)

function RmxplanfixeddiceView:buildUI()
	RmxplanfixeddiceView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._choseCells = {}

	for i = 1, 6 do
		local mainGo = goutil.findChild(self.mainGO, "choseCells/cell_" .. i)
		local cell = {}

		cell._mainGo = mainGo
		cell._select = goutil.findChild(mainGo, "select")
		cell._txt = goutil.findChildTextComponent(mainGo, "txt")
		self._choseCells[i] = cell
	end
end

function RmxplanfixeddiceView:bindEvents()
	RmxplanfixeddiceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)

	for i, cell in ipairs(self._choseCells) do
		GameUtil.addClickHandler(cell._mainGo, GameUtil.handler(self._onClickChoseCell, self, i))
	end
end

function RmxplanfixeddiceView:unbindEvents()
	RmxplanfixeddiceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)

	for _, cell in ipairs(self._choseCells) do
		GameUtil.rmClickHandler(cell._mainGo)
	end
end

function RmxplanfixeddiceView:onEnter()
	RmxplanfixeddiceView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._curSelectId = 1

	self:_onUpdateChoseCol()
end

function RmxplanfixeddiceView:onExit()
	RmxplanfixeddiceView.super.onExit(self)
end

function RmxplanfixeddiceView:_onUpdateChoseCol()
	for id, cell in ipairs(self._choseCells) do
		GameUtil.SetActive(cell._select, self._curSelectId == id)
	end
end

function RmxplanfixeddiceView:_onClickSure()
	RichManXPlanAgent.instance:sendPM_RichManXPlanDiceReq(self._activityId, RichmanxplanController.DiceType.Fixed, self._curSelectId)
	self:close()
end

function RmxplanfixeddiceView:_onClickChoseCell(id)
	self._curSelectId = id

	self:_onUpdateChoseCol()
end

return RmxplanfixeddiceView
