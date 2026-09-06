-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/view/PlanetariumprizeView.lua

module("logic.extensions.planetarium.view.PlanetariumprizeView", package.seeall)

local PlanetariumprizeView = class("PlanetariumprizeView", ViewComponent)

function PlanetariumprizeView:ctor()
	PlanetariumprizeView.super.ctor(self)
end

function PlanetariumprizeView:unbindEvents()
	PlanetariumprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PlanetariumprizeView:bindEvents()
	PlanetariumprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PlanetariumprizeView:buildUI()
	PlanetariumprizeView.super.buildUI(self)

	self._itemCell = self:getGo("itemcell")
	self._cell = self:getGo("cell")
	self._tableviewGo = self:getGo("tableview")
	self._txtNum = self:getTxt("num/txt")
	self._btnClose = self:getBtn("btnClose")
	self._tableview = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PlanetariumprizeView:onExit()
	PlanetariumprizeView.super.onExit(self)
	self._tableview:dispose()
end

function PlanetariumprizeView:onEnter()
	PlanetariumprizeView.super.onEnter(self)

	self._cellPool = {}
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Planetarium)
	self._gamePrizeCfg = PlanetariumConfig.instance:getPrizeCfgById(self._activityId)

	self.addGEvent(self, GlobalNotify.PlanetariumGameGainPrizeRes, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.PlanetariumGameInfoRes, self._refresh, self)

	local finishNum = PlanetariumModel.instance:getFinishNum()

	self._txtNum.text = string.format("成功次数：%d", finishNum)

	self._tableview:reloadData(self._gamePrizeCfg)
end

function PlanetariumprizeView:_updateCell(view, cell, data)
	local cellGo = self:_clearCell(cell)
	local state = PlanetariumController.instance:getPrizeState(data.prizeId, data.passNum)
	local prizeCfg = string.split(data.prize, "#")

	cellGo.rewardView:dragNotifyParent()
	cellGo.rewardView:reloadData(prizeCfg)
	GameUtil.SetActive(cellGo.receive, state > 2)
	GameUtil.SetActive(cellGo.noPass, state < 2)
	GameUtil.SetActive(cellGo.btnSure.gameObject, state == 2)

	cellGo.txtDesc.text = string.format("成功%d次", data.passNum)

	GameUtil.addClickHandler(cellGo.btnSure, GameUtil.handler(self._onClickGainPrize, self, data.prizeId))
end

function PlanetariumprizeView:_clearCell(cell)
	local cellGo = self._cellPool[cell]

	if cellGo == nil then
		cellGo = {
			txtDesc = goutil.findChildTextComponent(cell, "txtDesc"),
			receive = goutil.findChild(cell, "receive"),
			noPass = goutil.findChild(cell, "noPass"),
			btnSure = goutil.findChildButtonComponent(cell, "btnSure"),
			rewardViewGo = goutil.findChild(cell, "rewardView")
		}
		cellGo.rewardView = ScrollerList.create(cellGo.rewardViewGo, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		cellGo.rewardView:setCenterMode(true)

		self._cellPool[cell] = cellGo
	end

	cellGo.rewardView:dispose()
	GameUtil.rmClickHandler(cellGo.btnSure)

	return cellGo
end

function PlanetariumprizeView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function PlanetariumprizeView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell)
end

function PlanetariumprizeView:_onClickGainPrize(prizeId)
	PlanetariumController.instance:sendPM_PlanetariumGameGainPrizeReq(self._activityId, prizeId)
end

function PlanetariumprizeView:_sendInfoReq()
	PlanetariumController.instance:sendPM_PlanetariumGameInfoReq(self._activityId)
end

function PlanetariumprizeView:_refresh()
	local finishNum = PlanetariumModel.instance:getFinishNum()

	self._txtNum.text = string.format("成功次数：%d", finishNum)

	self._tableview:refresh()
end

return PlanetariumprizeView
