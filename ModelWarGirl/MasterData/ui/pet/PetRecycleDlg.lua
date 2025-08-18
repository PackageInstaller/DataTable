-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetRecycleDlg.lua

local CommonSortPanel = require("UI/Common/CommonSortPanel")
local ResPetMisc = require("ClientData/ResPetMisc")
local ResPetQuality = require("ClientData/ResPetQuality")
local ResPetAmulet = require("ClientData/ResPetAmulet")
local strClassName = "PetRecycleDlg"
local PetRecycleDlg = Class(strClassName, UIControls.Window)
local PET_SORT_MAP = {
	{
		name = "sortQuality",
		text = Lang.get(372)
	}
}

function PetRecycleDlg:ctor()
	self:initUI()
end

function PetRecycleDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.view = UIControls.ScrollViewLoopV(self, "PetListPanel/ItemList", 0, self._initAllItem)
	self.panelContentNone = UIControls.Panel(self, "PetListPanel/NoContent")
	self.cells = {}
	self.selectItemCell = {}
	self.btnHeroAll = UIControls.Button(self, "PetListPanel/ListFunPanel/BtnHeroAll")

	self.btnHeroAll:addEventClick(self.onBtnHeroAllClick)

	self.iconNew = UIControls.Panel(self, "PetListPanel/ListFunPanel/BtnHeroAll/IconNew")
	self.textAttentionPanel = UIControls.Panel(self, "PetSellPanel/TextAttentionPanel")
	self.sellRewardPanel = UIControls.Panel(self, "PetSellPanel/SellRewardPanel")
	self.recycleView = UIControls.ScrollViewLoopV(self, "PetSellPanel/ItemList", 0, self._initRecycleItem)
	self.btnSell = UIControls.Button(self, "PetSellPanel/SellRewardPanel/BtnSell")

	self.btnSell:addEventClick(self.onBtnSellClick)

	self.grids = {}
end

function PetRecycleDlg:setData()
	self:refreshAllItemPanel()

	self.selectItems = {}

	self:refreshSelectPanel()
end

local function sortItemList(a, b)
	if a.subType ~= b.subType then
		return a.subType == Const.ITEM_STYPE_PET_AMULET_CHIP
	elseif a.quality ~= b.quality then
		return a.quality < b.quality
	else
		return a.id > b.id
	end
end

function PetRecycleDlg:refreshAllItemPanel()
	self.allItemList = {}
	self.recyclePetList = CurAvatar:getAllCanRecyclePetList()
	self.recycleAmuletList = CurAvatar:getAllCanRecycleAmuletList()

	for i, v in ipairs(self.recyclePetList) do
		table.insert(self.allItemList, v)
	end

	for i, v in ipairs(self.recycleAmuletList) do
		table.insert(self.allItemList, v)
	end

	table.sort(self.allItemList, sortItemList)
	self.panelContentNone:setVisible(#self.allItemList == 0)
	self.view:setTotalCount(#self.allItemList)
end

function PetRecycleDlg:refreshSelectPanel()
	self.textAttentionPanel:setVisible(#self.selectItems == 0)
	self.sellRewardPanel:setVisible(#self.selectItems > 0)
	self.recycleView:setTotalCount(#self.selectItems)
	self.iconNew:setVisible(#self.allItemList > 0)
	self:refreshRecycleReward()
end

function PetRecycleDlg:refreshRecycleReward()
	local rewards = self:getRecycleReward()

	for i, reward in ipairs(rewards) do
		if self.grids[i] == nil then
			self.grids[i] = UIControls.ItemGridChild(self, "PetSellPanel/SellRewardPanel/SellRewardItem/Viewport/Content", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		end

		local item = BaseObject.GetObject(reward.id, reward.num)

		self.grids[i].mDisableWays = true

		self.grids[i]:setObj(item)
	end
end

function PetRecycleDlg:_initAllItem(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = UIControls.ItemGridLoop(sender, "System/Common/Grid/GridMaterialItem", newIdx)

		targetCell.btnSensor:clearEventClick()
		targetCell.btnSensor:addEventClick(Slot(self.selectMaterial, self))
	end

	if not self.allItemList or #self.allItemList == 0 then
		return
	end

	if self.allItemList[newIdx] ~= nil then
		targetCell:setObj(self.allItemList[newIdx])
		targetCell:setVisible(not self:checkIsBeSelect(targetCell.object.id))
		targetCell:setVisible(false)
	end

	self.cells[newIdx] = targetCell
end

function PetRecycleDlg:_initRecycleItem(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.ItemGridLoop(sender, "System/Common/Grid/GridMaterialItem", newIdx)

	if not self.selectItems or #self.selectItems == 0 then
		return
	end

	if self.selectItems[newIdx] ~= nil then
		targetCell:setObj(self.selectItems[newIdx])

		targetCell.mEnableTips = false
		targetCell.mEventClick = Slot(self.cancleMaterial, self)
	end

	self.selectItemCell[newIdx] = targetCell
end

function PetRecycleDlg:selectMaterial(sender, btn)
	for idx, sel in ipairs(self.allItemList) do
		if sel.id == sender.object.id then
			table.remove(self.allItemList, idx)

			break
		end
	end

	table.insert(self.selectItems, sender.object)
	table.sort(self.allItemList, sortItemList)
	self.view:setTotalCount(#self.allItemList)
	self:refreshSelectPanel()
end

function PetRecycleDlg:cancleMaterial(sender, btn)
	for idx, sel in ipairs(self.selectItems) do
		if sel.id == sender.object.id then
			table.remove(self.selectItems, idx)

			break
		end
	end

	table.insert(self.allItemList, sender.object)
	table.sort(self.allItemList, sortItemList)
	self.view:setTotalCount(#self.allItemList)
	self:refreshSelectPanel()
end

function PetRecycleDlg:checkIsBeSelect(id)
	if self.selectItems then
		for idx, sel in ipairs(self.selectItems) do
			if sel.id == id then
				return true
			end
		end

		return false
	end

	return false
end

function PetRecycleDlg:getRecycleReward()
	local rewards = {}
	local itemId = ResPetMisc[1].amulet_recycle_item
	local itemNum = 0

	for i, v in ipairs(self.selectItems) do
		if v.subType == Const.ITEM_STYPE_PET_CHIP then
			local num = ResPetQuality[v.quality] and ResPetQuality[v.quality].recycle_award or 10

			itemNum = itemNum + num * v.num
		else
			for _, amulet in pairs(ResPetAmulet) do
				if amulet.translate_item_id and amulet.translate_item_id == v.id then
					itemNum = itemNum + amulet.recycle_item_num * v.num

					break
				end
			end
		end
	end

	if itemNum > 0 then
		table.insert(rewards, {
			id = itemId,
			num = itemNum
		})
	end

	return rewards
end

function PetRecycleDlg:onBtnHeroAllClick()
	for i, v in ipairs(self.allItemList) do
		table.insert(self.selectItems, v)
	end

	self.allItemList = {}

	self.view:setTotalCount(#self.allItemList)
	self:refreshSelectPanel()
end

function PetRecycleDlg:onBtnSellClick()
	local items = {}

	for i, v in ipairs(self.selectItems) do
		table.insert(items, {
			id = v.id,
			num = v.num
		})
	end

	RPC.petRecycle(items)
end

function PetRecycleDlg:refreshData()
	self:setData()
end

function PetRecycleDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_RECYCLE)
end

function PetRecycleDlg:onCloseClick()
	self:setVisible(false)
end

return PetRecycleDlg
