-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTeamPreviewPresetItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreviewPresetItem", package.seeall)

local V1a6_CachotTeamPreviewPresetItem = class("V1a6_CachotTeamPreviewPresetItem", V1a6_CachotTeamItem)

function V1a6_CachotTeamPreviewPresetItem:_getEquipMO()
	if self._mo then
		self._equipMO = V1a6_CachotTeamPreviewPresetListModel.instance:getEquip(self._mo)
	end
end

function V1a6_CachotTeamPreviewPresetItem:onUpdateMO(mo)
	V1a6_CachotTeamPreviewPresetItem.super.onUpdateMO(self, mo)
	self:_updateHp()
end

return V1a6_CachotTeamPreviewPresetItem
