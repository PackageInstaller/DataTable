-- chunkname: @modules/logic/fight/view/preview/SkillEditorHeroSelectView.lua

module("modules.logic.fight.view.preview.SkillEditorHeroSelectView", package.seeall)

local SkillEditorHeroSelectView = class("SkillEditorHeroSelectView", FightBaseView)

function SkillEditorHeroSelectView:ctor()
	self._selectType = SkillEditorMgr.SelectType.Hero
end

function SkillEditorHeroSelectView:onCharacterTagItemShow(obj, data, index)
	gohelper.findChildText(obj, "text").text = lua_editor_skill_tag.configDict[data].name

	local click = gohelper.findChildClickWithDefaultAudio(obj, "click")
	local tab = {}

	tab.obj = obj
	tab.id = data

	self:com_registClick(click, self.onCharacterTagClick, tab)
end

function SkillEditorHeroSelectView:onCharacterTagClick(tab)
	local id = tab.id

	SkillEditorHeroSelectModel.selectedCharacterTagDict[id] = not SkillEditorHeroSelectModel.selectedCharacterTagDict[id]

	gohelper.setActive(gohelper.findChild(tab.obj, "select"), SkillEditorHeroSelectModel.selectedCharacterTagDict[id])
	self:_updateItems()
	self:_updateItemSelect()
end

function SkillEditorHeroSelectView:onInitView()
	self._heroViewGO = gohelper.findChild(self.viewGO, "selectHeros")
	self.characterTagSelect = gohelper.findChild(self.viewGO, "selectHeros/characterTagSelect")

	local list = {}

	for k, config in pairs(lua_editor_skill_tag.configDict) do
		table.insert(list, config.id)
	end

	table.sort(list, function(a, b)
		return a < b
	end)
	gohelper.CreateObjList(self, self.onCharacterTagItemShow, list, gohelper.findChild(self.characterTagSelect, "scroll/root"), gohelper.findChild(self.characterTagSelect, "scroll/root/tagItem"))

	self.monsterTagSelect = gohelper.findChild(self.viewGO, "selectHeros/monsterTagSelect")
	self._btnHeroPreviewL = gohelper.findChildButtonWithAudio(self.viewGO, "left/btnSelectHero")
	self._btnHeroPreviewR = gohelper.findChildButtonWithAudio(self.viewGO, "right/btnSelectHero")
	self._btnAutoPlaySkill = gohelper.findChildButtonWithAudio(self.viewGO, "right/autoplayskill")
	self._btnGroupGO = gohelper.findChild(self.viewGO, "selectHeros/btnGroup")
	self._txtcount = gohelper.findChildText(self.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect/Text")
	self._txtcount = gohelper.findChildText(self.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect/Text")
	self._selectHeroImg = gohelper.findChild(self.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect")
	self._selectMonsterImg = gohelper.findChild(self.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect")
	self._selectMonsterGroupImg = gohelper.findChild(self.viewGO, "selectHeros/btnGroup/btnSelectMonsterGroup/imgSelect")
	self._selectSubHeroImg = gohelper.findChild(self.viewGO, "selectHeros/btnGroup/btnSelectSubHero/imgSelect")
	self._selectMonsterIdImg = gohelper.findChild(self.viewGO, "selectHeros/btnGroup/btnSelectMonsterId/imgSelect")
	self._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btnClose")
	self._btnSelectHero = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btnGroup/btnSelectHero")
	self._btnSelectSubHero = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btnGroup/btnSelectSubHero")
	self._btnSelectMonster = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btnGroup/btnSelectMonster")
	self._btnSelectMonsterGroup = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btnGroup/btnSelectMonsterGroup")
	self._btnSelectMonsterId = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btnGroup/btnSelectMonsterId")
	self._btncountAdd = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect/btnAdd")
	self._btncountMinus = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect/btnMinus")
	self._btnMonsterCountAdd = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect/btnAdd")
	self._btnMonsterCountMinus = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect/btnMinus")
	self._inp = gohelper.findChildTextMeshInputField(self.viewGO, "selectHeros/inp")
	self._btnclearsub = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectHeros/btn_clear_sub")
	self._goSelect = gohelper.findChild(self.viewGO, "selectHeros/goSelect")
	self._goAutoPlaySkill = gohelper.findChild(self.viewGO, "autoPlaySkill")
	self._isOpenAutoSkillTool = false
end

function SkillEditorHeroSelectView:addEvents()
	SLFramework.UGUI.UIClickListener.Get(self._heroViewGO):AddClickListener(self._hideThis, self)
	self._btnClose:AddClickListener(self._hideThis, self)
	self._btnSelectHero:AddClickListener(self._onClickSelectHero, self)
	self._btnAutoPlaySkill:AddClickListener(self._openAutoPlaySkillTool, self)
	self._btnSelectSubHero:AddClickListener(self._onClickSelectSubHero, self)
	self._btnSelectMonster:AddClickListener(self._onClickSelectMonster, self)
	self._btnSelectMonsterGroup:AddClickListener(self._onClickSelectMonsterGroup, self)
	self._btnSelectMonsterId:AddClickListener(self._onClickSelectMonsterId, self)
	self._btncountAdd:AddClickListener(self._onClickAdd, self)
	self._btncountMinus:AddClickListener(self._onClickMinus, self)
	self._btnMonsterCountAdd:AddClickListener(self._onClickAdd, self)
	self._btnMonsterCountMinus:AddClickListener(self._onClickMinus, self)
	self._btnHeroPreviewL:AddClickListener(self._showThis, self, FightEnum.EntitySide.EnemySide)
	self._btnHeroPreviewR:AddClickListener(self._showThis, self, FightEnum.EntitySide.MySide)
	self._inp:AddOnValueChanged(self._onInpValueChanged, self)
	self._btnclearsub:AddClickListener(self._clearSubHero, self)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr.ShowHeroSelectView, self._showWithStancePosId, self)
end

function SkillEditorHeroSelectView:removeEvents()
	SLFramework.UGUI.UIClickListener.Get(self._heroViewGO):RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSelectHero:RemoveClickListener()
	self._btnAutoPlaySkill:RemoveClickListener()
	self._btnSelectSubHero:RemoveClickListener()
	self._btnSelectMonster:RemoveClickListener()
	self._btnSelectMonsterGroup:RemoveClickListener()
	self._btnSelectMonsterId:RemoveClickListener()
	self._btncountAdd:RemoveClickListener()
	self._btncountMinus:RemoveClickListener()
	self._btnMonsterCountAdd:RemoveClickListener()
	self._btnMonsterCountMinus:RemoveClickListener()
	self._btnHeroPreviewL:RemoveClickListener()
	self._btnHeroPreviewR:RemoveClickListener()
	self._inp:RemoveOnValueChanged()
	self._btnclearsub:RemoveClickListener()
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr.ShowHeroSelectView, self._showWithStancePosId, self)
end

function SkillEditorHeroSelectView:_onInpValueChanged(inputStr)
	self:_updateItems()
	self:_updateItemSelect()
end

function SkillEditorHeroSelectView:_showThis(side)
	gohelper.setActive(self._heroViewGO, true)
	gohelper.setActive(self._btnGroupGO, true)

	self._side = side
	self._stancePosId = nil
	self._selectType = SkillEditorMgr.instance:getTypeInfo(self._side)

	self:_updateTypeSelect()
	self:_updateItems()
	self:_updateItemSelect()
end

function SkillEditorHeroSelectView:_hideThis()
	gohelper.setActive(self._heroViewGO, false)
end

function SkillEditorHeroSelectView:_showWithStancePosId(side, stancePosId)
	gohelper.setActive(self._heroViewGO, true)
	gohelper.setActive(self._btnGroupGO, false)

	self._side = side
	self._stancePosId = stancePosId
	self._selectType = SkillEditorMgr.instance:getTypeInfo(self._side)

	if self._selectType == SkillEditorMgr.SelectType.Group then
		self._selectType = SkillEditorMgr.SelectType.Monster
	end

	self:_updateTypeSelect()
	self:_updateItems()
	self:_updateItemSelect()
end

function SkillEditorHeroSelectView:_btnStateChange(obj)
	gohelper.addChild(obj, self._goSelect)
	recthelper.setAnchor(self._goSelect.transform, 95, 34)
end

function SkillEditorHeroSelectView:_onClickSelectHero()
	self:_btnStateChange(self._btnSelectHero.gameObject)

	self._selectType = SkillEditorMgr.SelectType.Hero

	self:_updateTypeSelect()
	self:_updateItems()
	self:_updateItemSelect()
end

function SkillEditorHeroSelectView:_onClickSelectSubHero()
	self:_btnStateChange(self._btnSelectSubHero.gameObject)

	self._selectType = SkillEditorMgr.SelectType.SubHero

	self:_updateTypeSelect()
	self:_updateItems()
	self:_updateItemSelect()
end

function SkillEditorHeroSelectView:_onClickSelectMonster()
	self:_btnStateChange(self._btnSelectMonster.gameObject)

	self._selectType = SkillEditorMgr.SelectType.Monster

	self:_updateItems()
	self:_updateTypeSelect()
	self:_updateItemSelect()
end

function SkillEditorHeroSelectView:_onClickSelectMonsterGroup()
	self:_btnStateChange(self._btnSelectMonsterGroup.gameObject)

	self._selectType = SkillEditorMgr.SelectType.Group

	self:_updateItems()
	self:_updateTypeSelect()
	self:_updateItemSelect()
end

function SkillEditorHeroSelectView:_onClickSelectMonsterId()
	self:_btnStateChange(self._btnSelectMonsterId.gameObject)

	self._selectType = SkillEditorMgr.SelectType.MonsterId

	self:_updateItems()
	self:_updateTypeSelect()
	self:_updateItemSelect()
end

function SkillEditorHeroSelectView:_openAutoPlaySkillTool()
	self._isOpenAutoSkillTool = not self._isOpenAutoSkillTool

	gohelper.setActive(self._goAutoPlaySkill, self._isOpenAutoSkillTool)
end

function SkillEditorHeroSelectView:_onClickAdd()
	local _, info = SkillEditorMgr.instance:getTypeInfo(self._side)

	if SkillEditorHeroSelectModel.instance.side == FightEnum.EntitySide.MySide then
		if not SkillEditorMgr.instance.stance_count_limit then
			local limit_count = SkillEditorMgr.instance.enemy_stance_count_limit

			if limit_count > #info.ids then
				table.insert(info.ids, info.ids[1])
				table.insert(info.skinIds, info.skinIds[1])
				SkillEditorMgr.instance:refreshInfo(self._side)
				SkillEditorMgr.instance:rebuildEntitys(self._side)
			end
		end
	end
end

function SkillEditorHeroSelectView:_onClickMinus()
	local _, info = SkillEditorMgr.instance:getTypeInfo(self._side)

	if #info.ids > 1 then
		table.remove(info.ids, #info.ids)
		table.remove(info.skinIds, #info.ids)
		SkillEditorMgr.instance:refreshInfo(self._side)
		SkillEditorMgr.instance:rebuildEntitys(self._side)
	end
end

function SkillEditorHeroSelectView:_updateItems()
	SkillEditorHeroSelectModel.instance:setSelect(self._side, self._selectType, self._stancePosId, self._inp:GetText())
end

function SkillEditorHeroSelectView:_updateTypeSelect()
	gohelper.setActive(self._selectHeroImg, self._selectType == SkillEditorMgr.SelectType.Hero)
	gohelper.setActive(self.characterTagSelect, self._selectType == SkillEditorMgr.SelectType.Hero)
	gohelper.setActive(self._selectMonsterImg, self._selectType == SkillEditorMgr.SelectType.Monster)
	gohelper.setActive(self.monsterTagSelect, self._selectType == SkillEditorMgr.SelectType.Monster)
	gohelper.setActive(self._selectMonsterGroupImg, self._selectType == SkillEditorMgr.SelectType.Group)
	gohelper.setActive(self._btnclearsub.gameObject, self._selectType == SkillEditorMgr.SelectType.SubHero)
	gohelper.setActive(self._selectSubHeroImg, self._selectType == SkillEditorMgr.SelectType.SubHero)
	gohelper.setActive(self._selectMonsterIdImg, self._selectType == SkillEditorMgr.SelectType.MonsterId)
end

function SkillEditorHeroSelectView:_updateItemSelect()
	local list = SkillEditorHeroSelectModel.instance:getList()
	local _, info = SkillEditorMgr.instance:getTypeInfo(self._side)

	for i, mo in ipairs(list) do
		local co = mo.co

		if not self._stancePosId then
			if info.ids[self._stancePosId] == co.id then
				if info.skinIds[self._stancePosId] == co.skinId then
					SkillEditorHeroSelectModel.instance:selectCell(mo.id, true)
				end
			elseif info.groupId == co.id then
				SkillEditorHeroSelectModel.instance:selectCell(mo.id, true)
			end
		end
	end
end

function SkillEditorHeroSelectView:_clearSubHero()
	SkillEditorMgr.instance:clearSubHero()
end

return SkillEditorHeroSelectView
