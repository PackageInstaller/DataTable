-- chunkname: @modules/logic/fight/view/FightFocusOdysseyEquipView.lua

module("modules.logic.fight.view.FightFocusOdysseyEquipView", package.seeall)

local FightFocusOdysseyEquipView = class("FightFocusOdysseyEquipView", FightBaseView)

function FightFocusOdysseyEquipView:onInitView()
	self.collectionObjList = {}
	self.simage_iconList = {}
	self.img_rareList = {}

	for i = 1, 2 do
		table.insert(self.collectionObjList, gohelper.findChild(self.viewGO, "root/collection" .. i))
		table.insert(self.simage_iconList, gohelper.findChildSingleImage(self.viewGO, "root/collection" .. i .. "/simage_Icon"))
		table.insert(self.img_rareList, gohelper.findChildImage(self.viewGO, "root/collection" .. i .. "/image_Rare"))
	end
end

function FightFocusOdysseyEquipView:addEvents()
	return
end

function FightFocusOdysseyEquipView:onConstructor(entityMO)
	self.entityMO = entityMO
end

function FightFocusOdysseyEquipView:refreshEntityMO(entityMO)
	self.entityMO = entityMO

	if self.viewGO then
		self:refreshCollection()
	end
end

function FightFocusOdysseyEquipView:onOpen()
	self.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Odyssey]
	self.customData = self.customData or FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act128Sp]

	self:refreshCollection()
end

function FightFocusOdysseyEquipView:refreshCollection()
	if self.entityMO:isEnemySide() then
		gohelper.setActive(self.viewGO, false)

		return
	end

	local data = self.customData.customUnitId2Equip
	local collectionList

	for k, v in pairs(data) do
		if tonumber(k) == self.entityMO.customUnitId then
			collectionList = v

			break
		end
	end

	if not collectionList then
		gohelper.setActive(self.viewGO, false)

		return
	end

	if #collectionList == 0 then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	for i = 1, #self.collectionObjList do
		local obj = self.collectionObjList[i]
		local itemId = collectionList[i]

		if itemId then
			gohelper.setActive(obj, true)

			local config = lua_odyssey_item.configDict[itemId]

			UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self.img_rareList[i], "odyssey_item_quality" .. config.rare)

			if config.type == OdysseyEnum.ItemType.Item then
				self.simage_iconList[i]:LoadImage(ResUrl.getPropItemIcon(config.icon))
			elseif config.type == OdysseyEnum.ItemType.Equip then
				self.simage_iconList[i]:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(config.icon))
			end

			local click = gohelper.getClickWithDefaultAudio(obj)

			self:com_registClick(click, self.onItemClick, itemId)
		else
			gohelper.setActive(obj, false)
		end
	end
end

function FightFocusOdysseyEquipView:onItemClick(itemId)
	OdysseyController.instance:showItemTipView({
		itemId = itemId
	})
end

return FightFocusOdysseyEquipView
