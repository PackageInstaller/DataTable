-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTeamPreviewPrepareItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreviewPrepareItem", package.seeall)

local V1a6_CachotTeamPreviewPrepareItem = class("V1a6_CachotTeamPreviewPrepareItem", V1a6_CachotTeamPrepareItem)

function V1a6_CachotTeamPreviewPrepareItem:onInitView()
	V1a6_CachotTeamPreviewPrepareItem.super.onInitView(self)
end

function V1a6_CachotTeamPreviewPrepareItem:_getEquipMO()
	return
end

function V1a6_CachotTeamPreviewPrepareItem:showNone()
	gohelper.setActive(self._gorole, false)
	gohelper.setActive(self._goheart, false)

	local bgNormal = gohelper.findChild(self.viewGO, "bg_normal")
	local bgNone = gohelper.findChild(self.viewGO, "bg_none")

	gohelper.setActive(bgNormal, false)
	gohelper.setActive(bgNone, true)
end

function V1a6_CachotTeamPreviewPrepareItem:onUpdateMO(mo)
	V1a6_CachotTeamPreviewPrepareItem.super.onUpdateMO(self, mo)
	self:_updateHp()
end

return V1a6_CachotTeamPreviewPrepareItem
