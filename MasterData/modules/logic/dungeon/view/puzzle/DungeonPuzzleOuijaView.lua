-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleOuijaView.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleOuijaView", package.seeall)

local DungeonPuzzleOuijaView = class("DungeonPuzzleOuijaView", BaseView)

function DungeonPuzzleOuijaView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gosplinters = gohelper.findChild(self.viewGO, "#go_splinters")
	self._simagesplinter1 = gohelper.findChildSingleImage(self.viewGO, "#go_splinters/#simage_splinter1")
	self._simagesplinter2 = gohelper.findChildSingleImage(self.viewGO, "#go_splinters/#simage_splinter2")
	self._simagesplinter3 = gohelper.findChildSingleImage(self.viewGO, "#go_splinters/#simage_splinter3")
	self._goprogressbg = gohelper.findChild(self.viewGO, "#go_progressbg")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "#go_progressbg/#image_progress")
	self._goguide = gohelper.findChild(self.viewGO, "#go_guide")
	self._gotip = gohelper.findChild(self.viewGO, "#go_tip")
	self._gohoriRotate = gohelper.findChild(self.viewGO, "#go_tip/#go_horiRotate")
	self._govertiRotate = gohelper.findChild(self.viewGO, "#go_tip/#go_vertiRotate")
	self._gorotatearea = gohelper.findChild(self.viewGO, "#go_rotatearea")
	self._gorotateSplinter = gohelper.findChild(self.viewGO, "#go_rotatesplinter")
	self._simagewholeboat = gohelper.findChildSingleImage(self.viewGO, "#simage_wholeboat")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonPuzzleOuijaView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._rotateSlide:AddDragBeginListener(self._onRotateBegin, self)
	self._rotateSlide:AddDragListener(self._onRotate, self)
	self._rotateSlide:AddDragEndListener(self._onRotateEnd, self)
	self._btnrotatearea:AddClickListener(self._onClickRotateArea, self)
end

function DungeonPuzzleOuijaView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._rotateSlide:RemoveDragBeginListener()
	self._rotateSlide:RemoveDragListener()
	self._rotateSlide:RemoveDragEndListener()
	self._btnrotatearea:RemoveClickListener()
end

function DungeonPuzzleOuijaView:_editableInitView()
	self._firstClickView = true
	self._firstEnterView = true

	self._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("bg"))
	self._simagesplinter1:LoadImage(ResUrl.getDungeonPuzzleBg("suipian_1"))
	self._simagesplinter2:LoadImage(ResUrl.getDungeonPuzzleBg("suipian_2"))
	self._simagesplinter3:LoadImage(ResUrl.getDungeonPuzzleBg("suipian_3"))
	self._simagewholeboat:LoadImage(ResUrl.getDungeonPuzzleBg("img_boat"))

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goGlow = gohelper.findChild(self.viewGO, "glow")
	self._goGlowPro = gohelper.findChild(self.viewGO, "glow/jidutiao")
	self._glowCanvas = self._goGlow:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._btnrotatearea = gohelper.getClickWithAudio(self._gorotatearea)
	self._rotateSlide = SLFramework.UGUI.UIDragListener.Get(self._gorotatearea)
	self._beginTime = 0

	self:_getSplinterTrans()
end

function DungeonPuzzleOuijaView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		self:_resetGame()
	end)
end

function DungeonPuzzleOuijaView:_onClickRotateArea()
	if self._firstClickView then
		self._anim.enabled = false

		gohelper.setActive(self._goguide, false)
		gohelper.setActive(self._btnreset.gameObject, true)
		gohelper.setActive(self._gotip, false)
		gohelper.setActive(self._goGlow, true)

		self._glowCanvas.alpha = 0
		self._firstClickView = false
	end
end

function DungeonPuzzleOuijaView:_onRotateBegin(param, pointerEventData)
	self:_onClickRotateArea()

	if self._beginTime == 0 then
		self._beginTime = os.time()
	end
end

function DungeonPuzzleOuijaView:_onRotate(param, pointerEventData)
	local delta = pointerEventData.delta

	self._moveX = Mathf.Clamp(delta.x, -5, 5)
	self._moveY = Mathf.Clamp(delta.y, -5, 5)

	local rx, ry, rz = transformhelper.getLocalRotation(self._gorotateSplinter.transform)
	local curYRotate = ry + self._moveX * self._rotateSpeed
	local curZRotate = rz + self._moveY * self._rotateSpeed

	self._gorotateSplinter.transform.rotation = Quaternion.Euler(0, curYRotate, curZRotate)

	self:_refreshUI()
	self:_setSplinterPos()
end

function DungeonPuzzleOuijaView:_onRotateEnd(param, pointerEventData)
	return
end

function DungeonPuzzleOuijaView:_getSplinterPosRate()
	return
end

function DungeonPuzzleOuijaView:_getSplinterTrans()
	self._splinter1PosX, self._splinter1PosY = recthelper.getAnchor(self._simagesplinter1.gameObject.transform)
	self._splinter2PosX, self._splinter2PosY = recthelper.getAnchor(self._simagesplinter2.gameObject.transform)
	self._splinter3PosX, self._splinter3PosY = recthelper.getAnchor(self._simagesplinter3.gameObject.transform)
	self._splinterRotY = 0
	self._splinterRotZ = 0
	self._splinter2RotY = 0
	self._splinter2RotZ = 0
	self._splinter3RotY = 0
	self._splinter3RotZ = 0
end

function DungeonPuzzleOuijaView:_setSplinterPos()
	local rx, ry, rz = transformhelper.getLocalRotation(self._gorotateSplinter.transform)

	if self._moveX ~= 0 then
		if ry >= 0 and ry <= 90 then
			self._splinter1PosX = Mathf.Lerp(self.splinterInfoTab[1].pointTab[1].points[1], self.splinterInfoTab[1].pointTab[2].points[1], ry / 90)
			self._splinter2PosX = Mathf.Lerp(self.splinterInfoTab[3].pointTab[1].points[1], self.splinterInfoTab[3].pointTab[2].points[1], ry / 90)
			self._splinter2PosY = Mathf.Lerp(self.splinterInfoTab[3].pointTab[1].points[2], self.splinterInfoTab[3].pointTab[2].points[2], ry / 90)
			self._splinter3PosX = Mathf.Lerp(self.splinterInfoTab[5].pointTab[1].points[1], self.splinterInfoTab[5].pointTab[2].points[1], ry / 90)
			self._splinter3PosY = Mathf.Lerp(self.splinterInfoTab[5].pointTab[1].points[2], self.splinterInfoTab[5].pointTab[2].points[2], ry / 90)
		elseif ry > 90 and ry <= 180 then
			self._splinter1PosX = Mathf.Lerp(self.splinterInfoTab[1].pointTab[2].points[1], self.splinterInfoTab[1].pointTab[3].points[1], (ry - 90) / 90)
			self._splinter2PosX = Mathf.Lerp(self.splinterInfoTab[3].pointTab[2].points[1], self.splinterInfoTab[3].pointTab[3].points[1], (ry - 90) / 90)
			self._splinter2PosY = Mathf.Lerp(self.splinterInfoTab[3].pointTab[2].points[2], self.splinterInfoTab[3].pointTab[3].points[2], (ry - 90) / 90)
			self._splinter3PosX = Mathf.Lerp(self.splinterInfoTab[5].pointTab[2].points[1], self.splinterInfoTab[5].pointTab[3].points[1], (ry - 90) / 90)
			self._splinter3PosY = Mathf.Lerp(self.splinterInfoTab[5].pointTab[2].points[2], self.splinterInfoTab[5].pointTab[3].points[2], (ry - 90) / 90)
		elseif ry > 180 and ry <= 270 then
			self._splinter1PosX = Mathf.Lerp(self.splinterInfoTab[1].pointTab[3].points[1], self.splinterInfoTab[1].pointTab[4].points[1], (ry - 180) / 90)
			self._splinter2PosX = Mathf.Lerp(self.splinterInfoTab[3].pointTab[3].points[1], self.splinterInfoTab[3].pointTab[4].points[1], (ry - 180) / 90)
			self._splinter2PosY = Mathf.Lerp(self.splinterInfoTab[3].pointTab[3].points[2], self.splinterInfoTab[3].pointTab[4].points[2], (ry - 180) / 90)
			self._splinter3PosX = Mathf.Lerp(self.splinterInfoTab[5].pointTab[3].points[1], self.splinterInfoTab[5].pointTab[4].points[1], (ry - 180) / 90)
			self._splinter3PosY = Mathf.Lerp(self.splinterInfoTab[5].pointTab[3].points[2], self.splinterInfoTab[5].pointTab[4].points[2], (ry - 180) / 90)
		elseif ry > 270 and ry <= 360 then
			self._splinter1PosX = Mathf.Lerp(self.splinterInfoTab[1].pointTab[4].points[1], self.splinterInfoTab[1].pointTab[1].points[1], (ry - 270) / 90)
			self._splinter2PosX = Mathf.Lerp(self.splinterInfoTab[3].pointTab[4].points[1], self.splinterInfoTab[3].pointTab[1].points[1], (ry - 270) / 90)
			self._splinter2PosY = Mathf.Lerp(self.splinterInfoTab[3].pointTab[4].points[2], self.splinterInfoTab[3].pointTab[1].points[2], (ry - 270) / 90)
			self._splinter3PosX = Mathf.Lerp(self.splinterInfoTab[5].pointTab[4].points[1], self.splinterInfoTab[5].pointTab[1].points[1], (ry - 270) / 90)
			self._splinter3PosY = Mathf.Lerp(self.splinterInfoTab[5].pointTab[4].points[2], self.splinterInfoTab[5].pointTab[1].points[2], (ry - 270) / 90)
		end
	end

	if self._moveY ~= 0 then
		if rz >= 0 and rz <= 90 then
			self._splinter1PosY = Mathf.Lerp(self.splinterInfoTab[2].pointTab[1].points[2], self.splinterInfoTab[2].pointTab[2].points[2], rz / 90)
			self._splinterRotZ = Mathf.Lerp(self.splinterInfoTab[9].pointTab[1].points[1], self.splinterInfoTab[9].pointTab[2].points[1], rz / 90)
			self._splinter2RotZ = Mathf.Lerp(self.splinterInfoTab[10].pointTab[1].points[1], self.splinterInfoTab[10].pointTab[2].points[1], rz / 90)
			self._splinter3RotZ = Mathf.Lerp(self.splinterInfoTab[11].pointTab[1].points[1], self.splinterInfoTab[11].pointTab[2].points[1], rz / 90)
		elseif rz > 90 and rz <= 180 then
			self._splinter1PosY = Mathf.Lerp(self.splinterInfoTab[2].pointTab[2].points[2], self.splinterInfoTab[2].pointTab[3].points[2], (rz - 90) / 90)
			self._splinterRotZ = Mathf.Lerp(self.splinterInfoTab[9].pointTab[2].points[1], self.splinterInfoTab[9].pointTab[3].points[1], (rz - 90) / 90)
			self._splinter2RotZ = Mathf.Lerp(self.splinterInfoTab[10].pointTab[2].points[1], self.splinterInfoTab[10].pointTab[3].points[1], (rz - 90) / 90)
			self._splinter3RotZ = Mathf.Lerp(self.splinterInfoTab[11].pointTab[2].points[1], self.splinterInfoTab[11].pointTab[3].points[1], (rz - 90) / 90)
		elseif rz > 180 and rz <= 270 then
			self._splinter1PosY = Mathf.Lerp(self.splinterInfoTab[2].pointTab[3].points[2], self.splinterInfoTab[2].pointTab[4].points[2], (rz - 180) / 90)
			self._splinterRotZ = Mathf.Lerp(self.splinterInfoTab[9].pointTab[3].points[1], self.splinterInfoTab[9].pointTab[4].points[1], (rz - 180) / 90)
			self._splinter2RotZ = Mathf.Lerp(self.splinterInfoTab[10].pointTab[3].points[1], self.splinterInfoTab[10].pointTab[4].points[1], (rz - 180) / 90)
			self._splinter3RotZ = Mathf.Lerp(self.splinterInfoTab[11].pointTab[3].points[1], self.splinterInfoTab[11].pointTab[4].points[1], (rz - 180) / 90)
		elseif rz > 270 and rz <= 360 then
			self._splinter1PosY = Mathf.Lerp(self.splinterInfoTab[2].pointTab[4].points[2], self.splinterInfoTab[2].pointTab[1].points[2], (rz - 270) / 90)
			self._splinterRotZ = Mathf.Lerp(self.splinterInfoTab[9].pointTab[4].points[1], self.splinterInfoTab[9].pointTab[1].points[1], (rz - 270) / 90)
			self._splinter2RotZ = Mathf.Lerp(self.splinterInfoTab[10].pointTab[4].points[1], self.splinterInfoTab[10].pointTab[1].points[1], (rz - 270) / 90)
			self._splinter3RotZ = Mathf.Lerp(self.splinterInfoTab[11].pointTab[4].points[1], self.splinterInfoTab[11].pointTab[1].points[1], (rz - 270) / 90)
		end
	end

	recthelper.setAnchor(self._simagesplinter1.gameObject.transform, self._splinter1PosX, self._splinter1PosY)
	recthelper.setAnchor(self._simagesplinter2.gameObject.transform, self._splinter2PosX, self._splinter2PosY)
	recthelper.setAnchor(self._simagesplinter3.gameObject.transform, self._splinter3PosX, self._splinter3PosY)

	self._simagesplinter1.gameObject.transform.rotation = Quaternion.Euler(0, self._splinterRotY, self._splinterRotZ)
	self._simagesplinter2.gameObject.transform.rotation = Quaternion.Euler(0, self._splinter2RotY, self._splinter2RotZ)
	self._simagesplinter3.gameObject.transform.rotation = Quaternion.Euler(0, self._splinter3RotY, self._splinter3RotZ)
end

function DungeonPuzzleOuijaView:onUpdateParam()
	return
end

function DungeonPuzzleOuijaView:onOpen()
	self._proWidth = recthelper.getWidth(self._imageprogress.gameObject.transform)
	self._glowProWidth = recthelper.getWidth(self._goGlowPro.transform)

	self:_initData()
end

function DungeonPuzzleOuijaView:_resetGame()
	self:_cleanData()
	self:_initData()
end

function DungeonPuzzleOuijaView:_initData()
	gohelper.setActive(self._goguide, false)
	gohelper.setActive(self._gorotatearea, false)
	gohelper.setActive(self._btnreset.gameObject, false)

	self._glowCanvas.alpha = 0

	if self._firstEnterView then
		self._anim:Play(UIAnimationName.Open, 0, 0)
		TaskDispatcher.runDelay(self._showGuideTip, self, 2.167)

		self._firstEnterView = false
	else
		self:_showGuideTip()
	end

	self:_initConfig()

	self._rotateSpeed = self.splinterInfoTab[8].pointTab[1].points[1]
	self._hFinishRate = 0
	self._vFinishRate = 0
	self._initRotateY = tonumber(self.splinterInfoTab[7].pointTab[1].points[1])
	self._initRotateZ = tonumber(self.splinterInfoTab[7].pointTab[1].points[2])
	self._gorotateSplinter.transform.rotation = Quaternion.Euler(0, self._initRotateY, self._initRotateZ)

	self:_setSplinterPos()
	self:_refreshUI()
end

function DungeonPuzzleOuijaView:_showGuideTip()
	AudioMgr.instance:trigger(AudioEnum.PuzzleOuija.play_ui_checkpoint_boat_tips)
	gohelper.setActive(self._goguide, true)
	TaskDispatcher.runDelay(self._canOperate, self, 1)
end

function DungeonPuzzleOuijaView:_canOperate()
	gohelper.setActive(self._gorotatearea, true)
end

function DungeonPuzzleOuijaView:_initConfig()
	self._elementConfig = lua_chapter_map_element.configDict[self.viewParam.id]

	local splinterInfoTabStr = string.split(self._elementConfig.param, "|")

	self.splinterInfoTab = {}

	for k, info in ipairs(splinterInfoTabStr) do
		self.splinterInfoTab[k] = {}
		self.splinterInfoTab[k].pointTab = string.split(info, "#")

		for index, point in ipairs(self.splinterInfoTab[k].pointTab) do
			self.splinterInfoTab[k].pointTab[index] = {}
			self.splinterInfoTab[k].pointTab[index].points = string.split(point, ",")
		end
	end
end

function DungeonPuzzleOuijaView:_refreshUI()
	local finishPro = self:_setFinshRate()

	self:_setGlowEffect(finishPro)
	recthelper.setWidth(self._imageprogress.gameObject.transform, finishPro * self._proWidth)
	recthelper.setWidth(self._goGlowPro.transform, finishPro * self._glowProWidth)

	if finishPro == 1 then
		self:_setFinishState()
		AudioMgr.instance:trigger(AudioEnum.PuzzleOuija.play_ui_checkpoint_boat_connection)
	end
end

function DungeonPuzzleOuijaView:_setGlowEffect(progress)
	self._glowCanvas.alpha = progress >= 0.8 and progress <= 0.9 and Mathf.Lerp(0, 0.5, (progress - 0.8) * 10) or progress > 0.9 and progress <= 1 and Mathf.Lerp(0.5, 1, (progress - 0.9) * 10) or 0
end

function DungeonPuzzleOuijaView:_setFinshRate()
	local rx, ry, rz = transformhelper.getLocalRotation(self._gorotateSplinter.transform)

	self._hFinishRate = self:_getFinishRate(ry, 5, self._initRotateY)
	self._vFinishRate = self:_getFinishRate(rz, 5, self._initRotateZ)

	return self._hFinishRate / 2 + self._vFinishRate / 2
end

function DungeonPuzzleOuijaView:_getFinishRate(curRotate, offsetRotate, initRotate)
	if curRotate < 180 and curRotate - offsetRotate <= 0 then
		return 1
	elseif curRotate > 180 and 360 - curRotate - offsetRotate <= 0 then
		return 1
	elseif initRotate < curRotate then
		return (curRotate - initRotate) / (360 - initRotate - offsetRotate)
	else
		return (initRotate - curRotate) / (initRotate - offsetRotate)
	end
end

function DungeonPuzzleOuijaView:_showRotateTipIcon()
	local nowTime = os.time()

	if nowTime - self._beginTime < 60 then
		return
	end

	gohelper.setActive(self._gotip, true)

	if Mathf.Abs(self._hFinishRate / 2 - 0.5) > 0 then
		gohelper.setActive(self._gohoriRotate, true)
		gohelper.setActive(self._govertiRotate, false)
	elseif Mathf.Abs(self._vFinishRate / 2 - 0.5) > 0 then
		gohelper.setActive(self._gohoriRotate, false)
		gohelper.setActive(self._govertiRotate, true)
	else
		gohelper.setActive(self._gohoriRotate, false)
		gohelper.setActive(self._govertiRotate, false)
	end
end

function DungeonPuzzleOuijaView:_setFinishState()
	gohelper.setActive(self._gorotatearea, false)
	gohelper.setActive(self._btnreset.gameObject, false)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageprogress, "#d9a06f")

	self._anim.enabled = true

	self._anim:Play("finish", 0, 0)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)
	DungeonRpc.instance:sendPuzzleFinishRequest(self.viewParam.id)
end

function DungeonPuzzleOuijaView:_cleanData()
	TaskDispatcher.cancelTask(self._showGuideTip, self)
	TaskDispatcher.cancelTask(self._canOperate, self)

	self._firstClickView = true
	self._anim.enabled = true
end

function DungeonPuzzleOuijaView:onClose()
	TaskDispatcher.cancelTask(self._showGuideTip, self)
	TaskDispatcher.cancelTask(self._canOperate, self)
end

function DungeonPuzzleOuijaView:onCloseFinish()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, self.viewParam.id)
end

function DungeonPuzzleOuijaView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagesplinter1:UnLoadImage()
	self._simagesplinter2:UnLoadImage()
	self._simagesplinter3:UnLoadImage()
	self._simagewholeboat:UnLoadImage()
end

return DungeonPuzzleOuijaView
