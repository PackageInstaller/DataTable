-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookTabItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookTabItem", package.seeall)

local Rouge2_CareerHandBookTabItem = class("Rouge2_CareerHandBookTabItem", ListScrollCellExtend)

function Rouge2_CareerHandBookTabItem:onInitView()
	self._txtUnSelectLevel = gohelper.findChildText(self.viewGO, "#txt_UnSelectLevel")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._txtSelectLevel = gohelper.findChildText(self.viewGO, "#go_Selected/#txt_SelectLevel")
	self._txtStageName = gohelper.findChildText(self.viewGO, "#txt_StageName")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerHandBookTabItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_CareerHandBookTabItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function Rouge2_CareerHandBookTabItem:_btnClickOnClick()
	if self.isSelect then
		return
	end

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnSelectHandBookCareer, self._mo)
end

function Rouge2_CareerHandBookTabItem:onLevelUpAnimStart(param)
	if param.careerId ~= self._mo.careerId then
		return
	end

	gohelper.setActive(self._goLevelRefresh, true)

	self._txtSelectLevel.text = tostring(param.previousLevel)
	self._txtUnSelectLevel.text = tostring(param.previousLevel)
end

function Rouge2_CareerHandBookTabItem:onLevelUpAnimFinish(careerId)
	if careerId ~= self._mo.careerId then
		return
	end

	gohelper.setActive(self._goLevelRefresh, false)

	local config = self._config
	local level = Rouge2_TalentModel.instance:getCareerLevel(config.id)

	self._txtSelectLevel.text = tostring(level)
	self._txtUnSelectLevel.text = tostring(level)
end

function Rouge2_CareerHandBookTabItem:_editableInitView()
	self._goLevelRefresh = gohelper.findChild(self.viewGO, "#go_Selected/#level_refresh")

	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnLevelUpAnimStart, self.onLevelUpAnimStart, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnLevelUpAnimFinish, self.onLevelUpAnimFinish, self)

	self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_Selected/#image_Icon")
end

function Rouge2_CareerHandBookTabItem:_editableAddEvents()
	return
end

function Rouge2_CareerHandBookTabItem:_editableRemoveEvents()
	return
end

function Rouge2_CareerHandBookTabItem:onUpdateMO(mo)
	self._mo = mo
	self._id = mo.id
	self._config = mo.config

	self:refreshUI()
end

function Rouge2_CareerHandBookTabItem:refreshUI()
	local config = self._config
	local level = Rouge2_TalentModel.instance:getCareerLevel(config.id)

	self._txtSelectLevel.text = tostring(level)
	self._txtUnSelectLevel.text = tostring(level)
	self._txtStageName.text = config.name

	Rouge2_IconHelper.setCareerIcon(config.id, self._imageIcon)
	self:onSelect(false)
end

function Rouge2_CareerHandBookTabItem:onSelect(isSelect)
	self.isSelect = isSelect

	gohelper.setActive(self._goSelected, isSelect)
end

function Rouge2_CareerHandBookTabItem:onDestroyView()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnLevelUpAnimStart, self.onLevelUpAnimStart, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnLevelUpAnimFinish, self.onLevelUpAnimFinish, self)
end

return Rouge2_CareerHandBookTabItem
