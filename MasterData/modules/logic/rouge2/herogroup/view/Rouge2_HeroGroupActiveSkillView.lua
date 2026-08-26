-- chunkname: @modules/logic/rouge2/herogroup/view/Rouge2_HeroGroupActiveSkillView.lua

module("modules.logic.rouge2.herogroup.view.Rouge2_HeroGroupActiveSkillView", package.seeall)

local Rouge2_HeroGroupActiveSkillView = class("Rouge2_HeroGroupActiveSkillView", BaseView)

function Rouge2_HeroGroupActiveSkillView:onInitView()
	self._goActiveSkillList = gohelper.findChild(self.viewGO, "#go_container/#go_ActiveSkill/#go_ActiveSkillList")
	self._goActiveSkillItem = gohelper.findChild(self.viewGO, "#go_container/#go_ActiveSkill/#go_ActiveSkillList/#go_ActiveSkillItem")
	self._goBackpack = gohelper.findChild(self.viewGO, "#go_container/#go_ActiveSkill/#go_Backpack")
	self._goBackpackPos = gohelper.findChild(self.viewGO, "#go_container/#go_ActiveSkill/#go_Backpack/#go_BackpackPos")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_HeroGroupActiveSkillView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateActiveSkillInfo, self._onUpdateActiveSkillInfo, self)
end

function Rouge2_HeroGroupActiveSkillView:removeEvents()
	return
end

function Rouge2_HeroGroupActiveSkillView:_editableInitView()
	Rouge2_AttributeToolBar.Load(self._goBackpackPos, Rouge2_Enum.AttributeToolType.Enter)

	self._skillClickTab = self:getUserDataTb_()
	self._simageIconTab = self:getUserDataTb_()
end

function Rouge2_HeroGroupActiveSkillView:onOpen()
	self:refreshSkillList()
end

function Rouge2_HeroGroupActiveSkillView:refreshSkillList()
	self._skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	gohelper.CreateNumObjList(self._goActiveSkillList, self._goActiveSkillItem, Rouge2_Enum.MaxActiveSkillNum, self._refreshSingleActiveSkill, self)
end

function Rouge2_HeroGroupActiveSkillView:_refreshSingleActiveSkill(obj, index)
	local goUse = gohelper.findChild(obj, "go_Use")
	local goEmpty = gohelper.findChild(obj, "go_Empty")
	local goSelected = gohelper.findChild(obj, "go_Selected")
	local simageIcon = gohelper.findChildSingleImage(obj, "go_Use/image_SkillIcon")

	self._simageIconTab[index] = simageIcon

	local btnClick = gohelper.findChildButtonWithAudio(obj, "btn_Click")

	btnClick:RemoveClickListener()
	btnClick:AddClickListener(self._onClickSkill, self, index)

	self._skillClickTab[index] = btnClick

	if self._skillList then
		local skillMo = self._skillList[index]
		local isInUse = skillMo ~= nil

		gohelper.setActive(goUse, isInUse)
		gohelper.setActive(goEmpty, not isInUse)
		gohelper.setActive(goSelected, self._selectSkillIndex == index)

		if not isInUse then
			return
		end

		local skillId = skillMo and skillMo:getItemId()

		Rouge2_IconHelper.setActiveSkillIcon(skillId, simageIcon)
	end
end

function Rouge2_HeroGroupActiveSkillView:_onClickSkill(index)
	if self._skillList then
		local skillMo = self._skillList[index]
		local isUse = skillMo and skillMo ~= nil

		if not isUse then
			GameFacade.showToast(ToastEnum.Rouge2NotUseActiveSkill)

			return
		end

		Rouge2_ViewHelper.openActiveSkillAttrUpdateTipsView(Rouge2_Enum.ItemDataType.Server, skillMo and skillMo:getUid())

		self._selectSkillIndex = index

		self:refreshSkillList()
	end
end

function Rouge2_HeroGroupActiveSkillView:_onUpdateActiveSkillInfo()
	self:refreshSkillList()
end

function Rouge2_HeroGroupActiveSkillView:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_CareerSkillTipsView then
		return
	end

	self._selectSkillIndex = -1

	self:refreshSkillList()
end

function Rouge2_HeroGroupActiveSkillView:onDestroyView()
	if self._skillClickTab then
		for _, btnClick in pairs(self._skillClickTab) do
			btnClick:RemoveClickListener()
		end
	end

	if self._simageIconTab then
		for _, simageIcon in pairs(self._simageIconTab) do
			simageIcon:UnLoadImage()
		end
	end
end

return Rouge2_HeroGroupActiveSkillView
