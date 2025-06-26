-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandChooseGuideView.lua

local HomeLandChooseGuideView = {
	isCreate = false,
	isUpdate = false,
	buttons = {},
	functionButtons = {}
}
local HomeLandGuideBtnCell = require("IQIGame.UI.HomeLand.HomeLandGuideBtnCell")

function HomeLandChooseGuideView.__New(ui, parent)
	local o = Clone(HomeLandChooseGuideView)

	o:InitView(ui, parent)

	return o
end

function HomeLandChooseGuideView:InitView(ui, parent)
	self.rootUI = ui
	self.rootParent = parent

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	function self.delegateOnHomelandDragIngEventArgs(sender, args)
		self:OnDragIng(sender, args)
	end

	function self.delegateClickRoom(roomID)
		self:OnClickRoom(roomID)
	end

	function self.delegateClickObj(data)
		self:OnClickObj(data)
	end

	function self.delegateRoomCreatedArgs(sender, args)
		self:OnRoomCreateArgs(sender, args)
	end

	self:AddEventListener()
end

function HomeLandChooseGuideView:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.isCreate == false and HomeLandLuaModule.isCreate then
		self:CreateTip()

		self.isCreate = true
		self.isUpdate = true
	end

	if self.isUpdate then
		self:OnDragIng()
	end
end

function HomeLandChooseGuideView:AddEventListener()
	GameEntry.LuaEvent:Subscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
	GameEntry.LuaEvent:Subscribe(HomelandRoomCreatedEventArgs.EventId, self.delegateRoomCreatedArgs)
end

function HomeLandChooseGuideView:RemoveEventListener()
	GameEntry.LuaEvent:Unsubscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
	GameEntry.LuaEvent:Unsubscribe(HomelandRoomCreatedEventArgs.EventId, self.delegateRoomCreatedArgs)
end

function HomeLandChooseGuideView:CreateTip()
	for i, v in pairs(self.buttons) do
		v:Dispose()
	end

	for i, v in pairs(self.functionButtons) do
		v:Dispose()
	end

	self.buttons = {}
	self.roomTransforms = {}
	self.functionButtons = {}

	for i, v in pairsCfg(CfgHomeLandRoomTable) do
		if v.CastleIndex == 1 then
			local obj = UnityEngine.Object.Instantiate(self.BtnGuide)

			obj:SetActive(true)

			obj.name = "room" .. v.Id

			obj.transform:SetParent(self.GuidePos.transform, false)

			local roomTransform = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. v.Id).transform
			local pos = roomTransform.position
			local uiPos = self:ConvertPosToUI(pos)

			obj.transform.position = uiPos

			local btnCell = HomeLandGuideBtnCell.__New(obj)

			btnCell.callBackSelf = self.delegateClickRoom

			btnCell:SetData(v.Id)

			self.buttons[v.Id] = btnCell
			self.roomTransforms[v.Id] = roomTransform.position

			self:CreateFunctionBtn(v.Id)
		end
	end
end

function HomeLandChooseGuideView:CreateFunctionBtn(roomID)
	for i, v in ipairs(Constant.HomelandRoomFunDecorates) do
		local object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. roomID .. "/Objects/decorate_" .. v .. "/EntityObject_" .. v .. "/Image_centre")

		if object == nil then
			object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. roomID .. "/Objects/decorate_" .. v .. "/UIObj")
		end

		if object then
			local cfgDecorate = CfgHomeLandDecorateTable[v]

			if cfgDecorate.FunctionBuilding > 0 and self.roomTransforms[v] == nil then
				local obj = UnityEngine.Object.Instantiate(self.BtnGuide)

				obj:SetActive(true)

				obj.name = "Decorate" .. v

				obj.transform:SetParent(self.GuidePos.transform, false)

				local objTransform = object.transform
				local pos = objTransform.position
				local uiPos = self:ConvertPosToUI(pos)

				obj.transform.position = uiPos

				local size, pos = self:GetSize(cfgDecorate.FunctionBuilding)

				obj.transform.sizeDelta = size

				local btnCell = HomeLandGuideBtnCell.__New(obj)

				btnCell.callBackSelf = self.delegateClickObj

				btnCell:SetData(v)

				self.functionButtons[v] = btnCell
				self.roomTransforms[v] = objTransform.position + pos
			end
		end
	end
end

function HomeLandChooseGuideView:GetSize(functionBuilding)
	local size, pos = HomeLandChooseCastleApi:GetString("FunctionBuildGuideSize", functionBuilding)

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		size = size * (34 / UnityEngine.Camera.main.orthographicSize)
	end

	return size, pos
end

function HomeLandChooseGuideView:OnRoomCreateArgs(sender, args)
	if self.isCreate == false then
		return
	end

	self.isUpdate = false

	self:CreateFunctionBtn(args.RoomID)

	self.isUpdate = true
end

function HomeLandChooseGuideView:OnClickRoom(roomID)
	local pos = self.roomTransforms[roomID]

	GameEntry.LuaEvent:Fire(nil, HomelandSelectRoomEventArgs():Fill(roomID, true, pos))
end

function HomeLandChooseGuideView:OnClickObj(data)
	GameEntry.LuaEvent:Fire(nil, HomelandClickFunctionDecorationEventArgs():Fill(data, true))
end

function HomeLandChooseGuideView:OnDragIng()
	if self.buttons == nil or self.roomTransforms == nil then
		return
	end

	for i, v in pairs(self.buttons) do
		local btnCell = self.buttons[i]
		local pos = self.roomTransforms[i]
		local uiPos = self:ConvertPosToUI(pos)

		btnCell.goView.transform.position = uiPos
	end

	for i, v in pairs(self.functionButtons) do
		local btnCell = self.functionButtons[i]
		local pos = self.roomTransforms[i]
		local uiPos = self:ConvertPosToUI(pos)

		btnCell.goView.transform.position = uiPos

		local cfgDecorate = CfgHomeLandDecorateTable[i]
		local size, pos = self:GetSize(cfgDecorate.FunctionBuilding)

		btnCell.goView.transform.sizeDelta = size
	end
end

function HomeLandChooseGuideView:ConvertPosToUI(pos)
	local canvas = self.rootParent:GetComponent("Canvas")
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, canvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

function HomeLandChooseGuideView:Dispose()
	self:RemoveEventListener()

	for i, v in pairs(self.buttons) do
		v:Dispose()
	end

	for i, v in pairs(self.functionButtons) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function HomeLandChooseGuideView:Open()
	self.isCreate = false
	self.isUpdate = false

	self.rootUI:SetActive(true)
end

function HomeLandChooseGuideView:Close()
	self.rootUI:SetActive(false)
end

return HomeLandChooseGuideView
