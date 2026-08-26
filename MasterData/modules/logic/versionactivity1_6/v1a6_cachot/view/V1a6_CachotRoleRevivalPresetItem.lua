-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRevivalPresetItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalPresetItem", package.seeall)

local V1a6_CachotRoleRevivalPresetItem = class("V1a6_CachotRoleRevivalPresetItem", V1a6_CachotTeamItem)

function V1a6_CachotRoleRevivalPresetItem:addEvents()
	V1a6_CachotRoleRevivalPresetItem.super.addEvents(self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
end

function V1a6_CachotRoleRevivalPresetItem:removeEvents()
	V1a6_CachotRoleRevivalPresetItem.super.removeEvents(self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
end

function V1a6_CachotRoleRevivalPresetItem:_onClickTeamItem(mo)
	self:setSelected(self._mo == mo)
end

function V1a6_CachotRoleRevivalPresetItem:_getEquipMO()
	if self._mo then
		self._equipMO = V1a6_CachotRoleRevivalPresetListModel.instance:getEquip(self._mo)
	end
end

function V1a6_CachotRoleRevivalPresetItem:onUpdateMO(mo)
	V1a6_CachotRoleRevivalPresetItem.super.onUpdateMO(self, mo)
	self:_updateHp()
	self:setSelectEnable(true)
end

return V1a6_CachotRoleRevivalPresetItem
