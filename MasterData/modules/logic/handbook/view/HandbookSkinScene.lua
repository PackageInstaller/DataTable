-- chunkname: @modules/logic/handbook/view/HandbookSkinScene.lua

local UIAnimationName = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinScene", package.seeall)

local HandbookSkinScene = class("HandbookSkinScene", BaseView)
local oriSceneDownAni = "sence1down"
local oriSceneUpAni = "sence1up"
local newSceneDownAni = "sence2down"
local newSceneUpAni = "sence2up"
local centerCardIdx = 3
local cardCount = 5
local dragRate = 0.00075
local dragSuitRate = 0.0003
local maxDragProgressPerFrame = 0.15
local cardDefaultPosMap = {
	0.8333,
	0.6667,
	0.5,
	0.3333,
	0.1667
}
local resetPosDuration = 0.25
local openDetailDuration = 0.1

HandbookSkinScene.SkinSuitId2SuitView = {
	[20007] = ViewName.HandbookSkinSuitDetailView1_7,
	[20008] = ViewName.HandbookSkinSuitDetailView1_8,
	[20009] = ViewName.HandbookSkinSuitDetailView1_9,
	[20010] = ViewName.HandbookSkinSuitDetailView2_0,
	[20011] = ViewName.HandbookSkinSuitDetailView2_1,
	[20012] = ViewName.HandbookSkinSuitDetailView2_2,
	[20013] = ViewName.HandbookSkinSuitDetailView2_3,
	[20014] = ViewName.HandbookSkinSuitDetailView2_4,
	[20015] = ViewName.HandbookSkinSuitDetailView2_5,
	[20016] = ViewName.HandbookSkinSuitDetailView2_6,
	[20017] = ViewName.HandbookSkinSuitDetailView2_7,
	[20018] = ViewName.HandbookSkinSuitDetailView2_8,
	[22003] = ViewName.HandbookSkinSuitDetailView2_9,
	[20019] = ViewName.HandbookSkinSuitDetailView3_0,
	[20020] = ViewName.HandbookSkinSuitDetailView3_1,
	[20021] = ViewName.HandbookSkinSuitDetailView3_2,
	[21002] = ViewName.HandbookSkinSuitDetailView3_3,
	[20022] = ViewName.HandbookSkinSuitDetailView3_3_1,
	[20023] = ViewName.HandbookSkinSuitDetailView3_4,
	[20024] = ViewName.HandbookSkinSuitDetailView3_5,
	[20025] = ViewName.HandbookSkinSuitDetailView3_7,
	[20026] = ViewName.HandbookSkinSuitDetailView3_8,
	[22004] = ViewName.HandbookSkinSuitDetailView3_8_5,
	[20004] = ViewName.HandbookSkinSuitDetailView3_8_5_1,
	[22001] = ViewName.HandbookSkinSuitDetailView3_9,
	[20027] = ViewName.HandbookSkinSuitDetailView3_9_1
}

function HandbookSkinScene:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookSkinScene:addEvents()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.OnClickSkinSuitFloorItem, self.onClickFloorItem, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.SwitchSkinSuitFloorDone, self.onSwitchSkinSuitFloorDone, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.SkinBookSlideToPre, self.onSlideToPre, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.SkinBookSlideToNext, self.onSlideToNext, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.SkinBookSlideBegin, self.onDragBegin, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.SkinBookSlide, self.onDragging, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.SkinBookSlideEnd, self.onDragEnd, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.SkinBookSlideByClick, self.onSlideByClick, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.SkinBookDropListOpen, self.onSkinSuitDropListShow, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.OnExitToSuitGroup, self._onReturnToSkinGroupScene, self)
end

function HandbookSkinScene:removeEvents()
	return
end

function HandbookSkinScene:onClickFloorItem(index)
	self._tarotMode = false

	if self._curSelectedIdx == index then
		return
	end

	if index > self._curSelectedIdx then
		self._isUp = true
		self._curSelectedIdx = index

		self._sceneAnimatorPlayer:Play(oriSceneDownAni, self.onOriSceneAniDone, self)
	else
		self._isUp = false
		self._curSelectedIdx = index

		self._sceneAnimatorPlayer:Play(oriSceneUpAni, self.onOriSceneAniDone, self)
	end

	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_floor_switch)
end

function HandbookSkinScene:onOriSceneAniDone()
	self:updateSuitGroupData(self._curSelectedIdx)
	self:_refreshScene(self._skinSuitGroupCfgList[self._curSelectedIdx].id)
	self:_createSuitItems()

	self._suitCurveProgresss = 0
	self._moveToOtherSuitAni = false

	self:_selectDefaultIcon()
end

function HandbookSkinScene:onSwitchSkinSuitFloorDone()
	if self._isUp then
		self._sceneAnimatorPlayer:Play(newSceneDownAni)
	else
		self._sceneAnimatorPlayer:Play(newSceneUpAni)
	end
end

function HandbookSkinScene:onSlideToPre()
	if self._moveToOtherSuitAni then
		return
	end

	if self._suitIdx > 1 then
		self:slideToSuitIdx(self._suitIdx - 1)
	end
end

function HandbookSkinScene:onSlideToNext()
	if self._moveToOtherSuitAni then
		return
	end

	if self._suitIdx < self._suitCount then
		self:slideToSuitIdx(self._suitIdx + 1)
	end
end

function HandbookSkinScene:onSkinSuitDropListShow(show)
	self._suitDropListShow = show
end

function HandbookSkinScene:onSlideByClick(idx)
	if self._moveToOtherSuitAni then
		return
	end

	if idx ~= self._suitIdx then
		self:slideToSuitIdx(idx)
	end
end

function HandbookSkinScene:onDragging(offsetX, offsetY)
	if not self._inTarotGroup then
		if offsetX ~= 0 or offsetY ~= 0 then
			local maxOffset = math.abs(offsetX) > math.abs(offsetY) and offsetX or offsetY

			self._sceneAnimator:SetFloat("Speed", 0)

			self._suitCurveProgresss = self._suitCurveProgresss or 0
			self._suitCurveProgresss = Mathf.Clamp(self._suitCurveProgresss + maxOffset * dragSuitRate * 4 / self._suitCount, 0, 1)

			self:UpdateAnimProgress(self._sceneAnimator, "path_last", self._suitCurveProgresss)

			self._moveToOtherSuitAni = true
		end
	else
		if self._enteringTarotMode or not self._tarotMode then
			return
		end

		self._dragging = true

		if self._moveToOtherSuitAni then
			return
		end

		if self._dragResetPosTweens and #self._dragResetPosTweens > 0 then
			for i = 1, #self._dragResetPosTweens do
				ZProj.TweenHelper.KillById(self._dragResetPosTweens[i])
			end

			self._dragResetPosTweens = {}
		end

		local progressDiff = dragRate * offsetX

		progressDiff = Mathf.Clamp(progressDiff, -maxDragProgressPerFrame, maxDragProgressPerFrame)

		local changeSprite = false

		for i, cardAnimator in ipairs(self._tarotCardAnimators) do
			local curProgress = self._tarotCardAniProgress[i]
			local dragAnimationName = "slide"
			local newProgress = curProgress - progressDiff

			if newProgress >= self._maxProgress then
				self._tarotCardAniProgress[i] = self._minProgress + newProgress - self._maxProgress
				self._curLeftIdx = self._curLeftIdx >= HandbookEnum.TarotSkinCount and 1 or self._curLeftIdx + 1
				self._curRightIdx = self._curRightIdx >= HandbookEnum.TarotSkinCount and 1 or self._curRightIdx + 1

				self:setCardSprite(i, self._curRightIdx)

				self._tarotCardIdx2SkinIdx[i] = self._curRightIdx
				changeSprite = true
			elseif newProgress <= self._minProgress then
				self._tarotCardAniProgress[i] = self._maxProgress + newProgress - self._minProgress

				if self._curLeftIdx <= 1 then
					self._curLeftIdx = HandbookEnum.TarotSkinCount or self._curLeftIdx - 1
				end

				if self._curRightIdx <= 1 then
					self._curRightIdx = HandbookEnum.TarotSkinCount or self._curRightIdx - 1
				end

				self:setCardSprite(i, self._curLeftIdx)

				self._tarotCardIdx2SkinIdx[i] = self._curLeftIdx
				changeSprite = true
			else
				self._tarotCardAniProgress[i] = newProgress
			end

			self:UpdateAnimProgress(cardAnimator, dragAnimationName, self._tarotCardAniProgress[i])
		end
	end
end

function HandbookSkinScene:onDragBegin()
	if not self._tarotMode then
		return
	else
		self:doTarotCardDragBegin()
	end
end

function HandbookSkinScene:onDragEnd()
	if not self._tarotMode then
		self._moveToOtherSuitAni = false

		self:slideToClosestSuit()
	else
		self._dragging = false

		self:doTarotCardPosResetTween()
	end
end

function HandbookSkinScene:slideToSuitIdx(idx)
	if self._suitIdx ~= idx then
		self._sceneAnimator:SetFloat("Speed", 0)

		local curProgress = (self._suitIdx - 1) / (self._suitCount - 1)

		self._suitCurveProgresss = (idx - 1) / (self._suitCount - 1)

		local slideSuitAniTweenId = ZProj.TweenHelper.DOTweenFloat(curProgress, self._suitCurveProgresss, 1, self.slideSuitAniUpdate, nil, self)

		self:UpdateAnimProgress(self._sceneAnimator, "path_last", curProgress)
		AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_switch_2)

		self._moveToOtherSuitAni = true
		self._suitIdx = idx

		TaskDispatcher.runDelay(self._onMoveToOtherSuitAniDone, self, 1)
		UIBlockMgr.instance:startBlock(UIBlockKey.WaitItemAnimeDone)
		self:_refreshPoint()
	end
end

function HandbookSkinScene:slideToClosestSuit()
	if self._suitCount <= 1 then
		return
	end

	local progressDiff = 1
	local targetIdx = 0
	local targetProgress = 0

	if self._suitCurveProgresss == nil then
		self._suitCurveProgresss = 0
	end

	for idx = 0, self._suitCount - 1 do
		local suitProgress = idx / (self._suitCount - 1)
		local diff = math.abs(suitProgress - self._suitCurveProgresss)

		if diff < progressDiff then
			progressDiff = diff
			targetIdx = idx + 1
			targetProgress = suitProgress
		end
	end

	self._sceneAnimator:SetFloat("Speed", 0)

	local slideSuitAniTweenId = ZProj.TweenHelper.DOTweenFloat(self._suitCurveProgresss, targetProgress, 0.25, self.slideSuitAniUpdate, nil, self)

	self._moveToOtherSuitAni = true
	self._suitIdx = targetIdx
	self._suitCurveProgresss = targetProgress

	TaskDispatcher.runDelay(self._onMoveToOtherSuitAniDone, self, 0.25)
	self:_refreshPoint()
end

function HandbookSkinScene:slideSuitAniUpdate(value)
	self:UpdateAnimProgress(self._sceneAnimator, "path_last", value)
end

function HandbookSkinScene:_onMoveToOtherSuitAniDone()
	self._moveToOtherSuitAni = false

	UIBlockMgr.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
end

function HandbookSkinScene:_onReturnToSkinGroupScene()
	local skinGroupId = self._skinSuitGroupCfgList[self._curSelectedIdx].id

	if HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Festival then
		self:_exitFestivalSkinScene()
	end
end

function HandbookSkinScene:onOpen()
	CameraMgr.instance:switchVirtualCamera(1)

	local viewParam = self.viewParam

	self.sceneVisible = true
	self._skinSuitGroupCfgList = HandbookConfig.instance:getSkinThemeGroupCfgs(true, true)

	if viewParam then
		self._defaultSelectedIdx = viewParam.defaultSelectedIdx or HandbookController.instance:getDefaultHandbookSkinGroupId(self._skinSuitGroupCfgList)
	end

	self:updateSuitGroupData(self._defaultSelectedIdx)
	self:_refreshScene(self._curskinSuitGroupCfg.id)
	self:_createSuitItems()
	self:_selectDefaultIcon()
end

function HandbookSkinScene:_selectDefaultIcon()
	local defaultIndex = HandbookController.instance:getDefaultHandbookSkinSuitId(self._suitCfgList)

	if defaultIndex ~= self._suitIdx then
		self:slideToSuitIdx(defaultIndex)
	end
end

function HandbookSkinScene:setSceneActive(isActive)
	if self._sceneRoot then
		gohelper.setActive(self._sceneRoot, isActive)
	end
end

function HandbookSkinScene:_editableInitView()
	self:onScreenResize()

	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("HandbookSkinScene")

	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function HandbookSkinScene:onScreenResize()
	local fov = self:_calcFovInternal()
	local virtualCamera = CameraMgr.instance:getVirtualCamera(1, 1)
	local old = virtualCamera.m_Lens

	virtualCamera.m_Lens = Cinemachine.LensSettings.New(fov, old.OrthographicSize, old.NearClipPlane, old.FarClipPlane, old.Dutch)
end

function HandbookSkinScene:resetCamera()
	GameSceneMgr.instance:getCurScene().camera:resetParam()
end

function HandbookSkinScene:updateSuitGroupData(index)
	self._curSelectedIdx = index
	self._curskinSuitGroupCfg = self._skinSuitGroupCfgList[self._curSelectedIdx]
	self._curSuitGroupId = self._curskinSuitGroupCfg.id
	self._suitCfgList = HandbookConfig.instance:getSkinSuitCfgListInGroup(self._curskinSuitGroupCfg.id)
	self._suitCount = #self._suitCfgList

	table.sort(self._suitCfgList, self._suitCfgSort)

	self._suitIdx = 1

	self:_refreshPoint()
end

function HandbookSkinScene:_refreshPoint()
	self.viewContainer:dispatchEvent(HandbookEvent.SkinPointChanged, self._suitIdx, self._suitCount)
end

function HandbookSkinScene._suitCfgSort(cfg1, cfg2)
	if cfg1.show == 1 and cfg2.show == 0 then
		return true
	elseif cfg1.show == 0 and cfg2.show == 1 then
		return false
	else
		return cfg1.id > cfg2.id
	end
end

function HandbookSkinScene:_refreshScene(skinGroupId)
	if self._curSceneGo then
		gohelper.destroy(self._curSceneGo)

		self._curSceneGo = nil
	end

	local cfg = HandbookConfig.instance:getSkinThemeGroupCfg(skinGroupId)
	local scenePath = cfg.scenePath

	if string.nilorempty(scenePath) then
		scenePath = HandbookEnum.SkinSuitGroupDefaultScene
	end

	local go = self:getResInst(scenePath, self._sceneRoot)

	self._curSceneGo = go

	local virtualCameraGo = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(virtualCameraGo, true)

	local cameraRoot = CameraMgr.instance:getCameraTraceGO()
	local fov = self:_calcFovInternal()
	local virtualCamera = CameraMgr.instance:getVirtualCamera(1, 1)
	local old = virtualCamera.m_Lens

	virtualCamera.m_Lens = Cinemachine.LensSettings.New(fov, old.OrthographicSize, old.NearClipPlane, old.FarClipPlane, old.Dutch)
	self._cameraRootAnimator = gohelper.onceAddComponent(cameraRoot, typeof(UnityEngine.Animator))

	local animatorCtrlPath = self.viewContainer:getSetting().otherRes[1]

	self._cameraRootAnimator.runtimeAnimatorController = self.viewContainer._abLoader:getAssetItem(animatorCtrlPath):GetResource()

	self._cameraRootAnimator:Rebind()

	self._sceneAnimator = self._curSceneGo:GetComponent(gohelper.Type_Animator)
	self._sceneAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._curSceneGo)

	local goCvure = gohelper.findChild(go, "cvure")
	local splineFollowComp = goCvure:GetComponent(typeof(ZProj.SplineFollow))

	if splineFollowComp == nil then
		return
	end

	splineFollowComp:Add(cameraRoot.transform, 0)

	self._inTarotGroup = HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Tarot
end

function HandbookSkinScene:_createSuitItems()
	if self._suitItemLoaderList and #self._suitItemLoaderList > 0 then
		for _, loader in ipairs(self._suitItemLoaderList) do
			if loader then
				loader:dispose()
			end
		end
	end

	self._suitIconRootDict = self:getUserDataTb_()

	local skinGroupId = self._skinSuitGroupCfgList[self._curSelectedIdx].id

	if HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Tarot then
		local skinSuitCfg = self._suitCfgList[1]
		local iconGo = gohelper.findChild(self._curSceneGo, "sence/StandStill/Obj-Plant/near/quanzhuang/qiu")

		if iconGo then
			gohelper.setLayer(iconGo, UnityLayer.Scene, true)
			self:addBoxColliderListener(iconGo, skinSuitCfg.id, 0.5)

			local parentGo = gohelper.findChild(self._curSceneGo, "sence/skin_reddot_root")

			self._tarotRedDotComp = self:addNewRedDot(parentGo, skinSuitCfg.id, 0, 0)
		end
	elseif HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Festival then
		local skinSuitCfg = self._suitCfgList[1]
		local iconGo = gohelper.findChild(self._curSceneGo, "sence/StandStill/Obj-Plant/near/shuqian/v3a3_m_s17_pftj_shuqian_03")

		if iconGo then
			self:addBoxColliderListener(iconGo, skinSuitCfg.id, 5)
		end
	else
		self._suitItemLoaderList = {}
		self._suitId2IdxMap = {}

		for i = 1, #self._suitCfgList do
			local skinSuitCfg = self._suitCfgList[i]

			self._suitId2IdxMap[skinSuitCfg.id] = i

			local iconGo = gohelper.findChild(self._curSceneGo, "sence/Icon/icon0" .. i)

			if iconGo then
				gohelper.setLayer(iconGo, UnityLayer.Scene, true)

				self._suitIconRootDict[skinSuitCfg.id] = iconGo

				if skinSuitCfg.highId == self._curSuitGroupId then
					if skinSuitCfg.show then
						if not skinSuitCfg.id then
							local assetId = 10000
							local skinSuitAssetPath = string.format("scenes/v2a8_m_s17_pftj/prefab/icon_e/%d.prefab", assetId)
							local loader = PrefabInstantiate.Create(iconGo)

							self._suitItemLoaderList[#self._suitItemLoaderList + 1] = loader

							loader:startLoad(skinSuitAssetPath, function(loader)
								local suitItemGo = loader:getInstGO()

								if not gohelper.isNil(suitItemGo) then
									local suitItemComp = MonoHelper.addLuaComOnceToGo(suitItemGo, HandbookSkinSuitComp, {
										skinSuitCfg.id
									})

									if skinSuitCfg.show ~= nil and skinSuitCfg.show ~= 0 then
										local textGo = gohelper.findChild(suitItemGo, "root/loop/scence/zh_text")

										if textGo == nil then
											logError("皮肤图鉴红点: 不存在路径 root/loop/scence/zh_text 请检查 id: " .. tostring(skinSuitCfg.id))
										end

										self:addNewRedDot(textGo, skinSuitCfg.id, 0.2, 0.025, true)
									end
								end
							end)

							local oriChild = gohelper.findChild(iconGo, "root")

							if oriChild then
								gohelper.setActive(oriChild, false)
							end
						end
					end
				end

				self:addBoxColliderListener(iconGo, skinSuitCfg.id, 4)
			end
		end
	end
end

function HandbookSkinScene:addNewRedDot(parentGO, suitId, offsetX, offsetY, isText)
	if gohelper.isNil(parentGO) then
		return
	end

	local redDotPrefab = self.viewContainer._abLoader:getAssetItem(HandbookEnum.SkinSuitRedDotPath):GetResource()
	local redDotGo = gohelper.clone(redDotPrefab, parentGO, "handbook_skin_dot_" .. tostring(suitId))
	local scale = parentGO.transform.localScale

	scale.x = 1 / scale.x
	scale.y = 1 / scale.y
	redDotGo.transform.localScale = scale

	if not gohelper.isNil(redDotGo) then
		if isText then
			local text = parentGO:GetComponent(typeof(TMPro.TextMeshPro))

			if text then
				self:placeAtTMPLastCharTopRight(text, redDotGo.transform, offsetX, offsetY)
			else
				local position = parentGO.transform.localPosition

				position.x = position.x + offsetX
				position.y = position.y + offsetY
				position.z = 0.1
				redDotGo.transform.localPosition = position
			end
		else
			local position = redDotGo.transform.localPosition

			position.x = offsetX
			position.y = offsetY
			redDotGo.transform.localPosition = position
		end

		local item = MonoHelper.addNoUpdateLuaComOnceToGo(redDotGo, HandbookSkinNewRedDot, {
			suitId
		})

		item:refreshRedDot()

		return item
	end
end

function HandbookSkinScene:placeAtTMPLastCharTopRight(tmpText, targetTrans, offsetX, offsetY)
	offsetX = offsetX or 0
	offsetY = offsetY or 0

	local textInfo = tmpText:GetTextInfo(tmpText.text)
	local lineCount = textInfo.lineCount

	if lineCount <= 0 then
		return
	end

	local lastLineInfo = textInfo.lineInfo[lineCount - 1]
	local lastCharIdx = lastLineInfo.lastVisibleCharacterIndex
	local charInfo = textInfo.characterInfo[lastCharIdx]
	local trX = charInfo.topRight.x + offsetX
	local trY = charInfo.topRight.y + offsetY
	local worldPos = tmpText.transform:TransformPoint(trX, trY, 0)

	worldPos.z = tmpText.transform.position.z
	targetTrans.position = worldPos

	local localPosition = targetTrans.localPosition

	localPosition.z = 0
	targetTrans.localPosition = localPosition
end

function HandbookSkinScene:addBoxColliderListener(go, suitId, size)
	local clickListener = HandbookSkinScene.getOrAddBoxCollider2D(go, size)

	clickListener:AddClickListener(self.onIconMouseDown, self, suitId)
	clickListener:AddMouseUpListener(self.onIconMouseUp, self, suitId)
end

function HandbookSkinScene.getOrAddBoxCollider2D(go, size)
	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	size = size or 4

	local box = go:GetComponent(typeof(UnityEngine.BoxCollider2D))

	if not box then
		box = gohelper.onceAddComponent(go, typeof(UnityEngine.BoxCollider2D))
		box.size = Vector2(size, size)
	end

	box.enabled = true

	clickListener:SetIgnoreUI(true)

	return clickListener
end

function HandbookSkinScene:onIconMouseUp(suitId)
	if self._suitDropListShow then
		return
	end

	local curSuitId = self._mouseTouchSuitId

	self._mouseTouchSuitId = nil

	if curSuitId == suitId then
		local pos = UnityEngine.Input.mousePosition
		local dx = math.abs(self._mouseX - pos.x)
		local dy = math.abs(self._mouseY - pos.y)
		local maxOffset = 15

		if dx <= maxOffset and dy <= maxOffset then
			self:onIconClick(suitId)
		end
	end
end

function HandbookSkinScene:onIconMouseDown(suitId)
	if self._suitDropListShow then
		return
	end

	self._mouseTouchSuitId = suitId

	local pos = UnityEngine.Input.mousePosition

	self._mouseX = pos.x
	self._mouseY = pos.y
end

function HandbookSkinScene:onIconClick(suitId)
	if self._moveToOtherSuitAni then
		return
	end

	if not self.sceneVisible then
		return
	end

	local skinGroupId = self._skinSuitGroupCfgList[self._curSelectedIdx].id

	self._suitId = suitId

	if HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Tarot then
		self:enterTarotScene()
	elseif HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Festival then
		self:enterFestivalSkinScene()
	else
		local suitIdx = self._suitId2IdxMap[suitId]

		if self._suitIdx ~= suitIdx then
			self:slideToSuitIdx(suitIdx)

			self._suitIdx = suitIdx
		else
			local viewName = HandbookSkinScene.SkinSuitId2SuitView[suitId]

			if viewName then
				local viewParam = {
					skinThemeGroupId = suitId
				}

				ViewMgr.instance:openView(viewName, viewParam)
			end

			AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_open)
			HandbookController.instance:statSkinSuitDetail(suitId)
		end

		self:_refreshPoint()
	end
end

function HandbookSkinScene:enterTarotScene()
	if self._tarotMode then
		return
	end

	self._tarotCardAniProgress = {}

	self._sceneAnimatorPlayer:Play(UIAnimationName.Click, nil, nil)
	self.viewContainer:dispatchEvent(HandbookEvent.OnClickTarotSkinSuit)

	self._tarotCardDatas = {}
	self._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(self._suitId)

	local skinIdStr = self._skinSuitCfg.skinContain
	local skinImageNameStr = self._skinSuitCfg.tarotCardPath

	self._skinIdList = string.splitToNumber(skinIdStr, "|")
	self._skinCardNameList = string.split(skinImageNameStr, "|")

	for i = 1, HandbookEnum.TarotSkinCount do
		self._tarotCardDatas[i] = {}

		if i <= #self._skinIdList then
			local skinId = self._skinIdList[i]

			if skinId == 310003 then
				self._tarotCardDatas[i].path = string.format("%s/%s.png", HandbookEnum.TarotSkinCardDir, self._skinCardNameList[i])
				self._tarotCardDatas[i].extraCardIcon1 = string.format("%s/%s_l.png", HandbookEnum.TarotSkinCardDir, self._skinCardNameList[i])
				self._tarotCardDatas[i].extraCardIcon2 = string.format("%s/%s_r.png", HandbookEnum.TarotSkinCardDir, self._skinCardNameList[i])
			else
				self._tarotCardDatas[i].path = string.format("%s/%s.png", HandbookEnum.TarotSkinCardDir, self._skinCardNameList[i])
			end

			self._tarotCardDatas[i].skinId = self._skinIdList[i]
		else
			self._tarotCardDatas[i].path = HandbookEnum.TarotSkinDefaultCardPath
		end
	end

	self._curLeftIdx = 1
	self._curRightIdx = 5

	if HandbookController.instance:isHandbookSkinSuitNewRedDotShow(self._suitId) then
		local tarotSkinCount = HandbookEnum.TarotSkinCount

		for i = 1, tarotSkinCount do
			local skinId = self._skinIdList[i]

			if skinId and HandbookController.instance:isHandbookSkinUnlockRedDotShow(skinId) then
				local leftIdx = i - 2

				while leftIdx < 1 do
					leftIdx = leftIdx + tarotSkinCount
				end

				self._curLeftIdx = leftIdx

				local rightIdx = i + 2

				while tarotSkinCount < rightIdx do
					rightIdx = rightIdx - tarotSkinCount
				end

				self._curRightIdx = rightIdx

				break
			end
		end
	end

	if self._tarotRedDotComp then
		self._tarotRedDotComp:forceHide()
	end

	if HandbookController.instance:isHandbookSkinSuitNewRedDotShow(self._suitId) then
		HandbookController.instance:markHandbookSkinNewRedDotShow(self._suitId)
	end

	self._tarotCardGos = self:getUserDataTb_()
	self._tarotCardSpriteRender = self:getUserDataTb_()
	self._tarotCardGlowSpriteRender = self:getUserDataTb_()
	self._tarotCardBackSpriteRender = self:getUserDataTb_()
	self._tarotCardLeftSpriteRenders = self:getUserDataTb_()
	self._tarotCardRightSpriteRenders = self:getUserDataTb_()
	self._tarotCardAnimators = self:getUserDataTb_()
	self._tarotCardUnlockVxs = self:getUserDataTb_()
	self._tarotCardUnlockAnimEvent = self:getUserDataTb_()
	self._tarotCardUnlockAnimator = self:getUserDataTb_()
	self._tarotCardIdx2SkinIdx = {}

	local unlockVxPrefab = self.viewContainer._abLoader:getAssetItem(HandbookEnum.SkinUnlockVxPath.Tarot):GetResource()

	for i = 1, cardCount do
		local cardRootGo = gohelper.findChild(self._curSceneGo, string.format("#Card/card0%d", i))

		self._tarotCardGos[i] = gohelper.findChild(cardRootGo, "card")

		self:addTarotCardBoxColliderListener(self._tarotCardGos[i], i)

		self._tarotCardAnimators[i] = cardRootGo:GetComponent(gohelper.Type_Animator)

		local tarotCardSpriteRenderGo = cardRootGo.transform:Find("card/sprite").gameObject

		self._tarotCardSpriteRender[i] = tarotCardSpriteRenderGo:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local goSpriteGlowEffect = gohelper.findChild(cardRootGo, "card/sprite/spriteglow")

		self._tarotCardGlowSpriteRender[i] = goSpriteGlowEffect:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local goSpriteCardBack = gohelper.findChild(cardRootGo, "card/back")

		self._tarotCardBackSpriteRender[i] = goSpriteCardBack:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local goSpriteLeft = gohelper.findChild(cardRootGo, "card/card_sp/card_left/sprite")

		self._tarotCardLeftSpriteRenders[i] = goSpriteLeft and goSpriteLeft:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local goSpriteRight = gohelper.findChild(cardRootGo, "card/card_sp/card_right/sprite")

		self._tarotCardRightSpriteRenders[i] = goSpriteRight and goSpriteRight:GetComponent(typeof(UnityEngine.SpriteRenderer))
		self._tarotCardIdx2SkinIdx[i] = (self._curLeftIdx - 1 + i - 1) % HandbookEnum.TarotSkinCount + 1

		local uxName = "tarotUnlockVx_" .. tostring(i)
		local unlockVxGo = gohelper.findChild(self._tarotCardGos[i], uxName)

		unlockVxGo = unlockVxGo or gohelper.clone(unlockVxPrefab, self._tarotCardGos[i], uxName)

		gohelper.setActive(unlockVxGo, false)
		gohelper.setAsLastSibling(unlockVxGo)

		self._tarotCardUnlockVxs[i] = unlockVxGo

		local animEvent = unlockVxGo:GetComponent(gohelper.Type_AnimationEventWrap)

		self._tarotCardUnlockAnimEvent[i] = animEvent

		local param = {
			self,
			i
		}

		animEvent:AddEventListener("unlock", self.onUnlockAnimPlayFinish, param)

		self._tarotCardUnlockAnimator[i] = gohelper.findChildComponent(unlockVxGo, "", gohelper.Type_Animator)
	end

	for i = 1, cardCount do
		self:setCardSprite(i, self._tarotCardIdx2SkinIdx[i])
	end

	self:_setCardBackSprite()

	self._enteringTarotMode = true

	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_special)
	TaskDispatcher.runDelay(self.onTarotEnterAniDone, self, 2)
end

function HandbookSkinScene.onUnlockAnimPlayFinish(param)
	return
end

function HandbookSkinScene:exitTarotScene()
	if not self._tarotMode then
		return
	end

	self._tarotMode = false
	self._tarotEnterAniDone = false
	self._tarotCardAniProgress = {}

	self._sceneAnimatorPlayer:Play(UIAnimationName.Back, nil, nil)
	self.viewContainer:dispatchEvent(HandbookEvent.OnExitTarotSkinSuit)
	TaskDispatcher.runDelay(self.onTarotExitAniDone, self, 2)
end

function HandbookSkinScene:onTarotExitAniDone()
	if self._tarotRedDotComp then
		self._tarotRedDotComp:resetForceHide()
	end
end

function HandbookSkinScene:onTarotEnterAniDone()
	self._enteringTarotMode = false
	self._tarotMode = true
	self._tarotEnterAniDone = true
	self._maxProgress = 0.916
	self._minProgress = 0.083
	self._tarotCardAniProgress[1] = cardDefaultPosMap[1]
	self._tarotCardAniProgress[2] = cardDefaultPosMap[2]
	self._tarotCardAniProgress[3] = cardDefaultPosMap[3]
	self._tarotCardAniProgress[4] = cardDefaultPosMap[4]
	self._tarotCardAniProgress[5] = cardDefaultPosMap[5]

	for i = 1, cardCount do
		local aniName = "slide"

		self:UpdateAnimProgress(self._tarotCardAnimators[i], aniName, self._tarotCardAniProgress[i])
		self:playSpCardOpenAni(i)
		self:_refreshCardUnlockUx(i, self._tarotCardIdx2SkinIdx[i])
	end
end

function HandbookSkinScene:_refreshCardUnlockUx(cardGoIdx, SkinIdx)
	local animator = self._tarotCardUnlockAnimator[cardGoIdx]
	local skinId = self._skinIdList[SkinIdx]

	if skinId then
		::label_43_0::

		local haveSkin = HeroModel.instance:checkHasSkin(skinId)

		gohelper.setActive(self._tarotCardUnlockVxs[cardGoIdx], haveSkin)

		if haveSkin then
			local showUnlockAnim = HandbookController.instance:isHandbookSkinUnlockRedDotShow(skinId)
			local animName = showUnlockAnim and "open" or "idle"
			local unlockVxGo = self._tarotCardUnlockVxs[cardGoIdx]

			gohelper.setAsLastSibling(unlockVxGo)
			animator:Play(animName, 0, 0)

			if self.isUniqueSkin then
				if not HandbookEnum.Audio.play_ui_tujianskin_special_unlock then
					local audioId = HandbookEnum.Audio.play_ui_activity_hero37_checkpoint_gather

					AudioMgr.instance:trigger(audioId)
					HandbookController.instance:delaySendUnlockSkinRedDotInfo(skinId)
				end
			end
		end
	end
end

function HandbookSkinScene:setCardSprite(cardGoIdx, cardIdx)
	local spritePath = self._tarotCardDatas[cardIdx].path

	if self._changeCardIdxMap then
		self._changeCardIdxMap = self._changeCardIdxMap or {}
	end

	if self._cardLoaderxMap then
		self._cardLoaderxMap = self._cardLoaderxMap or {}
	end

	if not string.nilorempty(spritePath) then
		if self._cardLoaderxMap[cardGoIdx] then
			self._cardLoaderxMap[cardGoIdx]:dispose()
		end

		local loader = MultiAbLoader.New()

		self._cardLoaderxMap[cardGoIdx] = loader
		self._changeCardIdxMap[cardGoIdx] = cardIdx

		loader:addPath(spritePath)

		if not string.nilorempty(self._tarotCardDatas[cardIdx].extraCardIcon1) then
			loader:addPath(self._tarotCardDatas[cardIdx].extraCardIcon1)
			loader:addPath(self._tarotCardDatas[cardIdx].extraCardIcon2)
		end

		loader:startLoad(self._onLoadSpriteDone, self)
	end
end

function HandbookSkinScene:_onLoadSpriteDone(loader)
	local cardGoIdx = 0
	local changeCardIdx = 0

	for idx, cardLoader in pairs(self._cardLoaderxMap) do
		if cardLoader == loader then
			cardGoIdx = idx
			changeCardIdx = self._changeCardIdxMap[idx]

			break
		end
	end

	local spritePath = self._tarotCardDatas[changeCardIdx].path
	local assetItem = loader:getAssetItem(spritePath)
	local texture = assetItem:GetResource(spritePath)
	local sprite = UnityEngine.Sprite.Create(texture, UnityEngine.Rect.New(0, 0, texture.width, texture.height), Vector2.New(0.5, 0.5), 100, 0)
	local cardSpriteRender = self._tarotCardSpriteRender[cardGoIdx]
	local cardGlowSpriteRender = self._tarotCardGlowSpriteRender[cardGoIdx]

	cardGlowSpriteRender.sprite = sprite
	cardSpriteRender.sprite = sprite

	gohelper.setActive(cardSpriteRender.gameObject, true)

	local skinId = self._tarotCardDatas[changeCardIdx].skinId
	local has = skinId == nil or HeroModel.instance:checkHasSkin(skinId)

	if has then
		if not HandbookEnum.Color.Unlock then
			local colorStr = HandbookEnum.Color.Lock
			local color = SLFramework.UGUI.GuiHelper.ParseColor(colorStr)

			cardSpriteRender.color = color

			if not string.nilorempty(self._tarotCardDatas[changeCardIdx].extraCardIcon1) then
				local leftSpritePath = self._tarotCardDatas[changeCardIdx].extraCardIcon1
				local assetItem = loader:getAssetItem(leftSpritePath)
				local leftTexture = assetItem:GetResource(leftSpritePath)
				local leftSpriteRender = self._tarotCardLeftSpriteRenders[cardGoIdx]

				leftSpriteRender.sprite = UnityEngine.Sprite.Create(leftTexture, UnityEngine.Rect.New(0, 0, leftTexture.width, leftTexture.height), Vector2.New(0.5, 0.5), 100, 0)
				leftSpriteRender.color = color
			end

			if not string.nilorempty(self._tarotCardDatas[changeCardIdx].extraCardIcon2) then
				local rightSpritePath = self._tarotCardDatas[changeCardIdx].extraCardIcon2
				local assetItem = loader:getAssetItem(rightSpritePath)
				local rightTexture = assetItem:GetResource(rightSpritePath)
				local rightSpriteRender = self._tarotCardRightSpriteRenders[cardGoIdx]

				rightSpriteRender.sprite = UnityEngine.Sprite.Create(rightTexture, UnityEngine.Rect.New(0, 0, rightTexture.width, rightTexture.height), Vector2.New(0.5, 0.5), 100, 0)
				rightSpriteRender.color = color
			end

			if self._tarotEnterAniDone then
				self:_refreshCardUnlockUx(cardGoIdx, changeCardIdx)
			end
		end
	end
end

function HandbookSkinScene:_setCardBackSprite()
	local spritePath = HandbookEnum.TarotSkinDefaultCardPath

	if not string.nilorempty(spritePath) then
		if self._cardbackLoader then
			self._cardbackLoader:dispose()
		end

		local loader = MultiAbLoader.New()

		self._cardbackLoader = loader

		loader:addPath(spritePath)
		loader:startLoad(self._onCardBackLoadDone, self)
	end
end

function HandbookSkinScene:_onCardBackLoadDone(loader)
	local spritePath = HandbookEnum.TarotSkinDefaultCardPath
	local assetItem = loader:getAssetItem(spritePath)
	local texture = assetItem:GetResource(spritePath)
	local sprite = UnityEngine.Sprite.Create(texture, UnityEngine.Rect.New(0, 0, texture.width, texture.height), Vector2.New(0.5, 0.5), 100, 0)

	for _, cardBackSpriteRender in ipairs(self._tarotCardBackSpriteRender) do
		cardBackSpriteRender.sprite = sprite
	end
end

function HandbookSkinScene:addTarotCardBoxColliderListener(go, cardIdx)
	local clickListener = HandbookSkinScene.getOrAddBoxCollider2D(go)

	clickListener:AddMouseUpListener(self.onTarotItemClickUp, self, cardIdx)
end

function HandbookSkinScene:onTarotItemClickUp(cardId)
	if self._dragging or not self._tarotMode then
		return
	end

	if not self.sceneVisible then
		return
	end

	local skinIdx = self._tarotCardIdx2SkinIdx[cardId]

	self:doTarotCardPosToMiddle(skinIdx)
end

function HandbookSkinScene:openSkinDetailView(skinId)
	local skinCfg = SkinConfig.instance:getSkinCo(skinId)

	if not skinCfg then
		return
	end

	local heroId = skinCfg.characterId
	local skinViewParams = {
		handbook = true,
		storyMode = true,
		heroId = heroId,
		skin = skinId,
		skinSuitId = self._suitId
	}

	CharacterController.instance:openCharacterSkinView(skinViewParams)
end

function HandbookSkinScene:doTarotCardDragBegin()
	for i = 1, cardCount do
		local curProgress = self._tarotCardAniProgress[i]
		local cardPoxIdx = self:_checkCardPosIdx(curProgress)

		if cardPoxIdx == centerCardIdx then
			local cardAnimator = self._tarotCardAnimators[i]
			local skinIdx = self._tarotCardIdx2SkinIdx[i]
			local skinId = self._tarotCardDatas[skinIdx].skinId
			local skinCfg = SkinConfig.instance:getSkinCo(skinId)

			if not skinCfg then
				return
			end

			local curProgress = self._tarotCardAniProgress[i]
			local cardPosIdx = self:_checkCardPosIdx(curProgress)

			if cardPosIdx == centerCardIdx and skinId == 310003 then
				local spCardGo = cardAnimator.transform:Find("card/card_sp").gameObject
				local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

				spCardAnimator:Play(UIAnimationName.Close)
			end
		end
	end
end

local middleProgressIdx = 3

function HandbookSkinScene:getTarotMiddleSkinIdx()
	local offset = (HandbookEnum.TarotCardCount - 1) / 2

	return (self._curLeftIdx - 1 + offset) % HandbookEnum.TarotSkinCount + 1
end

function HandbookSkinScene:doTarotCardPosToMiddle(skinIdx)
	local skinId = self._tarotCardDatas[skinIdx].skinId

	if self:getTarotMiddleSkinIdx() == skinIdx then
		if skinId then
			self:openSkinDetailView(skinId)
		end

		return
	end

	self:doTarotCardDragToMiddleBegin()

	self._dragResetPosTweens = {}
	self._dragging = true
	self._tempSkinId = skinId

	local removeProgressOffset, idxAdd = self:_checkFirstCardPosIdxByMiddleSkinIdx(skinIdx)

	self._curProgressOffset = 0

	local changeNum = math.abs(idxAdd)

	self._leftChangeNum = changeNum
	self._rightChangeNum = changeNum

	if self._tweenCardPosTweenId then
		ZProj.TweenHelper.KillById(self._tweenCardPosTweenId)

		self._tweenCardPosTweenId = nil
	end

	local duration = resetPosDuration

	TaskDispatcher.runDelay(self.onDoTarotCardPosToMiddleEnd, self, duration + openDetailDuration)

	self._tweenCardPosTweenId = ZProj.TweenHelper.DOTweenFloat(0, removeProgressOffset, duration, self.cardPosToMiddleTweenFrameCallback, self.cardPosToMiddleTweenEndCallback, self)
end

function HandbookSkinScene:doTarotCardDragToMiddleBegin()
	for i = 1, cardCount do
		local curProgress = self._tarotCardAniProgress[i]
		local cardPoxIdx = self:_checkCardPosIdx(curProgress)

		if cardPoxIdx == centerCardIdx then
			local cardAnimator = self._tarotCardAnimators[i]
			local skinIdx = self._tarotCardIdx2SkinIdx[i]
			local skinId = self._tarotCardDatas[skinIdx].skinId
			local skinCfg = SkinConfig.instance:getSkinCo(skinId)

			if not skinCfg then
				return
			end

			local curProgress = self._tarotCardAniProgress[i]
			local cardPosIdx = self:_checkCardPosIdx(curProgress)

			if cardPosIdx == centerCardIdx and skinId == 310003 then
				local spCardGo = cardAnimator.transform:Find("card/card_sp").gameObject
				local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

				spCardAnimator:Play(UIAnimationName.Close)
			end
		end
	end
end

function HandbookSkinScene:onDoTarotCardPosToMiddleEnd()
	self._dragging = false

	self:openSkinDetailView(self._tempSkinId)
	TaskDispatcher.cancelTask(self.onDoTarotCardPosToMiddleEnd, self)

	self._tempSkinId = nil
end

function HandbookSkinScene:cardPosToMiddleTweenFrameCallback(value)
	local difference = value - self._curProgressOffset

	self._curProgressOffset = value

	for i, cardAnimator in ipairs(self._tarotCardAnimators) do
		local curProgress = self._tarotCardAniProgress[i]
		local dragAnimationName = "slide"
		local newProgress = curProgress + difference
		local changeSprite = false

		if newProgress >= self._maxProgress then
			self._tarotCardAniProgress[i] = self._minProgress + newProgress - self._maxProgress

			if self._rightChangeNum > 0 then
				self._curLeftIdx = self._curLeftIdx >= HandbookEnum.TarotSkinCount and 1 or self._curLeftIdx + 1
				self._curRightIdx = self._curRightIdx >= HandbookEnum.TarotSkinCount and 1 or self._curRightIdx + 1

				self:setCardSprite(i, self._curRightIdx)

				self._tarotCardIdx2SkinIdx[i] = self._curRightIdx
				changeSprite = true
				self._rightChangeNum = self._rightChangeNum - 1
			end
		elseif newProgress <= self._minProgress then
			self._tarotCardAniProgress[i] = self._maxProgress + newProgress - self._minProgress

			if self._leftChangeNum > 0 then
				if self._curLeftIdx <= 1 then
					self._curLeftIdx = HandbookEnum.TarotSkinCount or self._curLeftIdx - 1
				end

				if self._curRightIdx <= 1 then
					self._curRightIdx = HandbookEnum.TarotSkinCount or self._curRightIdx - 1
				end

				self:setCardSprite(i, self._curLeftIdx)

				self._tarotCardIdx2SkinIdx[i] = self._curLeftIdx
				changeSprite = true
				self._leftChangeNum = self._leftChangeNum - 1
			end
		else
			self._tarotCardAniProgress[i] = newProgress
		end

		self:UpdateAnimProgress(cardAnimator, dragAnimationName, self._tarotCardAniProgress[i])
	end
end

function HandbookSkinScene:cardPosToMiddleTweenEndCallback()
	for i = 1, cardCount do
		self:playSpCardOpenAni(i)
	end
end

function HandbookSkinScene:_checkFirstCardPosIdxByMiddleSkinIdx(skinIdx)
	local middleSkinMoveOffset = 0
	local idxAdd = 0
	local targetProgress = cardDefaultPosMap[middleProgressIdx]

	for i = 1, cardCount do
		if skinIdx == self._tarotCardIdx2SkinIdx[i] then
			local curProgress = self._tarotCardAniProgress[i]

			middleSkinMoveOffset = targetProgress - curProgress

			local curIndex = self:_checkCardPosIdx(curProgress)

			idxAdd = curIndex - middleProgressIdx

			break
		end
	end

	return middleSkinMoveOffset, idxAdd
end

function HandbookSkinScene:doTarotCardPosResetTween()
	self._dragResetPosTweens = {}

	for i = 1, cardCount do
		local curProgress = self._tarotCardAniProgress[i]
		local resetIdx = ((i == 1 or nil) and self:_checkCardPosIdx(curProgress)) + (i - 1)

		resetIdx = resetIdx > cardCount and resetIdx - cardCount or resetIdx

		local resetProgress = cardDefaultPosMap[resetIdx]

		self._dragResetPosTweens[i] = ZProj.TweenHelper.DOTweenFloat(curProgress, resetProgress, resetPosDuration, self.cardPosResetTweenFrameCallback, self.cardPosResetTweenEndCallback, self, i)

		self:playSpCardOpenAni(i)
	end
end

function HandbookSkinScene:cardPosResetTweenFrameCallback(value, idx)
	local dragAnimationName = "slide"
	local cardAnimator = self._tarotCardAnimators[idx]

	self._tarotCardAniProgress[idx] = value

	self:UpdateAnimProgress(cardAnimator, dragAnimationName, value)
end

function HandbookSkinScene:cardPosResetTweenEndCallback(idx)
	return
end

function HandbookSkinScene:playSpCardOpenAni(i)
	local cardAnimator = self._tarotCardAnimators[i]
	local skinIdx = self._tarotCardIdx2SkinIdx[i]
	local skinId = self._tarotCardDatas[skinIdx].skinId
	local skinCfg = SkinConfig.instance:getSkinCo(skinId)

	if not skinCfg then
		return
	end

	local curProgress = self._tarotCardAniProgress[i]
	local cardPosIdx = self:_checkCardPosIdx(curProgress)

	if cardPosIdx == centerCardIdx and skinId == 310003 then
		local spCardGo = cardAnimator.transform:Find("card/card_sp").gameObject
		local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

		gohelper.setActive(spCardGo, true)
		spCardAnimator:Play(UIAnimationName.Open)
	end
end

function HandbookSkinScene:_checkCardPosIdx(curProgress)
	local minDiff = math.huge
	local minIdx = 1

	for i, pos in ipairs(cardDefaultPosMap) do
		local diff = math.abs(curProgress - pos)

		if diff < minDiff then
			minDiff = diff
			minIdx = i
		end
	end

	return minIdx
end

function HandbookSkinScene:isInTarotMode()
	return self._tarotMode or self._enteringTarotMode
end

function HandbookSkinScene:_calcFovInternal()
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local w, h = SettingsModel.instance:getCurrentScreenSize()

		fovRatio = 16 * h / 9 / w
	end

	local fov = HandbookEnum.TarotDefaultFOV * fovRatio
	local minFov, maxFov = self:_getMinMaxFov()

	fov = Mathf.Clamp(fov, minFov, maxFov)

	return fov
end

function HandbookSkinScene:_getMinMaxFov()
	return 22, 40
end

function HandbookSkinScene:enterFestivalSkinScene()
	self.viewContainer:dispatchEvent(HandbookEvent.OnClickFestivalSkinSuit)
	self._sceneAnimatorPlayer:Play(UIAnimationName.Click, nil, nil)
	HandbookController.instance:statSkinSuitDetail(self._suitId)
	TaskDispatcher.runDelay(self.openFestivalSkinView, self, 2)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(UIBlockKey.WaitItemAnimeDone, 2)
end

function HandbookSkinScene:_exitFestivalSkinScene()
	self.viewContainer:dispatchEvent(HandbookEvent.OnExitFestivalSkinSuit)
	self._sceneAnimatorPlayer:Play(UIAnimationName.Back, nil, nil)
end

function HandbookSkinScene:openFestivalSkinView()
	UIBlockHelper.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
	UIBlockMgrExtend.setNeedCircleMv(true)

	local viewName = HandbookSkinScene.SkinSuitId2SuitView[self._suitId]

	if viewName then
		local viewParam = {
			skinThemeGroupId = self._suitId
		}

		ViewMgr.instance:openView(viewName, viewParam)
	end

	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_open)
	HandbookController.instance:statSkinSuitDetail(self._suitId)
end

function HandbookSkinScene:playCloseAni()
	local virtualCameraGo = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(virtualCameraGo, false)

	if self._cameraRootAnimator then
		self._cameraRootAnimator:Rebind()
		self._cameraRootAnimator:Play(UIAnimationName.Close, 0, 0)
	end
end

function HandbookSkinScene:onClose()
	TaskDispatcher.cancelTask(self.onTarotEnterAniDone, self)
	TaskDispatcher.cancelTask(self.onTarotExitAniDone, self)
	TaskDispatcher.cancelTask(self.openFestivalSkinView, self)

	if self._dragResetPosTweens and #self._dragResetPosTweens > 0 then
		for i = 1, #self._dragResetPosTweens do
			ZProj.TweenHelper.KillById(self._dragResetPosTweens[i])
		end

		self._dragResetPosTweens = {}
	end

	TaskDispatcher.cancelTask(self.onDoTarotCardPosToMiddleEnd, self)

	if self._cameraRootAnimator then
		self._cameraRootAnimator:Rebind()
		self._cameraRootAnimator:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(HandbookSkinScene.delayRemoveAnimator, self, 0.1)
	end

	if self._tweenCardPosTweenId then
		ZProj.TweenHelper.KillById(self._tweenCardPosTweenId)

		self._tweenCardPosTweenId = nil
	end
end

function HandbookSkinScene:delayRemoveAnimator()
	local cameraRoot = CameraMgr.instance:getCameraTraceGO()
	local cameraRootAnimator = gohelper.onceAddComponent(cameraRoot, typeof(UnityEngine.Animator))

	if cameraRootAnimator then
		gohelper.removeComponent(cameraRootAnimator.gameObject, typeof(UnityEngine.Animator))
	end
end

function HandbookSkinScene:UpdateAnimProgress(animator, aniName, normalizedTime)
	animator:Play(aniName, 0, normalizedTime)
end

function HandbookSkinScene:onDestroyView()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end

	if self._cardLoaderxMap then
		for _, loader in pairs(self._cardLoaderxMap) do
			if loader then
				loader:dispose()
			end
		end

		self._cardLoaderxMap = nil
	end

	if self._cardbackLoader then
		self._cardbackLoader:dispose()
	end

	if self._suitItemLoaderList and #self._suitItemLoaderList > 0 then
		for _, loader in ipairs(self._suitItemLoaderList) do
			if loader then
				loader:dispose()
			end
		end
	end

	if self._tarotCardUnlockAnimEvent and next(self._tarotCardUnlockAnimEvent) then
		tabletool.clear(self._tarotCardUnlockAnimEvent)
	end
end

function HandbookSkinScene:onCloseFinish()
	local mainCamera = CameraMgr.instance:getMainCamera()

	mainCamera.fieldOfView = 35

	BGMSwitchController.instance:checkStartMainBGM(true)
end

return HandbookSkinScene
