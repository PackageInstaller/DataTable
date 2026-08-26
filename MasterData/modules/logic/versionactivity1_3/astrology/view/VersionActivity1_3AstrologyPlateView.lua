-- chunkname: @modules/logic/versionactivity1_3/astrology/view/VersionActivity1_3AstrologyPlateView.lua

module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyPlateView", package.seeall)

local VersionActivity1_3AstrologyPlateView = class("VersionActivity1_3AstrologyPlateView", BaseView)

function VersionActivity1_3AstrologyPlateView:onInitView()
	self._goAstrologyPlate = gohelper.findChild(self.viewGO, "#go_AstrologyPlate")
	self._simagePlate = gohelper.findChildSingleImage(self.viewGO, "#go_AstrologyPlate/#simage_Plate")
	self._imageeffect = gohelper.findChildImage(self.viewGO, "#go_AstrologyPlate/#simage_Plate/#image_effect")
	self._gotaiyang = gohelper.findChild(self.viewGO, "#go_AstrologyPlate/Planets/#go_taiyang")
	self._goshuixing = gohelper.findChild(self.viewGO, "#go_AstrologyPlate/Planets/#go_shuixing")
	self._gojinxing = gohelper.findChild(self.viewGO, "#go_AstrologyPlate/Planets/#go_jinxing")
	self._goyueliang = gohelper.findChild(self.viewGO, "#go_AstrologyPlate/Planets/#go_yueliang")
	self._gohuoxing = gohelper.findChild(self.viewGO, "#go_AstrologyPlate/Planets/#go_huoxing")
	self._gomuxing = gohelper.findChild(self.viewGO, "#go_AstrologyPlate/Planets/#go_muxing")
	self._gotuxing = gohelper.findChild(self.viewGO, "#go_AstrologyPlate/Planets/#go_tuxing")
	self._goLeftInfo = gohelper.findChild(self.viewGO, "#go_LeftInfo")
	self._goleftbtn = gohelper.findChild(self.viewGO, "#go_LeftInfo/#go_leftbtn")
	self._btnLeftArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_LeftInfo/#go_leftbtn/#btn_LeftArrow")
	self._txtLeftAngle = gohelper.findChildText(self.viewGO, "#go_LeftInfo/#go_leftbtn/#txt_LeftAngle")
	self._gorightbtn = gohelper.findChild(self.viewGO, "#go_LeftInfo/#go_rightbtn")
	self._btnRightArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_LeftInfo/#go_rightbtn/#btn_RightArrow")
	self._txtRightAngle = gohelper.findChildText(self.viewGO, "#go_LeftInfo/#go_rightbtn/#txt_RightAngle")
	self._gorightbtndisable = gohelper.findChild(self.viewGO, "#go_LeftInfo/#go_rightbtndisable")
	self._btnRightArrowDisable = gohelper.findChildButtonWithAudio(self.viewGO, "#go_LeftInfo/#go_rightbtndisable/#btn_RightArrowDisable")
	self._txtRightAngledisable = gohelper.findChildText(self.viewGO, "#go_LeftInfo/#go_rightbtndisable/#txt_RightAngledisable")
	self._goleftbtndisable = gohelper.findChild(self.viewGO, "#go_LeftInfo/#go_leftbtndisable")
	self._btnLeftArrowDisable = gohelper.findChildButtonWithAudio(self.viewGO, "#go_LeftInfo/#go_leftbtndisable/#btn_LeftArrowDisable")
	self._txtLeftAngleDisable = gohelper.findChildText(self.viewGO, "#go_LeftInfo/#go_leftbtndisable/#txt_LeftAngleDisable")
	self._btnAstrology = gohelper.findChildButtonWithAudio(self.viewGO, "#go_LeftInfo/#btn_Astrology")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_LeftInfo/#btn_Astrology/#go_reddot")
	self._gomodel = gohelper.findChild(self.viewGO, "#go_model")
	self._goDecText = gohelper.findChild(self.viewGO, "#go_DecText")
	self._txtDecText = gohelper.findChildText(self.viewGO, "#go_DecText/#txt_DecText")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3AstrologyPlateView:addEvents()
	self._btnLeftArrow:AddClickListener(self._btnLeftArrowOnClick, self)
	self._btnRightArrow:AddClickListener(self._btnRightArrowOnClick, self)
	self._btnRightArrowDisable:AddClickListener(self._btnRightArrowDisableOnClick, self)
	self._btnLeftArrowDisable:AddClickListener(self._btnLeftArrowDisableOnClick, self)
	self._btnAstrology:AddClickListener(self._btnAstrologyOnClick, self)
end

function VersionActivity1_3AstrologyPlateView:removeEvents()
	self._btnLeftArrow:RemoveClickListener()
	self._btnRightArrow:RemoveClickListener()
	self._btnRightArrowDisable:RemoveClickListener()
	self._btnLeftArrowDisable:RemoveClickListener()
	self._btnAstrology:RemoveClickListener()
end

function VersionActivity1_3AstrologyPlateView:_btnRightArrowDisableOnClick()
	self:_disableTip()
end

function VersionActivity1_3AstrologyPlateView:_btnLeftArrowDisableOnClick()
	self:_disableTip()
end

function VersionActivity1_3AstrologyPlateView:_disableTip()
	if self._planetMo.num <= 0 then
		GameFacade.showToast(ToastEnum.Activity126_tip7)

		return
	end

	GameFacade.showToast(ToastEnum.Activity126_tip4)
end

function VersionActivity1_3AstrologyPlateView:_btnLeftArrowOnClick()
	self:_rotate(VersionActivity1_3AstrologyEnum.Angle)
end

function VersionActivity1_3AstrologyPlateView:_btnRightArrowOnClick()
	self:_rotate(-VersionActivity1_3AstrologyEnum.Angle)
end

function VersionActivity1_3AstrologyPlateView:_rotate(angle)
	if not self._selectedItem then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_move)
	self:_createGhost(self._selectedItem:getId())
	self:_tweenRotate(self._selectedItem:getId(), angle)
	self._planetMo:updatePreviewAngle(angle)
	self:_updateBtnStatus()
	VersionActivity1_3AstrologyController.instance:dispatchEvent(VersionActivity1_3AstrologyEvent.adjustPreviewAngle)
	self:_showPreviewStar()
end

function VersionActivity1_3AstrologyPlateView:_tweenRotate(planetId, angle)
	local tweenInfo = self._tweenList[planetId]

	if not tweenInfo then
		tweenInfo = {
			self = self,
			planetId = planetId,
			mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(planetId)
		}
		tweenInfo.tweenId = nil
		self._tweenList[planetId] = tweenInfo
	end

	if tweenInfo.tweenId then
		ZProj.TweenHelper.KillById(tweenInfo.tweenId)

		tweenInfo.tweenId = nil
		tweenInfo.curAngle = tweenInfo.curAngle + tweenInfo.prevAngle
		tweenInfo.prevAngle = 0
	else
		tweenInfo.prevAngle = 0
		tweenInfo.curAngle = tweenInfo.mo.previewAngle
		tweenInfo.targetAngle = tweenInfo.mo.previewAngle
	end

	tweenInfo.targetAngle = tweenInfo.targetAngle + angle
	tweenInfo.tweenAngle = tweenInfo.targetAngle - tweenInfo.curAngle
	tweenInfo.tweenId = ZProj.TweenHelper.DOTweenFloat(0, tweenInfo.tweenAngle, 0.5, self._tweenRotateFrame, self._tweenRotateFinish, tweenInfo, nil, EaseType.Linear)
end

function VersionActivity1_3AstrologyPlateView._tweenRotateFrame(tweenInfo, value)
	local self = tweenInfo.self

	self:_rotateAround(tweenInfo.planetId, -tweenInfo.prevAngle + value)

	tweenInfo.prevAngle = value

	self:_sortPlanets(true)
end

function VersionActivity1_3AstrologyPlateView._tweenRotateFinish(tweenInfo)
	local self = tweenInfo.self

	self:_rotateAround(tweenInfo.planetId, -tweenInfo.prevAngle + tweenInfo.tweenAngle)

	tweenInfo.prevAngle = tweenInfo.tweenAngle
	tweenInfo.tweenId = nil

	self:_sortPlanets()
end

function VersionActivity1_3AstrologyPlateView:_showRotateEffect()
	if not self._selectedItem then
		gohelper.setActive(self._imageeffect, false)

		return
	end

	local id = self._selectedItem:getId()
	local planet = self._planetList[id]

	if not planet or not planet._ghostGoInfo then
		gohelper.setActive(self._imageeffect, false)

		return
	end

	local ghostGo = planet._ghostGoInfo.go

	if not ghostGo or not ghostGo.activeSelf then
		gohelper.setActive(self._imageeffect, false)

		return
	end

	local tweenInfo = self._tweenList[id]

	if not tweenInfo then
		return
	end

	gohelper.setActive(self._imageeffect, true)

	local startAngle, endAngle
	local limitAngle = planet._ghostGoInfo.limitAngle

	if id == VersionActivity1_3AstrologyEnum.Planet.shuixing then
		local model = self._modelPlanetList[id]
		local _, angle, _ = transformhelper.getLocalRotation(model)

		startAngle = planet._ghostGoInfo.ghostAngle % 360
		endAngle = angle % 360
	else
		startAngle = self:_getAngle(ghostGo.transform)
		endAngle = self:_getAngle(planet[1])
	end

	local isForward = false

	if startAngle < limitAngle then
		isForward = startAngle <= endAngle and endAngle < limitAngle
	elseif startAngle <= endAngle and endAngle <= 360 or endAngle >= 0 and endAngle < limitAngle then
		isForward = true
	end

	if math.abs(endAngle - limitAngle) <= 10 then
		isForward = tweenInfo.lastForward
	end

	if isForward then
		if endAngle < startAngle then
			endAngle = endAngle + 360
		end
	elseif startAngle < limitAngle and startAngle < endAngle then
		endAngle = endAngle - 360
	end

	tweenInfo.lastForward = isForward
	self._matParamVec.x = startAngle
	self._matParamVec.y = endAngle

	self._matEffect:SetVector(self._matKey, self._matParamVec)
end

function VersionActivity1_3AstrologyPlateView:_getAngle(transform)
	local posX, posY = recthelper.getAnchor(transform)
	local angle = -Mathf.Atan2(posY - 152, posX) * Mathf.Rad2Deg - 90

	angle = angle % 360

	return angle
end

function VersionActivity1_3AstrologyPlateView:_sortPlanets(keepShow)
	for id = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local planet = self._planetList[id]
		local uiTransform = planet[1]
		local mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(id)

		if planet._ghostGoInfo then
			local ghostGo = planet._ghostGoInfo.go

			if planet._ghostGoInfo.isFront then
				gohelper.setAsLastSibling(ghostGo)
			else
				gohelper.setAsFirstSibling(ghostGo)
			end

			if keepShow and not mo:hasAdjust() then
				-- block empty
			else
				gohelper.setActive(ghostGo, mo:hasAdjust())
			end
		end

		local isFront = mo:isFront()
		local tweenInfo = self._tweenList[id]

		if (tweenInfo and tweenInfo.tweenId or nil) and mo:isFront(tweenInfo.curAngle + tweenInfo.prevAngle) then
			gohelper.setAsLastSibling(uiTransform.gameObject)
		else
			gohelper.setAsFirstSibling(uiTransform.gameObject)
		end
	end

	self:_showRotateEffect()
end

function VersionActivity1_3AstrologyPlateView:_hideGhosts()
	for id = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local planet = self._planetList[id]
		local mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(id)

		if planet._ghostGoInfo then
			local ghostGo = planet._ghostGoInfo.go

			gohelper.setActive(ghostGo, false)

			planet._ghostGoInfo._isRefresh = nil
		end
	end
end

function VersionActivity1_3AstrologyPlateView:_btnAstrologyOnClick()
	local resultId = VersionActivity1_3AstrologyModel.instance:getQuadrantResult()

	Activity126Rpc.instance:sendHoroscopeRequest(VersionActivity1_3Enum.ActivityId.Act310, resultId)
end

function VersionActivity1_3AstrologyPlateView:_editableInitView()
	self._matEffect = self._imageeffect.material
	self._matKey = UnityEngine.Shader.PropertyToID("_RotateAngle")
	self._matParamVec = self._matEffect:GetVector(self._matKey)

	self._simagePlate:LoadImage(ResUrl.getV1a3AstrologySinglebg("v1a3_astrology_plate"))

	self._tweenList = {}

	local planets = gohelper.findChild(self.viewGO, "#go_AstrologyPlate/Planets")

	self._planetsTransform = planets.transform
	self._prevNum = Activity126Model.instance:getStarNum()

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.Activity1_3RedDot4)

	self._tipAnimator = self._goDecText:GetComponent(typeof(UnityEngine.Animator))

	self:_setDecVisible(false)
end

function VersionActivity1_3AstrologyPlateView:_worldPosToRelativeAnchorPos(worldPos, relativeRectTr)
	local screenPos = self._modelCamera:WorldToScreenPoint(worldPos)
	local uiCamera = CameraMgr.instance:getUICamera()

	return SLFramework.UGUI.RectTrHelper.ScreenPosToAnchorPos(screenPos, relativeRectTr, uiCamera)
end

function VersionActivity1_3AstrologyPlateView:calcFOV(fov)
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if fovRatio < 1 then
		fov = fov / fovRatio
	elseif fovRatio > 1 then
		fov = fov * fovRatio * 0.85
	end

	return fov
end

function VersionActivity1_3AstrologyPlateView:_createGhost(planetType)
	local planet = self._planetList[planetType]
	local srcGo = planet[1].gameObject

	if not planet._ghostGoInfo then
		local ghostGo = gohelper.cloneInPlace(srcGo, srcGo.name .. "_ghost")
		local goSelected = gohelper.findChild(ghostGo, "go_selected")

		gohelper.setActive(goSelected, false)

		local transform = ghostGo.transform
		local itemCount = transform.childCount

		for i = 1, itemCount do
			local child = transform:GetChild(i - 1)
			local img = child:GetComponent(gohelper.Type_Image)

			if img then
				local color = img.color

				color.a = 0.5
				img.color = color
			end
		end

		planet._ghostGoInfo = self:getUserDataTb_()
		planet._ghostGoInfo.go = ghostGo
	end

	local info = planet._ghostGoInfo

	if not info._isRefresh then
		info.go.transform.position = srcGo.transform.position

		local mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(planetType)

		info.isFront = mo:isFront()

		local model = self._modelPlanetList[planetType]
		local _, angle, _ = transformhelper.getLocalRotation(model)

		info.ghostAngle = angle
		info._isRefresh = true

		self:_rotateAround(planetType, 180)

		info.limitAngle = self:_getAngle(planet[1])

		self:_rotateAround(planetType, -180)
	end
end

function VersionActivity1_3AstrologyPlateView:_rotateAround(planetType, angle)
	local sunTransform = self._modelPlanetList[VersionActivity1_3AstrologyEnum.Planet.taiyang]
	local modelTransform = self._modelPlanetList[planetType]

	modelTransform:RotateAround(sunTransform.position, Vector3.up, angle)
	self:_syncPlanetPos(planetType)
end

function VersionActivity1_3AstrologyPlateView:_syncPlanetPos(planetType)
	local modelTransform = self._modelPlanetList[planetType]
	local uiTransform = self._planetList[planetType][1]
	local pos = self:_worldPosToRelativeAnchorPos(modelTransform.position, self._planetsTransform)

	recthelper.setAnchor(uiTransform, pos.x + VersionActivity1_3AstrologyEnum.PlanetOffsetX, pos.y + VersionActivity1_3AstrologyEnum.PlanetOffsetY)
end

function VersionActivity1_3AstrologyPlateView:_init()
	self._txtLeftAngle.text = string.format("%s°", VersionActivity1_3AstrologyEnum.Angle)
	self._txtLeftAngleDisable.text = string.format("%s°", VersionActivity1_3AstrologyEnum.Angle)
	self._txtRightAngle.text = string.format("-%s°", VersionActivity1_3AstrologyEnum.Angle)
	self._txtRightAngledisable.text = string.format("-%s°", VersionActivity1_3AstrologyEnum.Angle)
end

function VersionActivity1_3AstrologyPlateView:_initStars()
	self._lightStarList = self:getUserDataTb_()
	self._lightStarAnimatorList = self:getUserDataTb_()
	self._lightStarPreviewList = {}

	for i = 1, VersionActivity1_3AstrologyEnum.MaxStarNum do
		local lightStarGo = gohelper.findChild(self.viewGO, string.format("#go_LeftInfo/Stars/image_Star%s/image_StarBG/lightStar", i))

		gohelper.setActive(lightStarGo, false)

		self._lightStarList[i] = lightStarGo

		local rootGo = gohelper.findChild(self.viewGO, string.format("#go_LeftInfo/Stars/image_Star%s", i))

		self._lightStarAnimatorList[i] = rootGo:GetComponent(typeof(UnityEngine.Animator))
	end
end

function VersionActivity1_3AstrologyPlateView:_showStar()
	local num = Activity126Model.instance:getStarNum()
	local lightStarNum = 0

	for i, v in ipairs(self._lightStarList) do
		local isLight = i <= num

		gohelper.setActive(v, isLight)

		if isLight then
			lightStarNum = lightStarNum + 1

			local animator = self._lightStarAnimatorList[i]

			animator:Play("idle")
		end
	end

	gohelper.setActive(self._btnAstrology, num >= #self._lightStarList)
	self:_showTip(lightStarNum)

	if self._prevNum and self._prevNum < 10 and num >= 10 then
		GameFacade.showToast(ToastEnum.Activity126_tip5)
		VersionActivity1_3AstrologyController.instance:dispatchEvent(VersionActivity1_3AstrologyEvent.guideOnAstrologyBtnShow)
	end

	self._prevNum = num
end

function VersionActivity1_3AstrologyPlateView:_showPreviewStar()
	local adjustNum = VersionActivity1_3AstrologyModel.instance:getAdjustNum()
	local num = Activity126Model.instance:getStarNum()

	for i, v in ipairs(self._lightStarList) do
		local isLight = i <= num + adjustNum

		gohelper.setActive(v, isLight)

		self._lightStarPreviewList[i] = false

		if isLight and num < i then
			local animator = self._lightStarAnimatorList[i]

			animator:Play("loop", 0, 0)

			self._lightStarPreviewList[i] = true
		end
	end
end

function VersionActivity1_3AstrologyPlateView:_showStarOpen()
	for i, v in ipairs(self._lightStarList) do
		if self._lightStarPreviewList[i] then
			local animator = self._lightStarAnimatorList[i]

			animator:Play("open", 0, 0)
		end

		self._lightStarPreviewList[i] = false
	end
end

function VersionActivity1_3AstrologyPlateView:_showTip(lightStarNum)
	if lightStarNum <= 0 then
		self:_setDecVisible(false)

		return
	end

	self:_setDecVisible(true)
end

function VersionActivity1_3AstrologyPlateView:_checkResult()
	local horoscope = Activity126Model.instance:receiveHoroscope()
	local hasHoroscope = horoscope and horoscope > 0

	gohelper.setActive(self._goLeftInfo, not hasHoroscope)
	gohelper.setActive(self._txtDecText, not hasHoroscope)

	if hasHoroscope then
		self:_setDecVisible(false)
	end
end

function VersionActivity1_3AstrologyPlateView:_setDecVisible(value)
	local isActive = self._goDecText.activeSelf

	gohelper.setActive(self._goDecText, value)

	if value then
		if isActive then
			return
		end

		self:_delayShowTip()
	else
		TaskDispatcher.cancelTask(self._delaySwitch, self)
		TaskDispatcher.cancelTask(self._delayShowTip, self)
	end
end

function VersionActivity1_3AstrologyPlateView:_delaySwitch()
	self._tipAnimator:Play("close", 0, 0)
	TaskDispatcher.cancelTask(self._delayShowTip, self)
	TaskDispatcher.runDelay(self._delayShowTip, self, 3)
end

function VersionActivity1_3AstrologyPlateView:_delayShowTip()
	self:_randomTip()
	self._tipAnimator:Play("open", 0, 0)
	TaskDispatcher.cancelTask(self._delaySwitch, self)
	TaskDispatcher.runDelay(self._delaySwitch, self, 5)
end

function VersionActivity1_3AstrologyPlateView:_randomTip()
	local pos = self:_randomPos()

	if not pos[1] then
		if not pos[2] then
			local y = 0

			recthelper.setAnchor(self._goDecText.transform, pos[1], y)

			local config = self:_randomTipConfig()

			self._txtDecText.text = config.tip
		end
	end
end

function VersionActivity1_3AstrologyPlateView:_randomPos()
	local index = 3

	while true do
		index = index - 1

		local posIndex = math.random(#VersionActivity1_3AstrologyEnum.TipPos)

		if self._randomPosIndex ~= posIndex or index <= 0 then
			self._randomPosIndex = posIndex

			break
		end
	end

	return VersionActivity1_3AstrologyEnum.TipPos[self._randomPosIndex]
end

function VersionActivity1_3AstrologyPlateView:_randomTipConfig()
	local num = Activity126Model.instance:getStarNum()

	num = math.min(num, VersionActivity1_3AstrologyEnum.MaxStarNum)

	local index = 3

	while true do
		index = index - 1

		local posIndex = math.random(num)

		if self._randomTipConfigIndex ~= posIndex or index <= 0 then
			self._randomTipConfigIndex = posIndex

			break
		end
	end

	return (Activity126Config.instance:getStarConfig(VersionActivity1_3Enum.ActivityId.Act310, self._randomTipConfigIndex))
end

function VersionActivity1_3AstrologyPlateView:onOpen()
	transformhelper.setLocalScale(self.viewContainer.viewGO.transform, 1, 1, 1)
	self:_init()
	self:_initStars()
	self:_initPlanets()
	self:_initModel()
	self:_onScreenSizeChange()
	self:_initPlanetsAngles()
	self:_sortPlanets()
	self:_showStar()
	self:_checkResult()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
	self.addEventCb(self, VersionActivity1_3AstrologyController.instance, VersionActivity1_3AstrologyEvent.selectPlanetItem, self._selectPlanetItem, self)
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onUpdateProgressReply, self._onUpdateProgressReply, self)
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onHoroscopeReply, self._onHoroscopeReply, self)
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onResetProgressReply, self._onResetProgressReply, self)
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onBeforeResetProgressReply, self._onBeforeResetProgressReply, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function VersionActivity1_3AstrologyPlateView:_onCloseViewFinish(viewName)
	if viewName == ViewName.VersionActivity1_3AstrologySuccessView then
		self.viewContainer:switchTab(2)
	end
end

function VersionActivity1_3AstrologyPlateView:_onBeforeResetProgressReply()
	for k, v in pairs(self._modelPlanetPosList) do
		local transform = self._modelPlanetList[k]

		transform.position = v

		local angle = self._modelPlanetRotationList[k]

		transformhelper.setLocalRotation(transform, angle[1], angle[2], angle[3])
	end
end

function VersionActivity1_3AstrologyPlateView:_onResetProgressReply()
	self._prevNum = Activity126Model.instance:getStarNum()

	self:_checkResult()
	self:_updateSelectedFlag()
	self:_initPlanetsAngles()
	self:_sortPlanets()
end

function VersionActivity1_3AstrologyPlateView:_onHoroscopeReply()
	VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologySuccessView()
	self:_checkResult()
	self:_hideGhosts()
	self:_updateSelectedFlagById(nil)
end

function VersionActivity1_3AstrologyPlateView:_onUpdateProgressReply(param)
	if param and param.fromReset then
		self:_showStar()
	else
		local planetList = self.viewContainer:getSendPlanetList()

		self:_showAdjustEffect(planetList)
		self:_showStarOpen()
		GameFacade.showToast(ToastEnum.Activity126_tip9)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("AstrologyDelayShowReply")
		TaskDispatcher.cancelTask(self._delayShowReply, self)
		TaskDispatcher.runDelay(self._delayShowReply, self, 2)
	end

	self:_hideGhosts()
	self:_updateBtnStatus()
	self:_showRotateEffect()
end

function VersionActivity1_3AstrologyPlateView:_delayShowReply()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AstrologyDelayShowReply")
	self:_showStar()
	self:_hideAdjustEffect()

	local list = VersionActivity1_3AstrologyModel.instance:getStarReward()

	if list then
		VersionActivity1_3AstrologyModel.instance:setStarReward(nil)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, list)
	end
end

function VersionActivity1_3AstrologyPlateView:_showAdjustEffect(planetList)
	if not planetList then
		return
	end

	for id, _ in pairs(planetList) do
		local planetInfo = self._planetList[id]
		local vx = planetInfo[3]

		gohelper.setActive(vx, true)
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_confirm)
end

function VersionActivity1_3AstrologyPlateView:_hideAdjustEffect()
	for k, planetInfo in pairs(self._planetList) do
		local vx = planetInfo[3]

		gohelper.setActive(vx, false)
	end
end

function VersionActivity1_3AstrologyPlateView:_selectPlanetItem(item)
	self._selectedItem = item
	self._planetMo = self._selectedItem:getPlanetMo()

	self:_updateBtnStatus()
	self:_updateSelectedFlag()
	self:_showRotateEffect()
end

function VersionActivity1_3AstrologyPlateView:_updateSelectedFlag()
	if self._selectedItem then
		local id = self._selectedItem:getId()

		self:_updateSelectedFlagById(self._selectedItem)
	end
end

function VersionActivity1_3AstrologyPlateView:_updateSelectedFlagById(id)
	for k, v in pairs(self._planetList) do
		gohelper.setActive(v[2], k == id)
	end
end

function VersionActivity1_3AstrologyPlateView:_updateBtnStatus()
	if not self._planetMo then
		return
	end

	local num = self._planetMo.num
	local showLeft = num > 0
	local showRight = num > 0
	local remainNum = self._planetMo:getRemainNum()

	if num > 0 and num < 3 and remainNum == 0 then
		local minDeltaAngle = self._planetMo:minDeltaAngle()
		local previewAngle = self._planetMo.previewAngle % 360
		local originalAngle = self._planetMo.angle % 360

		showRight = (previewAngle - minDeltaAngle) % 360 == originalAngle
		showLeft = not showRight
	end

	gohelper.setActive(self._goleftbtn, showLeft)
	gohelper.setActive(self._goleftbtndisable, not showLeft)
	gohelper.setActive(self._gorightbtn, showRight)
	gohelper.setActive(self._gorightbtndisable, not showRight)
end

function VersionActivity1_3AstrologyPlateView:_onScreenSizeChange()
	self._modelCamera.fieldOfView = self:calcFOV(48)
end

function VersionActivity1_3AstrologyPlateView:_initPlanets()
	self._planetList = self:getUserDataTb_()

	for name, v in pairs(VersionActivity1_3AstrologyEnum.Planet) do
		local go = self["_go" .. name]
		local goSelected = gohelper.findChild(go, "go_selected")
		local vx = gohelper.findChild(go, "vx")
		local t = self:getUserDataTb_()

		t[1] = go.transform
		t[2] = goSelected
		t[3] = vx
		self._planetList[v] = t
	end
end

function VersionActivity1_3AstrologyPlateView:_initPlanetsAngles()
	for id = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(id)

		self:_rotateAround(id, -90 + mo.angle)
	end
end

function VersionActivity1_3AstrologyPlateView:_initModel()
	local cameraGo = gohelper.findChild(self._gomodel, "cam")

	self._modelCamera = cameraGo:GetComponent("Camera")
	self._modelPlanetList = self:getUserDataTb_()
	self._modelPlanetPosList = self:getUserDataTb_()
	self._modelPlanetRotationList = self:getUserDataTb_()

	for name, v in pairs(VersionActivity1_3AstrologyEnum.Planet) do
		self:_addPlanet(v, name)
	end
end

function VersionActivity1_3AstrologyPlateView:_addPlanet(type, name)
	local planetGo = gohelper.findChild(self._gomodel, "zhanxingpan/xingqiu/" .. name)
	local transform = planetGo.transform

	self._modelPlanetList[type] = transform
	self._modelPlanetPosList[type] = transform.position

	local x, y, z = transformhelper.getLocalRotation(transform)

	self._modelPlanetRotationList[type] = {
		x,
		y,
		z
	}
end

function VersionActivity1_3AstrologyPlateView:onClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AstrologyDelayShowReply")

	for k, tweenInfo in pairs(self._tweenList) do
		if tweenInfo.tweenId then
			ZProj.TweenHelper.KillById(tweenInfo.tweenId)

			tweenInfo.tweenId = nil
		end
	end

	TaskDispatcher.cancelTask(self._delayShowReply, self)
	TaskDispatcher.cancelTask(self._delaySwitch, self)
	TaskDispatcher.cancelTask(self._delayShowTip, self)
end

function VersionActivity1_3AstrologyPlateView:onDestroyView()
	self._simagePlate:UnLoadImage()
end

return VersionActivity1_3AstrologyPlateView
