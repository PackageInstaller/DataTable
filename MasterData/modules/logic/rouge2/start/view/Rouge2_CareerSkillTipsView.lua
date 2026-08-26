-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerSkillTipsView.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerSkillTipsView", package.seeall)

local Rouge2_CareerSkillTipsView = class("Rouge2_CareerSkillTipsView", BaseView)
local IncludeTypeList1 = {
	Rouge2_Enum.RelicsDescType.NarrativeDesc
}
local IncludeTypeList2 = {
	Rouge2_Enum.RelicsDescType.Desc
}

function Rouge2_CareerSkillTipsView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._simageSkillIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Root/Title/#image_SkillIcon")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_Root/Title/#image_Icon")
	self._txtSkillName = gohelper.findChildText(self.viewGO, "#go_Root/Title/#txt_SkillName")
	self._goCapacity = gohelper.findChild(self.viewGO, "#go_Root/Title/#go_Capacity")
	self._goAssemblyList = gohelper.findChild(self.viewGO, "#go_Root/Title/#go_Capacity/#go_AssemblyList")
	self._goAssemblyItem = gohelper.findChild(self.viewGO, "#go_Root/Title/#go_Capacity/#go_AssemblyList/#go_AssemblyItem")
	self._scrolloverview = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#scroll_overview")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#txt_Descr")
	self._goCareer = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_Career")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_Career/Name/image_NameBG/#txt_Name")
	self._txtCareerDescr = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_Career/#txt_CareerDescr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerSkillTipsView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_CareerSkillTipsView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_CareerSkillTipsView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_CareerSkillTipsView:_editableInitView()
	return
end

function Rouge2_CareerSkillTipsView:onUpdateParam()
	self:refreshParams()
	self:refreshUI()
	self:updatePosition()
	self:usage2RefreshUI()
end

function Rouge2_CareerSkillTipsView:onOpen()
	self:refreshParams()
	self:refreshUI()
	self:updatePosition()
	self:usage2RefreshUI()
end

function Rouge2_CareerSkillTipsView:refreshParams()
	self._dataType = self.viewParam and self.viewParam.dataType
	self._dataId = self.viewParam and self.viewParam.dataId
	self._skillCo, self._skillMo = Rouge2_BackpackHelper.getItemCofigAndMo(self._dataType, self._dataId)
	self._skillUid = self._skillMo and self._skillMo:getUid()
	self._skillId = self._skillCo and self._skillCo.id
	self._tipPos = self.viewParam and self.viewParam.tipPos
	self._attributeId = self._skillCo and self._skillCo.attributeTag
	self._usage = self.viewParam and self.viewParam.usage
	self._usage = self._usage or Rouge2_Enum.SkillTipsUsage.Default
end

function Rouge2_CareerSkillTipsView:refreshUI()
	self._txtSkillName.text = self._skillCo and self._skillCo.name
	self._txtDescr.text = self._skillCo and self._skillCo.desc
	self._txtName.text = self._skillCo and self._skillCo.keyWord

	Rouge2_ItemDescHelper.setItemDescStr(self._dataType, self._dataId, self._txtDescr, Rouge2_Enum.ItemDescMode.Full, IncludeTypeList1)
	Rouge2_ItemDescHelper.setItemDescStr(self._dataType, self._dataId, self._txtCareerDescr, Rouge2_Enum.ItemDescMode.Full, IncludeTypeList2)

	if self._skillCo then
		if not self._skillCo.assembleCost then
			local assemblyNum = 0

			gohelper.setActive(self._goCapacity, assemblyNum > 0)
			gohelper.CreateNumObjList(self._goAssemblyList, self._goAssemblyItem, assemblyNum)
			Rouge2_IconHelper.setActiveSkillIcon(self._skillId, self._simageSkillIcon)
			Rouge2_IconHelper.setAttributeIcon(self._attributeId, self._imageIcon)
		end
	end
end

function Rouge2_CareerSkillTipsView:updatePosition()
	if self._tipPos then
		if not self._tipPos.x then
			local posX = 0

			if self._tipPos then
				if not self._tipPos.y then
					local posY = 0

					recthelper.setAnchor(self._goRoot.transform, posX, posY)
				end
			end
		end
	end
end

function Rouge2_CareerSkillTipsView:usage2RefreshUI()
	local usageFunc = self:_getUsageRefreshUIFunc(self._usage)

	if usageFunc then
		usageFunc(self)
	end
end

function Rouge2_CareerSkillTipsView:_getUsageRefreshUIFunc(usage)
	if not self._usageRefreshFuncTab then
		self._usageRefreshFuncTab = {}
		self._usageRefreshFuncTab[Rouge2_Enum.SkillTipsUsage.Default] = self._refreshUI_Default
	end

	if self._usageRefreshFuncTab then
		local func = self._usageRefreshFuncTab[usage]

		if not func then
			logError(string.format("Rouge2_CareerSkillTipsView:_getUsageRefreshUIFunc error ! usage = %s", usage))
		end

		return func
	end
end

function Rouge2_CareerSkillTipsView:_refreshUI_Default()
	gohelper.setActive(self._btnClose.gameObject, true)
end

function Rouge2_CareerSkillTipsView:onClose()
	return
end

function Rouge2_CareerSkillTipsView:onDestroyView()
	self._simageSkillIcon:UnLoadImage()
end

return Rouge2_CareerSkillTipsView
