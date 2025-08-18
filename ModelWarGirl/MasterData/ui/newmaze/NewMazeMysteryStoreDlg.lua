-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeMysteryStoreDlg.lua

local MysteryStorePanel = require("UI/newmaze/MysteryStorePanel")
local strClassName = "NewMazeMysteryStoreDlg"
local NewMazeMysteryStoreDlg = Class(strClassName, UIControls.Window)

function NewMazeMysteryStoreDlg:ctor()
	self:initUI()
end

function NewMazeMysteryStoreDlg:initUI()
	return
end

function NewMazeMysteryStoreDlg:setData(shop_sub_type, goods_item)
	self.shop_sub_type = shop_sub_type

	if self.mysteryStorePanel == nil then
		if shop_sub_type == Const.MYSTERY_SHOP_SUB_TYPE_PET_MAZE then
			self.mysteryStorePanel = MysteryStorePanel(self, "BgPanel", "System/MazzPet/MazzPetMysteryStorePanel", 0, 0, true)
			self.mysteryStorePanel.CELL_INFO[Const.MYSTERY_SHOP_TYPE_ITEM].prePath = "System/MazzPet/GridMazzPetMysteryStoreItem"
			self.mysteryStorePanel.CELL_INFO[Const.MYSTERY_SHOP_TYPE_GIFT].prePath = "System/MazzPet/GridMazzPetMysteryStoreGift"
			self.mysteryStorePanel.qualityBgId = 6
		else
			self.mysteryStorePanel = MysteryStorePanel(self, "BgPanel", "System/Rogue/RogueMysteryStorePanel", 0, 0, true)
		end
	end

	local items = {}

	for i, v in ipairs(goods_item or {}) do
		if v.special and v.special.buy_count then
			table.insert(items, {
				id = v.goods_id,
				type = v.goods_type,
				buyCount = v.special.buy_count.count
			})
		else
			table.insert(items, {
				id = v.goods_id,
				type = v.goods_type
			})
		end
	end

	self.mysteryStorePanel:setData(items, shop_sub_type)
	self.mysteryStorePanel:setCloseCB(Slot(self.closeFunc, self))
end

function NewMazeMysteryStoreDlg:closeFunc()
	if self.shop_sub_type == Const.MYSTERY_SHOP_SUB_TYPE_NEW_MAZE then
		self.actObj = CurAvatar:getNewMazeActivity()

		if self.actObj then
			RPC.newMazeLayerNextReq(self.actObj.opId)
		end
	end

	self:setVisible(false)
end

return NewMazeMysteryStoreDlg
