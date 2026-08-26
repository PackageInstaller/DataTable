-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRecoverPresetItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverPresetItem", package.seeall)

local V1a6_CachotRoleRecoverPresetItem = class("V1a6_CachotRoleRecoverPresetItem", V1a6_CachotTeamItem)

function V1a6_CachotRoleRecoverPresetItem:addEvents()
	V1a6_CachotRoleRecoverPresetItem.super.addEvents(self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
end

function V1a6_CachotRoleRecoverPresetItem:removeEvents()
	V1a6_CachotRoleRecoverPresetItem.super.removeEvents(self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
end

function V1a6_CachotRoleRecoverPresetItem:_onClickTeamItem(mo)
	self:setSelected(self._mo == mo)
end

function V1a6_CachotRoleRecoverPresetItem:_getEquipMO()
	if self._mo then
		self._equipMO = V1a6_CachotRoleRecoverPresetListModel.instance:getEquip(self._mo)
	end
end

function V1a6_CachotRoleRecoverPresetItem:setSelected(value)
	gohelper.setActive(self._goselect2, value)
end

function V1a6_CachotRoleRecoverPresetItem:onUpdateMO(mo)
	V1a6_CachotRoleRecoverPresetItem.super.onUpdateMO(self, mo)
	self:_updateHp()
	self:setSelectEnable(true)
end

return V1a6_CachotRoleRecoverPresetItem
