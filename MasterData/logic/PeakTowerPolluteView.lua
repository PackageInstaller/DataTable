-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/view/PeakTowerPolluteView.lua

module("logic.extensions.peaktower.view.PeakTowerPolluteView", package.seeall)

local PeakTowerPolluteView = class("PeakTowerPolluteView", ViewComponent)

function PeakTowerPolluteView:ctor()
	PeakTowerPolluteView.super.ctor(self)
end

function PeakTowerPolluteView:unbindEvents()
	PeakTowerPolluteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PeakTowerPolluteView:bindEvents()
	PeakTowerPolluteView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PeakTowerPolluteView:buildUI()
	PeakTowerPolluteView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtCurProgress = self:getTxt("txtCurProgress")
end

function PeakTowerPolluteView:onExit()
	PeakTowerPolluteView.super.onExit(self)
end

function PeakTowerPolluteView:onEnter()
	PeakTowerPolluteView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._floorId = checknumber(params[2])
	self._weekId = PeakTowerController.instance:getCurWeekId(self._activityId)

	self:_refreshView()
end

function PeakTowerPolluteView:_refreshView()
	local activeBuffList = {}
	local floorCfgs = PeakTowerConfig.instance:getLegendFloorCfgs(self._activityId, self._weekId)

	for i = 1, #floorCfgs do
		for j, v in ipairs(floorCfgs[i].polluteBuffId or {}) do
			local buffCfg = PeakTowerConfig.instance:getBuffCfg(self._activityId, v)

			table.insert(activeBuffList, {
				floorId = i,
				cfg = buffCfg
			})
		end
	end

	self._tableList:reloadData(activeBuffList)

	self._txtCurProgress.text = langPara("当前层数：<color=#FF2E2EFF>%d</color>", self._floorId)
end

function PeakTowerPolluteView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtProgress = goutil.findChildTextComponent(go, "txtProgress")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local activeGo = goutil.findChild(go, "active")

	txtProgress.text = langPara("第%d层", data.floorId)
	txtDesc.text = data.cfg.desc

	GameUtil.SetActive(activeGo, data.floorId <= self._floorId)
end

function PeakTowerPolluteView:_clearCell(cell)
	return
end

return PeakTowerPolluteView
