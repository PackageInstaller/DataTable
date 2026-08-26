-- chunkname: @modules/logic/survival/view/shelter/ShelterTentManagerNpcItem.lua

module("modules.logic.survival.view.shelter.ShelterTentManagerNpcItem", package.seeall)

local ShelterTentManagerNpcItem = class("ShelterTentManagerNpcItem", ListScrollCellExtend)

function ShelterTentManagerNpcItem:onInitView()
	self.imgQuality = gohelper.findChildImage(self.viewGO, "#image_quality")
	self.imageNpc = gohelper.findChildSingleImage(self.viewGO, "#image_Chess")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "#txt_PartnerName")
	self.goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self.goTips = gohelper.findChild(self.viewGO, "#go_Tips")
	self.txtBuildName = gohelper.findChildTextMesh(self.viewGO, "#go_Tips/#txt_TentName")
	self.btn = gohelper.findButtonWithAudio(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShelterTentManagerNpcItem:addEvents()
	self.addClickCb(self, self.btn, self.onClickNpcItem, self)
end

function ShelterTentManagerNpcItem:removeEvents()
	self:removeClickCb(self.btn)
end

function ShelterTentManagerNpcItem:_editableInitView()
	return
end

function ShelterTentManagerNpcItem:onClickNpcItem()
	if not self.mo then
		return
	end

	if SurvivalShelterTentListModel.instance:isQuickSelect() then
		SurvivalShelterTentListModel.instance:quickSelectNpc(self.mo.id)
	else
		SurvivalShelterTentListModel.instance:setSelectNpc(self.mo.id)
		self._view.viewContainer:refreshManagerSelectPanel()
	end
end

function ShelterTentManagerNpcItem:onUpdateMO(mo)
	self.mo = mo

	if not mo then
		return
	end

	self:refreshItem(mo)
end

function ShelterTentManagerNpcItem:refreshItem(data)
	local selectNpcId = SurvivalShelterTentListModel.instance:getSelectNpc()

	gohelper.setActive(self.goSelected, selectNpcId == data.id)

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingId = weekInfo:getNpcPostion(data.id)

	if buildingId then
		local buildingInfo = weekInfo:getBuildingInfo(buildingId)

		gohelper.setActive(self.goTips, true)

		local buildingConfig = SurvivalConfig.instance:getBuildingConfig(buildingInfo.buildingId, buildingInfo.level)

		self.txtBuildName.text = buildingConfig.name
	else
		gohelper.setActive(self.goTips, false)
	end

	self.txtName.text = data.co.name

	SurvivalUnitIconHelper.instance:setNpcIcon(self.imageNpc, data.co.headIcon)
	UISpriteSetMgr.instance:setSurvivalSprite(self.imgQuality, string.format("survival_bag_itemquality2_%s", data.co.rare))
end

function ShelterTentManagerNpcItem:onDestroyView()
	return
end

return ShelterTentManagerNpcItem
