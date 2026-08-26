-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackCareerView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackCareerView", package.seeall)

local Rouge2_BackpackCareerView = class("Rouge2_BackpackCareerView", BaseView)

function Rouge2_BackpackCareerView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageRightPanelBG = gohelper.findChildSingleImage(self.viewGO, "Details/#simage_RightPanelBG")
	self._txtName = gohelper.findChildText(self.viewGO, "Details/#txt_name")
	self._simageCareerIcon = gohelper.findChildSingleImage(self.viewGO, "Details/#simage_CareerIcon")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Details/#txt_Descr")
	self._btnSearch = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Search")
	self._goAttribute = gohelper.findChild(self.viewGO, "#go_Attribute")
	self._goSkillList = gohelper.findChild(self.viewGO, "Skill/SkillList")
	self._goSkillItem = gohelper.findChild(self.viewGO, "Skill/SkillList/#go_SkillItem")
	self._imageSkillIcon = gohelper.findChildImage(self.viewGO, "Skill/SkillList/#go_SkillItem/#image_SkillIcon")
	self._goTeamTips = gohelper.findChild(self.viewGO, "Details/Tag/#go_TeamTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackCareerView:addEvents()
	self._btnSearch:AddClickListener(self._btnSearchOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateActiveSkillInfo, self._onUpdateActiveSkillInfo, self)
end

function Rouge2_BackpackCareerView:removeEvents()
	self._btnSearch:RemoveClickListener()
end

function Rouge2_BackpackCareerView:_btnSearchOnClick()
	local params = {
		selectTabType = Rouge2_Enum.AttrDetailTabGroupType.AttrList
	}

	Rouge2_ViewHelper.openAttributeDetailView(nil, nil, params)
end

function Rouge2_BackpackCareerView:_editableInitView()
	self._skillClickTab = self:getUserDataTb_()
	self._activeSkillIconTab = self:getUserDataTb_()
	self._selectSkillIndex = -1

	local goAttributeMap = self:getResInst(Rouge2_Enum.ResPath.AttributeMap, self._goAttribute)

	self._attributeMap = Rouge2_CareerAttributeMap.Get(goAttributeMap, Rouge2_Enum.AttrMapUsage.BackpackCareerView)

	self._attributeMap:setCareerSelectVisible(true)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	Rouge2_TeamRecommendTipsLoader.LoadWithParams(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.Default_Layout)
end

function Rouge2_BackpackCareerView:onUpdateParam()
	return
end

function Rouge2_BackpackCareerView:onOpen()
	self._animator:Play("open", 0, 0)

	self._careerId = Rouge2_Model.instance:getCareerId()
	self._careerCo = Rouge2_CareerConfig.instance:getCareerConfig(self._careerId)

	self._attributeMap:onUpdateMO(self._careerId, Rouge2_Enum.AttributeData.Server)
	self:refreshUI()
end

function Rouge2_BackpackCareerView:refreshUI()
	self:refreshCareerUI()
	self:refreshSkillList()
end

function Rouge2_BackpackCareerView:refreshCareerUI()
	self._txtDescr.text = self._careerCo and self._careerCo.careerDesc

	Rouge2_IconHelper.setCareerName(self._careerId, self._txtName, true)
	Rouge2_IconHelper.setCareerIcon(self._careerId, self._simageCareerIcon, Rouge2_Enum.CareerIconSuffix.Bag)
end

function Rouge2_BackpackCareerView:refreshSkillList()
	self._skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	gohelper.CreateNumObjList(self._goSkillList, self._goSkillItem, Rouge2_Enum.MaxActiveSkillNum, self._refreshActiveSkill, self)
end

function Rouge2_BackpackCareerView:_refreshActiveSkill(obj, index)
	local goUse = gohelper.findChild(obj, "go_Use")
	local goUnuse = gohelper.findChild(obj, "go_Unuse")
	local goSelected = gohelper.findChild(obj, "go_Selected")
	local simageIcon = gohelper.findChildSingleImage(obj, "go_Use/image_SkillIcon")

	if self._skillList then
		local skillMo = self._skillList[index]
		local isUse = skillMo ~= nil

		gohelper.setActive(goUse, isUse)
		gohelper.setActive(goUnuse, not isUse)
		gohelper.setActive(goSelected, self._selectSkillIndex == index)

		local btnClick = gohelper.findChildButtonWithAudio(obj, "btn_Click")

		btnClick:RemoveClickListener()
		btnClick:AddClickListener(self._onClickActiveSkill, self, index)

		self._skillClickTab[index] = btnClick
		self._activeSkillIconTab[index] = simageIcon

		if not isUse then
			return
		end

		Rouge2_IconHelper.setActiveSkillIcon(skillMo:getItemId(), simageIcon)
	end
end

function Rouge2_BackpackCareerView:_onClickActiveSkill(index)
	if self._skillList then
		local skillMo = self._skillList[index]
		local isUse = skillMo ~= nil

		if not isUse then
			GameFacade.showToast(ToastEnum.Rouge2NotUseActiveSkill)

			return
		end

		Rouge2_ViewHelper.openActiveSkillAttrUpdateTipsView(Rouge2_Enum.ItemDataType.Server, skillMo and skillMo:getUid())

		self._selectSkillIndex = index

		self:refreshSkillList()
	end
end

function Rouge2_BackpackCareerView:_skillTipsViewClickCallback(skillTipsView, clickPosition)
	for index, btnClick in pairs(self._skillClickTab) do
		local isInRect = recthelper.screenPosInRect(btnClick.transform, nil, clickPosition.x, clickPosition.y)

		if isInRect then
			self:_onClickActiveSkill(index)

			return
		end
	end

	skillTipsView:closeThis()
end

function Rouge2_BackpackCareerView:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_CareerSkillTipsView then
		return
	end

	self._selectSkillIndex = -1

	self:refreshSkillList()
end

function Rouge2_BackpackCareerView:_onUpdateActiveSkillInfo()
	self:refreshSkillList()
end

function Rouge2_BackpackCareerView:realseAllActiveSkill()
	if self._skillClickTab then
		for _, btnClick in pairs(self._skillClickTab) do
			btnClick:RemoveClickListener()
		end
	end

	if self._activeSkillIconTab then
		for _, simageIcon in pairs(self._activeSkillIconTab) do
			simageIcon:UnLoadImage()
		end
	end
end

function Rouge2_BackpackCareerView:onClose()
	return
end

function Rouge2_BackpackCareerView:onDestroyView()
	self._simageCareerIcon:UnLoadImage()
	self:realseAllActiveSkill()
end

return Rouge2_BackpackCareerView
