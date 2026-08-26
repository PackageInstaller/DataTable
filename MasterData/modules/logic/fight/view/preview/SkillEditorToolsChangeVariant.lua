-- chunkname: @modules/logic/fight/view/preview/SkillEditorToolsChangeVariant.lua

module("modules.logic.fight.view.preview.SkillEditorToolsChangeVariant", package.seeall)

local SkillEditorToolsChangeVariant = class("SkillEditorToolsChangeVariant", BaseViewExtended)

function SkillEditorToolsChangeVariant:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkillEditorToolsChangeVariant:addEvents()
	return
end

function SkillEditorToolsChangeVariant:removeEvents()
	return
end

function SkillEditorToolsChangeVariant:_editableInitView()
	return
end

function SkillEditorToolsChangeVariant:onRefreshViewParam()
	return
end

function SkillEditorToolsChangeVariant:_onBtnClick()
	self:getParentView():hideToolsBtnList()
	gohelper.setActive(self._btn, true)
end

function SkillEditorToolsChangeVariant:onOpen()
	self:getParentView():addToolBtn("换变体", self._onBtnClick, self)

	self._btn = self:getParentView():addToolViewObj("换变体")
	self._item = gohelper.findChild(self._btn, "variant")

	self:_showData()
end

function SkillEditorToolsChangeVariant:_showData()
	local list = {}

	for k, v in pairs(FightVariantHeartComp.VariantKey) do
		table.insert(list, k)
	end

	table.insert(list, 1, -1)
	self:com_createObjList(self._onItemShow, list, self._btn, self._item)
end

function SkillEditorToolsChangeVariant:_onItemShow(obj, data, index)
	local text = gohelper.findChildText(obj, "Text")

	text.text = data

	if data == -1 then
		text.text = "还原"
	end

	local click = gohelper.getClick(obj)

	self.addClickCb(self, click, self._onItemClick, self, data)
end

function SkillEditorToolsChangeVariant:_onItemClick(data)
	local tar_entity
	local entityMgr = FightGameMgr.entityMgr

	tar_entity = SkillEditorMgr.instance.cur_select_entity_id and entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id) or entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])

	if tar_entity.variantHeart then
		for k, v in pairs(FightVariantHeartComp.VariantKey) do
			if data ~= k then
				local mat = tar_entity.spineRenderer:getReplaceMat()

				if not mat then
					return
				end

				mat:DisableKeyword(v)
			end
		end

		if data == -1 then
			return
		end

		tar_entity.variantHeart:_changeVariant(data)
	end
end

function SkillEditorToolsChangeVariant:onClose()
	return
end

function SkillEditorToolsChangeVariant:onDestroyView()
	return
end

return SkillEditorToolsChangeVariant
