-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandBuildingBubbleView.lua

local HomeLandBuildingBubbleView = {
	tipIcons = {},
	funObjTransforms = {}
}
local HomeLandCastleTipIcon = require("IQIGame.UI.HomeLand.HomeLandCastleTipIcon")

function HomeLandBuildingBubbleView.__New(ui, parent)
	local o = Clone(HomeLandBuildingBubbleView)

	o:InitView(ui, parent)

	return o
end

function HomeLandBuildingBubbleView:InitView(ui, rootParent)
	self.rootUI = ui
	self.rootParent = rootParent

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.canvas = self.rootParent.UIController.gameObject:GetComponent("Canvas")

	function self.delegateOnHomelandDragIngEventArgs(sender, args)
		self:OnDragIng(sender, args)
	end

	function self.delegateOnHomelandLookObjEventArgs(sender, args)
		self:OnLookObjEventArgs(sender, args)
	end

	function self.delegateUpdatePlantEvent(buildingCid, lands)
		self:UpdatePlantEvent(buildingCid, lands)
	end

	function self.delegateUpdateCookingEvent(buildCid)
		self:UpdateCookingEvent(buildCid)
	end

	function self.delegateManufactureResultEvent(buildCid)
		self:UpdateManufactureResultEvent(buildCid)
	end

	function self.delegateHomeLandUpdateBuildWork(buildCid)
		self:UpdateBuildWork(buildCid)
	end
end

function HomeLandBuildingBubbleView:AddEventListener()
	GameEntry.LuaEvent:Subscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
	GameEntry.LuaEvent:Subscribe(HomelandLookObjEventArgs.EventId, self.delegateOnHomelandLookObjEventArgs)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdatePlantEvent, self.delegateUpdatePlantEvent)
	EventDispatcher.AddEventListener(EventID.UpdateCookingEvent, self.delegateUpdateCookingEvent)
	EventDispatcher.AddEventListener(EventID.HomeLandManufactureResultEvent, self.delegateManufactureResultEvent)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateBuildWork, self.delegateHomeLandUpdateBuildWork)
end

function HomeLandBuildingBubbleView:RemoveEventListener()
	GameEntry.LuaEvent:Unsubscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
	GameEntry.LuaEvent:Unsubscribe(HomelandLookObjEventArgs.EventId, self.delegateOnHomelandLookObjEventArgs)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdatePlantEvent, self.delegateUpdatePlantEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateCookingEvent, self.delegateUpdateCookingEvent)
	EventDispatcher.RemoveEventListener(EventID.HomeLandManufactureResultEvent, self.delegateManufactureResultEvent)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateBuildWork, self.delegateHomeLandUpdateBuildWork)
end

function HomeLandBuildingBubbleView:OnDragIng(sender, args)
	for i, v in ipairs(self.tipIcons) do
		local tr = self.funObjTransforms[i]

		if tr == nil or LuaCodeInterface.GameObjIsDestroy(tr) then
			return
		end

		local tipIcon = self.tipIcons[i]

		if tipIcon then
			local uiPos = self:ConvertPosToUI(tr.position)

			tipIcon.goView.transform.position = uiPos
		end
	end
end

function HomeLandBuildingBubbleView:OnLookObjEventArgs(sender, args)
	if HomeLandLuaModule.cameraPosition == args.Position and HomeLandLuaModule.cameraSize == args.TargetSize then
		local time = Timer.New(function()
			self.rootUI:SetActive(true)
			self:OnDragIng()
		end, 0.5)

		time:Start()
	else
		self.rootUI:SetActive(false)
	end
end

function HomeLandBuildingBubbleView:UpDataView(roomPOD)
	self.roomPOD = roomPOD

	if UnityEngine.GameObject.Find("Root") == nil or self.roomPOD == nil then
		return
	end

	self.funRoomDic = {}

	for i, v in pairs(Constant.HomelandRoomFunDecorates) do
		local object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. self.roomPOD.cid .. "/Objects/decorate_" .. v)

		if object then
			local cfgDecorate = CfgHomeLandDecorateTable[v]

			if cfgDecorate.FunctionBuilding > 0 and cfgDecorate.FunctionBuilding ~= 36000004 then
				local homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(cfgDecorate.FunctionBuilding)
				local isGetReward = false

				if homeLandBuildingData.plantDataTab and #homeLandBuildingData.plantDataTab > 0 then
					self.funRoomDic = homeLandBuildingData:GetRewardPlants()
				else
					isGetReward = homeLandBuildingData:IsGetReward()

					if isGetReward then
						table.insert(self.funRoomDic, v)
					end
				end
			end

			self:PlayDecorateEffect(v)
		end
	end

	for i, v in ipairs(self.tipIcons) do
		v:Dispose()
	end

	self.tipIcons = {}
	self.funObjTransforms = {}

	for i, v in pairs(self.funRoomDic) do
		local obj = UnityEngine.Object.Instantiate(self.Mould)

		obj:SetActive(true)
		obj.transform:SetParent(self.Point.transform, false)

		local object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. self.roomPOD.cid .. "/Objects/decorate_" .. v)
		local transform = object.transform:Find("EntityObject_" .. v .. "/Image_centre")

		if transform == nil then
			logError("没有找到" .. v .. "物件的 Image_centre挂点信息")
		end

		local pos = transform.position
		local uiPos = self:ConvertPosToUI(pos)

		obj.transform.position = uiPos

		local cfgDecorate = CfgHomeLandDecorateTable[v]
		local tipIcon = HomeLandCastleTipIcon.__New(obj)

		tipIcon:SetData(cfgDecorate.FunctionBuilding)

		self.tipIcons[i] = tipIcon
		self.funObjTransforms[i] = transform
	end

	self:OnDragIng()
end

function HomeLandBuildingBubbleView:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = self.canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, self.canvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

function HomeLandBuildingBubbleView:PlayDecorateEffect(decorateCid)
	if decorateCid == 401057 then
		local decorate = CfgHomeLandDecorateTable[decorateCid]
		local homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(decorate.FunctionBuilding)
		local isCooking = false

		if homeLandBuildingData then
			local kitchenPOD = homeLandBuildingData.buildingPOD.kitchenPOD

			for i = 1, kitchenPOD.maxQueueCount do
				local culinaryPOD = kitchenPOD.culinarys[i]

				if culinaryPOD ~= nil and culinaryPOD.status == 1 then
					isCooking = true

					break
				end
			end
		end
	end
end

function HomeLandBuildingBubbleView:UpdatePlantEvent(buildingCid)
	self:UpdateTipEvent(buildingCid)
end

function HomeLandBuildingBubbleView:UpdateCookingEvent(buildingCid)
	self:UpdateTipEvent(buildingCid)
end

function HomeLandBuildingBubbleView:UpdateManufactureResultEvent(buildingCid)
	self:UpdateTipEvent(buildingCid)
end

function HomeLandBuildingBubbleView:UpdateBuildWork(buildingCid)
	self:UpdateTipEvent(buildingCid)
end

function HomeLandBuildingBubbleView:UpdateTipEvent(buildingCid)
	local cfgBuild = CfgHomeLandBuildingTable[buildingCid]

	if self.roomPOD and self.roomPOD.cid == cfgBuild.BelongRoom then
		self:UpDataView(self.roomPOD)
	end
end

function HomeLandBuildingBubbleView:Dispose()
	for i, v in ipairs(self.tipIcons) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function HomeLandBuildingBubbleView:Open()
	self.rootUI:SetActive(true)
	self:AddEventListener()
end

function HomeLandBuildingBubbleView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return HomeLandBuildingBubbleView
