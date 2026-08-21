-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroSellPreviewPanel.lua

local strClassName = "HeroSellPreviewPanel"
local HeroSellPreviewPanel = Class(strClassName, UIControls.Panel)

function HeroSellPreviewPanel:ctor()
	self:initUI()
end

function HeroSellPreviewPanel:initUI()
	self.cells = {}
	self.awardGridList = {}
	self.scroll = UIControls.ScrollViewLoopV(self, self.mPath .. "/HeroList")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.heroList = {}
	self.txtAttention = UIControls.Panel(self, self.mPath .. "/TextAttentionPanel")
	self.sellRewardPanel = UIControls.Panel(self, self.mPath .. "/SellRewardPanel")
	self.txtPainting = UIControls.Label(self, self.mPath .. "/TextAttentionPanel/Text5")

	self.txtPainting:setVisible(CurAvatar:haveHeroCanPaint())

	self.btnConfirmSell = UIControls.Button(self, self.mPath .. "/SellRewardPanel/BtnSell")

	self.btnConfirmSell:addEventClick(self.onBtnConfirmClick)
	self:refreshPanel()
end

function HeroSellPreviewPanel:onBtnConfirmClick()
	if self:checkAllHeroSell() then
		MsgManager.notice(Lang.get(30359))

		return
	end

	local gidList = {}

	for _, hero in ipairs(self.heroList) do
		table.insert(gidList, hero.gid)
	end

	RPC.heroRecycle(gidList)
end

function HeroSellPreviewPanel:checkAllHeroSell()
	return CurAvatar:getHeroCount() == #self.heroList
end

function HeroSellPreviewPanel:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.HeroCardLoop(sender, "System/Hero/GridHeroCard", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setHero(self.heroList[newIdx])
	targetCell:setHeroRealLv()
	targetCell.imgStateIcon:setVisible(CurAvatar.asyncPVPDefendFormation[targetCell.hero.gid] ~= nil)
	targetCell:setSelectCallback(Slot(self.clickSellHeroCard, self))

	self.cells[newIdx] = targetCell
end

function HeroSellPreviewPanel:refreshPanel()
	local heroCount = #self.heroList

	self.scroll:setTotalCount(#self.heroList)
	self.txtAttention:setVisible(heroCount == 0)
	self.sellRewardPanel:setVisible(heroCount > 0)
	self:refreshAwardGrid()
end

local function _sortSellMaterials(a, b)
	if a.quality ~= b.quality then
		return a.quality > b.quality
	else
		return a.id < b.id
	end
end

function HeroSellPreviewPanel:refreshAwardGrid()
	self.canGetMaterials = {}

	for _, hero in ipairs(self.heroList) do
		local radio = hero:getPaintMaterialRadio()

		for idx, resId in ipairs(hero.resData.recycle_ids) do
			if not self.canGetMaterials[resId] then
				self.canGetMaterials[resId] = math.floor(hero.resData.recycle_num[idx] * (radio / 10000))
			else
				self.canGetMaterials[resId] = self.canGetMaterials[resId] + math.floor(hero.resData.recycle_num[idx] * (radio / 10000))
			end
		end
	end

	self.canGetMaterialList = {}

	for _id, _num in pairs(self.canGetMaterials) do
		table.insert(self.canGetMaterialList, BaseObject.GetObject(_id, _num))
	end

	table.sort(self.canGetMaterialList, _sortSellMaterials)

	for idx, item in ipairs(self.canGetMaterialList) do
		if not self.awardGridList[idx] then
			self.awardGridList[idx] = UIControls.ItemGridChild(self, self.mPath .. "/SellRewardPanel/SellRewardItem/Viewport/Content", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		end

		self.awardGridList[idx].mDisableWays = true

		self.awardGridList[idx]:setVisible(true)
		self.awardGridList[idx]:setObj(item)
	end

	for i = #self.canGetMaterialList + 1, #self.awardGridList do
		self.awardGridList[i]:setVisible(false)
	end
end

function HeroSellPreviewPanel:clickSellHeroCard(sender)
	if self.mWindow then
		self.mWindow:setHeroToBag(sender.hero)
	end
end

function HeroSellPreviewPanel:addHero(hero, noRefresh)
	table.insert(self.heroList, hero)

	if not noRefresh then
		self:refreshPanel()
	end
end

function HeroSellPreviewPanel:delHero(hero, noRefresh)
	local heroCount = #self.heroList

	for idx = heroCount, 1, -1 do
		if self.heroList[idx].gid == hero.gid then
			table.remove(self.heroList, idx)
		end
	end

	if not noRefresh then
		self:refreshPanel()
	end
end

return HeroSellPreviewPanel
