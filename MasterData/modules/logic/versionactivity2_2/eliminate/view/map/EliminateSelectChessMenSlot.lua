-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateSelectChessMenSlot.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenSlot", package.seeall)

local EliminateSelectChessMenSlot = class("EliminateSelectChessMenSlot", ListScrollCellExtend)

function EliminateSelectChessMenSlot:onInitView()
	self._goadd = gohelper.findChild(self.viewGO, "#go_add")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._godetail = gohelper.findChild(self.viewGO, "#go_detail")
	self._imageQuality = gohelper.findChildImage(self.viewGO, "#go_detail/#image_Quality")
	self._imageChess = gohelper.findChildSingleImage(self.viewGO, "#go_detail/ChessMask/#image_Chess")
	self._txtFireNum = gohelper.findChildText(self.viewGO, "#go_detail/image_Fire/#txt_FireNum")
	self._goResources = gohelper.findChild(self.viewGO, "#go_detail/#go_Resources")
	self._goResourceItem = gohelper.findChild(self.viewGO, "#go_detail/#go_Resources/#go_ResourceItem")
	self._imageResourceQuality = gohelper.findChildImage(self.viewGO, "#go_detail/#go_Resources/#go_ResourceItem/#image_ResourceQuality")
	self._txtResourceNum = gohelper.findChildText(self.viewGO, "#go_detail/#go_Resources/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	self._goAssist = gohelper.findChild(self.viewGO, "#go_Assist")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateSelectChessMenSlot:addEvents()
	return
end

function EliminateSelectChessMenSlot:removeEvents()
	return
end

function EliminateSelectChessMenSlot:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)

	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.SelectChessMen, self._onSelectChessMen, self)

	self._isPreset = EliminateTeamSelectionModel.instance:isPreset()

	gohelper.setActive(self._goAssist, false)
end

function EliminateSelectChessMenSlot:_editableAddEvents()
	self._click:AddClickListener(self._onItemClick, self)
end

function EliminateSelectChessMenSlot:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function EliminateSelectChessMenSlot:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self._isUnlocked and self._mo then
		EliminateSelectChessMenListModel.instance:setSelectedChessMen(self._mo)

		if EliminateSelectChessMenListModel.instance:getQuickEdit() then
			EliminateMapController.instance:dispatchEvent(EliminateMapEvent.QuickSelectChessMen)
		end
	end
end

function EliminateSelectChessMenSlot:setIndex(index)
	self._index = index
	self._isUnlocked = index <= EliminateSelectChessMenListModel.instance:getAddMaxCount()
end

function EliminateSelectChessMenSlot:_onSelectChessMen()
	self._isSelected = self._mo == EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	gohelper.setActive(self._goSelected, self._isSelected)
end

function EliminateSelectChessMenSlot:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self._goLocked, not self._isUnlocked)
	gohelper.setActive(self._goadd, self._isUnlocked and not self._mo)
	gohelper.setActive(self._godetail, self._isUnlocked and self._mo)
	gohelper.setActive(self._goAssist, false)

	if not self._mo then
		return
	end

	self._config = mo.config
	self._txtFireNum.text = tostring(self._config.defaultPower)

	self:_onSelectChessMen()
	SurvivalUnitIconHelper.instance:setNpcIcon(self._imageChess, self._config.resPic)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(self._imageQuality, "v2a2_eliminate_builditem_quality_0" .. self._config.level, false)
	gohelper.setActive(self._goAssist, self._isPreset)

	local costList = self._mo.costList

	gohelper.CreateObjList(self, self._onItemShow, costList, self._goResources, self._goResourceItem)
end

function EliminateSelectChessMenSlot:_onItemShow(obj, data, index)
	local resourceImage = gohelper.findChildImage(obj, "#image_ResourceQuality")
	local txt = gohelper.findChildText(obj, "#image_ResourceQuality/#txt_ResourceNum")
	local resourceId = data[1]

	UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)

	txt.text = data[2]
end

function EliminateSelectChessMenSlot:onSelect(isSelect)
	return
end

function EliminateSelectChessMenSlot:onDestroyView()
	return
end

return EliminateSelectChessMenSlot
