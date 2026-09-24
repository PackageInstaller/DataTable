-- chunkname: @modules/logic/college/view/role/CollegeRoleDispatchView.lua

module("modules.logic.college.view.role.CollegeRoleDispatchView", package.seeall)

local CollegeRoleDispatchView = class("CollegeRoleDispatchView", CollegeRoleBaseView)

function CollegeRoleDispatchView:onInitView()
	CollegeRoleDispatchView.super.onInitView(self)

	self._goBatchType = gohelper.findChild(self.viewGO, "Right/Buttons/#btn_Batch/btn1")
	self._goBatchType2 = gohelper.findChild(self.viewGO, "Right/Buttons/#btn_Batch/btn2")
	self._txtDispatchNum = gohelper.findChildText(self.viewGO, "Right/#go_vertical/#go_Dispatch/#go_DispatchSelectNum/#txt_tile")

	gohelper.setActive(self._goBagBg, false)
	gohelper.setActive(self._goDispatchBg, true)
	gohelper.setActive(self._goDispatch, true)
	recthelper.setHeight(self._goRoleList.transform, 564)
end

function CollegeRoleDispatchView:_btnBatchOnClick()
	self._roleListModel:switchBatch(not self._isBatch)
	self:refreshUI()
end

function CollegeRoleDispatchView:_btnCancelOnClick()
	self:closeThis()
end

function CollegeRoleDispatchView:_btnConfirmOnClick()
	local selectUidList = self._roleListModel:getDispatchUidList()

	CollegeModel.instance:slotOper(self._locationMo, selectUidList, self.closeThis, self)
end

function CollegeRoleDispatchView:refreshBtnVisible()
	local hasRole = self._roleListModel:getCount() > 0

	self._isBatch = self._roleListModel:isInBatch()

	gohelper.setActive(self._goBtnBatch, hasRole)
	gohelper.setActive(self._goBatchType, not self._isBatch)
	gohelper.setActive(self._goBatchType2, self._isBatch)
	gohelper.setActive(self._goBtnConfirm, hasRole)
	gohelper.setActive(self._goBtnCancel, hasRole)

	local selectCount = self._roleListModel:getSelectCount()
	local maxDispatchNum = self._isBatch and self._roleListModel:getMaxDispatchNum() or 1

	self._txtDispatchNum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("college_roledispatchview_tips"), selectCount, maxDispatchNum)
end

function CollegeRoleDispatchView:getPanelClass()
	return CollegeRoleDispatchPanelItem
end

function CollegeRoleDispatchView:initViewParam()
	CollegeRoleDispatchView.super.initViewParam(self)

	self._locationMo = self.viewParam and self.viewParam.locationMo

	if self.viewParam then
		self._slotIndex = self.viewParam.slotIndex or 1
	end
end

function CollegeRoleDispatchView:initData()
	self._roleListModel:initList(self._selectMo, self._slotIndex, self._locationMo)
	self._roleListModel:switchBatch(true)
end

return CollegeRoleDispatchView
