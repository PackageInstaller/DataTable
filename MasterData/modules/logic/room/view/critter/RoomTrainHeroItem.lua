-- chunkname: @modules/logic/room/view/critter/RoomTrainHeroItem.lua

module("modules.logic.room.view.critter.RoomTrainHeroItem", package.seeall)

local RoomTrainHeroItem = class("RoomTrainHeroItem", ListScrollCellExtend)

function RoomTrainHeroItem:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_content/#txt_name")
	self._txtquailty = gohelper.findChildText(self.viewGO, "#go_content/#txt_quailty")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#go_content/head/#image_rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_content/head/#simage_icon")
	self._goselect = gohelper.findChild(self.viewGO, "#go_content/#go_select")
	self._gogroup = gohelper.findChild(self.viewGO, "#go_content/#go_group")
	self._gobaseitem = gohelper.findChild(self.viewGO, "#go_content/#go_group/#go_baseitem")
	self._txtpreference = gohelper.findChildText(self.viewGO, "#go_content/#go_group/go_preferenceitem/#txt_preference")
	self._simagepreference = gohelper.findChildSingleImage(self.viewGO, "#go_content/#go_group/go_preferenceitem/#simage_preference")
	self._btnclickitem = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_clickitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTrainHeroItem:addEvents()
	self._btnclickitem:AddClickListener(self._btnclickitemOnClick, self)
end

function RoomTrainHeroItem:removeEvents()
	self._btnclickitem:RemoveClickListener()
end

function RoomTrainHeroItem:_btnclickitemOnClick()
	if self._view and self._view.viewContainer then
		self._view.viewContainer:dispatchEvent(CritterEvent.UITrainSelectHero, self:getDataMO())
	end
end

function RoomTrainHeroItem:_editableInitView()
	self._gopreferenceitem = gohelper.findChild(self.viewGO, "#go_content/#go_group/go_preferenceitem")
	self._referenceCanvasGroup = gohelper.onceAddComponent(self._gopreferenceitem, typeof(UnityEngine.CanvasGroup))
	self._txtquailty.text = luaLang(CritterEnum.LangKey.HeroTrainLevel)
	self._attrComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobaseitem, RoomCritterAttrScrollCell)
	self._attrComp._view = self._view
	self._gograyList = {
		self._simagepreference.gameObject
	}
end

function RoomTrainHeroItem:_editableAddEvents()
	return
end

function RoomTrainHeroItem:_editableRemoveEvents()
	return
end

function RoomTrainHeroItem:getDataMO()
	return self._mo
end

function RoomTrainHeroItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function RoomTrainHeroItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function RoomTrainHeroItem:onDestroyView()
	self._attrComp:onDestroy()
end

function RoomTrainHeroItem:refreshUI()
	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(self._mo.skinConfig.headIcon))

	self._txtname.text = self._mo.heroConfig.name

	UISpriteSetMgr.instance:setCritterSprite(self._imagerare, CritterEnum.QualityImageNameMap[self._mo.heroConfig.rare])

	self._txtpreference.text = self._mo:getPrefernectName()

	if self._mo.critterHeroConfig then
		self._simagepreference:LoadImage(ResUrl.getCritterHedaIcon(self._mo.critterHeroConfig.critterIcon))
	end

	self._attrComp:onUpdateMO(self._mo:getAttributeInfoMO())

	self._referenceCanvasGroup.alpha = self:_isPreference() and 1 or 0.5
end

function RoomTrainHeroItem:_isPreference()
	if self._mo then
		local citterUid = RoomTrainCritterListModel.instance:getSelectId()
		local critterMO = RoomTrainCritterListModel.instance:getById(citterUid)

		if critterMO and self._mo:chcekPrefernectCritterId(critterMO:getDefineId()) then
			return true
		end
	end

	return false
end

RoomTrainHeroItem.prefabPath = "ui/viewres/room/critter/roomtrainheroitem.prefab"

return RoomTrainHeroItem
