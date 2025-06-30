-- chunkname: @IQIGame\\UI\\HomeLandSoulCheckInUI.lua

local HomeLandSoulCheckInUI = Base:Extend("HomeLandSoulCheckInUI", "IQIGame.Onigao.UI.HomeLandSoulCheckInUI", {
	roleSpineCells = {},
	roles = {},
	rolesInRoom = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local HomeLandRoleCheckPosCell = require("IQIGame.UI.HomeLand.HomeLandRoleCheckPosCell")
local HomeLandRoleSpineCell = require("IQIGame.UI.HomeLand.HomeLandRoleSpineCell")

function HomeLandSoulCheckInUI:OnInit()
	UGUIUtil.SetText(self.TextName, HomeLandSoulCheckInUIApi:GetString("TextName", false))
	UGUIUtil.SetText(self.TextNameEng, HomeLandSoulCheckInUIApi:GetString("TextName", true))
	UGUIUtil.SetText(self.TextTitle1, HomeLandSoulCheckInUIApi:GetString("TextTitle1"))
	UGUIUtil.SetText(self.TextTitle2, HomeLandSoulCheckInUIApi:GetString("TextTitle2"))
	UGUIUtil.SetText(self.TextTitle3, HomeLandSoulCheckInUIApi:GetString("TextTitle3"))
	UGUIUtil.SetText(self.ToggleOnTitle1, HomeLandSoulCheckInUIApi:GetString("ToggleTitle1"))
	UGUIUtil.SetText(self.ToggleDownTitle1, HomeLandSoulCheckInUIApi:GetString("ToggleTitle1"))
	UGUIUtil.SetText(self.ToggleOnTitle2, HomeLandSoulCheckInUIApi:GetString("ToggleTitle2"))
	UGUIUtil.SetText(self.ToggleDownTitle2, HomeLandSoulCheckInUIApi:GetString("ToggleTitle2"))

	self.btnToggle = self.Toggle:GetComponent("Button")

	function self.delegateOnBtnBack()
		self:OnClickBackBtn()
	end

	function self.delegateOnBtnChangeName()
		self:OnClickBtnChangeName()
	end

	function self.delegateUpdateRoomEvent(roomCid)
		self:OnUpdateRoomEvent(roomCid)
	end

	function self.delegateOnClickBtnToggle()
		self:OnBtnToggleChange()
	end

	function self.delegateUpdateRolesEvent()
		self:OnUpdateRoles()
	end

	self.roleCheckPosTab = {}

	for i = 1, 3 do
		local cellObj = UnityEngine.Object.Instantiate(self.MouldPose)

		cellObj.transform:SetParent(self.Grid.transform, false)
		cellObj:SetActive(true)

		local soulCheckPos = HomeLandRoleCheckPosCell.__New(cellObj)

		self.roleCheckPosTab[i] = soulCheckPos
	end

	self.roleSpineCellPool = UIObjectPool.New(10, function()
		local spineCellObj = UnityEngine.Object.Instantiate(self.MouldSpine)

		return HomeLandRoleSpineCell.__New(spineCellObj)
	end, function(currentCell)
		currentCell:Dispose()
	end)
end

function HomeLandSoulCheckInUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandSoulCheckInUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandSoulCheckInUI:OnOpen(userData)
	self.roomCid = userData

	self:UpdateView()
end

function HomeLandSoulCheckInUI:OnClose(userData)
	for i, v in pairs(self.roleCheckPosTab) do
		v:Close()
	end

	for i, v in pairs(self.roleSpineCells) do
		v:Close()
	end

	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseHomeLandSoulCheckInUI")
end

function HomeLandSoulCheckInUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateOnBtnBack)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateOnBtnBack)
	self.BtnChangeName:GetComponent("Button").onClick:AddListener(self.delegateOnBtnChangeName)
	self.btnToggle.onClick:AddListener(self.delegateOnClickBtnToggle)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateRoom, self.delegateUpdateRoomEvent)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateRolesEvent, self.delegateUpdateRolesEvent)
end

function HomeLandSoulCheckInUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnBtnBack)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateOnBtnBack)
	self.BtnChangeName:GetComponent("Button").onClick:RemoveListener(self.delegateOnBtnChangeName)
	self.btnToggle.onClick:RemoveListener(self.delegateOnClickBtnToggle)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateRoom, self.delegateUpdateRoomEvent)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateRolesEvent, self.delegateUpdateRolesEvent)
end

function HomeLandSoulCheckInUI:OnPause()
	return
end

function HomeLandSoulCheckInUI:OnResume()
	return
end

function HomeLandSoulCheckInUI:OnCover()
	return
end

function HomeLandSoulCheckInUI:OnReveal()
	return
end

function HomeLandSoulCheckInUI:OnRefocus(userData)
	return
end

function HomeLandSoulCheckInUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandSoulCheckInUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandSoulCheckInUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandSoulCheckInUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandSoulCheckInUI:OnDestroy()
	for i, v in pairs(self.roleCheckPosTab) do
		v:Dispose()
	end

	for i, v in pairs(self.roleSpineCells) do
		self.roleSpineCellPool:Release(v)
	end

	self.roleSpineCells = nil

	self.roleSpineCellPool:Dispose()
end

function HomeLandSoulCheckInUI:OnUpdateRoomEvent(roomCid)
	if self.roomCid == roomCid then
		self:UpdateView()
	end
end

function HomeLandSoulCheckInUI:OnUpdateRoles()
	if self.roomCid ~= nil then
		self:UpdateView()
	end
end

function HomeLandSoulCheckInUI:UpdateView()
	self.roles = {}
	self.rolesInRoom = {}

	local tab = HomeLandLuaModule.homeLandRoles

	for i, v in pairs(tab) do
		local isSoul = false

		for k, tab in pairsCfg(CfgSoulTable) do
			if tab.Id == v.roleCid then
				isSoul = true

				break
			end
		end

		if v.belongRoom == 0 and isSoul then
			table.insert(self.roles, v)
		elseif v.belongRoom == self.roomCid and isSoul then
			table.insert(self.rolesInRoom, v)
		end
	end

	table.sort(self.roles, function(a, b)
		return a.roleCid < b.roleCid
	end)
	table.sort(self.rolesInRoom, function(a, b)
		return a.roleCid < b.roleCid
	end)

	for i, v in pairs(self.roleSpineCells) do
		v.goView:SetActive(false)
		v.goView.transform:SetParent(self.UIController.transform, false)
		self.roleSpineCellPool:Release(v)
	end

	self.roleSpineCells = {}

	for i = 1, #self.roles do
		local rolePod = self.roles[i]
		local cell = self.roleSpineCellPool:Obtain()

		cell.goView.transform:SetParent(self.RoleContent.transform, false)
		cell.goView:SetActive(true)

		cell.goView.name = "MouldSpine_" .. rolePod.roleCid

		cell:SetData(rolePod)

		function cell.clickSelfCallBack(rolePOD)
			self:OnCheckIn(rolePOD)
		end

		table.insert(self.roleSpineCells, cell)
	end

	for i = 1, #self.roleCheckPosTab do
		local rolePosCell = self.roleCheckPosTab[i]
		local rolePod = self.rolesInRoom[i]

		rolePosCell:SetData(rolePod)
	end

	local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.roomCid)
	local cfgRoom = CfgHomeLandRoomTable[self.roomCid]
	local roomName = cfgRoom.Name

	if roomPOD ~= nil then
		if roomPOD.name ~= nil and roomPOD.name ~= "" then
			roomName = roomPOD.name
		end

		self.ToggleOn:SetActive(roomPOD.foreignShow)
		self.ToggleDown:SetActive(not roomPOD.foreignShow)
	end

	UGUIUtil.SetText(self.TextRoomName, roomName)
end

function HomeLandSoulCheckInUI:OnClickBtnChangeName()
	UIModule.Open(Constant.UIControllerName.InputTextUI, Constant.UILayer.Tooltip, {
		defaultTxt = HomeLandSoulCheckInUIApi:GetString("DefaultTxt"),
		yes = function(text)
			self:SetNameCallback(text)
		end
	})
end

function HomeLandSoulCheckInUI:SetNameCallback(text)
	HomeLandLuaModule.ChangeRoomName(self.roomCid, text)
end

function HomeLandSoulCheckInUI:OnCheckIn(rolePOD)
	if #self.rolesInRoom >= #self.roleCheckPosTab then
		NoticeModule.ShowNotice(21042033)

		return
	end

	if rolePOD.belongRoom > 0 then
		NoticeModule.ShowNotice(21042034)

		return
	end

	HomeLandLuaModule.EnterRoom(self.roomCid, rolePOD.roleCid)
end

function HomeLandSoulCheckInUI:OnBtnToggleChange()
	HomeLandLuaModule.SwitchRoomShow(self.roomCid)
end

function HomeLandSoulCheckInUI:OnClickBackBtn()
	UIModule.Close(Constant.UIControllerName.HomeLandSoulCheckInUI)
end

return HomeLandSoulCheckInUI
