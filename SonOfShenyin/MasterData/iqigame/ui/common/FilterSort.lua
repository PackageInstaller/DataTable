-- chunkname: @IQIGame\\UI\\Common\\FilterSort.lua

local FilterSort = Base:Extend("FilterSort", "IQIGame.Onigao.UI.Common.FilterSort", {
	isShowFilterPanel = false
})

function FilterSort.New(gameObject, delegateTable)
	local tbl = Clone(FilterSort)

	tbl:OnInit(gameObject, delegateTable)

	return tbl
end

function FilterSort:OnInit(gameObject, delegateTable)
	self.gameObject = gameObject

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.delegateTable = delegateTable
	self.FilterContentScrollAreaList = self.FilterContentScrollView:GetComponent("ScrollAreaList")
	self.FilterContentScrollAreaList.onSelectedCell = self.delegateTable.FilterContentScrollAreaListOnSelectedCell
	self.FilterContentScrollAreaList.onRenderCell = self.delegateTable.FilterContentScrollAreaListOnRenderCell

	function self.DelegateOnClickFilterPanelButton()
		self:OnClickFilterPanelButton()
	end

	self.tapContentScreen = TapContents.New()

	self.tapContentScreen:Init(self.SortingContent.gameObject, self.delegateTable.DelegateOnSortingTypeChanged)

	function self.DelegateOnClickSortingPanelButton()
		self:OnClickSortingPanelButton()
	end

	self:OnAddListeners()
end

function FilterSort:OnDestroy()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function FilterSort:OnAddListeners()
	self.FilterButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFilterPanelButton)
	self.UnfilterButton:GetComponent("Button").onClick:AddListener(self.delegateTable.DelegateOnClickUnfilterButton)
	self.SortingButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSortingPanelButton)
	self.SortingOrderButton:GetComponent("Button").onClick:AddListener(self.delegateTable.DelegateOnClickSortingOrderButton)
end

function FilterSort:OnRemoveListeners()
	self.FilterButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFilterPanelButton)
	self.UnfilterButton:GetComponent("Button").onClick:RemoveListener(self.delegateTable.DelegateOnClickUnfilterButton)
	self.SortingButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSortingPanelButton)
	self.SortingOrderButton:GetComponent("Button").onClick:RemoveListener(self.delegateTable.DelegateOnClickSortingOrderButton)
end

local gray = Color.New(0.30196078431372547, 0.30196078431372547, 0.30196078431372547, 1)

function FilterSort:SetupFilterPanel(isShow)
	self.FilterPanel.gameObject:SetActive(isShow)
	self:RefreshFilterSelectState(isShow)
end

function FilterSort:SetupSorterPanel(isShow)
	self.SortingPanel.gameObject:SetActive(isShow)
	self:RefreshSorterSelectState(isShow)
end

function FilterSort:RefreshFilterSelectState(isShow)
	UGUIUtil.SetColor(self.FilterDescText:GetComponent("Text"), isShow and gray or Color.white)
	self.selectState:SetActive(isShow)
	self.normalState:SetActive(not isShow)
end

function FilterSort:RefreshSorterSelectState(isShow)
	UGUIUtil.SetColor(self.SortingText:GetComponent("Text"), isShow and gray or Color.white)
	self.sortingSelectImg:SetActive(isShow)
	self.sortingNormalImg:SetActive(not isShow)
end

function FilterSort:HidePanel()
	self:HideFilterPanel()
	self:HideSortingPanel()
end

function FilterSort:HideFilterPanel()
	self.isShowFilterPanel = false

	self:SetupFilterPanel(false)
end

function FilterSort:HideSortingPanel()
	self.isShowSortingPanel = false

	self:SetupSorterPanel(false)
end

function FilterSort:OnClickFilterPanelButton()
	self.isShowFilterPanel = not self.isShowFilterPanel

	self:SetupFilterPanel(self.isShowFilterPanel)
end

function FilterSort:OnClickSortingPanelButton()
	self.isShowSortingPanel = not self.isShowSortingPanel

	self:SetupSorterPanel(self.isShowSortingPanel)
end

return FilterSort
