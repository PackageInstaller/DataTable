-- chunkname: @modules/logic/college/view/role/CollegeRoleRecruitSuccView.lua

module("modules.logic.college.view.role.CollegeRoleRecruitSuccView", package.seeall)

local CollegeRoleRecruitSuccView = class("CollegeRoleRecruitSuccView", BaseView)

function CollegeRoleRecruitSuccView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "root")
	self._goSuccess = gohelper.findChild(self.viewGO, "#go_Success")
	self._scrollRoleList = gohelper.findChild(self.viewGO, "#go_Success/#scroll_RoleList")
	self._goRoleContent = gohelper.findChild(self.viewGO, "#go_Success/#scroll_RoleList/Viewport/Content")
	self._btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Success/Buttons/#btn_Exit")
	self._btnContinue = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Success/Buttons/#btn_Contiune")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeRoleRecruitSuccView:addEvents()
	self._btnExit:AddClickListener(self._btnExitOnClick, self)
	self._btnContinue:AddClickListener(self._btnContinueOnClick, self)
end

function CollegeRoleRecruitSuccView:removeEvents()
	self._btnExit:RemoveClickListener()
	self._btnContinue:RemoveClickListener()
end

function CollegeRoleRecruitSuccView:_btnExitOnClick()
	self:closeThis()
end

function CollegeRoleRecruitSuccView:_btnContinueOnClick()
	ViewMgr.instance:openView(ViewName.CollegeRoleRecruitView)
	gohelper.setActive(self._goSuccess, true)
	self:playPanelItemAnim("close")
	self._animatorPlayer:Play("again", self._onPlayAgainAnimDone, self)
end

function CollegeRoleRecruitSuccView:_onPlayAgainAnimDone()
	gohelper.setActive(self._goSuccess, false)
end

function CollegeRoleRecruitSuccView:_editableInitView()
	self._goPanelItem = self:getResInst(CollegeEnum.PrefabPath.RolePanel, self._goRoleContent, "#go_PanelItem")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	gohelper.setActive(self._goSuccess, false)

	self._panelItemList = self:getUserDataTb_()
end

function CollegeRoleRecruitSuccView:onUpdateParam()
	self._recruitList = self.viewParam and self.viewParam.newRecruitList

	if self._recruitList then
		local hasRecruit = #self._recruitList > 0

		if not hasRecruit then
			gohelper.setActive(self._goSuccess, false)

			return
		end

		self:refreshUI()
	end
end

function CollegeRoleRecruitSuccView:refreshUI()
	gohelper.CreateObjList(self, self._refreshRecruitItem, self._recruitList, self._goRoleContent, self._goPanelItem, CollegeRoleBasePanelItem)
	self:playPanelItemAnim("has")
end

function CollegeRoleRecruitSuccView:_refreshRecruitItem(recruitItem, actorMo, index)
	recruitItem._view = self
	recruitItem._index = index

	recruitItem:onUpdateMO(actorMo)

	self._panelItemList[index] = recruitItem
end

function CollegeRoleRecruitSuccView:playPanelItemAnim(animName)
	for _, panelItem in ipairs(self._panelItemList) do
		panelItem:playAnim(animName)
	end
end

return CollegeRoleRecruitSuccView
