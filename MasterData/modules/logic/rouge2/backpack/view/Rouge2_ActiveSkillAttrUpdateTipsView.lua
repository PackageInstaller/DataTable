-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_ActiveSkillAttrUpdateTipsView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_ActiveSkillAttrUpdateTipsView", package.seeall)

local Rouge2_ActiveSkillAttrUpdateTipsView = class("Rouge2_ActiveSkillAttrUpdateTipsView", BaseViewExtended)

function Rouge2_ActiveSkillAttrUpdateTipsView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")
	self._goLayout = gohelper.findChild(self.viewGO, "#go_Root/#go_Layout")
	self._goSkill = gohelper.findChild(self.viewGO, "#go_Root/#go_Layout/#go_Skill")
	self._goSkillRoot = gohelper.findChild(self.viewGO, "#go_Root/#go_Layout/#go_Skill/#go_SkillRoot")
	self._goAttrUpdateList = gohelper.findChild(self.viewGO, "#go_Root/#go_Layout/#go_AttrUpdateList")
	self._goAttrUpdateItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Layout/#go_AttrUpdateList/#go_AttrUpdateItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ActiveSkillAttrUpdateTipsView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_ActiveSkillAttrUpdateTipsView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_ActiveSkillAttrUpdateTipsView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_ActiveSkillAttrUpdateTipsView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function Rouge2_ActiveSkillAttrUpdateTipsView:onOpen()
	self._dataType = self.viewParam and self.viewParam.dataType
	self._dataId = self.viewParam and self.viewParam.dataId
	self._skillCo, self._skillMo = Rouge2_BackpackHelper.getItemCofigAndMo(self._dataType, self._dataId)
	self._skillId = self._skillCo and self._skillCo.id
	self._careerId = Rouge2_Model.instance:getCareerId()

	self:refreshSkillItem()
	self:refreshUpdateAttrList()
end

function Rouge2_ActiveSkillAttrUpdateTipsView:refreshSkillItem()
	if not self._skillItem then
		local goSkillItem = self:getResInst(Rouge2_Enum.ResPath.CommonSkillItem, self._goSkillRoot, "go_SkillItem")

		self._skillItem = Rouge2_CommonSkillItem.Get(goSkillItem)

		self._skillItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.SkillAttrUpdate)
	end

	self._skillItem:onUpdateMO(1, Rouge2_MapEnum.ItemDropViewEnum.Tips, self._dataType, self._dataId)
end

function Rouge2_ActiveSkillAttrUpdateTipsView:refreshUpdateAttrList()
	local updateAttrList = Rouge2_CollectionConfig.instance:getMaxSkillUpdateAttrList(self._skillId) or {}

	gohelper.CreateObjList(self, self._refreshUpdateAttrItem, updateAttrList, self._goAttrUpdateList, self._goAttrUpdateItem)
end

function Rouge2_ActiveSkillAttrUpdateTipsView:_refreshUpdateAttrItem(goItem, attrInfo, index)
	local goRoot = gohelper.findChild(goItem, "go_Root")
	local attrId = attrInfo[1]
	local attrValue = Rouge2_Model.instance:getAttrValue(attrId)
	local params = {
		ignorePos = true,
		careerId = self._careerId,
		attributeId = attrId,
		attributeValue = attrValue
	}

	self:openExclusiveView(index, 1, Rouge2_CareerAttributeTipsView, Rouge2_Enum.ResPath.CareerAttributeTips, goRoot, params)
end

return Rouge2_ActiveSkillAttrUpdateTipsView
