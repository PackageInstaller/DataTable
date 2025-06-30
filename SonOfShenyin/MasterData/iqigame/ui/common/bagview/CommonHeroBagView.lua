-- chunkname: @IQIGame\\UI\\Common\\BagView\\CommonHeroBagView.lua

local CommonBagView = require("IQIGame/UI/Common/BagView/CommonBagView")
local CommonScreenControllerView = require("IQIGame/UI/Common/Screen/CommonScreenControllerView")
local BagView = Clone(CommonBagView)

function BagView:__OnInit()
	self:__HeroBag_Init()
end

function BagView:__HeroBag_Init()
	function self.__delegateOnScreenControllerValueChange(_isSortChange)
		self:__OnScreenControllerValueChange(_isSortChange)
	end

	self.screenController = CommonScreenControllerView.New(self.screenControllerRoot, self.__delegateOnScreenControllerValueChange)
end

function BagView:OnShow()
	self:__OnInitScreenControllerData()
	self:__OnInitHeroDataList()
	self:__RefreshShow()
end

function BagView:__OnInitScreenControllerData()
	local commonScreenData = CommonScreenModule.GetCommonPlayerScreenData()

	self.screenController:SetScreenPopupData(commonScreenData)
	self.screenController:SetSortPopupData(CommonSortingPopupListApi:GetRoleSortingData(), 1)
	self.screenController:SetSortOrderData(true)
end

function BagView:__OnInitHeroDataList()
	self.heroDataList = WarlockModule.GetWarlockListByScreenData(self.screenController.screenData)
end

function BagView:__RefreshShow()
	local sortType = self.screenController.sortIndex
	local ascending = self.screenController.ascending
	local showHeroList = WarlockModule.SortRoleListByType(self.heroDataList, sortType, ascending)

	self:__OnShow(showHeroList)
end

function BagView:__OnScreenControllerValueChange(isSortChange)
	if not isSortChange then
		self:__OnInitHeroDataList()
	end

	self:__RefreshShow()
end

return BagView
