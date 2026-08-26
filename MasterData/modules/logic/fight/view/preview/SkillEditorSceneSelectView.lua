-- chunkname: @modules/logic/fight/view/preview/SkillEditorSceneSelectView.lua

module("modules.logic.fight.view.preview.SkillEditorSceneSelectView", package.seeall)

local SkillEditorSceneSelectView = class("SkillEditorSceneSelectView", BaseView)

function SkillEditorSceneSelectView:ctor()
	return
end

function SkillEditorSceneSelectView:onInitView()
	self._btnSelectScene = SLFramework.UGUI.UIClickListener.GetWithPath(self.viewGO, "scene/Grid/imgScene")
	self._sceneViewGO = gohelper.findChild(self.viewGO, "selectScene")

	gohelper.setActive(self._itemGOPrefab, false)

	self._inp = gohelper.findChildTextMeshInputField(self.viewGO, "selectScene/inp")
	self._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectScene/btnClose")
end

function SkillEditorSceneSelectView:addEvents()
	self._btnSelectScene:AddClickListener(self._showThis, self)
	self._btnClose:AddClickListener(self._hideThis, self)
	self._inp:AddOnValueChanged(self._onInpValueChanged, self)
	SLFramework.UGUI.UIClickListener.Get(self._sceneViewGO):AddClickListener(self._hideThis, self)
end

function SkillEditorSceneSelectView:removeEvents()
	self._btnSelectScene:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._inp:RemoveOnValueChanged()
	SLFramework.UGUI.UIClickListener.Get(self._sceneViewGO):RemoveClickListener()
end

function SkillEditorSceneSelectView:_showThis()
	gohelper.setActive(self._sceneViewGO, true)
	self:_updateItems()
	self:_updateItemSelect()
end

function SkillEditorSceneSelectView:_hideThis()
	gohelper.setActive(self._sceneViewGO, false)
end

function SkillEditorSceneSelectView:_onInpValueChanged(inputStr)
	self:_updateItems()
	self:_updateItemSelect()
end

function SkillEditorSceneSelectView:_updateItems()
	SkillEditorSceneSelectModel.instance:setSelect(self._inp:GetText())
end

function SkillEditorSceneSelectView:_updateItemSelect(curLevelId)
	curLevelId = curLevelId or FightGameMgr.sceneLevelMgr:getCurLevelId()

	local list = SkillEditorSceneSelectModel.instance:getList()

	for i, mo in ipairs(list) do
		if mo.co.id == curLevelId then
			SkillEditorSceneSelectModel.instance:selectCell(i, true)
		end
	end
end

return SkillEditorSceneSelectView
