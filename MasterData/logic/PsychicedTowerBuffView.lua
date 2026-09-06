-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/view/PsychicedTowerBuffView.lua

module("logic.extensions.psychicedtower.view.PsychicedTowerBuffView", package.seeall)

local PsychicedTowerBuffView = class("PsychicedTowerBuffView", ViewComponent)

function PsychicedTowerBuffView:ctor()
	PsychicedTowerBuffView.super.ctor(self)
end

function PsychicedTowerBuffView:unbindEvents()
	PsychicedTowerBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PsychicedTowerBuffView:bindEvents()
	PsychicedTowerBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PsychicedTowerBuffView:buildUI()
	PsychicedTowerBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PsychicedTowerBuffView:destroyUI()
	PsychicedTowerBuffView.super.destroyUI(self)
	self._tableList:dispose()
end

function PsychicedTowerBuffView:onExit()
	PsychicedTowerBuffView.super.onExit(self)
	self._tableList:dispose()
end

function PsychicedTowerBuffView:onEnter()
	PsychicedTowerBuffView.super.onEnter(self)

	local param = self:getOpenParam()

	self._activityId = param[1]
	self._towerId = param[2]

	local cfgs = PsychicedTowerConfig.instance:getDailyBuffs(self._activityId, self._towerId)

	self._tableList:reloadData(cfgs)
end

function PsychicedTowerBuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local iconGo = goutil.findChild(go, "buffIcon")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")

	txtDesc.text = data.buffDesc
	txtLevel.text = langPara("Lv.%d", data.buffLevel)

	uGuiUtil.clearImage(iconGo)
	uGuiUtil.setSpriteToImage(iconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(data.icon))
end

function PsychicedTowerBuffView:_clearCell(cell)
	local go = cell.gameObject
	local iconGo = goutil.findChild(go, "buffIcon")

	uGuiUtil.clearImage(iconGo)
end

return PsychicedTowerBuffView
