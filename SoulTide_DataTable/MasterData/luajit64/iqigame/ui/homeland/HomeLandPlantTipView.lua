-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandPlantTipView.lua

local HomeLandPlantTipView = {
	isCreate = false,
	plantTimeRenders = {},
	plantTransforms = {}
}
local HomeLandPlantTimeCell = require("IQIGame.UI.HomeLand.HomeLandPlantTimeCell")

function HomeLandPlantTipView.New(view, parent)
	local obj = Clone(HomeLandPlantTipView)

	obj:Init(view, parent)

	return obj
end

function HomeLandPlantTipView:Init(view, parent)
	self.View = view
	self.rootParent = parent

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnHomelandDragIngEventArgs(sender, args)
		self:OnDragIng(sender, args)
	end

	function self.delegateUpdateUnlockLandEvent()
		self:OnUpdateUnlockLandEvent()
	end
end

function HomeLandPlantTipView:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.isCreate == false and HomeLandLuaModule.isCreate then
		self:CreatePlantTimeRenders()

		self.isCreate = true

		self:UpdateLandUnlockState()
	end

	if self.isCreate then
		self:OnDragIng()
	end
end

function HomeLandPlantTipView:AddEventListener()
	EventDispatcher.AddEventListener(EventID.UpdateHomeLandUnlockLandEvent, self.delegateUpdateUnlockLandEvent)
	GameEntry.LuaEvent:Subscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandPlantTipView:RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateHomeLandUnlockLandEvent, self.delegateUpdateUnlockLandEvent)
	GameEntry.LuaEvent:Unsubscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandPlantTipView:OnUpdateUnlockLandEvent()
	self:UpdateLandUnlockState()
end

function HomeLandPlantTipView:UpdateLandUnlockState()
	if self.isCreate then
		local homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildPlant)

		for i, v in ipairs(Constant.HomelandRoomFunDecorates) do
			local object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room19/Objects/decorate_" .. v .. "/EntityObject_" .. v .. "/Image_Locked")

			if object then
				local landData = homeLandBuildingData:GetPlantDataByDecorateCid(v)

				object:SetActive(landData == nil)
			end
		end
	end
end

function HomeLandPlantTipView:ChangePlant()
	for i, v in pairs(self.plantTransforms) do
		if v ~= nil then
			return
		end
	end

	if self.isCreate then
		self:CreatePlantTimeRenders()
	end
end

function HomeLandPlantTipView:CreatePlantTimeRenders()
	self.plantTransforms = {}
	self.plantTimeRenders = {}

	for i, v in ipairs(Constant.HomelandRoomFunDecorates) do
		local object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room19/Objects/decorate_" .. v)

		if object then
			local cfgDecorate = CfgHomeLandDecorateTable[v]

			if cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildPlant then
				local obj = UnityEngine.Object.Instantiate(self.rootParent.PlantTimeMould)

				obj:SetActive(true)

				obj.name = tostring(v)
				obj.transform.localScale = self:GetSize()

				obj.transform:SetParent(self.PlantTip.transform, false)

				local objTransform = object.transform
				local pos = objTransform.position
				local uiPos = self:ConvertPosToUI(pos)

				obj.transform.position = uiPos
				obj.transform.sizeDelta = self:GetSize()

				local btnCell = HomeLandPlantTimeCell.New(obj)

				btnCell:UpdateView(v)

				self.plantTimeRenders[v] = btnCell
				self.plantTransforms[v] = objTransform.position + Vector3.New(0, 0.3, 0)
			end
		end
	end
end

function HomeLandPlantTipView:GetSize()
	local size = Vector3.New(1, 1, 1)

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		size = size * (4.7 / UnityEngine.Camera.main.orthographicSize)
	end

	return size
end

function HomeLandPlantTipView:OnDragIng()
	if self.plantTransforms == nil then
		return
	end

	for i, v in pairs(self.plantTimeRenders) do
		local itemCell = self.plantTimeRenders[i]

		if itemCell.View ~= nil and not LuaCodeInterface.GameObjIsDestroy(itemCell.View) then
			local pos = self.plantTransforms[i]
			local uiPos = self:ConvertPosToUI(pos)

			itemCell.View.transform.position = uiPos
			itemCell.View.transform.localScale = self:GetSize()
		end
	end
end

function HomeLandPlantTipView:ConvertPosToUI(pos)
	local canvas = self.rootParent.UIController.gameObject:GetComponent("Canvas")
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, canvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

function HomeLandPlantTipView:Open()
	self:AddEventListener()

	self.isCreate = false

	self.View:SetActive(true)
end

function HomeLandPlantTipView:Close()
	self:RemoveEventListener()
	self.View:SetActive(false)

	for i, v in pairs(self.plantTimeRenders) do
		v:Dispose()
	end
end

function HomeLandPlantTipView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandPlantTipView
