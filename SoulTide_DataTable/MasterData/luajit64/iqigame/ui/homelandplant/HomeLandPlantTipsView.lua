-- chunkname: @IQIGame\\UI\\HomeLandPlant\\HomeLandPlantTipsView.lua

local HomeLandPlantTipsView = {
	EntityId = 0,
	plantItemCells = {}
}
local HomeLandPlantItemCell = require("IQIGame.UI.HomeLandPlant.HomeLandPlantItemCell")

function HomeLandPlantTipsView.New(view, RewardMould)
	local obj = Clone(HomeLandPlantTipsView)

	obj:Init(view, RewardMould)

	return obj
end

function HomeLandPlantTipsView:Init(view, RewardMould)
	self.View = view
	self.RewardMould = RewardMould

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextSeedTime, HomeLandPlantUIApi:GetString("TextSeedTime"))
	UGUIUtil.SetText(self.TextFinishMsg, HomeLandPlantUIApi:GetString("TextFinishMsg"))

	self.btnClose = self.BtnClose:GetComponent("Button")

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.delegateBtnClose()
		self:Close()
	end

	self:AddEventListener()
end

function HomeLandPlantTipsView:AddEventListener()
	self.btnClose.onClick:AddListener(self.delegateBtnClose)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function HomeLandPlantTipsView:RemoveEventListener()
	self.btnClose.onClick:RemoveListener(self.delegateBtnClose)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function HomeLandPlantTipsView:UpdateView(selectCfgData)
	self.selectCfgData = selectCfgData

	if self.selectCfgData then
		local cfgItem = CfgItemTable[self.selectCfgData.CostItem]

		self.haveNum = WarehouseModule.GetItemNumByCfgID(self.selectCfgData.CostItem)

		local itemCell = ItemCell.PackageOrReuseView(self, self.Slot.transform:GetChild(0).gameObject)

		itemCell:SetItem(cfgItem)

		local cfItem = CfgItemTable[self.selectCfgData.PlantItem]

		UGUIUtil.SetText(self.TextTitle, cfItem.Name)
		UGUIUtil.SetText(self.TextTimer, GetFormatTime(self.selectCfgData.CostTime))
		self:ShowItems()
		self:ShowElement(self.selectCfgData.EntityID)
	end
end

function HomeLandPlantTipsView:ShowItems()
	for i, v in pairs(self.plantItemCells) do
		v:Dispose()
	end

	self.plantItemCells = {}

	local itemId = self.selectCfgData.DropItem[1]

	if itemId > 0 then
		local obj = UnityEngine.Object.Instantiate(self.RewardMould)

		obj.transform:SetParent(self.RewardSlot.transform, false)
		obj:SetActive(true)

		local itemCell = HomeLandPlantItemCell:__New(obj)

		itemCell:SetDate(itemId, 1)
		table.insert(self.plantItemCells, itemCell)
	end

	local tab = {}

	for i = 1, #self.selectCfgData.RandomDropId do
		local dropTab = self.selectCfgData.RandomDropId[i]
		local isTimeout = false

		if cfgDateTimeToTimeStamp(self.selectCfgData.RandomDropStartTime[i]) < PlayerModule.GetServerTime() and cfgDateTimeToTimeStamp(self.selectCfgData.RandomDropEndTime[i]) > PlayerModule.GetServerTime() then
			isTimeout = true
		end

		if #dropTab > 0 and isTimeout then
			local id = dropTab[1]

			if id > 0 and table.indexOf(tab, id) == -1 then
				table.insert(tab, id)

				local obj = UnityEngine.Object.Instantiate(self.RewardMould)

				obj.transform:SetParent(self.RewardSlot.transform, false)
				obj:SetActive(true)

				local itemCell = HomeLandPlantItemCell:__New(obj)

				itemCell:SetDate(id, 2)
				table.insert(self.plantItemCells, itemCell)
			end
		end
	end
end

function HomeLandPlantTipsView:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIHomelandElement(self.EntityId, elementEntityCid, 0, self.SpinePos.transform)
end

function HomeLandPlantTipsView:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function HomeLandPlantTipsView:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id and self.selectCfgData ~= nil then
		local spineState = args.Entity.gameObject

		setGameObjectLayers(spineState.transform, IQIGame.Onigao.Game.Constant.Layer.DEFAULT_LAYER_NAME)

		spineState.transform.localScale = Vector3(self.selectCfgData.PrefabScale[1], self.selectCfgData.PrefabScale[2], self.selectCfgData.PrefabScale[3])
		spineState.transform.localPosition = Vector3(self.selectCfgData.PrefabPosition[1], self.selectCfgData.PrefabPosition[2], self.selectCfgData.PrefabPosition[3])

		local transforms = spineState:GetComponentsInChildren(typeof(UnityEngine.Transform), true)

		for i = 0, transforms.Length - 1 do
			transforms[i].gameObject.layer = LayerMask.NameToLayer("UI")
		end

		local skeletonAnimation = spineState:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if skeletonAnimation then
			skeletonAnimation.state:SetEmptyAnimation(0, 0)
			skeletonAnimation.state:SetAnimation(0, "ripe", true)
		end
	end
end

function HomeLandPlantTipsView:Open()
	self.View:SetActive(true)
end

function HomeLandPlantTipsView:Close()
	self:HideEntity()
	self.View:SetActive(false)
end

function HomeLandPlantTipsView:Dispose()
	self:RemoveEventListener()
	self:HideEntity()

	for i, v in pairs(self.plantItemCells) do
		v:Dispose()
	end

	self.selectCfgData = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandPlantTipsView
