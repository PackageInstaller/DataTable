-- chunkname: @modules/logic/survival/view/collectionRoom/SurvivalCollectionRoomView.lua

module("modules.logic.survival.view.collectionRoom.SurvivalCollectionRoomView", package.seeall)

local SurvivalCollectionRoomView = class("SurvivalCollectionRoomView", SurvivalMapDragBaseView)

function SurvivalCollectionRoomView:onInitView()
	SurvivalCollectionRoomView.super.onInitView(self)

	self.igoreViewList = {
		ViewName.SurvivalRoleLevelTipPopView,
		ViewName.SurvivalToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor,
		ViewName.GMGuideStatusView
	}
	self.txt_curent = gohelper.findChildTextMesh(self.viewGO, "go_root/progress/#txt_curent")
	self.txt_total = gohelper.findChildTextMesh(self.viewGO, "go_root/progress/#txt_total")
	self.btn_back = gohelper.findChildButtonWithAudio(self.viewGO, "go_root/#btn_back")
end

function SurvivalCollectionRoomView:addEvents()
	SurvivalCollectionRoomView.super.addEvents(self)
	SurvivalController.instance:registerCallback(SurvivalEvent.CameraFollowerTarget, self._onCameraFollowerTarget, self)
	self.addClickCb(self, self.btn_back, self.onClickBtnBack, self)
end

function SurvivalCollectionRoomView:removeEvents()
	SurvivalCollectionRoomView.super.removeEvents(self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.CameraFollowerTarget, self._onCameraFollowerTarget, self)
end

function SurvivalCollectionRoomView:onClickBtnBack()
	SurvivalController.instance:exitMap()
end

function SurvivalCollectionRoomView:calcSceneBoard()
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

			local HandBookType = SurvivalEnum.HandBookType
			local info = SurvivalHandbookModel.instance:getProgress(HandBookType.Collection)

			if info then
				self.txt_curent.text = info.progress
				self.txt_total.text = info.amount
			end
		end
	end
end

function SurvivalCollectionRoomView:onClose()
	return
end

function SurvivalCollectionRoomView:_onDrag(...)
	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	SurvivalCollectionRoomView.super._onDrag(self, ...)
end

function SurvivalCollectionRoomView:onClickScene(worldpos, hexPos)
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

	if scene.unit:checkClickUnit(hexPos) then
		return
	end

	local player = scene.unit:getPlayer()

	player:moveToByPos(hexPos)
end

function SurvivalCollectionRoomView:_setScale(scaleVal, force)
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

function SurvivalCollectionRoomView:setScenePosSafety(targetPos)
	SurvivalCollectionRoomView.super.setScenePosSafety(self, targetPos)

	local fogComp = SurvivalMapHelper.instance:getSceneFogComp()

	if not fogComp then
		return
	end

	fogComp:updateCenterPos(targetPos)
	fogComp:updateTexture()
end

function SurvivalCollectionRoomView:onSceneScaleChange()
	SurvivalMapHelper.instance:getSceneFogComp():updateTexture()
end

function SurvivalCollectionRoomView:_onCameraFollowerTarget(followerGO)
	self:setFollower(followerGO)
end

return SurvivalCollectionRoomView
