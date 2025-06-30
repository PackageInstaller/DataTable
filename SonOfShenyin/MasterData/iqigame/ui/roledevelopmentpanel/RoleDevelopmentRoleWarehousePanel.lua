-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\RoleDevelopmentRoleWarehousePanel.lua

local CommonSortingPopupListView = require("IQIGame.UI.Common.CommonSortingPopupListView")
local RoleItemCell = {}

function RoleItemCell.New(view)
	local obj = Clone(RoleItemCell)

	obj:__Init(view)

	return obj
end

function RoleItemCell:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
end

function RoleItemCell:SetData(heroData, selectHeroCid)
	local iconPath = heroData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, iconPath, self.heroImg:GetComponent("Image"))

	local bgPath = RoleDevelopmentApi:GetRoleWarehouseItemBackground(heroData:GetCfg().Quality)

	AssetUtil.LoadImage(self, bgPath, self.qualityIcon:GetComponent("Image"))

	self.levelText.gameObject:GetComponent("Text").text = RoleDevelopmentApi:GetRoleWarehouseItemRoleLv(heroData.lv)

	local elementPath = WarlockApi:GetElementIconPath(heroData:GetCfg().Elements)

	AssetUtil.LoadImage(self, elementPath, self.elementImage:GetComponent("Image"))

	if selectHeroCid == heroData.cid then
		self:Selected()
	else
		self:UnSelect()
	end
end

function RoleItemCell:Selected()
	self.selectState:SetActive(true)
end

function RoleItemCell:UnSelect()
	self.selectState:SetActive(false)
end

function RoleItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local panel = {
	selectRoleCid = 0,
	roleList = {},
	roleItemCellList = {}
}

function panel.New(view)
	local obj = Clone(panel)

	obj:__Init(view)

	return obj
end

function panel:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
	self:__OnInitEventDelegate()

	self.panelAnimation = self.view.gameObject:GetComponent("Animation")
	self.wrapContent = self.scrollAreaList:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:__OnRenderRoleCell(cell)
	end

	function self.wrapContent.onSelectedCell(cell)
		self:__OnRoleItemCellSelect(cell)
	end

	self.sortPopupList = CommonSortingPopupListView.New(self.sortPopup, function(_index)
		self:__OnSortingTypeChange(_index)
	end)

	self.view.gameObject:SetActive(false)
end

function panel:Show(roleList, roleCid, sortType, downSort)
	self:__AddListener()
	self.view.gameObject:SetActive(true)

	self.roleList = roleList
	self.selectRoleCid = roleCid
	self.sortType = sortType
	self.downSort = downSort

	self:__RefreshRoleList(false)
	self.sortPopupList:SetData(CommonSortingPopupListView.GetRoleSortingData(), sortType, false)
	self.panelAnimation:Play("TopContent_RoleWarehouse_Show")
end

function panel:Hide()
	self:__RemoveListener()

	if self.CloseEvent ~= nil then
		self.CloseEvent(self.sortType, self.downSort, self.roleList)
	end

	self.panelAnimation:Play("TopContent_RoleWarehouse_Hide")

	self.updateFrameTimer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.RoleDevelopmentPanel, function()
		self.updateFrameTimer:Stop()
		self.view.gameObject:SetActive(false)
	end, 30)

	self.updateFrameTimer:Start()
end

function panel:Dispose()
	if self.updateFrameTimer then
		self.updateFrameTimer:Stop()

		self.updateFrameTimer = nil
	end

	ForPairs(self.roleItemCellList, function(_insID, _itemCell)
		_itemCell:Dispose()
	end)

	self.roleItemCellList = nil

	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
	self.wrapContent = nil
	self.panelAnimation = nil
end

function panel:__OnInitEventDelegate()
	function self.__OnCloseBtnClickEventProxy()
		if self.panelAnimation.isPlaying then
			return
		end

		self:Hide()
	end

	function self.__OnSortOrderBtnClickEventProxy()
		self.downSort = not self.downSort

		self:__RefreshRoleList(true)
	end
end

function panel:__AddListener()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__OnCloseBtnClickEventProxy)
	self.sortOrderBtn:GetComponent("Button").onClick:AddListener(self.__OnSortOrderBtnClickEventProxy)
end

function panel:__RemoveListener()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__OnCloseBtnClickEventProxy)
	self.sortOrderBtn:GetComponent("Button").onClick:RemoveListener(self.__OnSortOrderBtnClickEventProxy)
end

function panel:__OnRenderRoleCell(cell)
	local itemData = self.roleList[cell.index + 1]
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.roleItemCellList[insID]

	if itemCell == nil then
		itemCell = RoleItemCell.New(cell.gameObject)
		self.roleItemCellList[insID] = itemCell
	end

	itemCell:SetData(itemData, self.selectRoleCid)
end

function panel:__OnRoleItemCellSelect(cell)
	local insID = cell.gameObject:GetInstanceID()

	ForPairs(self.roleItemCellList, function(_insID, _roleItemCell)
		if _insID == insID then
			_roleItemCell:Selected()
		else
			_roleItemCell:UnSelect()
		end
	end)

	local roleData = self.roleList[cell.index + 1]

	if self.ChangeSelectRoleEvent ~= nil then
		self.ChangeSelectRoleEvent(roleData.cid)
	end
end

function panel:__OnSortingTypeChange(index)
	if self.sortType == index then
		return
	end

	self.sortType = index

	self:__RefreshRoleList(true)
end

function panel:__RefreshRoleList(sort)
	if sort then
		self.roleList = WarlockModule.SortRoleListByType(self.roleList, self.sortType, self.downSort)
	end

	self.wrapContent:Refresh(#self.roleList)
end

return panel
