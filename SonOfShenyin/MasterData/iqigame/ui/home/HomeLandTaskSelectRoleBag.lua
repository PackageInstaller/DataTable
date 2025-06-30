-- chunkname: @IQIGame\\UI\\Home\\HomeLandTaskSelectRoleBag.lua

local CommonHeroBagView = require("IQIGame/UI/Common/BagView/CommonHeroBagView")
local CommonHeroBagItemView = require("IQIGame/UI/Common/BagView/CommonHeroBagItemView")
local RoleItemView = Clone(CommonHeroBagItemView)

RoleItemView.heroCid = 0

function RoleItemView:__OnShow()
	local heroData = self.itemData

	self.heroCid = heroData.cid

	self:__HeroItemCell_OnShow(heroData)
	self:ChangeSelectState(false)

	local workRoomCid = HomeModule.GetRoleWorkRoomCid(heroData.cid)

	if workRoomCid == nil then
		self.tagGo.gameObject:SetActive(false)
	else
		self.tagGo.gameObject:SetActive(true)
	end
end

function RoleItemView:ChangeSelectState(isSelect)
	self.selectState.gameObject:SetActive(isSelect)
end

local BagView = Clone(CommonHeroBagView)

function BagView.New(view)
	local obj = Clone(BagView)

	obj:__Init(view, RoleItemView)

	return obj
end

function BagView:__OnInit()
	self:__HeroBag_Init()
	self.gameObject.gameObject:SetActive(false)

	self.enableChangeSelectStateCall = false
end

function BagView:__OnInitScreenControllerData()
	self.screenController.sortIndex = Constant.WarlockSortType.Quality

	self.screenController:SetSortOrderData(true)
	self.screenController:SetScreenPopupData(nil)
end

function BagView:RefreshSelectHero(heroCidList)
	ForPairs(self.itemCellList, function(k, _itemCell)
		local isSelect = self.__InHeroList(heroCidList, _itemCell.heroCid)

		_itemCell:ChangeSelectState(isSelect)
	end)
end

function BagView.__InHeroList(heroCidList, cid)
	local isIn = false

	ForArray(heroCidList, function(k, _cid)
		isIn = _cid == cid

		return isIn
	end)

	return isIn
end

return BagView
