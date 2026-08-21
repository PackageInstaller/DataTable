-- chunkname: @IQIGame\\UI\\LibraryDialogInfoUI.lua

local LibraryDialogInfoUI = Base:Extend("LibraryDialogInfoUI", "IQIGame.Onigao.UI.LibraryDialogInfoUI", {
	selectIndex = 1,
	toggleCells = {}
})
local ToggleTownStoryType = {
	Constant.LibraryStoryResType.TownResMainType,
	Constant.LibraryStoryResType.TownResBranchType
}
local ToggleSoulStoryType = {
	Constant.LibraryStoryResType.SoulNewStoryResType,
	Constant.LibraryStoryResType.SoulDatingResType,
	Constant.LibraryStoryResType.SoulShopResType
}
local ToggleNpcStoryType = {
	Constant.LibraryStoryResType.NpcResBranchType,
	Constant.LibraryStoryResType.NpcShopResType
}
local ToggleActionStoryType = {
	Constant.LibraryStoryResType.ActionStoryMainType,
	Constant.LibraryStoryResType.ActionStoryBranchType
}
local ToggleTypes = {}

ToggleTypes[Constant.LibraryStoryType.TownStory] = ToggleTownStoryType
ToggleTypes[Constant.LibraryStoryType.SoulStory] = ToggleSoulStoryType
ToggleTypes[Constant.LibraryStoryType.NPCStory] = ToggleNpcStoryType
ToggleTypes[Constant.LibraryStoryType.ActionStory] = ToggleActionStoryType

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LibraryDialogStoryCell = require("IQIGame.UI.Library.LibraryDialogStoryCell")

function LibraryDialogInfoUI:OnInit()
	self.ToggleMould:SetActive(false)

	self.toggleCellPool = UIObjectPool.New(3, function()
		local cellObj = UnityEngine.Object.Instantiate(self.ToggleMould)

		return cellObj
	end, function(currentCell)
		UnityEngine.Object.Destroy(currentCell)
	end)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateToggleValueChange(isOn)
		self:OnToggleValueChange(isOn)
	end

	self.scrollDialogList = self.DiaLogList:GetComponent("ScrollAreaList")

	function self.scrollDialogList.onRenderCell(cell)
		self:OnRenderDialogCell(cell)
	end
end

function LibraryDialogInfoUI:GetPreloadAssetPaths()
	return nil
end

function LibraryDialogInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryDialogInfoUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryDialogInfoUI:GetBGM(userData)
	return nil
end

function LibraryDialogInfoUI:OnOpen(userData)
	self.townLibraryStoryData = userData
	self.selectIndex = 1

	self:CreateToggle()
	self:UpDateView()
end

function LibraryDialogInfoUI:OnClose(userData)
	return
end

function LibraryDialogInfoUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function LibraryDialogInfoUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)

	for i, v in pairs(self.toggleCells) do
		v:GetComponent("Toggle").onValueChanged:RemoveListener(self.delegateToggleValueChange)
	end
end

function LibraryDialogInfoUI:OnPause()
	return
end

function LibraryDialogInfoUI:OnResume()
	return
end

function LibraryDialogInfoUI:OnCover()
	return
end

function LibraryDialogInfoUI:OnReveal()
	return
end

function LibraryDialogInfoUI:OnRefocus(userData)
	return
end

function LibraryDialogInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryDialogInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryDialogInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryDialogInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryDialogInfoUI:OnDestroy()
	LibraryDialogStoryCell.DisposeIn(self)

	for i, v in pairs(self.toggleCells) do
		self.toggleCellPool:Release(v)
	end

	self.toggleCells = {}

	self.toggleCellPool:Dispose()
end

function LibraryDialogInfoUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryDialogInfoUI)
end

function LibraryDialogInfoUI:CreateToggle()
	for i, v in pairs(self.toggleCells) do
		v:GetComponent("Toggle").onValueChanged:RemoveListener(self.delegateToggleValueChange)
		v.transform:SetParent(self.UIController.gameObject.transform, false)
		v:SetActive(false)
		self.toggleCellPool:Release(v)
	end

	self.toggleCells = {}

	local tab = ToggleTypes[self.townLibraryStoryData.storyType]

	for i = 1, #tab do
		local resType = tab[i]
		local togObj = self.toggleCellPool:Obtain()

		togObj.transform:SetParent(self.Toggles.transform, false)
		togObj:SetActive(true)
		UGUIUtil.SetText(togObj.transform:Find("goDown/Text_01").gameObject, LibraryStoryUIApi:GetString("ToggleResType", resType))
		UGUIUtil.SetText(togObj.transform:Find("goUp/Text_01").gameObject, LibraryStoryUIApi:GetString("ToggleResType", resType))

		local num, maxNum = self.townLibraryStoryData:GetResNumByResType(resType)

		UGUIUtil.SetText(togObj.transform:Find("goDown/Text_02").gameObject, LibraryStoryUIApi:GetString("ToggleResNum", num, maxNum))
		UGUIUtil.SetText(togObj.transform:Find("goUp/Text_02").gameObject, LibraryStoryUIApi:GetString("ToggleResNum", num, maxNum))

		local toggle = togObj:GetComponent("Toggle")

		toggle.onValueChanged:AddListener(self.delegateToggleValueChange)
		table.insert(self.toggleCells, togObj)

		if self.selectIndex == i then
			toggle.isOn = true
		else
			toggle.isOn = false
		end
	end

	self:ShowDialogList()
end

function LibraryDialogInfoUI:UpDateView()
	if self.townLibraryStoryData.storyType == Constant.LibraryStoryType.TownStory or self.townLibraryStoryData.storyType == Constant.LibraryStoryType.MazeStory or self.townLibraryStoryData.storyType == Constant.LibraryStoryType.ActionStory then
		local cfgStoryBook = CfgTownStoryBookTable[self.townLibraryStoryData.cfgID]

		UGUIUtil.SetText(self.TextTitle1, cfgStoryBook.Name)
		UGUIUtil.SetText(self.TextTitle2, cfgStoryBook.EngName)
	elseif self.townLibraryStoryData.storyType == Constant.LibraryStoryType.NPCStory then
		local cfgStoryBook = CfgTownNpcBookTable[self.townLibraryStoryData.cfgID]

		UGUIUtil.SetText(self.TextTitle1, cfgStoryBook.Name)
		UGUIUtil.SetText(self.TextTitle2, cfgStoryBook.EnglishName)
	elseif self.townLibraryStoryData.storyType == Constant.LibraryStoryType.SoulStory then
		local cfgStoryBook = CfgSoulTable[self.townLibraryStoryData.cfgID]

		UGUIUtil.SetText(self.TextTitle1, cfgStoryBook.Name)
		UGUIUtil.SetText(self.TextTitle2, cfgStoryBook.EngName)
	end
end

function LibraryDialogInfoUI:OnToggleValueChange(isOn)
	if isOn then
		for i = 1, #self.toggleCells do
			local obj = self.toggleCells[i]
			local toggle = obj:GetComponent("Toggle")

			if toggle.isOn == true and self.selectIndex ~= i then
				self.selectIndex = i

				self:ShowDialogList()

				break
			end
		end
	end
end

function LibraryDialogInfoUI:ShowDialogList()
	local tab = ToggleTypes[self.townLibraryStoryData.storyType]

	self.resType = tab[self.selectIndex]
	self.storyDialogResTab = self.townLibraryStoryData:GetStoryResTab(self.resType)

	self.scrollDialogList:Refresh(#self.storyDialogResTab)
end

function LibraryDialogInfoUI:OnRenderDialogCell(cell)
	local storyResData = self.storyDialogResTab[cell.index + 1]
	local gameObj = cell.gameObject

	if storyResData == nil then
		gameObj:SetActive(false)

		return
	end

	gameObj:SetActive(true)

	local dialogStoryCell = LibraryDialogStoryCell.PackageOrReuseView(self, gameObj)

	dialogStoryCell:SetData(storyResData, cell.index + 1, self.resType)
end

return LibraryDialogInfoUI
