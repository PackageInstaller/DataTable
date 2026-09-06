-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamCreateView.lua

module("logic.extensions.formteam.view.FormTeamCreateView", package.seeall)

local FormTeamCreateView = class("FormTeamCreateView", ViewComponent)

function FormTeamCreateView:buildUI()
	FormTeamCreateView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._goModeCell = self:getGo("mode/cell")
	self._goModeTableView = self:getGo("mode/tableview")
	self._modeTableView = ScrollerList.create(self._goModeTableView, self._goModeCell, GameUtil.handler(self._updateModeCell, self), GameUtil.handler(self._clearCell, self))
	self._goCopyCell = self:getGo("copy/cell")
	self._goCopyTableView = self:getGo("copy/tableview")
	self._copyTableView = ScrollerList.create(self._goCopyTableView, self._goCopyCell, GameUtil.handler(self._updateCopyCell, self), GameUtil.handler(self._clearCell, self))
	self._goPowerCell = self:getGo("power/cell")
	self._goPowerTableView = self:getGo("power/tableview")
	self._powerTableView = ScrollerList.create(self._goPowerTableView, self._goPowerCell, GameUtil.handler(self._updatePowerCell, self), GameUtil.handler(self._clearCell, self))
	self._togPermissionAll = self:getToggle("permission/togAll")
	self._togPermissionPrivate = self:getToggle("permission/togPrivate")
end

function FormTeamCreateView:bindEvents()
	FormTeamCreateView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	self._togPermissionAll:AddOnValueChanged(self._onValueChangedAll, self)
	self._togPermissionPrivate:AddOnValueChanged(self._onValueChangedPrivate, self)
end

function FormTeamCreateView:unbindEvents()
	FormTeamCreateView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
	self._togPermissionAll:RemoveOnValueChanged()
	self._togPermissionPrivate:RemoveOnValueChanged()
end

function FormTeamCreateView:onEnter()
	FormTeamCreateView.super.onEnter(self)

	self._curCopyId = checkint(self:getFirstParam())

	self:_forceRefreshModeId()

	self._zdlId = 1
	self._isOnlyInvite = false
	self._togPermissionAll.isOn = not self._isOnlyInvite
	self._togPermissionPrivate.isOn = self._isOnlyInvite

	self:_updateCopyList()
	self._modeTableView:MoveCellToCenter(self._curModeId - 1)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)
end

function FormTeamCreateView:onExit()
	FormTeamCreateView.super.onExit(self)
	self._modeTableView:dispose()
	self._powerTableView:dispose()
	self._copyTableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)
end

function FormTeamCreateView:_onError(status)
	return
end

function FormTeamCreateView:_onJoinTeam()
	self:close()
	UIStateManager.instance:push(ViewName.FormTeamCurTeamView)
end

function FormTeamCreateView:_onClickSure()
	FormTeamController.instance:createTeam(self._curGroupId, self._curZDLSetting, self._isOnlyInvite)
end

function FormTeamCreateView:_onSwitchCopy(data)
	if not FormTeamModel.instance:checkFormTeamTabOpen(data.typeId) then
		return
	end

	if self._curCopyId ~= data.typeId then
		self._curCopyId = data.typeId

		self:_updateCopyList()
	end
end

function FormTeamCreateView:_onSwitchMode(data)
	if not FormTeamModel.instance:checkIsUnlockBygroupId(data.groupId) then
		return
	end

	if self._curModeId ~= data.tier then
		self._curModeId = data.tier

		self:_updateModeList()
	end
end

function FormTeamCreateView:_onSwitchZDL(data)
	if self._zdlId ~= data.id then
		self._zdlId = data.id

		self:_updatePowerList()
	end
end

function FormTeamCreateView:_forceRefreshModeId()
	self._curModeId = 1

	local dataList = FormTeamConfig.instance:getTeamCfgsByTabId(self._curCopyId)

	for i = 2, #dataList do
		if not FormTeamModel.instance:checkIsUnlockBygroupId(dataList[i].groupId) then
			self._curModeId = i - 1

			return
		end
	end

	self._curModeId = #dataList
end

function FormTeamCreateView:_updateCopyList()
	self:_forceRefreshModeId()

	self._zdlId = 1

	local dataList = {}
	local cfgs = FormTeamConfig.instance:getTabCfgs()

	for k, v in ipairs(cfgs) do
		local result = FormTeamController.instance:isNeedFilterTypeWithType(v.typeId)

		if not result then
			table.insert(dataList, v)
		end
	end

	self._copyTableView:reloadData(dataList)
	self:_updateModeList()
	self:_updatePowerList()
end

function FormTeamCreateView:_updateModeList()
	local dataList = FormTeamConfig.instance:getTeamCfgsByTabId(self._curCopyId)

	self._modeTableView:reloadData(dataList)
end

function FormTeamCreateView:_updatePowerList()
	local dataList = FormTeamConfig.instance:getZDLOptionCfgs()

	self._powerTableView:reloadData(dataList)
end

function FormTeamCreateView:_updateCopyCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if data.typeId == self._curCopyId then
		goutil.setActive(cell.select, true)
	end

	if not FormTeamModel.instance:checkFormTeamTabOpen(data.typeId) then
		goutil.setActive(cell.lock, true)
	end

	cell.txt.text = data.name
	cell.txt2.text = data.name

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onSwitchCopy, self, data))
end

function FormTeamCreateView:_updateModeCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if data.tier == self._curModeId then
		goutil.setActive(cell.select, true)

		self._curGroupId = data.groupId
	end

	if not FormTeamModel.instance:checkIsUnlockBygroupId(data.groupId) then
		goutil.setActive(cell.lock, true)
	end

	cell.txt.text = data.name
	cell.txt2.text = data.name

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onSwitchMode, self, data))
end

function FormTeamCreateView:_updatePowerCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if data.id == self._zdlId then
		goutil.setActive(cell.select, true)

		self._curZDLSetting = data.zdl
	end

	cell.txt.text = data.zdl
	cell.txt2.text = data.zdl

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onSwitchZDL, self, data))
end

function FormTeamCreateView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.select = goutil.findChild(cell.go, "select")
	cell.txt = goutil.findChildTextComponent(cell.go, "txt")
	cell.txt2 = goutil.findChildTextComponent(cell.select, "txt")

	goutil.setActive(cell.select, false)

	cell.txt.text = ""
	cell.txt2.text = ""
	cell.lock = goutil.findChild(cell.go, "lock")

	goutil.setActive(cell.lock, false)
	GameUtil.rmClickHandler(cell.go)

	return cell
end

function FormTeamCreateView:_onValueChangedAll(go, isOn)
	if self._togPermissionPrivate.isOn == isOn then
		self._togPermissionPrivate.isOn = not isOn
	end

	self._isOnlyInvite = not isOn
end

function FormTeamCreateView:_onValueChangedPrivate(go, isOn)
	if self._togPermissionAll.isOn == isOn then
		self._togPermissionAll.isOn = not isOn
	end

	self._isOnlyInvite = isOn
end

return FormTeamCreateView
