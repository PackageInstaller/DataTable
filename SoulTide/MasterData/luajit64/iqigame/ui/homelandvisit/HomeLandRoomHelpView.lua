-- chunkname: @IQIGame\\UI\\HomeLandVisit\\HomeLandRoomHelpView.lua

local HomeLandRoomHelpView = {
	helpBtnCells = {},
	funObjTransforms = {}
}
local HomeLandHelpBtnCell = require("IQIGame.UI.HomeLandVisit.HomeLandHelpBtnCell")

function HomeLandRoomHelpView.__New(ui, parent)
	local o = Clone(HomeLandRoomHelpView)

	o:InitView(ui, parent)

	return o
end

function HomeLandRoomHelpView:InitView(ui, rootParent)
	self.rootUI = ui
	self.rootParent = rootParent

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.canvas = self.rootParent.UIController.gameObject:GetComponent("Canvas")

	function self.delegateHomeLandVisitEvent()
		self:OnHomeLandVisitEvent()
	end

	function self.delegateOnHomelandDragIngEventArgs(sender, args)
		self:OnDragIng(sender, args)
	end
end

function HomeLandRoomHelpView:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandRoomHelpView:AddEventListener()
	EventDispatcher.AddEventListener(EventID.HomeLandVisitEvent, self.delegateHomeLandVisitEvent)
	GameEntry.LuaEvent:Subscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandRoomHelpView:RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.HomeLandVisitEvent, self.delegateHomeLandVisitEvent)
	GameEntry.LuaEvent:Unsubscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandRoomHelpView:OnDragIng(sender, args)
	for i, v in ipairs(self.helpBtnCells) do
		local tr = self.funObjTransforms[i]

		if tr == nil or LuaCodeInterface.GameObjIsDestroy(tr) then
			return
		end

		local btnCell = self.helpBtnCells[i]

		if btnCell then
			local uiPos = self:ConvertPosToUI(tr.position)

			btnCell.goView.transform.position = uiPos
		end
	end
end

function HomeLandRoomHelpView:Dispose()
	for i, v in ipairs(self.helpBtnCells) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function HomeLandRoomHelpView:OnHomeLandVisitEvent()
	if self.roomPOD then
		local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.roomPOD.cid)

		self:UpDataView(roomPOD)
	end
end

function HomeLandRoomHelpView:UpDataView(roomPOD)
	self.roomPOD = roomPOD

	if UnityEngine.GameObject.Find("Root") == nil or self.roomPOD == nil then
		return
	end

	self.funRoomDic = {}

	for i, v in pairs(Constant.HomelandRoomFunDecorates) do
		local object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. self.roomPOD.cid .. "/Objects/decorate_" .. v)

		if object then
			local cfgDecorate = CfgHomeLandDecorateTable[v]

			if cfgDecorate.FunctionBuilding > 0 and HomeLandVisitMould.CheckShowHelpBtnCondition(v) then
				table.insert(self.funRoomDic, v)
			end
		end
	end

	for i, v in ipairs(self.helpBtnCells) do
		v:Dispose()
	end

	self.helpBtnCells = {}
	self.funObjTransforms = {}

	for i, v in pairs(self.funRoomDic) do
		local obj = UnityEngine.Object.Instantiate(self.Mould)

		obj:SetActive(true)
		obj.transform:SetParent(self.Point.transform, false)

		local transform = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. self.roomPOD.cid .. "/Objects/decorate_" .. v .. "/UIObj").transform
		local pos = transform.position
		local uiPos = self:ConvertPosToUI(pos)

		obj.transform.position = uiPos

		local cfgDecorate = CfgHomeLandDecorateTable[v]
		local cfgBuilding = CfgHomeLandBuildingTable[cfgDecorate.FunctionBuilding]
		local cfgPos = Vector3.New(cfgBuilding.HelpButtonPos[1], cfgBuilding.HelpButtonPos[2], 0)
		local btnCell = HomeLandHelpBtnCell.__New(obj)

		btnCell:SetData(v, cfgPos)

		self.helpBtnCells[i] = btnCell
		self.funObjTransforms[i] = transform
	end
end

function HomeLandRoomHelpView:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = self.canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, self.canvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

function HomeLandRoomHelpView:Open()
	self.rootUI:SetActive(true)
	self:AddEventListener()
end

function HomeLandRoomHelpView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return HomeLandRoomHelpView
