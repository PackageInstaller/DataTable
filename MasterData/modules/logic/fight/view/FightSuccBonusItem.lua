-- chunkname: @modules/logic/fight/view/FightSuccBonusItem.lua

module("modules.logic.fight.view.FightSuccBonusItem", package.seeall)

local FightSuccBonusItem = class("FightSuccBonusItem", ListScrollCell)

function FightSuccBonusItem:init(go)
	local itemIconGO = gohelper.findChild(go, "itemIcon")

	self._itemIcon = IconMgr.instance:getCommonItemIcon(itemIconGO)
	self._tagGO = gohelper.findChild(go, "tag")
	self._imgFirstGO = gohelper.findChild(go, "tag/imgFirst")
	self._imgNormalGO = gohelper.findChild(go, "tag/imgNormal")
	self._imgHardGO = gohelper.findChild(go, "tag/imgHard")
end

function FightSuccBonusItem:onUpdateMO(mo)
	self._itemIcon:onUpdateMO(mo)
	self._itemIcon:setCantJump(true)
end

return FightSuccBonusItem
