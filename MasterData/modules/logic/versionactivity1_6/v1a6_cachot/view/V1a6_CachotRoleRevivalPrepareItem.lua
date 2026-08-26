-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRevivalPrepareItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalPrepareItem", package.seeall)

local V1a6_CachotRoleRevivalPrepareItem = class("V1a6_CachotRoleRevivalPrepareItem", V1a6_CachotTeamPrepareItem)

function V1a6_CachotRoleRevivalPrepareItem:onInitView()
	V1a6_CachotRoleRevivalPrepareItem.super.onInitView(self)
end

function V1a6_CachotRoleRevivalPrepareItem:addEvents()
	V1a6_CachotRoleRevivalPrepareItem.super.addEvents(self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
end

function V1a6_CachotRoleRevivalPrepareItem:removeEvents()
	V1a6_CachotRoleRevivalPrepareItem.super.removeEvents(self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
end

function V1a6_CachotRoleRevivalPrepareItem:_onClickTeamItem(mo)
	self:setSelected(self._mo == mo)
end

function V1a6_CachotRoleRevivalPrepareItem:_getEquipMO()
	return
end

function V1a6_CachotRoleRevivalPrepareItem:showNone()
	gohelper.setActive(self._gorole, false)
	gohelper.setActive(self._goheart, false)

	local bgNormal = gohelper.findChild(self.viewGO, "bg_normal")
	local bgNone = gohelper.findChild(self.viewGO, "bg_none")

	gohelper.setActive(bgNormal, false)
	gohelper.setActive(bgNone, true)
end

function V1a6_CachotRoleRevivalPrepareItem:hideDeadStatus(value)
	self._hideDeadStatus = value
end

function V1a6_CachotRoleRevivalPrepareItem:onUpdateMO(mo)
	V1a6_CachotRoleRevivalPrepareItem.super.onUpdateMO(self, mo)
	self:_updateHp()
	self:setSelectEnable(true)
end

function V1a6_CachotRoleRevivalPrepareItem:_showDeadStatus(isDead)
	if self._hideDeadStatus then
		return
	end

	V1a6_CachotRoleRevivalPrepareItem.super._showDeadStatus(self, isDead)
end

return V1a6_CachotRoleRevivalPrepareItem
