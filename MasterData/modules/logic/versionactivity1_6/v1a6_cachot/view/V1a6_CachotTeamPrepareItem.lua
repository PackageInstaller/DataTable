-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTeamPrepareItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPrepareItem", package.seeall)

local V1a6_CachotTeamPrepareItem = class("V1a6_CachotTeamPrepareItem", V1a6_CachotTeamItem)

function V1a6_CachotTeamPrepareItem:showNone()
	gohelper.setActive(self._gorole, false)
	gohelper.setActive(self._goheart, false)

	local bgNormal = gohelper.findChild(self.viewGO, "bg_normal")
	local bgNone = gohelper.findChild(self.viewGO, "bg_none")

	gohelper.setActive(bgNormal, false)
	gohelper.setActive(bgNone, true)
end

return V1a6_CachotTeamPrepareItem
