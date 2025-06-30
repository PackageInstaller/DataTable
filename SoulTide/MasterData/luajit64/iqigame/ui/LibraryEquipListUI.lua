-- chunkname: @IQIGame\\UI\\LibraryEquipListUI.lua

local LibraryEquipListUI = Base:Extend("LibraryEquipListUI", "IQIGame.Onigao.UI.LibraryEquipListUI", {})
local equipTypeToggles = {
	{
		-1,
		LibraryEquipApi:GetString("EquipType", -1)
	},
	{
		5,
		LibraryEquipApi:GetString("EquipType", 5)
	},
	{
		4,
		LibraryEquipApi:GetString("EquipType", 4)
	},
	{
		3,
		LibraryEquipApi:GetString("EquipType", 3)
	},
	{
		2,
		LibraryEquipApi:GetString("EquipType", 2)
	}
}
local LibraryEquipCell = require("IQIGame.UI.Library.LibraryEquipCell")

function LibraryEquipListUI:OnInit()
	UGUIUtil.SetText(self.EquipListTitle, LibraryEquipApi:GetString("EquipListTitle"))

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateTaskCommitResponse(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	function self.delegateBtnReward()
		self:OnClickBtnReward()
	end

	self.scrollTypeList = self.EquipQuality:GetComponent("ScrollAreaList")

	function self.scrollTypeList.onRenderCell(gridCell)
		self:OnRenderTypeCell(gridCell)
	end

	function self.scrollTypeList.onSelectedCell(gridCell)
		self:OnSelectedTypeCell(gridCell)
	end

	self.scrollEquipList = self.EquipList:GetComponent("ScrollAreaList")

	function self.scrollEquipList.onRenderCell(gridCell)
		self:OnRenderEquipGridCell(gridCell)
	end

	function self.scrollEquipList.onSelectedCell(gridCell)
		self:OnSelectedEquipGridCell(gridCell)
	end
end

function LibraryEquipListUI:GetPreloadAssetPaths()
	return nil
end

function LibraryEquipListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryEquipListUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryEquipListUI:GetBGM(userData)
	return nil
end

function LibraryEquipListUI:OnOpen(userData)
	self.showToggles = self:GetShowToggles()

	self.scrollTypeList:Refresh(#self.showToggles)
	self:UpdateReward()
	self:ShowEquipList()
end

function LibraryEquipListUI:OnClose(userData)
	return
end

function LibraryEquipListUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnRewardBox:GetComponent("Button").onClick:AddListener(self.delegateBtnReward)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
end

function LibraryEquipListUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnRewardBox:GetComponent("Button").onClick:RemoveListener(self.delegateBtnReward)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
end

function LibraryEquipListUI:OnPause()
	return
end

function LibraryEquipListUI:OnResume()
	return
end

function LibraryEquipListUI:OnCover()
	return
end

function LibraryEquipListUI:OnReveal()
	return
end

function LibraryEquipListUI:OnRefocus(userData)
	return
end

function LibraryEquipListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryEquipListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryEquipListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryEquipListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryEquipListUI:OnDestroy()
	LibraryEquipCell.DisposeIn(self)
end

function LibraryEquipListUI:GetShowToggles()
	local tab = {}

	for i = 1, #equipTypeToggles do
		local t = equipTypeToggles[i]
		local num = self:GetEquipNum(t[1])

		if num > 0 then
			table.insert(tab, t)
		end
	end

	return tab
end

function LibraryEquipListUI:GetEquipNum(type)
	local equip = TownLibraryModule.EquipTab
	local num1 = 0
	local equipDateTab = {}

	for i, v in pairs(equip) do
		if type == -1 then
			if v.cfgInfo.ExclusiveSoul > 0 then
				if v.isLock == true then
					num1 = num1 + 1
				end

				table.insert(equipDateTab, v)
			end
		elseif v.cfgInfo.Quality == type and v.cfgInfo.ExclusiveSoul == 0 then
			if v.isLock == true then
				num1 = num1 + 1
			end

			table.insert(equipDateTab, v)
		end
	end

	return #equipDateTab
end

function LibraryEquipListUI:SetToggleTypeSelect(togObj, isSelect)
	if togObj then
		togObj.transform:Find("goDown").gameObject:SetActive(not isSelect)
		togObj.transform:Find("goUp").gameObject:SetActive(isSelect)
	end
end

function LibraryEquipListUI:OnSelectedTypeCell(cell)
	self.selectEquipType = self.showToggles[cell.index + 1]

	if self.selectObj ~= nil then
		self:SetToggleTypeSelect(self.selectObj, false)
	end

	self.selectObj = cell.gameObject.gameObject

	self:SetToggleTypeSelect(self.selectObj, true)
	self:ShowEquipList()
end

function LibraryEquipListUI:OnRenderTypeCell(cell)
	local storyType = self.showToggles[cell.index + 1]

	if storyType == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local item = cell.gameObject

	item:SetActive(true)

	item.transform:Find("goDown/Text").gameObject:GetComponent("Text").text = storyType[2]
	item.transform:Find("goUp/Text").gameObject:GetComponent("Text").text = storyType[2]

	if self.selectEquipType ~= nil then
		if self.selectEquipType[1] == storyType[1] then
			self.selectObj = item

			self:SetToggleTypeSelect(self.selectObj, true)
		else
			self:SetToggleTypeSelect(item, false)
		end
	else
		self.selectEquipType = storyType
		self.selectObj = item

		self:SetToggleTypeSelect(self.selectObj, true)
	end
end

function LibraryEquipListUI:ShowEquipList()
	self.equipDateTab = {}

	local type = self.selectEquipType[1]
	local equip = TownLibraryModule.EquipTab
	local num1 = 0

	for i, v in pairs(equip) do
		if type == -1 then
			if v.cfgInfo.ExclusiveSoul > 0 then
				if v.isLock == true then
					num1 = num1 + 1
				end

				table.insert(self.equipDateTab, v)
			end
		elseif v.cfgInfo.Quality == type and v.cfgInfo.ExclusiveSoul == 0 then
			if v.isLock == true then
				num1 = num1 + 1
			end

			table.insert(self.equipDateTab, v)
		end
	end

	table.sort(self.equipDateTab, function(a, b)
		return a.cfgID < b.cfgID
	end)
	self.scrollEquipList:Refresh(#self.equipDateTab)
	UGUIUtil.SetText(self.TextNum, LibraryEquipApi:GetString("TextNum", num1, #self.equipDateTab))
end

function LibraryEquipListUI:OnRenderEquipGridCell(cell)
	local equipData = self.equipDateTab[cell.index + 1]

	if equipData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local itemCell = LibraryEquipCell.PackageOrReuseView(self, cell.gameObject)

	itemCell:SetData(equipData)
end

function LibraryEquipListUI:OnSelectedEquipGridCell(cell)
	UIModule.Open(Constant.UIControllerName.LibraryEquipInfoUI, Constant.UILayer.UI, {
		self.equipDateTab,
		cell.index + 1
	})
end

function LibraryEquipListUI:OnTaskCommitResponse(cids, awards)
	self:UpdateReward()
end

function LibraryEquipListUI:UpdateReward()
	local red = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeEquipment)

	self.ImgRedPoint:SetActive(red)

	local num, totalNum = TownLibraryModule.GetUnLockEquipmentRes()

	UGUIUtil.SetText(self.TextReward, LibraryEquipApi:GetString("TextReward", num, totalNum))

	self.ImgReward:GetComponent("Image").fillAmount = num / totalNum
end

function LibraryEquipListUI:OnClickBtnReward()
	UIModule.Open(Constant.UIControllerName.LibraryRewardUI, Constant.UILayer.UI, Constant.LibraryTaskType.TaskTypeEquipment)
end

function LibraryEquipListUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryEquipListUI)
end

return LibraryEquipListUI
