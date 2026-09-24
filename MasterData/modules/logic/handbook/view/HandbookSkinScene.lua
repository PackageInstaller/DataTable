-- chunkname: @modules/logic/handbook/view/HandbookSkinScene.lua

local UIAnimationName = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinScene", package.seeall)

local HandbookSkinScene = class("HandbookSkinScene", BaseView)
local oriSceneDownAni = "sence1down"
local oriSceneUpAni = "sence1up"
local newSceneDownAni = "sence2down"
local newSceneUpAni = "sence2up"
local dragSuitRate = 0.0003

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
	[20027] = ViewName.HandbookSkinSuitDetailView3_9_1,
	[20028] = ViewName.HandbookSkinSuitDetailView4_0
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
	self._sevenMode = false
	self._enteringSevenMode = false

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
	if not self._inTarotGroup and not self._inSevenGroup then
		if offsetX ~= 0 or offsetY ~= 0 then
			local maxOffset = math.abs(offsetX) > math.abs(offsetY) and offsetX or offsetY

			self._sceneAnimator:SetFloat("Speed", 0)

			self._suitCurveProgresss = self._suitCurveProgresss or 0
			self._suitCurveProgresss = Mathf.Clamp(self._suitCurveProgresss + maxOffset * dragSuitRate * 4 / self._suitCount, 0, 1)

			self:UpdateAnimProgress(self._sceneAnimator, "path_last", self._suitCurveProgresss)

			self._moveToOtherSuitAni = true
		end
	elseif self._inSevenGroup and self._sevenSubScene then
		self._sevenSubScene:onDragging(offsetX)
	elseif self._tarotSubScene then
		self._tarotSubScene:onDragging(offsetX)
	end
end

function HandbookSkinScene:onDragBegin()
	if self._sevenMode then
		if self._sevenSubScene then
			self._sevenSubScene:doCardDragBegin()
		end

		return
	end

	if not self._tarotMode then
		return
	elseif self._tarotSubScene then
		self._tarotSubScene:doCardDragBegin()
	end
end

function HandbookSkinScene:onDragEnd()
	if self._sevenMode then
		self._dragging = false

		self._sevenSubScene:doCardPosResetTween()

		return
	end

	if not self._tarotMode then
		self._moveToOtherSuitAni = false

		self:slideToClosestSuit()
	else
		self._dragging = false

		if self._tarotSubScene then
			self._tarotSubScene:doCardPosResetTween()
		end
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
	elseif HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Seven and self._sevenSubScene then
		self._sevenSubScene:_exitScene()
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
	self._inTarotGroup = HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Tarot
	self._inSevenGroup = HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Seven

	local goCvure = gohelper.findChild(go, "cvure")

	if gohelper.isNil(goCvure) then
		return
	end

	local splineFollowComp = goCvure:GetComponent(typeof(ZProj.SplineFollow))

	if splineFollowComp == nil then
		return
	end

	splineFollowComp:Add(cameraRoot.transform, 0)
end

function HandbookSkinScene:setSevenSubScene(subScene)
	self._sevenSubScene = subScene

	if subScene then
		subScene:setScene(self)
	end
end

function HandbookSkinScene:setTarotSubScene(subScene)
	self._tarotSubScene = subScene

	if subScene then
		subScene:setScene(self)
	end
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
			local redDotComp = self:addNewRedDot(parentGo, skinSuitCfg.id, 0, 0)

			if self._tarotSubScene then
				self._tarotSubScene:setupRedDot(redDotComp)
			end
		end
	elseif HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Festival then
		local skinSuitCfg = self._suitCfgList[1]
		local iconGo = gohelper.findChild(self._curSceneGo, "sence/StandStill/Obj-Plant/near/shuqian/v3a3_m_s17_pftj_shuqian_03")

		if iconGo then
			self:addBoxColliderListener(iconGo, skinSuitCfg.id, 5)
		end
	elseif HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Seven then
		local skinSuitCfg = self._suitCfgList[1]
		local iconGo = gohelper.findChild(self._curSceneGo, "sence/book/Dummy003")

		if iconGo then
			gohelper.setLayer(iconGo, UnityLayer.Scene, true)
			self:addBoxColliderListener(iconGo, skinSuitCfg.id, 5)

			local parentGo = gohelper.findChild(self._curSceneGo, "sence/skin_reddot_root")
			local redDotComp = self:addNewRedDot(parentGo, skinSuitCfg.id, 0, 0)

			if self._sevenSubScene then
				self._sevenSubScene:setupRedDot(redDotComp)
			end
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
		if self._tarotSubScene then
			self._tarotSubScene:enterScene()
		end
	elseif HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Festival then
		self:enterFestivalSkinScene()
	elseif HandbookEnum.SkinSuitId2SceneType[skinGroupId] == HandbookEnum.SkinSuitSceneType.Seven then
		if self._sevenSubScene then
			self._sevenSubScene:enterScene()
		end
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

			if self._tarotSubScene and self._tarotEnterAniDone then
				self._tarotSubScene:_refreshCardUnlockUx(cardGoIdx, changeCardIdx)
			elseif self._sevenMode and self._sevenSubScene and self._sevenSubScene._enterAniDone then
				self._sevenSubScene:_refreshCardUnlockUx(cardGoIdx, changeCardIdx)
			end
		end
	end
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

function HandbookSkinScene:isInTarotMode()
	if self._tarotSubScene then
		return self._tarotSubScene:isInMode()
	end

	return false
end

function HandbookSkinScene:exitTarotScene()
	if self._tarotSubScene then
		self._tarotSubScene:exitScene()
	end
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

function HandbookSkinScene:isInSevenMode()
	if self._sevenSubScene then
		return self._sevenSubScene:isInMode()
	end

	return false
end

function HandbookSkinScene:exitSevenScene()
	if self._sevenSubScene then
		self._sevenSubScene:exitScene()
	end
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
	TaskDispatcher.cancelTask(self.openFestivalSkinView, self)

	if self._dragResetPosTweens and #self._dragResetPosTweens > 0 then
		for i = 1, #self._dragResetPosTweens do
			ZProj.TweenHelper.KillById(self._dragResetPosTweens[i])
		end

		self._dragResetPosTweens = {}
	end

	if self._cameraRootAnimator then
		self._cameraRootAnimator:Rebind()
		self._cameraRootAnimator:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(HandbookSkinScene.delayRemoveAnimator, self, 0.1)
	end

	if self._tweenCardPosTweenId then
		ZProj.TweenHelper.KillById(self._tweenCardPosTweenId)

		self._tweenCardPosTweenId = nil
	end

	if self._sevenSubScene then
		self._sevenSubScene:onClose()
	end

	if self._tarotSubScene then
		self._tarotSubScene:onClose()
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
