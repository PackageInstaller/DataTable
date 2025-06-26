-- chunkname: @IQIGame\\UI\\MemorySettlement.lua

local MemorySettlement = Base:Extend("MemorySettlement", "IQIGame.Onigao.UI.MemorySettlement", {
	barTime = 1000,
	delayTime = 1,
	isOpen = false,
	itemList = {}
})

function MemorySettlement:OnInit()
	self:Init()
end

function MemorySettlement:GetPreloadAssetPaths()
	return nil
end

function MemorySettlement:GetOpenPreloadAssetPaths(userData)
	self.prefabPath = AssetPath.Get(GlobalKey.UIPrefabPath, "Common/CommonSlotUI")

	local path = {
		self.prefabPath
	}

	return path
end

function MemorySettlement:OnOpen(userData)
	self.openTime = PlayerModule.GetServerTime()
	self.memoryEndServerData = userData

	self:UpdateView()
end

function MemorySettlement:OnAddListeners()
	self.btnConfirmComponent.onClick:AddListener(self.delegateBtnConfirm)
end

function MemorySettlement:OnClose(userData)
	self.isOpen = false

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end
end

function MemorySettlement:OnRemoveListeners()
	self.btnConfirmComponent.onClick:RemoveListener(self.delegateBtnConfirm)
end

function MemorySettlement:OnPause()
	return
end

function MemorySettlement:OnResume()
	return
end

function MemorySettlement:OnCover()
	return
end

function MemorySettlement:OnReveal()
	return
end

function MemorySettlement:OnRefocus(userData)
	return
end

function MemorySettlement:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MemorySettlement:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MemorySettlement:OnLoadSucceed(assetName, asset, duration, userData)
	if userData == "CommonSlotUI" then
		self.commonSlotPrefab = asset
	end

	self:IsShowPanel()
end

function MemorySettlement:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MemorySettlement:OnDestroy()
	return
end

function MemorySettlement:IsShowPanel()
	return
end

function MemorySettlement:Init()
	UGUIUtil.SetText(self.TextTitle, NewMemoryUIApi:GetString("TextTitle", false))
	UGUIUtil.SetText(self.TextTitleEng, NewMemoryUIApi:GetString("TextTitle", true))
	UGUIUtil.SetText(self.TextBtnClose, NewMemoryUIApi:GetString("TextBtnClose"))

	self.btnConfirmComponent = self.BtnConfirm:GetComponent("Button")
	self.currentPerTxt = self.currentPerTxt:GetComponent("Text")

	function self.delegateBtnConfirm()
		self:OnBtnConfirm()
	end

	function self.delegateUpdateTime()
		self:UpdateTime()
	end

	function self.delegateUpdateItem(cell)
		self:UpdateItemCell(cell)
	end

	function self.delegateSelectedItem(cell)
		self:SelectedItemCell(cell)
	end
end

function MemorySettlement:UpdateView()
	self.commonSlotPrefab = self.UIController:GetPreloadedAsset(self.prefabPath)

	self.TextLvFull:SetActive(false)

	if self.memoryEndServerData ~= nil then
		self.startLv = self.memoryEndServerData.beginFavorLevel

		local soulData = SoulModule.GetSoulData(self.memoryEndServerData.soulID)
		local cfgSoulFavor = soulData:GetCfgSoulFavor(self.startLv)

		self.TextLv:GetComponent("Text").text = cfgSoulFavor.LoveStage
		self.TextLv1:GetComponent("Text").text = tostring(cfgSoulFavor.FavorDegree)
		self.currentPer = self.memoryEndServerData.beginPer
		self.ImageBar:GetComponent("Image").fillAmount = self.currentPer

		if self.memoryEndServerData.soulNewStoryPOD ~= nil then
			UGUIUtil.SetText(self.TextNewStory, CfgSoulNewStoryTable[self.memoryEndServerData.soulNewStoryPOD.cid].Name)
		else
			UGUIUtil.SetText(self.TextNewStory, self.memoryEndServerData.bigTitle)
		end

		local addLv = self.memoryEndServerData.endFavorLevel - self.memoryEndServerData.beginFavorLevel

		self.currentPerTxt.text = self.memoryEndServerData.endExp .. "/" .. self.memoryEndServerData.endExpMax .. " +" .. self.memoryEndServerData.addExp

		if addLv > 0 then
			self.des = 1 - self.memoryEndServerData.beginPer + 1 * (addLv - 1) + self.memoryEndServerData.endPer
		else
			self.des = self.memoryEndServerData.endPer - self.memoryEndServerData.beginPer
		end

		self.speed = self.des / self.barTime
		self.passTime = 0

		if self.des > 0 then
			if self.timer then
				self.timer:Stop()
			end

			self.timer = nil
			self.timer = Timer.New(self.delegateUpdateTime, 0.02, -1)

			self.timer:Start()
		end
	end

	self:ShowItems()
end

local last = 0

function MemorySettlement:UpdateTime()
	self.passTime = self.passTime + 20
	self.currentPer = self.currentPer + self.speed * 20

	local new = self.currentPer % 1

	if new < last then
		if self.memoryEndServerData.beginFavorLevel < self.memoryEndServerData.endFavorLevel then
			self.startLv = self.startLv + 1

			local soulData = SoulModule.GetSoulData(self.memoryEndServerData.soulID)
			local cfgSoulFavor = soulData:GetCfgSoulFavor(self.startLv)

			self.TextLv:GetComponent("Text").text = cfgSoulFavor.LoveStage
			self.TextLv1:GetComponent("Text").text = tostring(cfgSoulFavor.FavorDegree)
		end

		self.currentPerTxt.text = self.memoryEndServerData.endExp .. "/" .. self.memoryEndServerData.endExpMax
	end

	last = new

	if self.passTime >= self.barTime then
		self.currentPer = self.memoryEndServerData.endPer

		local soulData = SoulModule.GetSoulData(self.memoryEndServerData.soulID)
		local cfgSoulFavor = soulData:GetCfgSoulFavor(self.memoryEndServerData.endFavorLevel)

		self.TextLv:GetComponent("Text").text = cfgSoulFavor.LoveStage
		self.TextLv1:GetComponent("Text").text = tostring(cfgSoulFavor.FavorDegree)

		if self.timer then
			self.timer:Stop()
		end

		self.ImageBar:GetComponent("Image").fillAmount = self.memoryEndServerData.endPer
	else
		self.ImageBar:GetComponent("Image").fillAmount = new
	end
end

function MemorySettlement:ShowItems()
	local gridTransform = self.GridItem:GetComponent("HorizontalLayoutGroup").transform

	for i = 0, gridTransform.childCount - 1 do
		local obj = gridTransform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	if self.memoryEndServerData ~= nil then
		local itemShowPOD

		for i = 1, #self.memoryEndServerData.getItems do
			itemShowPOD = self.memoryEndServerData.getItems[i]

			local itemData = CfgItemTable[itemShowPOD.cid]
			local itemObj = UnityEngine.Object.Instantiate(self.commonSlotPrefab)

			itemObj.transform:SetParent(gridTransform, false)

			itemObj:GetComponent("RectTransform").sizeDelta = Vector2.New(100, 100)

			itemObj:SetActive(true)

			local itemCell = ItemCell.PackageOrReuseView(self, itemObj)

			itemCell:SetItem(itemData)
			itemCell:SetNum(itemShowPOD.num)
		end
	end
end

function MemorySettlement:OnBtnConfirm()
	local time = PlayerModule.GetServerTime()

	if time - self.openTime < self.delayTime then
		return
	end

	UIModule.Close(Constant.UIControllerName.MemorySettlement)

	for i, v in pairs(self.itemList) do
		UnityEngine.GameObject.DestroyImmediate(v)
	end
end

function MemorySettlement:UpdateItemCell(cell)
	local itemData = self.memoryEndServerData.getItems[cell.index + 1]

	if itemData == nil then
		cell.cacheGameObject:SetActive(false)

		return
	end

	local itemCell = ItemCell.PackageOrReuseView(self, cell.cacheGameObject, false)
	local metaItem = CfgItemTable[itemData.cid]

	itemCell:SetItem(metaItem)
	itemCell:SetNum(itemData.num)
end

function MemorySettlement:SelectedItemCell(cell)
	return
end

return MemorySettlement
