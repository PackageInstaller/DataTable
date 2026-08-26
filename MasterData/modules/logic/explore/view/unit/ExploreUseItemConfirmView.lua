-- chunkname: @modules/logic/explore/view/unit/ExploreUseItemConfirmView.lua

module("modules.logic.explore.view.unit.ExploreUseItemConfirmView", package.seeall)

local ExploreUseItemConfirmView = class("ExploreUseItemConfirmView")

function ExploreUseItemConfirmView:ctor()
	self._containerGO = gohelper.create2d(GameSceneMgr.instance:getCurScene().view:getRoot(), "ExploreUseItemConfirmView")
	self._uiLoader = PrefabInstantiate.Create(self._containerGO)

	self._uiLoader:startLoad("ui/viewres/explore/exploreconfirmview.prefab", self._onLoaded, self)

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower = gohelper.onceAddComponent(self._containerGO, typeof(ZProj.UIFollower))

	self._uiFollower:Set(mainCamera, uiCamera, plane, self._containerGO.transform, 0, 0, 0, 0, 0)
	self._uiFollower:SetEnable(false)
	gohelper.setActive(self._containerGO, false)
end

function ExploreUseItemConfirmView:setTarget(targetGo, pos)
	self._targetPos = pos

	if targetGo then
		self._uiFollower:SetTarget3d(targetGo.transform)
		self._uiFollower:SetEnable(true)
		gohelper.setActive(self._containerGO, true)
	else
		self._uiFollower:SetEnable(false)
		gohelper.setActive(self._containerGO, false)
	end
end

function ExploreUseItemConfirmView:_onLoaded()
	self.viewGO = self._uiLoader:getInstGO()
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "go_confirm/go_container/btn_confirm")
	self._btncancle = gohelper.findChildButtonWithAudio(self.viewGO, "go_confirm/go_container/btn_cancel")

	self._btnconfirm:AddClickListener(self.onConfirm, self)
	self._btncancle:AddClickListener(self.onCancel, self)
end

function ExploreUseItemConfirmView:onCancel()
	local map = ExploreController.instance:getMap()

	map:getCompByType(ExploreEnum.MapStatus.UseItem):onCancel(self._targetPos)
	self:setTarget()
end

function ExploreUseItemConfirmView:onConfirm()
	local map = ExploreController.instance:getMap()
	local mo = map:getCompByType(ExploreEnum.MapStatus.UseItem):getCurItemMo()
	local pos = self._targetPos
	local hero = map:getHero()

	hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CreateUnit, true, true)
	hero:onCheckDir(hero.nodePos, pos)
	ExploreRpc.instance:sendExploreUseItemRequest(mo.id, pos.x, pos.y)
	map:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function ExploreUseItemConfirmView:dispose()
	if self.viewGO then
		self._btnconfirm:RemoveClickListener()
		self._btncancle:RemoveClickListener()

		self._btnconfirm = nil
		self._btncancle = nil
		self.viewGO = nil
	end

	self._targetPos = nil

	self._uiLoader:dispose()

	self._uiLoader = nil

	gohelper.destroy(self._containerGO)

	self._containerGO = nil
end

return ExploreUseItemConfirmView
