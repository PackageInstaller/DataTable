-- chunkname: @modules/logic/fight/view/FightFocusOdysseyEquipSuitView.lua

module("modules.logic.fight.view.FightFocusOdysseyEquipSuitView", package.seeall)

local FightFocusOdysseyEquipSuitView = class("FightFocusOdysseyEquipSuitView", FightBaseView)

function FightFocusOdysseyEquipSuitView:onInitView()
	self.itemRoot = gohelper.findChild(self.viewGO, "root/suit")
	self.itemObj = gohelper.findChild(self.viewGO, "root/suit/item")
end

function FightFocusOdysseyEquipSuitView:addEvents()
	return
end

function FightFocusOdysseyEquipSuitView:onConstructor(entityMO)
	self.entityMO = entityMO
end

function FightFocusOdysseyEquipSuitView:refreshEntityMO(entityMO)
	self.entityMO = entityMO

	if self.viewGO then
		self:refreshData()
	end
end

function FightFocusOdysseyEquipSuitView:onOpen()
	self.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Odyssey]
	self.customData = self.customData or FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act128Sp]

	self:refreshData()
end

function FightFocusOdysseyEquipSuitView:refreshData()
	if self.entityMO:isEnemySide() then
		gohelper.setActive(self.viewGO, false)

		return
	end

	local data = self.customData.equipSuit2Level
	local dataList = {}

	for k, v in pairs(data) do
		if v > 0 then
			local tab = {}

			tab.suitId = tonumber(k)
			tab.level = v

			table.insert(dataList, tab)
		end
	end

	table.sort(dataList, function(a, b)
		return a.suitId < b.suitId
	end)

	if #dataList == 0 then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)
	self:com_createObjList(self.onItemShow, dataList, self.itemRoot, self.itemObj)
end

function FightFocusOdysseyEquipSuitView:onItemShow(obj, data, index)
	local config = OdysseyConfig.instance:getEquipSuitConfig(data.suitId)
	local imageIcon = gohelper.findChildImage(obj, "#image_icon")

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(imageIcon, config.icon)

	local click = gohelper.findChildClick(obj, "#btn_click")

	self:com_registClick(click, self.onItemClick, data)
end

function FightFocusOdysseyEquipSuitView:onItemClick(data)
	data.bagType = OdysseyEnum.BagType.FightPrepare

	OdysseyController.instance:openSuitTipsView(data)
end

return FightFocusOdysseyEquipSuitView
