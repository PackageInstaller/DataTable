-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/view/OriginDragonNoahFightEndView.lua

module("logic.extensions.origindragonnoah.view.OriginDragonNoahFightEndView", package.seeall)

local OriginDragonNoahFightEndView = class("OriginDragonNoahFightEndView", ViewComponent)

function OriginDragonNoahFightEndView:ctor()
	OriginDragonNoahFightEndView.super.ctor(self)
end

function OriginDragonNoahFightEndView:unbindEvents()
	OriginDragonNoahFightEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginDragonNoahFightEndView:bindEvents()
	OriginDragonNoahFightEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginDragonNoahFightEndView:buildUI()
	OriginDragonNoahFightEndView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtLeftDiatance = self:getTxt("txtLeftDiatance")
	self._txtAllFight = self:getTxt("txtAllFight")
	self._txtNoah = self:getTxt("txtNoah")
	self._txtTrans = self:getTxt("txtTrans")
	self._txtAojiu = self:getTxt("txtAojiu")
	self._emptyPet = self:getGo("emptyPet")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginDragonNoahFightEndView:onExit()
	OriginDragonNoahFightEndView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginDragonNoahFightEndView:onEnter()
	OriginDragonNoahFightEndView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageInfo = params[2]
	self._buffSignCount = params[3]

	local scores = self._stageInfo.scores
	local lockRaceIds = self._stageInfo.lockRaceIds
	local leftScore = OriginDragonNoahController.instance:getLeftScore(self._activityId)
	local buffNoahNum, buffAoJiuNum = OriginDragonNoahController.instance:getBuffsNum(self._activityId, self._stageInfo.stageId)

	self._txtLeftDiatance.text = string.format("诺亚与敖九剩余距离: %d米", leftScore)
	self._txtNoah.text = string.format("诺亚:      前进<color=#41C07E>%d</color>米", checknumber(scores[OriginDragonNoahController.BuffIdx.noah]))
	self._txtAojiu.text = string.format("敖九:      前进<color=#41C07E>%d</color>米", checknumber(scores[OriginDragonNoahController.BuffIdx.aoJiu]))
	self._txtAllFight.text = string.format("群攻次数:      <color=#41C07E>%d</color>", checknumber(self._buffSignCount[OriginDragonNoahController.BuffIdx.noah]))
	self._txtTrans.text = string.format("变身次数:      <color=#41C07E>%d</color>", checknumber(self._buffSignCount[OriginDragonNoahController.BuffIdx.aoJiu]))

	GameUtil.SetActive(self._emptyPet, #lockRaceIds <= 0)
	self._scrollList:reloadData(lockRaceIds)
	self._scrollList:setCenterMode(true)
end

function OriginDragonNoahFightEndView:_onClickBtnSure()
	BattleController.instance:endBattle()
	self:close()
end

function OriginDragonNoahFightEndView:_updateCell(view, cell, data)
	MaterialMgr.setCell(MatType.Pet, data, cell)
end

function OriginDragonNoahFightEndView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

return OriginDragonNoahFightEndView
