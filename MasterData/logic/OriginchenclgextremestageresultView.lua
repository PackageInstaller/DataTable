-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgextremestageresultView.lua

module("logic.extensions.originchenclg.view.OriginchenclgextremestageresultView", package.seeall)

local OriginchenclgextremestageresultView = class("OriginchenclgextremestageresultView", ViewComponent)

function OriginchenclgextremestageresultView:ctor()
	OriginchenclgextremestageresultView.super.ctor(self)
end

function OriginchenclgextremestageresultView:unbindEvents()
	OriginchenclgextremestageresultView.super.unbindEvents(self)
	self._btnAgain:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function OriginchenclgextremestageresultView:bindEvents()
	OriginchenclgextremestageresultView.super.bindEvents(self)
	self._btnAgain:AddClickListener(self._onClickbtnAgain, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OriginchenclgextremestageresultView:buildUI()
	OriginchenclgextremestageresultView.super.buildUI(self)

	self._btnAgain = self:getBtn("btnAgain")
	self._btnSure = self:getBtn("btnSure")
	self._scrViewGo = self:getGo("petCol/scrView")
	self._scrCellGo = self:getGo("petCol/scrCell")
	self._tagReachGo = self:getGo("detail1/tagReach")
	self._tagBuffGo = self:getGo("gain/tagBuff")
	self._tagBuffChange = goutil.findChildComponent(self.mainGO, "gain/tagBuff", "UIImageSpriteChange")
	self._scrollerList = ScrollerList.create(self._scrViewGo, self._scrCellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:setCenterMode(true)

	self._txtKill = self:getTxt("detail1/txt")
end

function OriginchenclgextremestageresultView:onExit()
	OriginchenclgextremestageresultView.super.onExit(self)
	self._scrollerList:dispose()
end

function OriginchenclgextremestageresultView:onEnter()
	OriginchenclgextremestageresultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_OriginChenClgConfirmExtremeRes, self._onhandlePM_OriginChenClgConfirmExtremeRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._stageInfo = params[3]

	self:_updateUI()
end

function OriginchenclgextremestageresultView:_onClickbtnAgain()
	OriginChenClgAgent.instance:sendPM_OriginChenClgConfirmExtremeReq(self._activityId, self._stageId, false)
end

function OriginchenclgextremestageresultView:_onClickbtnSure()
	OriginChenClgAgent.instance:sendPM_OriginChenClgConfirmExtremeReq(self._activityId, self._stageId, true)
end

function OriginchenclgextremestageresultView:_updateUI()
	local curNum, totalNum = self:_getTargetProgress()

	self._txtKill.text = langPara("击败所有敌人（<color=#ff4d29>{0}</color>/{1}）", curNum, totalNum)

	GameUtil.SetActive(self._tagReachGo, totalNum <= curNum)
	self._scrollerList:reloadData(self._stageInfo.lockRaceIds)

	local suit = self._stageInfo and checknumber(self._stageInfo.suit) or 0

	GameUtil.SetActive(self._tagBuffGo, suit > 0)

	if suit > 0 and self._tagBuffChange then
		self._tagBuffChange:SetState(suit - 1)
	end
end

function OriginchenclgextremestageresultView:_updateCell(view, cell, raceId, tag)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCell(MatType.Pet, raceId, goItem)
end

function OriginchenclgextremestageresultView:_clearCell(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

function OriginchenclgextremestageresultView:_getTargetProgress()
	local totalNum = 0
	local curNum = 0

	for _, unit in pairs(BattleModel.instance:getEnemyUnits() or {}) do
		if not unit.attrs:isFakePet() then
			totalNum = totalNum + 1

			if unit.attrs:getCurHp() <= 0 then
				curNum = curNum + 1
			end
		end
	end

	return curNum, totalNum
end

function OriginchenclgextremestageresultView:_onhandlePM_OriginChenClgConfirmExtremeRes(msg)
	if msg.confirm then
		OriginChenClgModel.instance:onConfirmExtreme(self._activityId, self._stageInfo)
	end

	BattleFacade.instance:endBattle()
end

return OriginchenclgextremestageresultView
