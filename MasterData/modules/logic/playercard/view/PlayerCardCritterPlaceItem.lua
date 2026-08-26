-- chunkname: @modules/logic/playercard/view/PlayerCardCritterPlaceItem.lua

module("modules.logic.playercard.view.PlayerCardCritterPlaceItem", package.seeall)

local PlayerCardCritterPlaceItem = class("PlayerCardCritterPlaceItem", ListScrollCellExtend)

function PlayerCardCritterPlaceItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._goclick = gohelper.findChild(self.viewGO, "#go_click")
	self._uiclick = gohelper.getClickWithDefaultAudio(self._goclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardCritterPlaceItem:addEvents()
	self._uiclick:AddClickListener(self._btnclickOnClick, self)
	self._uiclick:AddClickDownListener(self._btnclickOnClickDown, self)
end

function PlayerCardCritterPlaceItem:removeEvents()
	self._uiclick:RemoveClickListener()
	self._uiclick:RemoveClickDownListener()
end

function PlayerCardCritterPlaceItem:_btnclickOnClick()
	local critterUid, critterId = self:getCritterId()

	self.filterMO = CritterFilterModel.instance:generateFilterMO(ViewName.PlayerCardCritterPlaceView)

	PlayerCardModel.instance:setSelectCritterUid(critterUid)
	PlayerCardRpc.instance:sendSetPlayerCardCritterRequest(critterUid)
end

function PlayerCardCritterPlaceItem:_editableInitView()
	return
end

function PlayerCardCritterPlaceItem:onUpdateMO(mo)
	self._mo = mo

	self:setCritter()
end

function PlayerCardCritterPlaceItem:setCritter()
	local critterUid, critterId = self:getCritterId()

	if not self.critterIcon then
		self.critterIcon = IconMgr.instance:getCommonCritterIcon(self._goicon)

		self.critterIcon:setSelectUIVisible(true)
	end

	self.critterIcon:setMOValue(critterUid, critterId)
	self.critterIcon:showSpeical()
	self.critterIcon:setMaturityIconShow(true)
	self:_refreshSelect()
end

function PlayerCardCritterPlaceItem:_refreshSelect()
	local critterUid, critterId = self:getCritterId()

	self._isSelect = tonumber(critterUid) == PlayerCardModel.instance:getSelectCritterUid()

	self.critterIcon:onSelect(self._isSelect)
end

function PlayerCardCritterPlaceItem:getCritterId()
	local critterUid, critterId

	if self._mo then
		critterUid = self._mo:getId()
		critterId = self._mo:getDefineId()
	end

	return critterUid, critterId
end

function PlayerCardCritterPlaceItem:onDestroy()
	return
end

return PlayerCardCritterPlaceItem
