-- chunkname: @modules/logic/fight/view/preview/SkillEditorStanceSelectView.lua

module("modules.logic.fight.view.preview.SkillEditorStanceSelectView", package.seeall)

local SkillEditorStanceSelectView = class("SkillEditorStanceSelectView", BaseView)

function SkillEditorStanceSelectView:ctor()
	return
end

function SkillEditorStanceSelectView:onInitView()
	self._actionViewGO = gohelper.findChild(self.viewGO, "selectStance")
	self._itemGOParent = gohelper.findChild(self.viewGO, "selectStance/scroll/content")
	self._itemGOPrefab = gohelper.findChild(self.viewGO, "selectStance/scroll/item")
	self._btnSelectStanceID = gohelper.findChildButton(self.viewGO, "scene/Grid/btnSelectStanceID")
end

function SkillEditorStanceSelectView:addEvents()
	SLFramework.UGUI.UIClickListener.Get(self._actionViewGO):AddClickListener(self._hideThis, self)
	self.addClickCb(self, self._btnSelectStanceID, self._showThis, self)
	self.addEventCb(self, SkillEditorMgr.instance, SkillEditorMgr.OnSelectStance, self._onSelectStance, self)
end

function SkillEditorStanceSelectView:removeEvents()
	SLFramework.UGUI.UIClickListener.Get(self._actionViewGO):RemoveClickListener()
	self:removeClickCb(self._btnSelectStanceID)
	self.removeEventCb(self, SkillEditorMgr.instance, SkillEditorMgr.OnSelectStance, self._onSelectStance, self)
end

function SkillEditorStanceSelectView:onOpen()
	self.data_list = self.data_list or lua_stance.configList

	gohelper.CreateObjList(self, self.OnItemShow, self.data_list, self._itemGOParent, self._itemGOPrefab)
end

function SkillEditorStanceSelectView:_hideThis()
	gohelper.setActive(self._actionViewGO, false)
end

function SkillEditorStanceSelectView:_showThis()
	gohelper.setActive(self._actionViewGO, true)
end

function SkillEditorStanceSelectView:OnItemShow(obj, data, index)
	local transform = obj.transform
	local text = transform:Find("Text"):GetComponent(gohelper.Type_TextMesh)

	text.text = data.dec_stance

	self.addClickCb(self, obj:GetComponent(typeof(SLFramework.UGUI.ButtonWrap)), self.OnItemClick, self, data)
end

function SkillEditorStanceSelectView:OnItemClick(config)
	self.cur_select = SkillEditorMgr.instance.cur_select_side == FightEnum.EntitySide.EnemySide and "enemy_" or ""
	SkillEditorMgr.instance[self.cur_select .. "stance_id"] = config.id

	local side = SkillEditorMgr.instance.cur_select_side
	local member_num = 0

	for i = 1, 5 do
		if #config["pos" .. i] ~= 0 then
			member_num = member_num + 1
		end
	end

	local _, info = SkillEditorMgr.instance:getTypeInfo(side)

	while member_num < #info.ids do
		local index = #info.ids

		if SkillEditorMgr.instance.cur_select_entity_id == info.ids[index] then
			SkillEditorMgr.instance.cur_select_entity_id = info.ids[index - 1]
		end

		table.remove(info.ids, index)
		table.remove(info.skinIds, index)
	end

	SkillEditorMgr.instance[self.cur_select .. "stance_count_limit"] = member_num

	SkillEditorMgr.instance:refreshInfo(side)
	SkillEditorMgr.instance:rebuildEntitys(side)
end

function SkillEditorStanceSelectView:_onSelectStance(side, stanceId, needRebuild)
	local config = lua_stance.configDict[stanceId]

	if not config then
		logError("站位不存在: " .. stanceId)

		return
	end

	self.cur_select = side == FightEnum.EntitySide.EnemySide and "enemy_" or ""
	SkillEditorMgr.instance[self.cur_select .. "stance_id"] = config.id

	local member_num = 0

	for i = 1, 5 do
		if #config["pos" .. i] ~= 0 then
			member_num = member_num + 1
		end
	end

	local _, info = SkillEditorMgr.instance:getTypeInfo(side)

	while member_num < #info.ids do
		local index = #info.ids

		if SkillEditorMgr.instance.cur_select_entity_id == info.ids[index] then
			SkillEditorMgr.instance.cur_select_entity_id = info.ids[index - 1]
		end

		table.remove(info.ids, index)
		table.remove(info.skinIds, index)
	end

	SkillEditorMgr.instance[self.cur_select .. "stance_count_limit"] = member_num

	SkillEditorMgr.instance:refreshInfo(side)

	if needRebuild then
		SkillEditorMgr.instance:rebuildEntitys(side)
	end
end

return SkillEditorStanceSelectView
