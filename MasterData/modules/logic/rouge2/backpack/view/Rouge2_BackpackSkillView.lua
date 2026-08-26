-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillView", package.seeall)

local Rouge2_BackpackSkillView = class("Rouge2_BackpackSkillView", BaseViewExtended)

function Rouge2_BackpackSkillView:onInitView()
	self._goTab = gohelper.findChild(self.viewGO, "#go_Tab")
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_Prop/#go_Empty")
	self._scrollSkill = gohelper.findChildScrollRect(self.viewGO, "#go_Prop/#scroll_Skill")
	self._goSkillItem = gohelper.findChild(self.viewGO, "#go_Prop/#scroll_Skill/Viewport/Content/#go_SkillItem")
	self._goSkillContent = gohelper.findChild(self.viewGO, "#go_Prop/#scroll_Skill/Viewport/Content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackSkillView:addEvents()
	self._scrollSkill:AddOnValueChanged(self._scrollSkillChanged, self)
end

function Rouge2_BackpackSkillView:removeEvents()
	self._scrollSkill:RemoveOnValueChanged()
end

function Rouge2_BackpackSkillView:_scrollSkillChanged()
	if self.isClose then
		return
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnScrollSkillBag)
end

function Rouge2_BackpackSkillView:_editableInitView()
	self._goScroll = self._scrollSkill.gameObject

	gohelper.setActive(self._goSkillItem, false)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	Rouge2_BackpackSkillListModel.instance:initList()
	self:initScrollView()
end

function Rouge2_BackpackSkillView:onOpen()
	self.isClose = false

	self:refreshUI()
	self._animator:Play("open", 0, 0)
end

function Rouge2_BackpackSkillView:refreshUI()
	Rouge2_BackpackSkillListModel.instance:initList()
	gohelper.setActive(self._goEmpty, Rouge2_BackpackSkillListModel.instance:getCount() <= 0)
end

function Rouge2_BackpackSkillView:initScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_Prop/#scroll_Skill"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_Prop/#scroll_Skill/Viewport/Content/#go_SkillItem"
	scrollParam.cellClass = Rouge2_BackpackSkillListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 520
	scrollParam.cellHeight = 780
	scrollParam.cellSpaceV = 0

	local scrollView = LuaListScrollView.New(Rouge2_BackpackSkillListModel.instance, scrollParam)

	self:addChildView(scrollView)

	self._scrollSkill.verticalNormalizedPosition = 1
end

function Rouge2_BackpackSkillView:onClose()
	self.isClose = true
end

function Rouge2_BackpackSkillView:onDestroyView()
	return
end

return Rouge2_BackpackSkillView
