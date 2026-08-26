-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailSkillView.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailSkillView", package.seeall)

local Rouge2_AttributeDetailSkillView = class("Rouge2_AttributeDetailSkillView", BaseView)

function Rouge2_AttributeDetailSkillView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goSkillContent = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_SkillContent")
	self._goSkillScroll = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillScroll")
	self._goSkillContainer = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillScroll/Viewport/#go_SkillContainer")
	self._goSkillTop = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillScroll/Viewport/#go_SkillContainer/#go_SkillTop")
	self._txtSkillName = gohelper.findChildText(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillScroll/Viewport/#go_SkillContainer/#go_SkillTop/#txt_SkillName")
	self._goSkillAttrTips = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillScroll/Viewport/#go_SkillContainer/#go_SkillTop/#go_SkillAttrTips")
	self._goSkillLevelList = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillScroll/Viewport/#go_SkillContainer/#go_SkillLevelList")
	self._goSkillLevelItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillScroll/Viewport/#go_SkillContainer/#go_SkillLevelList/#go_SkillLevelItem")
	self._goEmptySkill = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillScroll/Viewport/#go_SkillContainer/#go_EmptySkill")
	self._goSkillList = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillBanner/Viewport/#go_SkillList")
	self._goSkillItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillBanner/Viewport/#go_SkillList/#go_SkillItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AttributeDetailSkillView:addEvents()
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectAttrTab, self._onSelectAttrTab, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectSkillAttrUpdate, self._onSelectSkill, self)
end

function Rouge2_AttributeDetailSkillView:removeEvents()
	return
end

function Rouge2_AttributeDetailSkillView:_editableInitView()
	self._teamTipsParam = {
		[Rouge2_Enum.TeamRecommendParam.LayoutType] = UnityEngine.TextAnchor.MiddleLeft
	}
	self._teamTipsLoader = Rouge2_TeamRecommendTipsLoader.Load(self._goSkillAttrTips, Rouge2_Enum.TeamRecommendTipType.MultiItemSystemTag)
end

function Rouge2_AttributeDetailSkillView:onOpen()
	self._careerId = self.viewParam and self.viewParam.careerId

	self:initSkillList()
	self:initSelectIndex()
end

function Rouge2_AttributeDetailSkillView:initSkillList()
	self._skillList = {}

	if self.viewParam then
		if self.viewParam then
			local dataType = self.viewParam.dataType

			if not self.viewParam or #self.viewParam <= 0 then
				local skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

				if skillList then
					for _, skillMo in ipairs(skillList) do
						local mo = {
							dataType = Rouge2_Enum.ItemDataType.Server,
							dataId = skillMo:getUid()
						}

						table.insert(self._skillList, mo)
					end
				end

				table.sort(self._skillList, self._sortSkillList)
			else
				for _, dataId in ipairs(self.viewParam) do
					local mo = {
						dataType = dataType,
						dataId = dataId
					}

					table.insert(self._skillList, mo)
				end
			end

			self._notHasSkill = not self._skillList or #self._skillList <= 0
		end
	end
end

function Rouge2_AttributeDetailSkillView:initSelectIndex()
	self._selectIndex = 1

	if self.viewParam then
		if not self.viewParam or self.viewParam == 0 then
			return
		end

		for i, skillMo in ipairs(self._skillList) do
			if skillMo.dataId == self.viewParam then
				self._selectIndex = i

				break
			end
		end
	end
end

function Rouge2_AttributeDetailSkillView._sortSkillList(aSkillMo, bSkillMo)
	return aSkillMo.dataId < bSkillMo.dataId
end

function Rouge2_AttributeDetailSkillView:refresh(groupType, subId)
	local isSkillInfo = groupType == Rouge2_Enum.AttrDetailTabGroupType.SkillList
	local isSelectSub = subId and subId ~= 0

	gohelper.setActive(self._goSkillContent, isSkillInfo and isSelectSub)

	if not isSkillInfo then
		return
	end

	gohelper.setActive(self._goEmptySkill, self._notHasSkill)
	gohelper.setActive(self._goSkillLevelList, not self._notHasSkill)
	gohelper.setActive(self._goSkillTop, not self._notHasSkill)

	if self._notHasSkill then
		return
	end

	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_AttributeDetailSkillView:refreshInfo()
	self._selectSkill = self._skillList[self._selectIndex]
	self._selectSkillDataType = self._selectSkill and self._selectSkill.dataType
	self._selectSkillDataId = self._selectSkill and self._selectSkill.dataId
	self._selectSkillCo = Rouge2_BackpackHelper.getItemCofigAndMo(self._selectSkillDataType, self._selectSkillDataId)
	self._selectSkillId = self._selectSkillCo and self._selectSkillCo.id
	self._skillType = self._selectSkillCo and self._selectSkillCo.skillTypeName
end

function Rouge2_AttributeDetailSkillView:refreshUI()
	self._txtSkillName.text = self._selectSkillCo and self._selectSkillCo.name
	self._teamTipsParam[Rouge2_Enum.TeamRecommendParam.ItemId] = self._selectSkillId

	self._teamTipsLoader:initInfo(nil, self._teamTipsParam)
	self:refreshSkillList()
	self:refreshSkillLevelList()
end

function Rouge2_AttributeDetailSkillView:refreshSkillList()
	gohelper.CreateObjList(self, self._refreshSkillItem, self._skillList, self._goSkillList, self._goSkillItem, Rouge2_AttributeDetailSkillItem)
end

function Rouge2_AttributeDetailSkillView:_refreshSkillItem(skillItem, skillMo, index)
	skillItem:initParentView(self)
	skillItem:onUpdateMO(index, skillMo.dataType, skillMo.dataId)
	skillItem:onSelect(index == self._selectIndex)
end

function Rouge2_AttributeDetailSkillView:refreshSkillLevelList()
	TaskDispatcher.cancelTask(self.focusCurLevel, self)

	local skillList = Rouge2_CollectionConfig.instance:getSkillListBySkillType(self._skillType)
	local hasSkillList = skillList and #skillList > 0

	gohelper.setActive(self._goSkillLevelList, hasSkillList)

	if not hasSkillList then
		return
	end

	self._goCurLvItem = nil

	gohelper.CreateObjList(self, self._refreshSkillLevelUpItem, skillList, self._goSkillLevelList, self._goSkillLevelItem)
	TaskDispatcher.runDelay(self.focusCurLevel, self, 0.01)
end

function Rouge2_AttributeDetailSkillView:_refreshSkillLevelUpItem(goItem, skillCo, index)
	local imageRare = gohelper.findChildImage(goItem, "banner/go_RareTag/image_Rare")
	local goDefault = gohelper.findChild(goItem, "banner/go_Default")
	local goOther = gohelper.findChild(goItem, "banner/go_Other")
	local txtOtherLv = gohelper.findChildText(goItem, "banner/go_Other/txt_OtherLv")
	local goConditionList = gohelper.findChild(goItem, "banner/go_ConditionList")
	local skillId = skillCo.id

	Rouge2_IconHelper.setGameItemRare(skillId, imageRare, Rouge2_Enum.ItemRareIconType.CircleIcon)
	gohelper.setActive(goDefault, index == 1)
	gohelper.setActive(goOther, index ~= 1)
	gohelper.setActive(goConditionList, index ~= 1)

	if index ~= 1 then
		local romanNum = GameUtil.getRomanNums(index)

		txtOtherLv.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_attributedetailskillview_otherlv"), romanNum)

		local goConditionItem = gohelper.findChild(goItem, "banner/go_ConditionList/go_ConditionItem")
		local updateAttrList = Rouge2_CollectionConfig.instance:getSkillUpdateAttrList(skillId) or {}

		gohelper.CreateObjList(self, self._refreshUpateAttrItem, updateAttrList, goConditionList, goConditionItem)
	end

	local txtDesc = gohelper.findChildText(goItem, "go_Desc/txt_Desc")

	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Config, skillId, txtDesc, nil, nil, Rouge2_AttributeDetailAttrView.PercentColor, Rouge2_AttributeDetailAttrView.BracketColor)

	local isCurLv = skillId == self._selectSkillId
	local goCurLv = gohelper.findChild(goItem, "go_CurLv")

	gohelper.setActive(goCurLv, isCurLv)

	if isCurLv then
		self._goCurLvItem = goItem
	end
end

function Rouge2_AttributeDetailSkillView:focusCurLevel()
	if not self._goCurLvItem then
		return
	end

	local offset = gohelper.fitScrollItemOffset(self._goSkillScroll, self._goSkillContainer, self._goCurLvItem, ScrollEnum.ScrollDirV)

	recthelper.setAnchorY(self._goSkillContainer.transform, offset)
end

function Rouge2_AttributeDetailSkillView:_refreshUpateAttrItem(goItem, conditionInfo, index)
	local imageAttrIcon = gohelper.findChildImage(goItem, "image_AttrIcon")
	local txtPreLv = gohelper.findChildText(goItem, "txt_PreLv")
	local txtNextLv = gohelper.findChildText(goItem, "txt_NextLv")
	local attrId = conditionInfo[1]
	local attrValue = conditionInfo[2]
	local curAttrValue = Rouge2_Model.instance:getAttrValue(attrId) or 0

	txtPreLv.text = curAttrValue
	txtNextLv.text = attrValue

	Rouge2_IconHelper.setAttributeIcon(attrId, imageAttrIcon)
	SLFramework.UGUI.GuiHelper.SetColor(txtPreLv, attrValue <= curAttrValue and "#73BE73" or "#D57E7E")
end

function Rouge2_AttributeDetailSkillView:_onSelectAttrTab(groupType, subId)
	self:refresh(groupType, subId)
end

function Rouge2_AttributeDetailSkillView:_onSelectSkill(index)
	self._selectIndex = index

	self:refreshInfo()
	self:refreshUI()
end

function Rouge2_AttributeDetailSkillView:onClose()
	TaskDispatcher.cancelTask(self.focusCurLevel, self)
end

function Rouge2_AttributeDetailSkillView:onDestroyView()
	return
end

return Rouge2_AttributeDetailSkillView
