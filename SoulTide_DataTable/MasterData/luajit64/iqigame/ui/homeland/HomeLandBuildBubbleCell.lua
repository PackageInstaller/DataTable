-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandBuildBubbleCell.lua

local HomeLandBuildBubbleCell = {}

function HomeLandBuildBubbleCell.New(view)
	local obj = Clone(HomeLandBuildBubbleCell)

	obj:Init(view)

	return obj
end

function HomeLandBuildBubbleCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnSelf()
		self:OnClickBtnSelf()
	end

	function self.delegateOnHomelandDragIngEventArgs(sender, args)
		self:OnDragIng(sender, args)
	end

	self:AddListener()
end

function HomeLandBuildBubbleCell:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
	GameEntry.LuaEvent:Subscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandBuildBubbleCell:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
	GameEntry.LuaEvent:Unsubscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandBuildBubbleCell:OnClickBtnSelf()
	if self.isEmptyQueue then
		GameEntry.LuaEvent:Fire(nil, HomelandClickFunctionDecorationEventArgs():Fill(self.decorateId, true))
	elseif self.isGetReward then
		local cfgDecorate = CfgHomeLandDecorateTable[self.decorateId]

		if cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildPlant then
			local landCid
			local homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(cfgDecorate.FunctionBuilding)

			for i, v in pairs(homeLandBuildingData.plantDataTab) do
				if v.decorateCid == self.decorateId then
					landCid = v.landPOD.cid

					break
				end
			end

			if landCid then
				self.View:SetActive(false)
				HomeLandLuaModule.HarvestLand(Constant.HomelandBuildType.BuildPlant, landCid)
			end
		elseif cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildGold then
			HomeLandLuaModule.HarvestBuilding(Constant.HomelandBuildType.BuildGold)
		elseif cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildManufacture then
			HomeLandManufactureMould.RewardMake(Constant.HomelandBuildType.BuildManufacture, -1)
		elseif cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildCooking then
			HomeLandLuaModule.RewardCook(Constant.HomelandBuildType.BuildCooking, -1)
		elseif cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildWork then
			HLWorkModule.ReqGetReward(Constant.HomelandBuildType.BuildWork, -1)
		end
	end
end

function HomeLandBuildBubbleCell:SetData(roomID, decorateId, canvas)
	self.roomID = roomID
	self.decorateId = decorateId
	self.canvas = canvas

	local cfgDecorate = CfgHomeLandDecorateTable[decorateId]
	local homeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(cfgDecorate.FunctionBuilding)

	self.isGetReward = homeLandBuildingData:IsGetReward()
	self.isEmptyQueue = homeLandBuildingData:IsEmptyQueue()

	local pathIcon, pathBg

	if self.isEmptyQueue then
		pathBg = HomeLandChooseCastleApi:GetString("ImgBuildBubbleBgPath", 1)
		pathIcon = HomeLandChooseCastleApi:GetString("ImgBuildBubbleIconPath", cfgDecorate.FunctionBuilding)
	elseif self.isGetReward then
		local itemID

		pathBg = HomeLandChooseCastleApi:GetString("ImgBuildBubbleBgPath", 2)

		if cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildWork then
			pathIcon = HomeLandChooseCastleApi:GetString("ImgBuildBubbleWorkPath")
		elseif cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildGold then
			for k, v in pairs(homeLandBuildingData.buildingPOD.productionData.output) do
				if k > 0 then
					itemID = k

					break
				end
			end
		elseif cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildManufacture then
			for i, v in pairs(homeLandBuildingData.buildingPOD.manufacture.makes) do
				if v.cid > 0 then
					local cfgManufactureItem = CfgHomeLandManufactureItemTable[v.cid]

					itemID = cfgManufactureItem.GetItem

					break
				end
			end
		elseif cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildPlant then
			for i, v in pairs(homeLandBuildingData.plantDataTab) do
				if v.decorateCid == decorateId and v.landPOD.currentSeedCid > 0 then
					local cfgPlant = CfgHomeLandPlantTable[v.landPOD.currentSeedCid]

					itemID = cfgPlant.PlantItem

					break
				end
			end
		elseif cfgDecorate.FunctionBuilding == Constant.HomelandBuildType.BuildCooking then
			for i, v in pairs(homeLandBuildingData.buildingPOD.kitchenPOD.culinarys) do
				if v.cid > 0 then
					itemID = CfgCookCombinationTable[v.cid].ItemId[1]

					break
				end
			end
		end

		if itemID ~= nil and itemID > 0 then
			local cfgItemData = CfgItemTable[itemID]

			pathIcon = UIGlobalApi.GetIconPath(cfgItemData.Icon)
		end
	end

	if pathIcon then
		AssetUtil.LoadImage(self, pathIcon, self.ImgIcon:GetComponent("Image"))
	end

	if pathBg then
		AssetUtil.LoadImage(self, pathBg, self.ImgBg:GetComponent("Image"))
	end

	self:UpdatePos()
end

function HomeLandBuildBubbleCell:UpdatePos()
	local object = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. self.roomID .. "/Objects/decorate_" .. self.decorateId)

	if object then
		local transform = object.transform:Find("EntityObject_" .. self.decorateId .. "/Image_show")

		if transform == nil then
			transform = object.transform:Find("EntityObject_" .. self.decorateId .. "/Image_centre")
		end

		if transform ~= nil then
			local pos = transform.position
			local uiPos = self:ConvertPosToUI(pos)

			self.View.transform.position = uiPos
		end
	end
end

function HomeLandBuildBubbleCell:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = self.canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, self.canvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

function HomeLandBuildBubbleCell:OnDragIng(sender, args)
	self:UpdatePos()
end

function HomeLandBuildBubbleCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return HomeLandBuildBubbleCell
