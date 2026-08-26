-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoGameView.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoGameView", package.seeall)

local FeiLinShiDuoGameView = class("FeiLinShiDuoGameView", BaseView)

function FeiLinShiDuoGameView:onInitView()
	self._imagecolorBg = gohelper.findChildImage(self.viewGO, "bg/#image_colorBg")
	self._simageDec = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_Dec")
	self._goscene = gohelper.findChild(self.viewGO, "bg/#go_scene")
	self._btnmoveLeft = gohelper.findChildButton(self.viewGO, "#btn_moveLeft")
	self._btnmoveRight = gohelper.findChildButton(self.viewGO, "#btn_moveRight")
	self._btnoption = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_option", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	self._gocanOption = gohelper.findChild(self.viewGO, "#btn_option/#go_canOption")
	self._gonotOption = gohelper.findChild(self.viewGO, "#btn_option/#go_notOption")
	self._gocolorPlane = gohelper.findChild(self.viewGO, "#go_colorPlane")
	self._btncolor1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_colorPlane/#btn_color1", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	self._gocolor1selected = gohelper.findChild(self.viewGO, "#go_colorPlane/#btn_color1/#go_color1selected")
	self._btncolor2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_colorPlane/#btn_color2", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	self._gocolor2selected = gohelper.findChild(self.viewGO, "#go_colorPlane/#btn_color2/#go_color2selected")
	self._btncolor3 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_colorPlane/#btn_color3", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	self._gocolor3selected = gohelper.findChild(self.viewGO, "#go_colorPlane/#btn_color3/#go_color3selected")
	self._btncolor4 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_colorPlane/#btn_color4", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	self._gocolor4selected = gohelper.findChild(self.viewGO, "#go_colorPlane/#btn_color4/#go_color4selected")
	self._btnchangColor = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_changColor", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	self._gonormalIcon = gohelper.findChild(self.viewGO, "#btn_changColor/#go_normalIcon")
	self._goblindnessIcon = gohelper.findChild(self.viewGO, "#btn_changColor/#go_blindnessIcon")
	self._btnclosePlane = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closePlane")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Reset", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	self._toggleBlindness = gohelper.findChildToggle(self.viewGO, "#toggle_Blindness")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._optionAnimPlayer = SLFramework.AnimatorPlayer.Get(self._btnoption.gameObject)
	self._optionAnim = self._btnoption.gameObject:GetComponent(gohelper.Type_Animator)
	self._changeColorAnimPlayer = SLFramework.AnimatorPlayer.Get(self._btnchangColor.gameObject)
	self._changeColorAnim = self._btnchangColor.gameObject:GetComponent(gohelper.Type_Animator)
	self._colorPlaneAnimPlayer = SLFramework.AnimatorPlayer.Get(self._gocolorPlane)
	self._colorPlaneAnim = self._gocolorPlane:GetComponent(gohelper.Type_Animator)
	self._godeadEffect = gohelper.findChild(self.viewGO, "vx_dead")
	self._vxMaskAnim = gohelper.findChild(self.viewGO, "bg/vx_mask"):GetComponent(gohelper.Type_Animator)
	self._btnMoveLeftAnim = self._btnmoveLeft.gameObject:GetComponent(gohelper.Type_Animator)
	self._btnMoveRightAnim = self._btnmoveRight.gameObject:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FeiLinShiDuoGameView:addEvents()
	self._btnoption:AddClickListener(self._btnoptionOnClick, self)
	self._btncolor1:AddClickListener(self._btncolor1OnClick, self)
	self._btncolor2:AddClickListener(self._btncolor2OnClick, self)
	self._btncolor3:AddClickListener(self._btncolor3OnClick, self)
	self._btncolor4:AddClickListener(self._btncolor4OnClick, self)
	self._btnchangColor:AddClickListener(self._btnchangColorOnClick, self)
	self._btnclosePlane:AddClickListener(self._btnclosePlaneOnClick, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._toggleBlindness:AddOnValueChanged(self._toggleBlindnessOnClick, self)

	self._leftClick = SLFramework.UGUI.UIClickListener.Get(self._btnmoveLeft.gameObject)

	self._leftClick:AddClickDownListener(self._onLeftClickDown, self)
	self._leftClick:AddClickUpListener(self._onLeftClickUp, self)

	self._rightClick = SLFramework.UGUI.UIClickListener.Get(self._btnmoveRight.gameObject)

	self._rightClick:AddClickDownListener(self._onRightClickDown, self)
	self._rightClick:AddClickUpListener(self._onRightClickUp, self)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.playerChangeAnim, self.refreshChangeColorUI, self)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.ResultResetGame, self.resetGame, self)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.OnClickGuideRightMoveUpBtn, self._onRightClickUp, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self, LuaEventSystem.Low)
end

function FeiLinShiDuoGameView:removeEvents()
	self._btnoption:RemoveClickListener()
	self._btncolor1:RemoveClickListener()
	self._btncolor2:RemoveClickListener()
	self._btncolor3:RemoveClickListener()
	self._btncolor4:RemoveClickListener()
	self._btnchangColor:RemoveClickListener()
	self._btnclosePlane:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._toggleBlindness:RemoveOnValueChanged()
	self._leftClick:RemoveClickDownListener()
	self._leftClick:RemoveClickUpListener()
	self._rightClick:RemoveClickDownListener()
	self._rightClick:RemoveClickUpListener()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.playerChangeAnim, self.refreshChangeColorUI, self)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.ResultResetGame, self.resetGame, self)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.OnClickGuideRightMoveUpBtn, self._onRightClickUp, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function FeiLinShiDuoGameView:_btnResetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.FeiLinShiDuoResetTip, MsgBoxEnum.BoxType.Yes_No, self.resetGame, nil, nil, self)
end

function FeiLinShiDuoGameView:_btncolor1OnClick()
	local changeColor = FeiLinShiDuoEnum.ColorType.Red

	self:onChangeColor(changeColor)
end

function FeiLinShiDuoGameView:_btncolor2OnClick()
	local changeColor = FeiLinShiDuoEnum.ColorType.Green

	self:onChangeColor(changeColor)
end

function FeiLinShiDuoGameView:_btncolor3OnClick()
	local changeColor = FeiLinShiDuoEnum.ColorType.Blue

	self:onChangeColor(changeColor)
end

function FeiLinShiDuoGameView:_btncolor4OnClick()
	local changeColor = FeiLinShiDuoEnum.ColorType.Yellow

	self:onChangeColor(changeColor)
end

function FeiLinShiDuoGameView:_btnclosePlaneOnClick()
	local color = FeiLinShiDuoGameModel.instance:getCurColor()
	local isBlindnessMode = FeiLinShiDuoGameModel.instance:getBlindnessModeState()

	if not isBlindnessMode and color == FeiLinShiDuoEnum.ColorType.Yellow then
		color = FeiLinShiDuoEnum.ColorType.Red
	elseif isBlindnessMode and color == FeiLinShiDuoEnum.ColorType.Red then
		color = FeiLinShiDuoEnum.ColorType.Yellow
	end

	self:onChangeColor(color)
end

function FeiLinShiDuoGameView:_toggleBlindnessOnClick(param, isOn)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	FeiLinShiDuoGameModel.instance:setBlindnessModeState(isOn)

	local saveValue = isOn and 1 or 0

	GameUtil.playerPrefsSetNumberByUserId(FeiLinShiDuoEnum.BlindnessModeKey, saveValue)
	self:refreshBlindnessModeUI()
end

function FeiLinShiDuoGameView:_onLeftClickDown()
	if self.playerComp then
		self.playerComp:setUIClickLeftDown()
		self:leftClickDown()
	end
end

function FeiLinShiDuoGameView:leftClickDown()
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	ZProj.UGUIHelper.SetColorAlpha(self.imageMoveLeftBtn, 1)
	ZProj.UGUIHelper.SetColorAlpha(self.imageMoveRightBtn, 0.5)
end

function FeiLinShiDuoGameView:_onLeftClickUp()
	if self.playerComp then
		self.playerComp:setUIClickLeftUp()
		self:leftClickUp()
	end
end

function FeiLinShiDuoGameView:leftClickUp()
	ZProj.UGUIHelper.SetColorAlpha(self.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(self.imageMoveRightBtn, 0.5)
end

function FeiLinShiDuoGameView:_onRightClickDown()
	if self.playerComp then
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.OnClickGuideRightMoveBtn)
		self.playerComp:setUIClickRightDown()
		self:rightClickDown()
	end
end

function FeiLinShiDuoGameView:rightClickDown()
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	ZProj.UGUIHelper.SetColorAlpha(self.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(self.imageMoveRightBtn, 1)
end

function FeiLinShiDuoGameView:_onRightClickUp()
	if self.playerComp then
		self.playerComp:setUIClickRightUp()
		self:rightClickUp()
	end
end

function FeiLinShiDuoGameView:rightClickUp()
	ZProj.UGUIHelper.SetColorAlpha(self.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(self.imageMoveRightBtn, 0.5)
end

function FeiLinShiDuoGameView:_btnoptionOnClick()
	if self.playerComp and not self.isOptionBtnAniming then
		self.playerComp:startClimbStairs()
	end
end

function FeiLinShiDuoGameView:_btnchangColorOnClick()
	if not self.playerCurIdleState or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper) or self.isColorBtnAniming then
		return
	end

	self._changeColorAnimPlayer:Play("out", self.closeChangeColorBtnFinish, self)

	self.isColorBtnAniming = true
	self._colorPlaneAnim.enabled = true
	self.isOpenColorPlane = true

	gohelper.setActive(self._gocolorPlane, true)
	gohelper.setActive(self._btnclosePlane.gameObject, true)
	self._btnMoveLeftAnim:Play("out", 0, 0)
	self._btnMoveRightAnim:Play("out", 0, 0)

	if self._btnoption.gameObject.activeSelf then
		self._optionAnimPlayer:Play("out", self.playOptionAnimFinish, self)
	end

	FeiLinShiDuoGameModel.instance:setIsPlayerInColorChanging(true)

	local elementMap = FeiLinShiDuoGameModel.instance:getInterElementMap()
	local elementGOMap = self.sceneview:getElementGOMap()

	if not elementMap or not elementGOMap then
		logError("获取不到场景的元件物体，请检查")

		return
	end

	for _, mapItem in pairs(elementMap) do
		gohelper.setActive(elementGOMap[mapItem.id].elementGO, true)
	end

	local curMouseColor = FeiLinShiDuoGameModel.instance:getCurColor() or FeiLinShiDuoEnum.ColorType.None

	for i = 1, 4 do
		gohelper.setActive(self["_gocolor" .. i .. "selected"], false)

		if curMouseColor == FeiLinShiDuoEnum.ColorType.Red or curMouseColor == FeiLinShiDuoEnum.ColorType.Yellow then
			ZProj.UGUIHelper.SetColorAlpha(self.colorPlaneImageMap[i], (i == FeiLinShiDuoEnum.ColorType.Red or i == FeiLinShiDuoEnum.ColorType.Yellow) and 1 or 0.3)
		else
			ZProj.UGUIHelper.SetColorAlpha(self.colorPlaneImageMap[i], i == curMouseColor and 1 or 0.3)
		end
	end

	FeiLinShiDuoGameModel.instance:showAllElementState()
	self._vxMaskAnim:Play("in", 0, 0)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.changePlayerColor, FeiLinShiDuoEnum.ColorType.None)
end

function FeiLinShiDuoGameView:closeChangeColorBtnFinish()
	gohelper.setActive(self._btnchangColor.gameObject, false)

	self.isColorBtnAniming = false
end

function FeiLinShiDuoGameView:_editableInitView()
	gohelper.setActive(self._btnoption.gameObject, false)
	gohelper.setActive(self._btnchangColor.gameObject, true)
	gohelper.setActive(self._gocolorPlane, false)
	gohelper.setActive(self._btnclosePlane.gameObject, false)

	self.canShowOption = false
	self.canDoOption = false
	self.playerCurIdleState = true
	self.normalColorCanvasGroup = self._gonormalIcon:GetComponent(gohelper.Type_CanvasGroup)
	self.blindnessColorCanvasGroup = self._goblindnessIcon:GetComponent(gohelper.Type_CanvasGroup)
	self.imageMoveLeftBtn = gohelper.findChildImage(self.viewGO, "#btn_moveLeft/icon")
	self.imageMoveRightBtn = gohelper.findChildImage(self.viewGO, "#btn_moveRight/icon")
	self.normalColorCanvasGroup.alpha = 1
	self.blindnessColorCanvasGroup.alpha = 1

	ZProj.UGUIHelper.SetColorAlpha(self.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(self.imageMoveRightBtn, 0.5)

	for i = 1, 4 do
		gohelper.setActive(self["_gocolor" .. i .. "selected"], false)
	end

	FeiLinShiDuoGameModel.instance:setElememntShowStateByColor(FeiLinShiDuoEnum.ColorType.None)

	self.isOptionBtnAniming = false
	self.isColorBtnAniming = false

	self:initColorPlaneData()
	self:initBlindnessMode()
	FeiLinShiDuoStatHelper.instance:initGameStartTime()
	FeiLinShiDuoStatHelper.instance:initResetStartTime()
end

function FeiLinShiDuoGameView:initBlindnessMode()
	local blindnessOnValue = GameUtil.playerPrefsGetNumberByUserId(FeiLinShiDuoEnum.BlindnessModeKey, 0)
	local isBlindnessMode = blindnessOnValue == 1

	self._toggleBlindness.isOn = isBlindnessMode

	FeiLinShiDuoGameModel.instance:setBlindnessModeState(isBlindnessMode)
end

function FeiLinShiDuoGameView:initColorPlaneData()
	self.isOpenColorPlane = false

	local startPos = gohelper.findChild(self.viewGO, "#go_colorPlane/#go_startPos")
	local originPos = gohelper.findChild(self.viewGO, "#go_colorPlane/#go_originPos")

	self.originTrans = originPos.transform
	self.startPosTrans = startPos.transform
	self.startVector = Vector3(self.startPosTrans.localPosition.x - self.originTrans.localPosition.x, self.startPosTrans.localPosition.y - self.originTrans.localPosition.y, 0)
	self.colorPlaneRect = self._gocolorPlane:GetComponent(gohelper.Type_RectTransform)
	self.mouseCheckRadius = 270
	self.colorPlaneImageMap = self:getUserDataTb_()

	for i = 1, 4 do
		self.colorPlaneImageMap[i] = self["_btncolor" .. i].gameObject:GetComponent(gohelper.Type_Image)
	end
end

function FeiLinShiDuoGameView:onOpen()
	self.sceneview = self.viewContainer:getSceneView()
	self.playerComp = self.sceneview and self.sceneview:getPlayerComp()
	self.playerAnimComp = self.sceneview and self.sceneview:getPlayerAnimComp()

	self.viewContainer:setOverrideCloseClick(self.onCloseBtnClick, self)
	self:refreshUI()
	TaskDispatcher.runRepeat(self.refreshColorPlane, self, 0.1)
end

function FeiLinShiDuoGameView:refreshUI()
	self:refreshChangeColorUI()
	self:refreshBlindnessModeUI()
	self:refreshColorPlane()
end

function FeiLinShiDuoGameView:refreshChangeColorUI()
	local playerIsIdleState = FeiLinShiDuoGameModel.instance:getPlayerIsIdleState()

	if self.playerCurIdleState ~= playerIsIdleState then
		self.playerCurIdleState = playerIsIdleState
		self.normalColorCanvasGroup.alpha = self.playerCurIdleState and 1 or 0.5
		self.blindnessColorCanvasGroup.alpha = self.playerCurIdleState and 1 or 0.5
	end
end

function FeiLinShiDuoGameView:refreshBlindnessModeUI()
	local isBlindnessMode = FeiLinShiDuoGameModel.instance:getBlindnessModeState()

	self._toggleBlindness.isOn = isBlindnessMode

	gohelper.setActive(self._gonormalIcon, not isBlindnessMode)
	gohelper.setActive(self._goblindnessIcon, isBlindnessMode)
	gohelper.setActive(self._btncolor1, not isBlindnessMode)
	gohelper.setActive(self._btncolor4, isBlindnessMode)
	self.sceneview:refreshBlindnessMode()

	local curColor = FeiLinShiDuoGameModel.instance:getCurColor()

	if curColor == FeiLinShiDuoEnum.ColorType.Red or curColor == FeiLinShiDuoEnum.ColorType.Yellow then
		if isBlindnessMode then
			if not FeiLinShiDuoEnum.ColorStr[FeiLinShiDuoEnum.ColorType.Yellow] then
				local bgColor = FeiLinShiDuoEnum.ColorStr[FeiLinShiDuoEnum.ColorType.Red]

				if isBlindnessMode then
					if not FeiLinShiDuoEnum.ColorType.Yellow then
						local colorType = FeiLinShiDuoEnum.ColorType.Red

						SLFramework.UGUI.GuiHelper.SetColor(self._imagecolorBg, bgColor)
						FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.changePlayerColor, colorType)
					end
				end
			end
		end
	end

	for i = 1, 4 do
		if curColor == FeiLinShiDuoEnum.ColorType.Red or curColor == FeiLinShiDuoEnum.ColorType.Yellow then
			ZProj.UGUIHelper.SetColorAlpha(self.colorPlaneImageMap[i], (i == FeiLinShiDuoEnum.ColorType.Red or i == FeiLinShiDuoEnum.ColorType.Yellow) and 1 or 0.3)
		else
			ZProj.UGUIHelper.SetColorAlpha(self.colorPlaneImageMap[i], i == curColor and 1 or 0.3)
		end
	end
end

function FeiLinShiDuoGameView:refreshColorPlane()
	if not self.isOpenColorPlane or self.isColorBtnAniming then
		return
	end

	local uiMousePosX, uiMousePosY = recthelper.screenPosToAnchorPos2(GamepadController.instance:getMousePosition(), self.colorPlaneRect)

	self.mouseVector = Vector3(uiMousePosX - self.originTrans.localPosition.x, uiMousePosY - self.originTrans.localPosition.y, 0)

	local dot = Vector2.Dot(self.startVector, self.mouseVector)
	local length1 = Vector2.Magnitude(self.startVector)
	local length2 = Vector2.Magnitude(self.mouseVector)

	if length1 == 0 or length2 == 0 then
		return 0
	end

	local forward = Vector3.Cross(self.startVector, self.mouseVector)

	if length2 > self.mouseCheckRadius or forward.z >= 0 then
		for i = 1, 4 do
			gohelper.setActive(self["_gocolor" .. i .. "selected"], false)
		end

		return
	end

	local cos = dot / (length1 * length2)

	cos = Mathf.Clamp(cos, -1, 1)

	local angle = Mathf.Acos(cos) * Mathf.Rad2Deg
	local blindnessMode = FeiLinShiDuoGameModel.instance:getBlindnessModeState()
	local curMouseColor = FeiLinShiDuoGameModel.instance:getCurColor() or FeiLinShiDuoEnum.ColorType.None
	local hasSelectColor = false

	if angle > 120 and angle <= 180 and not blindnessMode then
		curMouseColor = FeiLinShiDuoEnum.ColorType.Red
		hasSelectColor = true
	elseif angle > 120 and angle <= 180 and blindnessMode then
		curMouseColor = FeiLinShiDuoEnum.ColorType.Yellow
		hasSelectColor = true
	elseif angle >= 0 and angle <= 60 then
		curMouseColor = FeiLinShiDuoEnum.ColorType.Green
		hasSelectColor = true
	elseif angle > 60 and angle <= 120 then
		curMouseColor = FeiLinShiDuoEnum.ColorType.Blue
		hasSelectColor = true
	end

	for i = 1, 4 do
		gohelper.setActive(self["_gocolor" .. i .. "selected"], i == curMouseColor and hasSelectColor)
		ZProj.UGUIHelper.SetColorAlpha(self.colorPlaneImageMap[i], i == curMouseColor and 1 or 0.3)
	end
end

function FeiLinShiDuoGameView:onChangeColor(color, isResetGame)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper) or self.isColorBtnAniming then
		return
	end

	self._changeColorAnim.enabled = true

	gohelper.setActive(self._btnchangColor.gameObject, true)

	if self._gocolorPlane.activeSelf then
		self.isOpenColorPlane = false

		self._colorPlaneAnimPlayer:Play("out", self.closeColorPlaneFinish, self)

		if not isResetGame then
			self._vxMaskAnim:Play("out", 0, 0)
		else
			self._vxMaskAnim:Play("idle", 0, 0)
		end

		self._btnMoveLeftAnim:Play("in", 0, 0)
		self._btnMoveRightAnim:Play("in", 0, 0)
	end

	self.isColorBtnAniming = true

	gohelper.setActive(self._btnclosePlane.gameObject, false)

	if self:checkIntersect() then
		GameFacade.showToast(ToastEnum.Act185ChangeColorWithSamePos)

		color = FeiLinShiDuoGameModel.instance:getCurColor()
	end

	FeiLinShiDuoGameModel.instance:setElememntShowStateByColor(color)

	if self.sceneview then
		self.sceneview:changeSceneColor(color)
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._imagecolorBg, FeiLinShiDuoEnum.ColorStr[color])
	FeiLinShiDuoGameModel.instance:setIsPlayerInColorChanging(false)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.changePlayerColor, color)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_scene_switch)
end

function FeiLinShiDuoGameView:closeColorPlaneFinish()
	gohelper.setActive(self._gocolorPlane, false)

	self.isColorBtnAniming = false
end

function FeiLinShiDuoGameView:checkIntersect()
	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()
	local checkElementList = {}

	if not elementMap[FeiLinShiDuoEnum.ObjectType.Box] then
		for index, item in pairs(elementMap[FeiLinShiDuoEnum.ObjectType.Box]) do
			table.insert(checkElementList, item)
		end

		for _, curItem in pairs(checkElementList) do
			for _, checkItem in pairs(checkElementList) do
				if curItem.id ~= checkItem.id and FeiLinShiDuoGameModel.instance:getElementShowState(checkItem) and FeiLinShiDuoGameModel.instance:getElementShowState(curItem) then
					local curItemCenterPosX = curItem.pos[1] + curItem.width / 2
					local checkItemCenterPosX = checkItem.pos[1] + checkItem.width / 2

					if Mathf.Abs(curItemCenterPosX - checkItemCenterPosX) < curItem.width / 2 + checkItem.width / 2 - FeiLinShiDuoEnum.touchCheckRange and Mathf.Abs(curItem.pos[2] - checkItem.pos[2]) < FeiLinShiDuoEnum.HalfSlotWidth / 4 then
						return true
					end
				end
			end
		end

		return false
	end
end

function FeiLinShiDuoGameView:showOptionState(state, ignoreAnim)
	if self.canShowOption == state then
		return
	end

	self.canShowOption = state

	if not self.canShowOption and not ignoreAnim then
		if self._btnoption.gameObject.activeSelf then
			self._optionAnimPlayer:Play("out", self.playOptionAnimFinish, self)
		end

		self.isOptionBtnAniming = true
	else
		self._optionAnim.enabled = true

		gohelper.setActive(self._btnoption.gameObject, state)

		self.isOptionBtnAniming = false
	end
end

function FeiLinShiDuoGameView:playOptionAnimFinish()
	self.isOptionBtnAniming = false
	self.canShowOption = false

	gohelper.setActive(self._btnoption.gameObject, false)
end

function FeiLinShiDuoGameView:showOptionCanDoState(state)
	if self.canDoOption == state then
		return
	end

	self.canDoOption = state

	gohelper.setActive(self._gocanOption, self.canDoOption)
	gohelper.setActive(self._gonotOption, not self.canDoOption)
end

function FeiLinShiDuoGameView:resetGame()
	self:showOptionState(false, true)

	local changeColor = FeiLinShiDuoEnum.ColorType.None

	FeiLinShiDuoGameModel.instance:showAllElementState()

	if self.sceneview then
		local playerGO = self.sceneview:getPlayerGO()

		FeiLinShiDuoStatHelper.instance:sendResetGameMap(playerGO)
		self.sceneview:resetData()
	end

	self:onChangeColor(changeColor, true)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.resetGame)

	self.canDoOption = false
	self.playerCurIdleState = true
	self.isOptionBtnAniming = false
	self.isColorBtnAniming = false
	self.isOpenColorPlane = false

	self._btnMoveLeftAnim:Play("idle", 0, 0)
	self._btnMoveRightAnim:Play("idle", 0, 0)
end

function FeiLinShiDuoGameView:onCloseBtnClick()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper) then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.FeiLinShiDuoQuitGameTip, MsgBoxEnum.BoxType.Yes_No, self.openGameResultView, nil, nil, self)
end

function FeiLinShiDuoGameView:openGameResultView()
	local param = {}

	param.isSuccess = false

	FeiLinShiDuoGameController.instance:openGameResultView(param)

	local playerGO = self.sceneview:getPlayerGO()

	FeiLinShiDuoStatHelper.instance:sendExitGameMap(playerGO)
end

function FeiLinShiDuoGameView:showDeadEffect()
	gohelper.setActive(self._godeadEffect, false)
	gohelper.setActive(self._godeadEffect, true)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_revival)
end

function FeiLinShiDuoGameView:onCloseViewFinish(viewName)
	if viewName == ViewName.GuideView then
		self:_onLeftClickUp()
		self:_onRightClickUp()
	end
end

function FeiLinShiDuoGameView:onClose()
	TaskDispatcher.cancelTask(self.refreshColorPlane, self)
end

function FeiLinShiDuoGameView:onDestroyView()
	return
end

return FeiLinShiDuoGameView
