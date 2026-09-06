-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgExtResultView.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgExtResultView", package.seeall)

local DivineZhongFeiClgExtResultView = class("DivineZhongFeiClgExtResultView", ViewComponent)

function DivineZhongFeiClgExtResultView:ctor()
	DivineZhongFeiClgExtResultView.super.ctor(self)
end

function DivineZhongFeiClgExtResultView:unbindEvents()
	DivineZhongFeiClgExtResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function DivineZhongFeiClgExtResultView:bindEvents()
	DivineZhongFeiClgExtResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function DivineZhongFeiClgExtResultView:buildUI()
	DivineZhongFeiClgExtResultView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._txtBuff = self:getTxt("txtBuff")
end

function DivineZhongFeiClgExtResultView:onExit()
	DivineZhongFeiClgExtResultView.super.onExit(self)
end

function DivineZhongFeiClgExtResultView:onEnter()
	DivineZhongFeiClgExtResultView.super.onEnter(self)

	local tempInfo = DivineZhongFeiClgModel.instance:getTempExtBattleInfo()

	self._activityId = tempInfo.activityId

	local buffCfgs = DivineZhongFeiClgConfig.instance:getExtBuffCfgs(self._activityId)
	local list = {}

	for i, v in pairs(buffCfgs) do
		table.insert(list, {
			cfg = v
		})
	end

	table.sort(list, function(a, b)
		return a.cfg.killNum < b.cfg.killNum
	end)

	for i, v in ipairs(list) do
		v.index = i
	end

	local curScore = DivineZhongFeiClgModel.instance:getExtStageTotalScore(self._activityId) + tempInfo.killNum
	local activeBuffIndex = 0

	for i, v in ipairs(list) do
		if curScore >= v.cfg.killNum then
			activeBuffIndex = v.index
		end
	end

	self._txtBuff.text = activeBuffIndex > 0 and list[activeBuffIndex].cfg.desc or lang("未激活")

	if not tempInfo.lockRaceIds then
		local list2 = {}

		self._tableList:reloadData(list2)
	end
end

function DivineZhongFeiClgExtResultView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCell(MatType.Pet, data, go)
end

function DivineZhongFeiClgExtResultView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function DivineZhongFeiClgExtResultView:_onClickSure()
	local tempInfo = DivineZhongFeiClgModel.instance:getTempExtBattleInfo()

	DivineZhongFeiClgAgent.instance:sendPM_DivineZhongFeiClgExtremeConfirmReq(tempInfo.activityId, tempInfo.stageId, true)
	self:close()
end

function DivineZhongFeiClgExtResultView:_onClickCancel()
	local tempInfo = DivineZhongFeiClgModel.instance:getTempExtBattleInfo()

	DivineZhongFeiClgAgent.instance:sendPM_DivineZhongFeiClgExtremeConfirmReq(tempInfo.activityId, tempInfo.stageId, false)
	self:close()
end

return DivineZhongFeiClgExtResultView
