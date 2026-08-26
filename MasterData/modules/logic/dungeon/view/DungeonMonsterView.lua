-- chunkname: @modules/logic/dungeon/view/DungeonMonsterView.lua

module("modules.logic.dungeon.view.DungeonMonsterView", package.seeall)

local DungeonMonsterView = class("DungeonMonsterView", BaseView)

function DungeonMonsterView:onInitView()
	self._simagequality = gohelper.findChildImage(self.viewGO, "desc/#simage_quality")
	self._simageicon = gohelper.findChildImage(self.viewGO, "desc/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "desc/#txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "desc/#txt_desc")
	self._simagecareericon = gohelper.findChildImage(self.viewGO, "desc/#simage_careericon")
	self._scrollmonster = gohelper.findChildScrollRect(self.viewGO, "#scroll_monster")
	self._goselected = gohelper.findChild(self.viewGO, "content_prefab/#go_selected")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMonsterView:addEvents()
	return
end

function DungeonMonsterView:removeEvents()
	return
end

function DungeonMonsterView:_btnbackOnClick()
	self:closeThis()
end

function DungeonMonsterView:_editableInitView()
	return
end

function DungeonMonsterView:onUpdateParam()
	return
end

function DungeonMonsterView:onOpen()
	DungeonMonsterListModel.instance:setMonsterList(self.viewParam.monsterDisplayList)
	self.viewContainer:getScrollView():setSelect(DungeonMonsterListModel.instance.initSelectMO)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeMonster, self._onChangeMonster, self)
end

function DungeonMonsterView:onClose()
	return
end

function DungeonMonsterView:_onChangeMonster(monsterConfig)
	self._txtname.text = monsterConfig.name
	self._txtdesc.text = monsterConfig.des

	UISpriteSetMgr.instance:setCommonSprite(self._simagecareericon, "lssx_" .. tostring(monsterConfig.career))

	local skinCO = FightConfig.instance:getSkinCO(monsterConfig.skinId)

	if skinCO then
		if not skinCO.headIcon then
			local icon

			if icon then
				gohelper.getSingleImage(self._simageicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(icon))
			end

			UISpriteSetMgr.instance:setCommonSprite(self._simagequality, "bp_quality_01")
		end
	end
end

function DungeonMonsterView:onDestroyView()
	return
end

return DungeonMonsterView
