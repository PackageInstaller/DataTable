-- chunkname: @modules/logic/versionactivity1_3/astrology/view/VersionActivity1_3AstrologyPlanetItem.lua

module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyPlanetItem", package.seeall)

local VersionActivity1_3AstrologyPlanetItem = class("VersionActivity1_3AstrologyPlanetItem", ListScrollCellExtend)

function VersionActivity1_3AstrologyPlanetItem:onInitView()
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._imagePlanetSelected = gohelper.findChildImage(self.viewGO, "#go_Selected/#image_PlanetSelected")
	self._txtNumSelected = gohelper.findChildText(self.viewGO, "#go_Selected/#txt_NumSelected")
	self._goUnSelected = gohelper.findChild(self.viewGO, "#go_UnSelected")
	self._imagePlanetUnSelected = gohelper.findChildImage(self.viewGO, "#go_UnSelected/#image_PlanetUnSelected")
	self._txtNumUnSelected = gohelper.findChildText(self.viewGO, "#go_UnSelected/#txt_NumUnSelected")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3AstrologyPlanetItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function VersionActivity1_3AstrologyPlanetItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function VersionActivity1_3AstrologyPlanetItem:_btnclickOnClick()
	self._astrologySelectView:setSelected(self)
end

function VersionActivity1_3AstrologyPlanetItem:ctor(param)
	self._id = param[1]
	self._astrologySelectView = param[2]
	self._mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(self._id)
end

function VersionActivity1_3AstrologyPlanetItem:getPlanetMo()
	return self._mo
end

function VersionActivity1_3AstrologyPlanetItem:getId()
	return self._id
end

function VersionActivity1_3AstrologyPlanetItem:_editableInitView()
	local icon = "v1a3_astrology_planet" .. self._id

	UISpriteSetMgr.instance:setV1a3AstrologySprite(self._imagePlanetSelected, icon)

	local alpha = self._imagePlanetUnSelected.color.a

	UISpriteSetMgr.instance:setV1a3AstrologySprite(self._imagePlanetUnSelected, icon, nil, alpha)
	self:updateNum()
end

function VersionActivity1_3AstrologyPlanetItem:setSelected(value)
	self._isSelected = value

	gohelper.setActive(self._goSelected, self._isSelected)
	gohelper.setActive(self._goUnSelected, not self._isSelected)
end

function VersionActivity1_3AstrologyPlanetItem:isSelected()
	return self._isSelected
end

function VersionActivity1_3AstrologyPlanetItem:updateNum()
	local num = self._mo.num
	local text = string.format("x%s", num)

	self._txtNumSelected.text = text
	self._txtNumUnSelected.text = text
end

function VersionActivity1_3AstrologyPlanetItem:_editableAddEvents()
	return
end

function VersionActivity1_3AstrologyPlanetItem:_editableRemoveEvents()
	return
end

function VersionActivity1_3AstrologyPlanetItem:onDestroyView()
	return
end

return VersionActivity1_3AstrologyPlanetItem
