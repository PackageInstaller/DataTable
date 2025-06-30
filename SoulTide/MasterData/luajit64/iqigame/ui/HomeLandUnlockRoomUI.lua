-- chunkname: @IQIGame\\UI\\HomeLandUnlockRoomUI.lua

local HomeLandUnlockRoomUI = Base:Extend("HomeLandUnlockRoomUI", "IQIGame.Onigao.UI.HomeLandUnlockRoomUI", {
	ample = true,
	isCondition = true
})

function HomeLandUnlockRoomUI:OnInit()
	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnReachedComponent = self.BtnReached:GetComponent("Button")

	function self.delegateOnBtnClose()
		self:OnBtnClose()
	end

	function self.delegateOnBtnReached()
		self:OnBtnReached()
	end
end

function HomeLandUnlockRoomUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandUnlockRoomUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandUnlockRoomUI:OnOpen(userData)
	self.roomID = userData

	self:UpdateView()
end

function HomeLandUnlockRoomUI:OnClose(userData)
	return
end

function HomeLandUnlockRoomUI:OnAddListeners()
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateOnBtnClose)
	self.btnCloseComponent.onClick:AddListener(self.delegateOnBtnClose)
	self.btnReachedComponent.onClick:AddListener(self.delegateOnBtnReached)
end

function HomeLandUnlockRoomUI:OnRemoveListeners()
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateOnBtnClose)
	self.btnCloseComponent.onClick:RemoveListener(self.delegateOnBtnClose)
	self.btnReachedComponent.onClick:RemoveListener(self.delegateOnBtnReached)
end

function HomeLandUnlockRoomUI:OnPause()
	return
end

function HomeLandUnlockRoomUI:OnResume()
	return
end

function HomeLandUnlockRoomUI:OnCover()
	return
end

function HomeLandUnlockRoomUI:OnReveal()
	return
end

function HomeLandUnlockRoomUI:OnRefocus(userData)
	return
end

function HomeLandUnlockRoomUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandUnlockRoomUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandUnlockRoomUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandUnlockRoomUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandUnlockRoomUI:OnDestroy()
	self.roomID = nil
end

function HomeLandUnlockRoomUI:UpdateView()
	local cfgInfo = CfgHomeLandRoomTable[self.roomID]

	UGUIUtil.SetText(self.TextBtnNoReached, HomeLandChooseCastleApi:GetString("TextBtnNoReached", cfgInfo.Type))

	self.TextName:GetComponent("Text").text = cfgInfo.Name
	self.TextComfort:GetComponent("Text").text = cfgInfo.Comfort
	self.TextDes:GetComponent("Text").text = cfgInfo.Unlocking

	local cfgCondition = CfgConditionTable[cfgInfo.ConditionId]

	self.Item:SetActive(not cfgInfo.IsAutoUnLock)

	self.isCondition = ConditionModule.Check(cfgInfo.ConditionId)

	if cfgInfo.ConditionId > 0 then
		self.TextCondition:GetComponent("Text").text = HomeLandChooseCastleApi:GetString("TextCondition", cfgCondition.Name, self.isCondition)
	else
		self.TextCondition:GetComponent("Text").text = HomeLandChooseCastleApi:GetString("TextCondition", "", self.isCondition)
	end

	local parentTransform = self.ItemGrid.transform
	local prefabItem = parentTransform:GetChild(0).gameObject

	prefabItem:SetActive(false)

	for i = 1, parentTransform.childCount - 1 do
		local obj = parentTransform:GetChild(1).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	self.ample = true

	for i = 1, #cfgInfo.OpenCost, 2 do
		local needItemID = cfgInfo.OpenCost[i]
		local needNum = cfgInfo.OpenCost[i + 1]
		local haveNum = WarehouseModule.GetItemNumByCfgID(needItemID)

		if self.ample == true then
			self.ample = needNum <= haveNum
		end

		local itemData = CfgItemTable[needItemID]
		local obj = UnityEngine.Object.Instantiate(prefabItem)

		obj.transform:SetParent(parentTransform, false)
		obj:SetActive(true)

		local itemCell = ItemCell.PackageOrReuseView(self, obj)

		itemCell:SetItem(itemData)
		itemCell:SetCustomNum(haveNum, needNum)
	end
end

function HomeLandUnlockRoomUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandUnlockRoomUI)
end

function HomeLandUnlockRoomUI:OnBtnReached()
	if self.isCondition == false then
		NoticeModule.ShowNoticeByType(1, HomeLandChooseCastleApi:GetString("TextError1"))

		return
	end

	if self.ample == false then
		NoticeModule.ShowNoticeByType(1, HomeLandChooseCastleApi:GetString("TextError2"))

		return
	end

	if self.roomID ~= nil then
		HomeLandLuaModule.UnlockRoom(self.roomID)
		UIModule.Close(Constant.UIControllerName.HomeLandChangeRoomUI)
	end

	self:OnBtnClose()
end

return HomeLandUnlockRoomUI
