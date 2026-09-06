-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/view/DivineMiRuiKeClgBuffView.lua

module("logic.extensions.divinemiruikeclg.view.DivineMiRuiKeClgBuffView", package.seeall)

local DivineMiRuiKeClgBuffView = class("DivineMiRuiKeClgBuffView", ViewComponent)

function DivineMiRuiKeClgBuffView:buildUI()
	DivineMiRuiKeClgBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("cell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineMiRuiKeClgBuffView:bindEvents()
	DivineMiRuiKeClgBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineMiRuiKeClgBuffView:unbindEvents()
	DivineMiRuiKeClgBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineMiRuiKeClgBuffView:onEnter()
	DivineMiRuiKeClgBuffView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local cfgBuffs = DivineMiRuiKeClgConfig.instance:getBuffList(self._activityId)

	self._scrollList:reloadData(cfgBuffs)
end

function DivineMiRuiKeClgBuffView:onExit()
	DivineMiRuiKeClgBuffView.super.onExit(self)
end

function DivineMiRuiKeClgBuffView:_updateCell(view, cell, data, tag)
	local headIcon = goutil.findChild(cell, "headIcon")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local getedGo = goutil.findChild(cell, "geted")

	MaterialMgr.setCell(MatType.Pet, data.raceId, headIcon)

	txtDesc.text = data.desc

	goutil.setActive(getedGo, BagModel.instance:isExistRaceId(data.raceId))
end

function DivineMiRuiKeClgBuffView:_clearCell(cell)
	local headIcon = goutil.findChild(cell, "headIcon")

	MaterialMgr.resetAll(headIcon)
end

return DivineMiRuiKeClgBuffView
