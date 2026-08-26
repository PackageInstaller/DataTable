-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateSelectChessMenItem.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenItem", package.seeall)

local EliminateSelectChessMenItem = class("EliminateSelectChessMenItem", ListScrollCellExtend)

function EliminateSelectChessMenItem:onInitView()
	self._goChessSelected = gohelper.findChild(self.viewGO, "#go_ChessSelected")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goUnLocked = gohelper.findChild(self.viewGO, "#go_UnLocked")
	self._imageChessQuality = gohelper.findChildImage(self.viewGO, "#go_UnLocked/#image_ChessQuality")
	self._imageChess = gohelper.findChildSingleImage(self.viewGO, "#go_UnLocked/#image_Chess")
	self._goResource = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_Resource")
	self._goResourceItem = gohelper.findChild(self.viewGO, "#go_UnLocked/#go_Resource/#go_ResourceItem")
	self._imageResourceQuality = gohelper.findChildImage(self.viewGO, "#go_UnLocked/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	self._txtResourceNum = gohelper.findChildText(self.viewGO, "#go_UnLocked/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	self._txtFireNum = gohelper.findChildText(self.viewGO, "#go_UnLocked/image_Fire/#txt_FireNum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateSelectChessMenItem:addEvents()
	return
end

function EliminateSelectChessMenItem:removeEvents()
	return
end

function EliminateSelectChessMenItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)
	self._animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self.addEventCb(self, EliminateMapController.instance, EliminateMapEvent.SelectChessMen, self._onSelectChessMen, self)
end

function EliminateSelectChessMenItem:_editableAddEvents()
	self._click:AddClickListener(self._onItemClick, self)
end

function EliminateSelectChessMenItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function EliminateSelectChessMenItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not self._isUnlocked then
		GameFacade.showToast(ToastEnum.EliminateChessMenLocked)

		return
	end

	if not self._isSelected then
		EliminateSelectChessMenListModel.instance:setSelectedChessMen(self._mo)
	end

	if EliminateSelectChessMenListModel.instance:getQuickEdit() then
		EliminateMapController.instance:dispatchEvent(EliminateMapEvent.QuickSelectChessMen)
	end
end

function EliminateSelectChessMenItem:_onSelectChessMen()
	self._isSelected = self._mo == EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	gohelper.setActive(self._goChessSelected, self._isSelected)
end

function EliminateSelectChessMenItem:onUpdateMO(mo)
	self._mo = mo
	self._config = mo.config
	self._isUnlocked = EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(self._config.id)

	gohelper.setActive(self._goLocked, not self._isUnlocked)
	gohelper.setActive(self._goUnLocked, self._isUnlocked)
	self:_onSelectChessMen()

	if not self._isUnlocked then
		self._animator:Play("idle", self._idleDone, self)

		return
	end

	self._txtFireNum.text = tostring(self._config.defaultPower)

	local costList = self._mo.costList

	gohelper.CreateObjList(self, self._onItemShow, costList, self._goResource, self._goResourceItem)
	SurvivalUnitIconHelper.instance:setNpcIcon(self._imageChess, self._config.resPic)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(self._imageChessQuality, "v2a2_eliminate_chessqualitybg_0" .. self._config.level, false)

	if not EliminateMapController.hasOnceActionKey(EliminateMapEnum.PrefsKey.ChessUnlock, self._config.id) then
		EliminateMapController.setOnceActionKey(EliminateMapEnum.PrefsKey.ChessUnlock, self._config.id)
		gohelper.setActive(self._goLocked, true)
		self._animator:Play("unlock", self._unlockDone, self)
	end
end

function EliminateSelectChessMenItem:_unlockDone()
	self._animator:Play("idle", self._idleDone, self)
	gohelper.setActive(self._goLocked, false)
end

function EliminateSelectChessMenItem:_idleDone()
	return
end

function EliminateSelectChessMenItem:_onItemShow(obj, data, index)
	local resourceImage = gohelper.findChildImage(obj, "#image_ResourceQuality")
	local txt = gohelper.findChildText(obj, "#image_ResourceQuality/#txt_ResourceNum")
	local resourceId = data[1]

	UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)

	txt.text = data[2]
end

function EliminateSelectChessMenItem:onSelect(isSelect)
	return
end

function EliminateSelectChessMenItem:onDestroyView()
	return
end

return EliminateSelectChessMenItem
