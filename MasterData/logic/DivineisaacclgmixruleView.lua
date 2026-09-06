-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgmixruleView.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgmixruleView", package.seeall)

local DivineisaacclgmixruleView = class("DivineisaacclgmixruleView", ViewComponent)

function DivineisaacclgmixruleView:ctor()
	DivineisaacclgmixruleView.super.ctor(self)
end

function DivineisaacclgmixruleView:unbindEvents()
	DivineisaacclgmixruleView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineisaacclgmixruleView:bindEvents()
	DivineisaacclgmixruleView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function DivineisaacclgmixruleView:buildUI()
	DivineisaacclgmixruleView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnClose = self:getBtn("btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtRule = self:getTxt("rule/txtRule")
end

function DivineisaacclgmixruleView:onExit()
	DivineisaacclgmixruleView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivineisaacclgmixruleView:onEnter()
	DivineisaacclgmixruleView.super.onEnter(self)

	self._metalCfgs = DivineisaacclgConfig.instance:getMetalResCfgs()

	self._scrollerList:reloadData(self._metalCfgs)

	self._txtRule.text = RulesConfig.instance:getRuleCo("divineisaacclgmixrule").rules
end

function DivineisaacclgmixruleView:_onClickbtnClose()
	self:close()
end

function DivineisaacclgmixruleView:_updateCell(view, cell, data, tag)
	local layoutComp = goutil.findChild(cell.gameObject, "con"):GetComponent(ComponentType.UILayoutSingleLine)
	local goItem = goutil.findChild(cell.gameObject, "item")
	local metalGos = {}

	for i = 1, 3 do
		local go = goutil.findChild(layoutComp.gameObject, "metal" .. i)

		table.insert(metalGos, go)
	end

	MaterialMgr.setCellByCfg(data.clientMatStr, goItem)
	self:_updateMetalGos(metalGos, data.formula)
	layoutComp:Layout()
end

function DivineisaacclgmixruleView:_updateMetalGos(metalGos, formula)
	local arr = string.split(formula, "#")
	local metalCnt = #arr

	for i, v in ipairs(metalGos) do
		goutil.setActive(v, i <= metalCnt)
	end

	for i, v in ipairs(arr) do
		local go = metalGos[i]
		local iconChange = goutil.findChild(go, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
		local txtNum = goutil.findChildTextComponent(go, "txtNum")
		local raceArr = string.split(v, ":")
		local raceType = raceArr[1]

		txtNum.text = checknumber(raceArr[2])

		iconChange:SetState(GameEnum.Races[raceType] - 1)
	end
end

function DivineisaacclgmixruleView:_clearCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

return DivineisaacclgmixruleView
