-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleReportView.lua

module("logic.extensions.scuffle.view.ScuffleReportView", package.seeall)

local ScuffleReportView = class("ScuffleReportView", TableViewComponent)

function ScuffleReportView:ctor()
	ScuffleReportView.super.ctor(self)
end

function ScuffleReportView:buildUI()
	ScuffleReportView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._goEmpty = self:getGo("goEmpty")
end

function ScuffleReportView:bindEvents()
	ScuffleReportView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ScuffleReportView:unbindEvents()
	ScuffleReportView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function ScuffleReportView:onEnter()
	ScuffleReportView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SF_GetBattleRecordRes, self._onGetBattleRecordRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SF_GetBattleVideoRes, self._onGetBattleVideoRes, self)
	self:_setGoEmpty(false)
	self:_updateBattleRecordList()
	ScuffleAgent.instance:sendSF_GetBattleRecordReq()
end

function ScuffleReportView:onExit()
	ScuffleReportView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_GetBattleRecordRes, self._onGetBattleRecordRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_GetBattleVideoRes, self._onGetBattleVideoRes, self)
end

function ScuffleReportView:_onClickClose()
	self:close()
end

function ScuffleReportView:_onGetBattleRecordRes()
	self:_updateBattleRecordList()
end

function ScuffleReportView:_onGetBattleVideoRes(battleResult)
	BattleFacade.instance:onViewUserFightMonsterBtlResult(battleResult)
	UIJumper.instance:pushOneStack(ViewName.ScuffleMainView, true)
end

function ScuffleReportView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function ScuffleReportView:_updateCell(view, cell, data)
	local leftHead = goutil.findChild(cell, "left/head")
	local leftTxtName = goutil.findChildTextComponent(cell, "left/txtName")
	local leftTxtLevel = goutil.findChildTextComponent(cell, "left/txtLevel")
	local rightHead = goutil.findChild(cell, "right/head")
	local rightTxtName = goutil.findChildTextComponent(cell, "right/txtName")
	local rightTxtLevel = goutil.findChildTextComponent(cell, "right/txtLevel")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local imgResult = goutil.findChild(cell, "imgResult"):GetComponent(typeof(UIImageSpriteChange))
	local btnVideo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnVideo")
	local battleId = data.battleId

	btnVideo:AddClickListener(function()
		ScuffleAgent.instance:sendSF_GetBattleVideoReq(battleId)
	end)
	imgResult:SetState(data.result >= 0 and 0 or 1)

	if data.myTeamId == 0 then
		HeadItemController.instance:setMyHeadCell(leftHead)

		leftTxtName.text = RoleModel.instance:getUserName()

		local cfgLeft = ScuffleConfig.instance:getLevelCfgByScore(data.score)

		leftTxtLevel.text = cfgLeft.levelName

		HeadItemController.instance:setHeadCellByInfo(rightHead, data.opHeadInfo)

		rightTxtName.text = data.opHeadInfo.userName

		local cfgRight = ScuffleConfig.instance:getLevelCfgByScore(data.opScore)

		rightTxtLevel.text = cfgRight.levelName
	else
		HeadItemController.instance:setMyHeadCell(rightHead)

		rightTxtName.text = RoleModel.instance:getUserName()

		local cfgRight = ScuffleConfig.instance:getLevelCfgByScore(data.score)

		rightTxtLevel.text = cfgRight.levelName

		HeadItemController.instance:setHeadCellByInfo(leftHead, data.opHeadInfo)

		leftTxtName.text = data.opHeadInfo.userName

		local cfgLeft = ScuffleConfig.instance:getLevelCfgByScore(data.opScore)

		leftTxtLevel.text = cfgLeft.levelName
	end

	txtTime.text = GameUtil.formatTimeStamp("%Y-%m-%d %H:%M:%S", data.recordTime / 1000)
end

function ScuffleReportView:_clearTableview(cell)
	local leftHead = goutil.findChild(cell, "left/head")
	local rightHead = goutil.findChild(cell, "right/head")
	local btnVideo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnVideo")

	btnVideo:RemoveClickListener()
	MaterialMgr.resetAll(leftHead)
	MaterialMgr.resetAll(rightHead)
end

function ScuffleReportView:_updateBattleRecordList()
	local list = ScuffleModel.instance:getBattleRecordList()

	ArraySort.sortOn(list, "recordTime", ArraySort.DESCENDING)
	self:updateListData(list)
	self:_setGoEmpty(#list == 0)
end

function ScuffleReportView:_setGoEmpty(isActive)
	self._goEmpty:SetActive(isActive)
end

return ScuffleReportView
