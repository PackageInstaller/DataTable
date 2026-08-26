-- chunkname: @modules/logic/dungeon/view/monster/DungeonMonsterItem.lua

module("modules.logic.dungeon.view.monster.DungeonMonsterItem", package.seeall)

local DungeonMonsterItem = class("DungeonMonsterItem", ListScrollCellExtend)

function DungeonMonsterItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMonsterItem:addEvents()
	return
end

function DungeonMonsterItem:removeEvents()
	return
end

function DungeonMonsterItem:_btncategoryOnClick()
	self._view:selectCell(self._index, true)
end

function DungeonMonsterItem:_editableInitView()
	self._singleImage = gohelper.findChildImage(self.viewGO, "image")
	self._quality = gohelper.findChildImage(self.viewGO, "quality")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._click = SLFramework.UGUI.UIClickListener.Get(self._singleImage.gameObject)
end

function DungeonMonsterItem:_editableAddEvents()
	self._click:AddClickListener(self._btncategoryOnClick, self)
end

function DungeonMonsterItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function DungeonMonsterItem:onUpdateMO(mo)
	self._mo = mo

	local skinCO = FightConfig.instance:getSkinCO(self._mo.config.skinId)

	if skinCO then
		if not skinCO.headIcon then
			local icon

			if icon then
				gohelper.getSingleImage(self._singleImage.gameObject):LoadImage(ResUrl.monsterHeadIcon(icon))
			end

			UISpriteSetMgr.instance:setCommonSprite(self._quality, "bp_quality_01")
		end
	end
end

function DungeonMonsterItem:onSelect(isSelect)
	if isSelect then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMonster, self._mo.config)
	end

	self._goselected:SetActive(isSelect)
end

function DungeonMonsterItem:onDestroyView()
	return
end

return DungeonMonsterItem
