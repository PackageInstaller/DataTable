-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianBuffView.lua

module("logic.extensions.divinetuntian.view.DivineTunTianBuffView", package.seeall)

local DivineTunTianBuffView = class("DivineTunTianBuffView", ViewComponent)

function DivineTunTianBuffView:ctor()
	DivineTunTianBuffView.super.ctor(self)
end

function DivineTunTianBuffView:unbindEvents()
	DivineTunTianBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineTunTianBuffView:bindEvents()
	DivineTunTianBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function DivineTunTianBuffView:buildUI()
	DivineTunTianBuffView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineTunTianBuffView:onExit()
	DivineTunTianBuffView.super.onExit(self)
	self._scrollList:dispose()
end

function DivineTunTianBuffView:onEnter()
	DivineTunTianBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 508001
	end

	local activateBuffIdx = DivineTunTianController.instance:getNorCurActivateBuffIdx(self._activityId)

	self._norBuffCfgs = DivineTunTianConfig.instance:getNorBuffCfgsByActId(self._activityId)

	self._scrollList:reloadData(self._norBuffCfgs)
	self._scrollList:MoveCellToCenter(activateBuffIdx - 1)
end

function DivineTunTianBuffView:_updateCell(view, cell, data)
	local active = goutil.findChild(cell, "active")
	local bg = goutil.findChild(cell, "bg")
	local txtPower = goutil.findChildTextComponent(cell, "txtPower")
	local txtBuff = goutil.findChildTextComponent(cell, "txtBuff")
	local totalPower = DivineTunTianModel.instance:getAllNorScores(self._activityId)
	local powerArr = string.split(data.powerArrDesc, "-")
	local buffCanActive = totalPower >= checknumber(powerArr[1]) and totalPower <= checknumber(powerArr[2])

	txtPower.text = data.powerArrDesc
	txtBuff.text = data.desc

	if checknumber(powerArr[2]) == 0 then
		buffCanActive = totalPower >= checknumber(powerArr[1])
		txtPower.text = checknumber(powerArr[1]) .. "以上"
	end

	GameUtil.SetActive(active, buffCanActive)
	GameUtil.SetActive(bg, cell.index % 2 == 0)
end

function DivineTunTianBuffView:_clearCell(cell)
	return
end

return DivineTunTianBuffView
