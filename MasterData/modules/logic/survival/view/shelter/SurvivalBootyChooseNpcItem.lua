-- chunkname: @modules/logic/survival/view/shelter/SurvivalBootyChooseNpcItem.lua

module("modules.logic.survival.view.shelter.SurvivalBootyChooseNpcItem", package.seeall)

local SurvivalBootyChooseNpcItem = class("SurvivalBootyChooseNpcItem", ShelterTentManagerNpcItem)

function SurvivalBootyChooseNpcItem:onInitView()
	SurvivalBootyChooseNpcItem.super.onInitView(self)

	self._imgQuality = gohelper.findChildImage(self.viewGO, "#image_quality")
end

function SurvivalBootyChooseNpcItem:onClickNpcItem()
	if not self.mo then
		return
	end

	if SurvivalShelterChooseNpcListModel.instance:isQuickSelect() then
		SurvivalShelterChooseNpcListModel.instance:quickSelectNpc(self.mo.id)
	else
		SurvivalShelterChooseNpcListModel.instance:setSelectNpc(self.mo.id)
		self._view.viewContainer:refreshNpcChooseView()
	end
end

function SurvivalBootyChooseNpcItem:refreshItem(data)
	local selectNpcId = SurvivalShelterChooseNpcListModel.instance:getSelectNpc()
	local selectIndex = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(data.id)
	local quickSelect = SurvivalShelterChooseNpcListModel.instance:isQuickSelect()

	gohelper.setActive(self.goSelected, selectNpcId == data.id and not quickSelect)
	gohelper.setActive(self.goTips, selectIndex ~= nil)

	if selectIndex ~= nil then
		self.txtBuildName.text = luaLang("SurvivalShelterChooseNpcItem_Tips")
	end

	self.txtName.text = data.co.name

	if not string.nilorempty(data.co.headIcon) then
		SurvivalUnitIconHelper.instance:setNpcIcon(self.imageNpc, data.co.headIcon)
	end

	if data.co.rare ~= nil then
		UISpriteSetMgr.instance:setSurvivalSprite(self._imgQuality, string.format("survival_bag_itemquality2_%s", data.co.rare))
	end
end

return SurvivalBootyChooseNpcItem
