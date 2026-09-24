-- chunkname: @modules/logic/college/view/building/CollegeBottomInfoView.lua

module("modules.logic.college.view.building.CollegeBottomInfoView", package.seeall)

local CollegeBottomInfoView = class("CollegeBottomInfoView", BaseViewExtended)

function CollegeBottomInfoView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#go_TitleArea/#btn_Close")
	self._btnClose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Bottom/#go_TitleArea/#txt_Title")
	self._goStateInfo = gohelper.findChild(self.viewGO, "Bottom/#go_StateInfo")
	self._goBuildInfo = gohelper.findChild(self.viewGO, "Bottom/#go_StateInfo/#go_BuildInfo")
	self._goExploreInfo = gohelper.findChild(self.viewGO, "Bottom/#go_StateInfo/#go_ExploreInfo")
	self._goInfoDispatch = gohelper.findChild(self.viewGO, "Bottom/#go_StateInfo/#go_InfoDispatch")
	self._goInfoBuff = gohelper.findChild(self.viewGO, "Bottom/#go_StateInfo/#go_InfoBuff")
	self._goStateUpgrade = gohelper.findChild(self.viewGO, "Bottom/#go_StateUpgrade")
	self._goRecruit = gohelper.findChild(self.viewGO, "Bottom/#go_Btns/#btn_Recruit")
	self._goRefresh = gohelper.findChild(self.viewGO, "Bottom/#go_Btns/#btn_Refresh")
	self._goGoUpgrade = gohelper.findChild(self.viewGO, "Bottom/#go_Btns/#btn_GoUpgrade")
	self._goGoBuild = gohelper.findChild(self.viewGO, "Bottom/#go_Btns/#btn_GoBuild")
	self._goBuild = gohelper.findChild(self.viewGO, "Bottom/#go_Btns/#btn_Build")
	self._goUpgrade = gohelper.findChild(self.viewGO, "Bottom/#go_Btns/#btn_Upgrade")
	self._goMilestone = gohelper.findChild(self.viewGO, "Bottom/#go_Btns/#btn_Milestone")
	self._goCostRow = gohelper.findChild(self.viewGO, "Bottom/#go_Btns/CostRow")
	self._goCostRowComp = gohelper.findChild(self.viewGO, "Bottom/#go_Btns/CostRow/#go_CostRow")
	self._anim = gohelper.findComponentAnim(self.viewGO)

	self:resetUI()
	self:resetBtns()
end

function CollegeBottomInfoView:addEvents()
	self._btnClose:AddClickListener(self.onCloseClick, self)
	self._btnClose2:AddClickListener(self.onCloseClick, self)
	NavigateMgr.instance:addEscape(self.viewName, self.onEcsClick, self)
end

function CollegeBottomInfoView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function CollegeBottomInfoView:onCloseClick()
	self:closeThis()
	CollegeHelper.instance:cancelFocus()
end

function CollegeBottomInfoView:onEcsClick()
	self:onCloseClick()
end

function CollegeBottomInfoView:resetUI()
	gohelper.setActive(self._goStateInfo, false)
	gohelper.setActive(self._goStateUpgrade, false)
	gohelper.setActive(self._goExploreInfo, false)
end

function CollegeBottomInfoView:resetBtns()
	gohelper.setActive(self._goRecruit, false)
	gohelper.setActive(self._goRefresh, false)
	gohelper.setActive(self._goGoUpgrade, false)
	gohelper.setActive(self._goGoBuild, false)
	gohelper.setActive(self._goBuild, false)
	gohelper.setActive(self._goUpgrade, false)
	gohelper.setActive(self._goMilestone, false)
end

return CollegeBottomInfoView
