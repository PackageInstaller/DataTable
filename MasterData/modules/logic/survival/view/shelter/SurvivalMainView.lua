-- chunkname: @modules/logic/survival/view/shelter/SurvivalMainView.lua

module("modules.logic.survival.view.shelter.SurvivalMainView", package.seeall)

local SurvivalMainView = class("SurvivalMainView", SurvivalMapDragBaseView)

function SurvivalMainView:onInitView()
	SurvivalMainView.super.onInitView(self)

	self.igoreViewList = {
		ViewName.SurvivalRoleLevelTipPopView,
		ViewName.SurvivalToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor,
		ViewName.GMGuideStatusView
	}
	self.BossInvasionContainer = gohelper.findChild(self.viewGO, "go_normalroot/Right/BossInvasionContainer")

	local resPath = self.viewContainer:getSetting().otherRes.survivalbossinvasionview
	local obj = self:getResInst(resPath, self.BossInvasionContainer)

	self.survivalBossInvasionView = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalBossInvasionView, 1)
end

function SurvivalMainView:addEvents()
	SurvivalMainView.super.addEvents(self)
	SurvivalController.instance:registerCallback(SurvivalEvent.CameraFollowerTarget, self._onCameraFollowerTarget, self)
end

function SurvivalMainView:removeEvents()
	SurvivalMainView.super.removeEvents(self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.CameraFollowerTarget, self._onCameraFollowerTarget, self)
end

function SurvivalMainView:calcSceneBoard()
	local camera = SurvivalMapHelper.instance:getSceneCameraComp()

	self._mapMinX = camera.mapMinX
	self._mapMaxX = camera.mapMaxX
	self._mapMinY = camera.mapMinY
	self._mapMaxY = camera.mapMaxY
	self._maxDis = camera.maxDis
	self._minDis = camera.minDis
	self._mapMaxPitch = 60
	self._mapMinPitch = 45
	self._mapYaw = 0

	self:_setScale(0, true)

	local playerMo = SurvivalShelterModel.instance:getPlayerMo()
	local playerPos = playerMo and playerMo:getPos()

	if playerPos then
		if playerPos then
			local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(playerPos.q or 0, playerPos.r or 0)
			local targetPos = Vector3(x, y, z)

			self:setScenePosSafety(targetPos)
		end
	end
end

function SurvivalMainView:_onDrag(...)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	SurvivalMainView.super._onDrag(self, ...)
end

function SurvivalMainView:onClickScene(worldpos, hexPos)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName, self.igoreViewList) then
		return
	end

	self.viewContainer:dispatchEvent(SurvivalEvent.OnClickShelterScene)

	local scene = SurvivalMapHelper.instance:getScene()

	if not scene then
		return
	end

	if not scene.block:isClickBlock(hexPos) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_general_click)

	local survivalBubbleComp = SurvivalMapHelper.instance:getSurvivalBubbleComp()

	if survivalBubbleComp:isPlayerBubbleIntercept() then
		return
	end

	if scene.unit:checkClickUnit(hexPos) then
		return
	end

	local player = scene.unit:getPlayer()

	player:moveToByPos(hexPos)
end

function SurvivalMainView:_setScale(scaleVal, force)
	if not force and not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	scaleVal = Mathf.Clamp(scaleVal, 0, 1)

	if scaleVal == self._scale then
		return
	end

	self._lastScale = self._scale
	self._scale = scaleVal

	SurvivalMapHelper.instance:setDistance(self._maxDis - (self._maxDis - self._minDis) * self._scale)
	SurvivalMapHelper.instance:setRotate(self._mapYaw, self._mapMinPitch + (self._mapMaxPitch - self._mapMinPitch) * self._scale)
	self:onSceneScaleChange()
end

function SurvivalMainView:setScenePosSafety(targetPos)
	SurvivalMainView.super.setScenePosSafety(self, targetPos)

	local fogComp = SurvivalMapHelper.instance:getSceneFogComp()

	if not fogComp then
		return
	end

	fogComp:updateCenterPos(targetPos)
	fogComp:updateTexture()
end

function SurvivalMainView:onSceneScaleChange()
	SurvivalMapHelper.instance:getSceneFogComp():updateTexture()
end

function SurvivalMainView:_onCameraFollowerTarget(followerGO)
	self:setFollower(followerGO)
end

return SurvivalMainView
