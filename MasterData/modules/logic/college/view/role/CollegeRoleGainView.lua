-- chunkname: @modules/logic/college/view/role/CollegeRoleGainView.lua

module("modules.logic.college.view.role.CollegeRoleGainView", package.seeall)

local CollegeRoleGainView = class("CollegeRoleGainView", BaseView)

function CollegeRoleGainView:onInitView()
	self._scrollRoleList = gohelper.findChild(self.viewGO, "root/#scroll_RoleList")
	self._goRoleContent = gohelper.findChild(self.viewGO, "root/#scroll_RoleList/Viewport/Content")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._btnClose2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeRoleGainView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnClose2:AddClickListener(self._btnCloseOnClick, self)
end

function CollegeRoleGainView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function CollegeRoleGainView:_btnCloseOnClick()
	self:closeThis()
end

function CollegeRoleGainView:_editableInitView()
	self._goPanelItem = self:getResInst(CollegeEnum.PrefabPath.RolePanel, self._goRoleContent, "#go_PanelItem")

	NavigateMgr.instance:addEscape(self.viewName, self._btnExitOnClick, self)
end

function CollegeRoleGainView:onOpen()
	self._recruitList = self.viewParam and self.viewParam.newRecruitList
	self._recruitList = self._recruitList or {}

	self:refreshUI()
end

function CollegeRoleGainView:refreshUI()
	gohelper.CreateObjList(self, self._refreshRecruitItem, self._recruitList, self._goRoleContent, self._goPanelItem, CollegeRoleBasePanelItem)
end

function CollegeRoleGainView:_refreshRecruitItem(recruitItem, actorMo, index)
	recruitItem._view = self
	recruitItem._index = index

	recruitItem:onUpdateMO(actorMo)
end

return CollegeRoleGainView
