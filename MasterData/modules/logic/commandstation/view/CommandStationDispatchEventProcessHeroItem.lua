-- chunkname: @modules/logic/commandstation/view/CommandStationDispatchEventProcessHeroItem.lua

module("modules.logic.commandstation.view.CommandStationDispatchEventProcessHeroItem", package.seeall)

local CommandStationDispatchEventProcessHeroItem = class("CommandStationDispatchEventProcessHeroItem", ListScrollCellExtend)

function CommandStationDispatchEventProcessHeroItem:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "#image_career")
	self._godispatched = gohelper.findChild(self.viewGO, "#go_dispatched")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_selected/#txt_index")
	self._goclick = gohelper.findChild(self.viewGO, "#go_selected/#go_click")
	self._goupicon = gohelper.findChild(self.viewGO, "#go_upicon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationDispatchEventProcessHeroItem:addEvents()
	return
end

function CommandStationDispatchEventProcessHeroItem:removeEvents()
	return
end

function CommandStationDispatchEventProcessHeroItem:_editableInitView()
	return
end

function CommandStationDispatchEventProcessHeroItem:_editableAddEvents()
	self._clickListener = SLFramework.UGUI.UIClickListener.Get(self._gobg)

	self._clickListener:AddClickListener(self._onClickHandler, self)
end

function CommandStationDispatchEventProcessHeroItem:_editableRemoveEvents()
	if self._clickListener then
		self._clickListener:RemoveClickListener()
	end
end

function CommandStationDispatchEventProcessHeroItem:_onClickHandler()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_common_click2)

	if self._isUsed then
		return
	end

	local selectedIndex = CommandStationHeroListModel.instance:getHeroSelectedIndex(self._mo)

	if selectedIndex then
		CommandStationHeroListModel.instance:cancelSelectedHero(self._mo)
		self:_updateSelectedInfo()

		return
	end

	local index = CommandStationHeroListModel.instance:getEmptyIndex()

	if index then
		CommandStationHeroListModel.instance:setSelectedHero(index, self._mo)
		self:_updateSelectedInfo()
	end
end

function CommandStationDispatchEventProcessHeroItem:_updateSelectedInfo()
	local selectedIndex = CommandStationHeroListModel.instance:getHeroSelectedIndex(self._mo)

	gohelper.setActive(self._goselected, selectedIndex ~= nil)

	if selectedIndex then
		self._txtindex.text = selectedIndex
	end
end

function CommandStationDispatchEventProcessHeroItem:onUpdateMO(mo)
	self._mo = mo

	local heroConfig = self._mo.config
	local skinId = heroConfig.skinId
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)

	self._simageicon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroConfig.career)
	gohelper.setActive(self._goupicon, CommandStationHeroListModel.instance:heroIsSpecial(self._mo.heroId))

	self._isUsed = CommandStationHeroListModel.instance:heroIsUsed(self._mo.heroId)

	gohelper.setActive(self._godispatched, self._isUsed)
	self:_updateSelectedInfo()
end

function CommandStationDispatchEventProcessHeroItem:onSelect(isSelect)
	return
end

function CommandStationDispatchEventProcessHeroItem:onDestroyView()
	return
end

return CommandStationDispatchEventProcessHeroItem
