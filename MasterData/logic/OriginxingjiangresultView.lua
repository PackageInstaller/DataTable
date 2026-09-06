-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/view/OriginxingjiangresultView.lua

module("logic.extensions.orixingjiang.view.OriginxingjiangresultView", package.seeall)

local OriginxingjiangresultView = class("OriginxingjiangresultView", ViewComponent)

OriginxingjiangresultView.PassType = {
	Kill = 1,
	Buff2 = 3,
	Buff1 = 2
}

function OriginxingjiangresultView:ctor()
	OriginxingjiangresultView.super.ctor(self)
end

function OriginxingjiangresultView:unbindEvents()
	OriginxingjiangresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function OriginxingjiangresultView:bindEvents()
	OriginxingjiangresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function OriginxingjiangresultView:buildUI()
	OriginxingjiangresultView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:setCenterMode(true)

	self._txtNum = self:getTxt("txtNum")
end

function OriginxingjiangresultView:onExit()
	OriginxingjiangresultView.super.onExit(self)
	self._scrollerList:dispose()
end

function OriginxingjiangresultView:onEnter()
	OriginxingjiangresultView.super.onEnter(self)

	local params = self:getOpenParam()
	local msg = params[1]

	if not params[2] then
		local successCnt = 0
		local sortResultDatas = {}
		local transDatas = {}
		local norDatas = {}

		for i, v in ipairs(params[2]) do
			if not v.isDead and v.isTransmog then
				successCnt = successCnt + 1

				table.insert(sortResultDatas, 1, v)
			elseif v.transmogId then
				table.insert(transDatas, v)
			else
				table.insert(norDatas, v)
			end
		end

		table.insertto(sortResultDatas, transDatas)
		table.insertto(sortResultDatas, norDatas)

		self._activityId = msg.activityId
		self._stageId = msg.stageId

		self._scrollerList:reloadData(sortResultDatas)

		self._txtNum.text = successCnt
	end
end

function OriginxingjiangresultView:_onClickbtnSure()
	BattleFacade.instance:endBattle()
end

function OriginxingjiangresultView:_updateCell(view, cell, petData, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local goTransCon = goutil.findChild(cell.gameObject, "exclSptGo")
	local goTransIcon = goutil.findChild(cell.gameObject, "exclSptGo/exclIcon")
	local transGo = goutil.findChild(cell.gameObject, "txtcon/trans")
	local aliveGo = goutil.findChild(cell.gameObject, "txtcon/alive")
	local changeTrans = goutil.findChild(cell.gameObject, "txtcon/trans/gou"):GetComponent(ComponentType.UIImageSpriteChange)
	local changeAlive = goutil.findChild(cell.gameObject, "txtcon/alive/gou"):GetComponent(ComponentType.UIImageSpriteChange)
	local isDead = petData.isDead
	local isTransmog = petData.isTransmog

	MaterialMgr.setCell(MatType.Pet, petData.raceId, goCon)
	goutil.setActive(goLock, not isDead and isTransmog)
	goutil.setActive(goTransCon, isTransmog)

	if petData.transmogId then
		local transCfg = OrixingjiangConfig.instance:getTransmogCfg(self._activityId, petData.transmogId)

		if transCfg then
			MaterialMgr.setIcon(goTransIcon, MatType.Pet, transCfg.raceId)
		end
	end

	changeTrans:SetState(isTransmog and 0 or 1)
	changeAlive:SetState(isDead and 1 or 0)
end

function OriginxingjiangresultView:_clearCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goTransCon = goutil.findChild(cell.gameObject, "exclSptGo")

	MaterialMgr.resetAll(goCon)
	MaterialMgr.resetAll(goTransCon)
end

return OriginxingjiangresultView
