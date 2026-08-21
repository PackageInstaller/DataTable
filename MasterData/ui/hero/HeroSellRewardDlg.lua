-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroSellRewardDlg.lua

local strClassName = "HeroSellRewardDlg"
local HeroSellRewardDlg = Class(strClassName, UIControls.Window)

function HeroSellRewardDlg:ctor()
	self:initUI()
end

function HeroSellRewardDlg:initUI()
	return
end

function HeroSellRewardDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.getGridContainerLoop(sender, "System/Hero/GridHeroCard", newIdx)
	else
		self.wearedGridList[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setObj(self.wearedList[newIdx])

	local grid = targetCell.grid

	self.wearedGridList[newIdx] = targetCell
end

function HeroSellRewardDlg:refreshData()
	self.recycleHeroData = CurAvatar.cacheDelHeros[Const.HERO_DEL_TYPE_RECYCLE]
	CurAvatar.cacheDelHeros[Const.HERO_DEL_TYPE_RECYCLE] = {}

	self:setEatedMaterialsData(CurAvatar.recycleMaterials)
end

function HeroSellRewardDlg:setEatedMaterialsData(materialsData)
	self.eatedMaterials = materialsData
	self.itemGridList = {}

	for _, idNum in ipairs(self.eatedMaterials) do
		local itemGrid = UIControls.GridNameContainerChild(self, "BgPanel/RewardList/Content", "System/Common/Grid/GridAwardGetHolder", 0, 0, true)
		local gridItem = BaseObject.GetObject(idNum.id, idNum.num)

		itemGrid.mDisableWays = true

		itemGrid:setObj(gridItem)
		table.insert(self.itemGridList, itemGrid)
	end
end

function HeroSellRewardDlg:setEatedMaterialsItem(materialsItem)
	self.itemGridList = {}

	for _, item in ipairs(materialsItem) do
		local itemGrid = UIControls.GridNameContainerChild(self, "BgPanel/RewardList/Content", "System/Common/Grid/GridAwardGetHolder", 0, 0, true)

		itemGrid.mDisableWays = true

		itemGrid:setObj(item)
		table.insert(self.itemGridList, itemGrid)
	end
end

return HeroSellRewardDlg
