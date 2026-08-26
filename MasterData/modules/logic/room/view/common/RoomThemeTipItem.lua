-- chunkname: @modules/logic/room/view/common/RoomThemeTipItem.lua

module("modules.logic.room.view.common.RoomThemeTipItem", package.seeall)

local RoomThemeTipItem = class("RoomThemeTipItem", ListScrollCellExtend)

function RoomThemeTipItem:onInitView()
	self._hideSourcesShowTypeMap = {
		[RoomEnum.SourcesShowType.Cobrand] = true
	}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomThemeTipItem:addEvents()
	return
end

function RoomThemeTipItem:removeEvents()
	return
end

function RoomThemeTipItem:_editableInitView()
	self._gobuildingicon = gohelper.findChild(self.viewGO, "go_buildingicon")
	self._goplaneicon = gohelper.findChild(self.viewGO, "go_planeicon")
	self._txtname = gohelper.findChildText(self.viewGO, "txt_name")
	self._txtstate = gohelper.findChildText(self.viewGO, "txt_state")
	self._gosource = gohelper.findChild(self.viewGO, "go_source")
	self._gosourceItem = gohelper.findChild(self.viewGO, "go_source/go_sourceItem")
	self._sourceTab = self:getUserDataTb_()

	gohelper.setActive(self._gosourceItem, false)
end

function RoomThemeTipItem:_refreshUI()
	local quantity = self._themeItemMO:getItemQuantity()
	local isFull = quantity >= self._themeItemMO.itemNum

	gohelper.setActive(self._gobuildingicon, self._themeItemMO.materialType == MaterialEnum.MaterialType.Building)
	gohelper.setActive(self._goplaneicon, self._themeItemMO.materialType == MaterialEnum.MaterialType.BlockPackage)

	local cfg = self._themeItemMO:getItemConfig()

	for k, item in pairs(self._sourceTab) do
		gohelper.setActive(item.go, false)
	end

	if cfg then
		self._txtname.text = cfg.name or ""
	end

	self._txtstate.text = self:_getStateStr(self._themeItemMO.itemNum, quantity)

	SLFramework.UGUI.GuiHelper.SetColor(self._txtstate, isFull and "#65B96F" or "#D97373")

	if not string.nilorempty(cfg.sourcesType) then
		local sourceTypeTab = string.splitToNumber(cfg.sourcesType, "#")

		self:_sortSource(sourceTypeTab)

		for k, typeid in pairs(sourceTypeTab) do
			local sourceTypeCfg = RoomConfig.instance:getSourcesTypeConfig(typeid)

			if sourceTypeCfg and (not sourceTypeCfg.showType or not self._hideSourcesShowTypeMap[sourceTypeCfg.showType]) then
				local sourceItem = self:_getSourceItem(typeid)

				gohelper.setActive(sourceItem.go, true)

				sourceItem.txt.text = string.format("<color=%s>%s</color>", sourceTypeCfg.nameColor, sourceTypeCfg.name)

				UISpriteSetMgr.instance:setRoomSprite(sourceItem.bg, sourceTypeCfg.bgIcon)
				SLFramework.UGUI.GuiHelper.SetColor(sourceItem.bg, string.nilorempty(sourceTypeCfg.bgColor) and "#FFFFFF" or sourceTypeCfg.bgColor)
			elseif sourceTypeCfg == nil then
				logError(string.format("小屋主题\"export_获得类型\"缺少配置。id:%s", typeid))
			end
		end
	end
end

function RoomThemeTipItem:_getSourceItem(id)
	local sourceItem = self._sourceTab[id]

	if not sourceItem then
		sourceItem = self:getUserDataTb_()
		sourceItem.go = gohelper.clone(self._gosourceItem, self._gosource, "source" .. id)
		sourceItem.txt = gohelper.findChildText(sourceItem.go, "txt")
		sourceItem.bg = gohelper.findChildImage(sourceItem.go, "bg")

		gohelper.setActive(sourceItem.go, false)

		self._sourceTab[id] = sourceItem
	end

	return sourceItem
end

function RoomThemeTipItem:_sortSource(sourceTypeTab)
	table.sort(sourceTypeTab, RoomThemeTipItem._sortFunc)
end

function RoomThemeTipItem._sortFunc(a, b)
	local aOrder = RoomConfig.instance:getSourcesTypeConfig(a).order
	local bOrder = RoomConfig.instance:getSourcesTypeConfig(b).order

	if aOrder ~= bOrder then
		return aOrder < bOrder
	end
end

function RoomThemeTipItem:_getStateStr(itemNum, quantity)
	return string.format("%s/%s", quantity, itemNum)
end

function RoomThemeTipItem:onUpdateMO(mo)
	self._themeItemMO = mo

	self:_refreshUI()
end

function RoomThemeTipItem:onSelect(isSelect)
	return
end

function RoomThemeTipItem:onDestroyView()
	return
end

return RoomThemeTipItem
