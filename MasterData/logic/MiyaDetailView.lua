-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaDetailView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaDetailView", package.seeall)

local MiyaDetailView = class("MiyaDetailView", ViewComponent)

function MiyaDetailView:unbindEvents()
	MiyaDetailView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function MiyaDetailView:bindEvents()
	MiyaDetailView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function MiyaDetailView:onExit()
	MiyaDetailView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	GlobalDispatcher:removeListener(GlobalNotify.MiyaReOpenDetailView, self._openSubView, self)
end

function MiyaDetailView:buildUI()
	MiyaDetailView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._con = self:getGo("con")
	self._goldBarCon = self:getGo("goldBarCon")
	self._container = self:getGo("container")
	self._btnTip = self:getBtn("btnTip")
	self._txtTitle = self:getTxt("txtTitle")
end

function MiyaDetailView:_updateGoldBar()
	local btn_list = {
		{
			id = "4:86",
			showAdd = false
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
end

function MiyaDetailView:_updateRole()
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, 10147, self._con)
end

function MiyaDetailView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "miyadetail")
end

function MiyaDetailView:onEnter()
	MiyaDetailView.super.onEnter(self)
	self:_updateGoldBar()
	self:_updateRole()
	GlobalDispatcher:addListener(GlobalNotify.MiyaReOpenDetailView, self._openSubView, self)
	self:_openSubView()
end

function MiyaDetailView:_openSubView()
	local curModeId = MiyaGameModel.instance:getCurModeId()
	local viewName

	if curModeId > 0 then
		self._txtTitle.text = "造化对弈"
		viewName = ViewName.MiyaPlayChessView
	else
		self._txtTitle.text = "选择难度"
		viewName = ViewName.MiyaChooseDifficultyView
	end

	ViewMgr.instance:openAt(self._container, viewName, self._viewPresentor)
end

return MiyaDetailView
