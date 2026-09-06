-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neweranuoya/view/NeweranuoyaresultView.lua

module("logic.extensions.neweranuoya.view.NeweranuoyaresultView", package.seeall)

local NeweranuoyaresultView = class("NeweranuoyaresultView", ViewComponent)

function NeweranuoyaresultView:ctor()
	NeweranuoyaresultView.super.ctor(self)
end

function NeweranuoyaresultView:unbindEvents()
	NeweranuoyaresultView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function NeweranuoyaresultView:bindEvents()
	NeweranuoyaresultView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function NeweranuoyaresultView:buildUI()
	NeweranuoyaresultView.super.buildUI(self)

	self._btnSure = self:getBtn("btns/btnSure")
	self._btnCancel = self:getBtn("btns/btnCancel")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDesc = self:getTxt("txtDesc")
	self._layout = self:getGo("btns"):GetComponent(ComponentType.UILayoutSingleLine)
end

function NeweranuoyaresultView:onExit()
	NeweranuoyaresultView.super.onExit(self)
	self._scrollerList:dispose()
end

function NeweranuoyaresultView:onEnter()
	NeweranuoyaresultView.super.onEnter(self)

	local param = self:getOpenParam()

	self._msg = self:getFirstParam()
	self._fromBattle = param[1]
	self._activityId = param[2]
	self._banRaceIdToIsDead = param[3]
	self._jobIdToBuffNum = param[4]

	self:_updateUI()
end

function NeweranuoyaresultView:_onClickbtnSure()
	if self._fromBattle then
		NewEraNuoYaAgent.instance:sendPM_NewEraNuoYaSaveReq(self._activityId, true)
		BattleFacade.instance:endBattle()
	else
		self:close()
	end
end

function NeweranuoyaresultView:_onClickbtnCancel()
	if self._fromBattle then
		NewEraNuoYaAgent.instance:sendPM_NewEraNuoYaSaveReq(self._activityId, false)
		BattleFacade.instance:endBattle()
	else
		self:close()
	end
end

function NeweranuoyaresultView:_updateUI()
	self._scrollerList:reloadData(self._banRaceIdToIsDead)

	local nameList = {}
	local descList = {}

	for i, pair in ipairs(self._jobIdToBuffNum or {}) do
		local jobId = pair.left
		local num = pair.right
		local jobCfg = NeweranuoyaConfig.instance:getJobCfg(self._activityId, jobId, num)
		local arr = string.split(jobCfg.petValidator, "$")
		local name = arr[2]

		table.insert(nameList, name)
		table.insert(descList, jobCfg.buffDesc)
	end

	self._txtDesc.text = #nameList > 0 and string.format("%s阵亡：%s", table.concat(nameList, "、"), table.concat(descList, "、")) or "暂无精灵阵亡"

	goutil.setActive(self._btnCancel.gameObject, self._fromBattle)
	self._layout:Layout()
end

function NeweranuoyaresultView:_updateCell(view, cell, pair, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goDie = goutil.findChild(cell.gameObject, "die")

	goutil.setActive(goDie, pair.right == 1)
	MaterialMgr.setCell(MatType.Pet, pair.left, goCon)
end

function NeweranuoyaresultView:_clearCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

return NeweranuoyaresultView
