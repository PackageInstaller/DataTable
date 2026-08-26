-- chunkname: @modules/logic/player/view/PlayerClothItem.lua

module("modules.logic.player.view.PlayerClothItem", package.seeall)

local PlayerClothItem = class("PlayerClothItem", ListScrollCell)

function PlayerClothItem:init(go)
	self._bg = gohelper.findChildImage(go, "bg")
	self._imgBg = gohelper.findChildSingleImage(go, "skillicon")
	self._inUseGO = gohelper.findChild(go, "inuse")
	self._beSelectedGO = gohelper.findChild(go, "beselected")
	self._clickThis = gohelper.getClick(go)
end

function PlayerClothItem:addEventListeners()
	self._clickThis:AddClickListener(self._onClickThis, self)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, self._onChangeClothId, self)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, self._onChangeClothId, self)
end

function PlayerClothItem:removeEventListeners()
	self._clickThis:RemoveClickListener()
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, self._onChangeClothId, self)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, self._onChangeClothId, self)
end

function PlayerClothItem:onUpdateMO(mo)
	self.mo = mo

	self._imgBg:LoadImage(ResUrl.getPlayerClothIcon(tostring(mo.clothId)))

	local firstSelectMO = self._view:getFirstSelect()

	if firstSelectMO == mo then
		self:onSelect(true)
	end

	self:_updateOnUse()
end

function PlayerClothItem:_updateOnUse()
	local groupModel = PlayerClothListViewModel.instance:getGroupModel()
	local curGroupMO = groupModel and groupModel:getCurGroupMO()
	local cloth_id = PlayerClothModel.instance:getSpEpisodeClothID() or curGroupMO and curGroupMO.clothId
	local isUsing = cloth_id == self.mo.clothId

	gohelper.setActive(self._beSelectedGO, self._isSelect)
	gohelper.setActive(self._inUseGO, isUsing)
end

function PlayerClothItem:onSelect(isSelect)
	self._isSelect = isSelect

	self:_updateOnUse()
end

function PlayerClothItem:_onChangeClothId()
	self:_updateOnUse()
end

function PlayerClothItem:_onClickThis()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return
	end

	if not self._isSelect then
		PlayerController.instance:dispatchEvent(PlayerEvent.SelectCloth, self.mo.clothId)
	end
end

return PlayerClothItem
