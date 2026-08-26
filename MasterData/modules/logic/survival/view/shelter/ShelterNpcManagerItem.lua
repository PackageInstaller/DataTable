-- chunkname: @modules/logic/survival/view/shelter/ShelterNpcManagerItem.lua

module("modules.logic.survival.view.shelter.ShelterNpcManagerItem", package.seeall)

local ShelterNpcManagerItem = class("ShelterNpcManagerItem", ListScrollCellExtend)

function ShelterNpcManagerItem:onInitView()
	self.goGrid = gohelper.findChild(self.viewGO, "Grid")
	self.goSmallItem = gohelper.findChild(self.viewGO, "#go_SmallItem")

	gohelper.setActive(self.goSmallItem, false)

	self.itemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShelterNpcManagerItem:addEvents()
	return
end

function ShelterNpcManagerItem:removeEvents()
	return
end

function ShelterNpcManagerItem:_editableInitView()
	return
end

function ShelterNpcManagerItem:onClickGridItem(item)
	if not item.data then
		return
	end

	if SurvivalShelterNpcListModel.instance:setSelectNpcId(item.data.id) then
		self._view.viewContainer:refreshManagerView()
	end
end

function ShelterNpcManagerItem:onUpdateMO(mo)
	self.mo = mo

	if not mo then
		return
	end

	local list = mo.dataList

	for i = 1, math.max(#list, #self.itemList) do
		local item = self:getGridItem(i)

		self:refreshGridItem(item, list[i])
	end
end

function ShelterNpcManagerItem:getGridItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.go = gohelper.clone(self.goSmallItem, self.goGrid, tostring(index))
		item.imgQuality = gohelper.findChildImage(item.go, "#image_quality")
		item.imgChess = gohelper.findChildSingleImage(item.go, "#image_Chess")
		item.txtName = gohelper.findChildTextMesh(item.go, "#txt_PartnerName")
		item.goSelect = gohelper.findChild(item.go, "#go_Selected")
		item.goOut = gohelper.findChild(item.go, "#go_Out")
		item.goTips = gohelper.findChild(item.go, "#go_Tips")
		item.txtTips = gohelper.findChildTextMesh(item.go, "#go_Tips/#txt_TentName")
		item.btn = gohelper.findButtonWithAudio(item.go)

		item.btn:AddClickListener(self.onClickGridItem, self, item)

		self.itemList[index] = item
	end

	return item
end

function ShelterNpcManagerItem:refreshGridItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)
	gohelper.setActive(item.goSelect, SurvivalShelterNpcListModel.instance:isSelectNpc(data.id))
	gohelper.setActive(item.goOut, data:isEqualStatus(SurvivalEnum.ShelterNpcStatus.OutSide))

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingId = weekInfo:getNpcPostion(data.id)

	if buildingId then
		local buildingInfo = weekInfo:getBuildingInfo(buildingId)

		gohelper.setActive(item.goTips, true)

		local buildingConfig = SurvivalConfig.instance:getBuildingConfig(buildingInfo.buildingId, buildingInfo.level)

		item.txtTips.text = buildingConfig.name
	else
		gohelper.setActive(item.goTips, false)
	end

	item.txtName.text = data.co.name

	SurvivalUnitIconHelper.instance:setNpcIcon(item.imgChess, data.co.headIcon)
	UISpriteSetMgr.instance:setSurvivalSprite(item.imgQuality, string.format("survival_bag_itemquality2_%s", data.co.rare))
end

function ShelterNpcManagerItem:onDestroyView()
	for k, v in pairs(self.itemList) do
		v.btn:RemoveClickListener()
	end
end

return ShelterNpcManagerItem
