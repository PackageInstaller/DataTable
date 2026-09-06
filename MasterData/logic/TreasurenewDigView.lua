-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasurenew/view/TreasurenewDigView.lua

module("logic.extensions.treasurenew.view.TreasurenewDigView", package.seeall)

local TreasurenewDigView = class("TreasurenewDigView", ViewComponent)

function TreasurenewDigView:ctor()
	TreasurenewDigView.super.ctor(self)
end

function TreasurenewDigView:buildUI()
	TreasurenewDigView.super.buildUI(self)

	self._goDig = self:getGo("Dig")
	self._btnDig = self:getBtn("Dig/btnDig")
	self._goCancel = self:getGo("btnCancel")
	self._btnCancel = self:getBtn("btnCancel")
	self._goProgress = self:getGo("sldProgress")
	self._sldProgress = self:getSlider("sldProgress")
end

function TreasurenewDigView:bindEvents()
	TreasurenewDigView.super.bindEvents(self)
	self._btnDig:AddClickListener(self._onClickBtnDig, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
end

function TreasurenewDigView:unbindEvents()
	TreasurenewDigView.super.unbindEvents(self)
	self._btnDig:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function TreasurenewDigView:destroyUI()
	TreasurenewDigView.super.destroyUI(self)
	self:_releaseRes()
end

function TreasurenewDigView:onEnter()
	TreasurenewDigView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LeaveCityDone, self.close, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onOpenView, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureAutoStop, self._onClickCancel, self)
	GlobalDispatcher:addListener(GlobalNotify.TreasureAutoNext, self._onClickBtnDig, self)
	self:_preLoadRes()
	goutil.setActive(self._goDig, false)
	goutil.setActive(self._goCancel, false)
	goutil.setActive(self._goProgress, false)

	self._isShowBtn = self:getFirstParam()

	if self._isShowBtn then
		goutil.setActive(self.mainGO, true)
		goutil.setActive(self._goDig, true)
	end
end

function TreasurenewDigView:onEnterFinished()
	TreasurenewDigView.super.onEnterFinished(self)
end

function TreasurenewDigView:onExit()
	self:_releaseRes()
	TreasurenewDigView.super.onExit(self)
	removetimer(self._updateTime, self)
	removetimer(self._startDig, self)
	self:_resetMainPlayer()
	GlobalDispatcher:removeListener(GlobalNotify.LeaveCityDone, self.close, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self._onOpenView, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureAutoStop, self._onClickCancel, self)
	GlobalDispatcher:removeListener(GlobalNotify.TreasureAutoNext, self._onClickBtnDig, self)
end

function TreasurenewDigView:onExitFinished()
	TreasurenewDigView.super.onExitFinished(self)
end

function TreasurenewDigView:_onOpenView(view)
	if view.viewName ~= self._viewPresentor.viewName then
		self:close()
	end
end

function TreasurenewDigView:_onClickBtnDig()
	self:_resetMainPlayer()
	goutil.setActive(self._goCancel, true)
	goutil.setActive(self._goDig, false)

	local targetcfg = TreasureNewModel.instance:getTargetCfg()

	if targetcfg then
		print("开始挖宝：" .. targetcfg.sceneId .. "_" .. targetcfg.x .. "_" .. targetcfg.y)

		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		mainPlayer:gotoScenePosition(targetcfg.sceneId, targetcfg.x, targetcfg.y, function()
			self:_finishDig()
		end)
	end
end

function TreasurenewDigView:_finishDig()
	print("结束挖宝动作")
	goutil.setActive(self._goDig, true)
	goutil.setActive(self._goCancel, true)
	goutil.setActive(self._goProgress, true)
	removetimer(self._startDig, self)
	settimer(0.01, self._startDig, self, false)
end

function TreasurenewDigView:_onClickCancel()
	removetimer(self._updateTime, self)
	self:_resetMainPlayer()
	goutil.setActive(self._goProgress, false)
	goutil.setActive(self._goCancel, false)
	goutil.setActive(self._goDig, true)
end

function TreasurenewDigView:_startDig()
	removetimer(self._updateTime, self)

	self._aniTimer = 0
	self._stepTime = 0.1
	self._totalTimer = 50
	self._stepValue = 1 / self._totalTimer
	self._sldValue = 0

	self._sldProgress:SetValue(self._sldValue)
	goutil.setActive(self._goProgress, true)
	goutil.setActive(self._goCancel, true)
	goutil.setActive(self._goDig, false)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer.spine ~= nil then
		if self._goGaoTou ~= nil then
			local parent = mainPlayer.spine:getHandPoint(AvatarHangPointType.RHand)

			self._goGaoTou.transform:SetParent(parent)
			GameUtil.setLocalScale(self._goGaoTou, 1, 1, 1)
			GameUtil.setLocalPos(self._goGaoTou, 0, 0, 0)
			Framework.TransformUtil.SetLocalRotation(self._goGaoTou.transform, 90, 0, 0)
			goutil.setActive(self._goGaoTou, true)
		end

		local avatar = mainPlayer.spine._avatar

		if avatar then
			avatar.pendantsCtrl:setVisibleByType(AvatarPendantType.Rhand, false)
		end

		mainPlayer.spine:play(MainPlayerAnimState.Dig, true)
	end

	settimer(self._stepTime, self._updateTime, self)
end

function TreasurenewDigView:_updateTime()
	self._aniTimer = self._aniTimer + 1
	self._sldValue = self._sldValue + self._stepValue

	self._sldProgress:SetValue(self._sldValue)

	if self._aniTimer >= self._totalTimer then
		removetimer(self._updateTime, self)
		TreasureNewController.instance:sendFinishDigReq()

		return
	end
end

function TreasurenewDigView:_preLoadRes()
	self._resPath = GameUrl.getSpineUrl("30001_xunbao_gaotou")

	getres(self._resPath, self._onResLoaded, self, ResType.AssetBundle, true)
end

function TreasurenewDigView:_onResLoaded(res)
	local resPath = self._resPath

	self:_releaseRes()

	if not resPath or res.ResPath ~= resPath then
		return
	end

	if res and res.IsSuccess then
		self._resPath = res.ResPath
		self._resGaoTou = res

		self._resGaoTou:Retain()

		self._goGaoTou = goutil.clone(res:GetMainAsset())

		goutil.setActive(self._goGaoTou, false)
		Framework.GameObjectUtil.SetLayerRecursively(self._goGaoTou, SceneLayer.MainPlayer_Value)
	end
end

function TreasurenewDigView:_releaseRes()
	if self._goGaoTou then
		goutil.destroy(self._goGaoTou, true)

		self._goGaoTou = nil
	end

	if self._resGaoTou then
		self._resGaoTou:Release()

		self._resGaoTou = nil
	end

	self._resPath = nil
end

function TreasurenewDigView:_resetMainPlayer()
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and mainPlayer.spine then
		local avatar = mainPlayer.spine._avatar

		if avatar then
			avatar.pendantsCtrl:setVisibleByType(AvatarPendantType.Rhand)
		end

		SceneMainPlayer.instance:forceMainPlayerIdle()
		SceneMainPlayer.instance:ResetPlayerVariables()
	end

	if self._goGaoTou ~= nil then
		goutil.setActive(self._goGaoTou, false)
		self._goGaoTou.transform:SetParent(nil)
	end
end

return TreasurenewDigView
