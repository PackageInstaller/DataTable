-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRecoverPrepareItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverPrepareItem", package.seeall)

local V1a6_CachotRoleRecoverPrepareItem = class("V1a6_CachotRoleRecoverPrepareItem", V1a6_CachotTeamPrepareItem)

function V1a6_CachotRoleRecoverPrepareItem:onInitView()
	V1a6_CachotRoleRecoverPrepareItem.super.onInitView(self)
end

function V1a6_CachotRoleRecoverPrepareItem:addEvents()
	V1a6_CachotRoleRecoverPrepareItem.super.addEvents(self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
end

function V1a6_CachotRoleRecoverPrepareItem:removeEvents()
	V1a6_CachotRoleRecoverPrepareItem.super.removeEvents(self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
end

function V1a6_CachotRoleRecoverPrepareItem:_onClickTeamItem(mo)
	self:setSelected(self._mo == mo)
end

function V1a6_CachotRoleRecoverPrepareItem:_getEquipMO()
	return
end

function V1a6_CachotRoleRecoverPrepareItem:showNone()
	gohelper.setActive(self._gorole, false)
	gohelper.setActive(self._goheart, false)

	local bgNormal = gohelper.findChild(self.viewGO, "bg_normal")
	local bgNone = gohelper.findChild(self.viewGO, "bg_none")

	gohelper.setActive(bgNormal, false)
	gohelper.setActive(bgNone, true)
end

function V1a6_CachotRoleRecoverPrepareItem:onUpdateMO(mo)
	V1a6_CachotRoleRecoverPrepareItem.super.onUpdateMO(self, mo)
	self:_updateHp()
	self:setSelectEnable(true)
end

return V1a6_CachotRoleRecoverPrepareItem
