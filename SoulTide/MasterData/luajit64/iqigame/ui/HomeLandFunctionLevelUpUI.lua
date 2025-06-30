-- chunkname: @IQIGame\\UI\\HomeLandFunctionLevelUpUI.lua

local HomeLandFunctionLevelUpUI = Base:Extend("HomeLandFunctionLevelUpUI", "IQIGame.Onigao.UI.HomeLandFunctionLevelUpUI", {
	EntityId = 0,
	lastShowEntityCid = 0,
	isHaveItem = false,
	textDesTable = {},
	textLevelUpValueUpTable = {},
	NeedItemCell = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local HomeLandNeedItemCell = require("IQIGame.UI.HomeLandManufacture.HomeLandNeedItemCell")
local HomeLandBuildingLevelDesCell = require("IQIGame.UI.HomeLandBuilding.HomeLandBuildingLevelDesCell")
local HomeLandBuildingLevelUpTextValueCell = require("IQIGame.UI.HomeLandBuilding.HomeLandBuildingLevelUpTextValueCell")

function HomeLandFunctionLevelUpUI:OnInit()
	UGUIUtil.SetText(self.TextRightTitle1, HomeLandFunctionLevelUpUIApi:GetString("TextRightTitle1"))
	UGUIUtil.SetText(self.TextRightTitle2, HomeLandFunctionLevelUpUIApi:GetString("TextRightTitle2"))
	UGUIUtil.SetText(self.TextRightTitle3, HomeLandFunctionLevelUpUIApi:GetString("TextRightTitle3"))
	UGUIUtil.SetText(self.TextBtnLevelUp, HomeLandFunctionLevelUpUIApi:GetString("TextBtnLevelUp"))
	UGUIUtil.SetText(self.TextMax1, HomeLandFunctionLevelUpUIApi:GetString("TextMax1"))
	UGUIUtil.SetText(self.TextMax2, HomeLandFunctionLevelUpUIApi:GetString("TextMax2"))

	local desStrTab = HomeLandFunctionLevelUpUIApi:GetString("TextLeftGrid")

	self.textDesTable = {}

	for i = 1, #desStrTab do
		local str = desStrTab[i]
		local obj = UnityEngine.Object.Instantiate(self.LeftTextMould)

		obj.transform:SetParent(self.LeftGrid.transform, false)
		obj:SetActive(true)

		local textLevelDesCell = HomeLandBuildingLevelDesCell.New(obj)

		textLevelDesCell:SetTextValue(str)
		table.insert(self.textDesTable, textLevelDesCell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnLevelUp()
		self:OnBtnLevelUp()
	end

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.delegateHomeUpdateBuildingEvent(cfgBuildingID)
		self:OnHomeUpdateBuildingEvent(cfgBuildingID)
	end

	self.ItemCellPool = UIObjectPool.New(10, function()
		return HomeLandNeedItemCell.New(UnityEngine.Object.Instantiate(self.NeedItem))
	end, function(cell)
		cell:Dispose()
	end)
end

function HomeLandFunctionLevelUpUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandFunctionLevelUpUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandFunctionLevelUpUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandFunctionLevelUpUI:GetBGM(userData)
	return nil
end

function HomeLandFunctionLevelUpUI:OnOpen(userData)
	self.Effect:SetActive(false)

	self.lastShowEntityCid = 0

	local cfgBuildingID = userData[1]

	self.decorate = userData[2]
	self.buildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuildingID)

	self:UpdateView()
end

function HomeLandFunctionLevelUpUI:OnClose(userData)
	return
end

function HomeLandFunctionLevelUpUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnLevelUp:GetComponent("Button").onClick:AddListener(self.delegateBtnLevelUp)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandFunctionLevelUpUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnLevelUp:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLevelUp)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandFunctionLevelUpUI:OnPause()
	return
end

function HomeLandFunctionLevelUpUI:OnResume()
	return
end

function HomeLandFunctionLevelUpUI:OnCover()
	return
end

function HomeLandFunctionLevelUpUI:OnReveal()
	return
end

function HomeLandFunctionLevelUpUI:OnRefocus(userData)
	return
end

function HomeLandFunctionLevelUpUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandFunctionLevelUpUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandFunctionLevelUpUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandFunctionLevelUpUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandFunctionLevelUpUI:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:HideEntity()

	for i, v in pairs(self.textDesTable) do
		v:Dispose()
	end

	for i, v in pairs(self.textLevelUpValueUpTable) do
		v:Dispose()
	end

	for i, v in pairs(self.NeedItemCell) do
		self.ItemCellPool:Release(v)
	end

	self.NeedItemCell = {}

	self.ItemCellPool:Dispose()
end

function HomeLandFunctionLevelUpUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandFunctionLevelUpUI)
end

function HomeLandFunctionLevelUpUI:OnHomeUpdateBuildingEvent(cfgBuildingID)
	if self.buildingData ~= nil and self.buildingData.cfgBuildingID == cfgBuildingID then
		self.buildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuildingID)

		self:UpdateView()
	end
end

function HomeLandFunctionLevelUpUI:UpdateView()
	if self.buildingData then
		local lv, maxLv = self.buildingData:GetBuildingLvAndMaxLv()
		local isFullLv = lv == maxLv

		self.Max1:SetActive(isFullLv)
		self.Max2:SetActive(isFullLv)
		self.view1:SetActive(not isFullLv)
		self.view2:SetActive(not isFullLv)

		self.currentCfgBuildingLevel = self.buildingData:GetCfgBuildLevelUpByLv(lv)
		self.nextCfgBuildingLevel = self.buildingData:GetCfgBuildLevelUpByLv(lv + 1)

		UGUIUtil.SetText(self.TextLeftTitle1, HomeLandFunctionLevelUpUIApi:GetString("TextLeftTitle1", self.buildingData.cfgBuilding.Name, lv))

		local roomData = HomeLandLuaModule.GetRoomDataByID(self.buildingData.cfgBuilding.BelongRoom)
		local index = 1

		for i = 1, #self.currentCfgBuildingLevel.SuitID do
			local suitId = self.currentCfgBuildingLevel.SuitID[i]

			if suitId == roomData.suitCid then
				index = i

				break
			end
		end

		local entity = self.currentCfgBuildingLevel.EntityID[index]

		if entity > 0 and self.lastShowEntityCid ~= entity then
			self.lastShowEntityCid = entity

			self:ShowElement(self.lastShowEntityCid)
		end

		for i, v in pairs(self.textLevelUpValueUpTable) do
			v:Dispose()
		end

		self.textLevelUpValueUpTable = {}

		for i = 1, #self.currentCfgBuildingLevel.NowLevelEffect do
			local str1 = self.currentCfgBuildingLevel.NowLevelEffect[i]

			str1 = str1 == nil and "" or str1

			local str2 = self.currentCfgBuildingLevel.NextLevelEffect[i]

			str2 = str2 == nil and "" or str2

			local obj = UnityEngine.Object.Instantiate(self.RightTextMould)

			obj.transform:SetParent(self.RightGrid.transform, false)
			obj:SetActive(true)

			local textLevelUpCell = HomeLandBuildingLevelUpTextValueCell.New(obj)

			textLevelUpCell:SetTextValue(str1, str2)
			table.insert(self.textLevelUpValueUpTable, textLevelUpCell)
		end

		self.isHaveItem = true

		for i, v in pairs(self.NeedItemCell) do
			self.ItemCellPool:Release(v)
		end

		self.NeedItemCell = {}

		for i = 1, #self.nextCfgBuildingLevel.Cost, 2 do
			local id = self.nextCfgBuildingLevel.Cost[i]
			local needNum = self.nextCfgBuildingLevel.Cost[i + 1]
			local haveNum = WarehouseModule.GetItemNumByCfgID(id)
			local itemCell = self.ItemCellPool:Obtain()

			itemCell.View:SetActive(true)
			itemCell.View.transform:SetParent(self.ItemGrid.transform, false)
			itemCell:SetItemByCID(id)
			itemCell:SetCustomNum(haveNum, needNum)
			table.insert(self.NeedItemCell, itemCell)

			if self.isHaveItem then
				self.isHaveItem = needNum <= haveNum
			end
		end
	end
end

function HomeLandFunctionLevelUpUI:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIHomelandElement(self.EntityId, elementEntityCid, 0, self.Point.transform)
end

function HomeLandFunctionLevelUpUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function HomeLandFunctionLevelUpUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		local spineState = args.Entity.gameObject
		local scale = Vector3.New(self.currentCfgBuildingLevel.ShowUiSize, self.currentCfgBuildingLevel.ShowUiSize, self.currentCfgBuildingLevel.ShowUiSize)
		local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.buildingData.cfgBuilding.BelongRoom)
		local index = 1

		for i = 1, #self.currentCfgBuildingLevel.SuitID do
			local suitCid = self.currentCfgBuildingLevel.SuitID[i]

			if suitCid == roomPOD.suitCid then
				index = i

				break
			end
		end

		local pos = Vector3.New(self.currentCfgBuildingLevel.ShowUIPosition[index][1], self.currentCfgBuildingLevel.ShowUIPosition[index][2], self.currentCfgBuildingLevel.ShowUIPosition[index][3])

		spineState.transform.localScale = scale
		spineState.transform.localPosition = pos

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")

		local spriteRenderers = spineState:GetComponentsInChildren(typeof(UnityEngine.SpriteRenderer))

		for i = 0, spriteRenderers.Length - 1 do
			spriteRenderers[i].maskInteraction = UnityEngine.SpriteMaskInteraction.VisibleInsideMask
		end
	end
end

function HomeLandFunctionLevelUpUI:OnBtnLevelUp()
	if self.isHaveItem == false then
		NoticeModule.ShowNoticeByType(1, HomeLandFunctionLevelUpUIApi:GetString("ErrorMsg1"))

		return
	end

	local lv, maxLv = self.buildingData:GetBuildingLvAndMaxLv()

	if maxLv <= lv then
		NoticeModule.ShowNoticeByType(1, HomeLandFunctionLevelUpUIApi:GetString("ErrorMsg2"))

		return
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = Timer.New(function()
		self.Effect:SetActive(false)

		self.BtnLevelUp:GetComponent("Button").enabled = true

		HomeLandLuaModule.UpdateBuildingLv(self.buildingData.cfgBuildingID)
	end, 2)
	self.BtnLevelUp:GetComponent("Button").enabled = false

	self.Effect:SetActive(true)
	self.timer:Start()
end

return HomeLandFunctionLevelUpUI
