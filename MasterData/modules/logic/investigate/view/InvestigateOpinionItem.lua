-- chunkname: @modules/logic/investigate/view/InvestigateOpinionItem.lua

module("modules.logic.investigate.view.InvestigateOpinionItem", package.seeall)

local InvestigateOpinionItem = class("InvestigateOpinionItem", ListScrollCellExtend)

function InvestigateOpinionItem:onInitView()
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._simagelock = gohelper.findChildSingleImage(self.viewGO, "#go_locked/#simage_lock")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "#go_locked/#btn_goto")
	self._btnlocktip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_locked/#btn_locktip")
	self._gounlink = gohelper.findChild(self.viewGO, "#go_unlink")
	self._simageopinionunlink = gohelper.findChildSingleImage(self.viewGO, "#go_unlink/#simage_opinionunlink")
	self._btnextendunlink = gohelper.findChildButtonWithAudio(self.viewGO, "#go_unlink/#btn_extendunlink")
	self._gounlinkextend = gohelper.findChild(self.viewGO, "#go_unlink_extend")
	self._simageopinionunlinkextend = gohelper.findChildSingleImage(self.viewGO, "#go_unlink_extend/#simage_opinionunlinkextend")
	self._txtdecunlinkextend = gohelper.findChildText(self.viewGO, "#go_unlink_extend/scroll_des/viewport/content/#txt_decunlinkextend")
	self._btncloseunlink = gohelper.findChildButtonWithAudio(self.viewGO, "#go_unlink_extend/#btn_closeunlink")
	self._golinked = gohelper.findChild(self.viewGO, "#go_linked")
	self._simageopinionlink = gohelper.findChildSingleImage(self.viewGO, "#go_linked/#simage_opinionlink")
	self._btnextendlink = gohelper.findChildButtonWithAudio(self.viewGO, "#go_linked/#btn_extendlink")
	self._golinkedextend = gohelper.findChild(self.viewGO, "#go_linked_extend")
	self._simageopinionlinkextend = gohelper.findChildSingleImage(self.viewGO, "#go_linked_extend/#simage_opinionlinkextend")
	self._txtdeclinkextend = gohelper.findChildText(self.viewGO, "#go_linked_extend/scroll_des/viewport/content/#txt_declinkextend")
	self._btncloselink = gohelper.findChildButtonWithAudio(self.viewGO, "#go_linked_extend/#btn_closelink")
	self._golineeffect = gohelper.findChild(self.viewGO, "#go_lineeffect")
	self._imageline = gohelper.findChildImage(self.viewGO, "#go_lineeffect/#image_line")
	self._imagelineup = gohelper.findChildImage(self.viewGO, "#go_lineeffect/#image_lineup")
	self._godot = gohelper.findChild(self.viewGO, "#go_lineeffect/#go_dot")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateOpinionItem:addEvents()
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btnlocktip:AddClickListener(self._btnlocktipOnClick, self)
	self._btnextendunlink:AddClickListener(self._btnextendunlinkOnClick, self)
	self._btncloseunlink:AddClickListener(self._btncloseunlinkOnClick, self)
	self._btnextendlink:AddClickListener(self._btnextendlinkOnClick, self)
	self._btncloselink:AddClickListener(self._btncloselinkOnClick, self)
end

function InvestigateOpinionItem:removeEvents()
	self._btngoto:RemoveClickListener()
	self._btnlocktip:RemoveClickListener()
	self._btnextendunlink:RemoveClickListener()
	self._btncloseunlink:RemoveClickListener()
	self._btnextendlink:RemoveClickListener()
	self._btncloselink:RemoveClickListener()
end

function InvestigateOpinionItem:_btnlocktipOnClick()
	GameFacade.showToast(ToastEnum.InvestigateTip2)
end

function InvestigateOpinionItem:_btnextendunlinkOnClick()
	gohelper.setAsLastSibling(self._opinionGo)
	self:_updateStatus(InvestigateEnum.OpinionStatus.UnlinkedExtend)
	self:_onScreenSizeChange()
	self:_hideReddot()
end

function InvestigateOpinionItem:_btnextendlinkOnClick()
	gohelper.setAsLastSibling(self._opinionGo)
	self:_updateStatus(InvestigateEnum.OpinionStatus.LinkedExtend)
	self:_onScreenSizeChange()
end

function InvestigateOpinionItem:_btncloseunlinkOnClick()
	self._btncloseunlink.button.enabled = false

	self._unlinkextendPlayer:Play(self:_getFullAnimName("close"), self._closeunlinkHandler, self)
end

function InvestigateOpinionItem:_closeunlinkHandler()
	self:_updateStatus(InvestigateEnum.OpinionStatus.Unlinked)
end

function InvestigateOpinionItem:_btncloselinkOnClick()
	self:_startFrameUpdateLine()

	self._btncloselink.button.enabled = false

	self._linkextendPlayer:Play(self:_getFullAnimName("close"), self._closelinkHandler, self)
end

function InvestigateOpinionItem:_closelinkHandler()
	TaskDispatcher.cancelTask(self._frameUpdateLine, self)
	self:_updateStatus(InvestigateEnum.OpinionStatus.Linked)
end

function InvestigateOpinionItem:_btngotoOnClick()
	if not self._mapElementConfig then
		return
	end

	local mapId = self._mapElementConfig.mapId
	local jumpStr = string.format("4#%s#1", mapId)

	JumpController.instance:jumpTo(jumpStr)
end

function InvestigateOpinionItem:_editableInitView()
	self._statusHandler = self:getUserDataTb_()
	self._statusHandler[InvestigateEnum.OpinionStatus.Locked] = self._lockHandler
	self._statusHandler[InvestigateEnum.OpinionStatus.Unlinked] = self._unlinkedHandler
	self._statusHandler[InvestigateEnum.OpinionStatus.UnlinkedExtend] = self._unlinkedExtendHandler
	self._statusHandler[InvestigateEnum.OpinionStatus.Linked] = self._linkedHandler
	self._statusHandler[InvestigateEnum.OpinionStatus.LinkedExtend] = self._linkedExtendHandler
	self._statusGoList = self:getUserDataTb_()
	self._statusGoList[InvestigateEnum.OpinionStatus.Locked] = self._golocked
	self._statusGoList[InvestigateEnum.OpinionStatus.Unlinked] = self._gounlink
	self._statusGoList[InvestigateEnum.OpinionStatus.UnlinkedExtend] = self._gounlinkextend
	self._statusGoList[InvestigateEnum.OpinionStatus.Linked] = self._golinked
	self._statusGoList[InvestigateEnum.OpinionStatus.LinkedExtend] = self._golinkedextend
	self._drag = SLFramework.UGUI.UIDragListener.Get(self.viewGO)
	self._defaultPosX = recthelper.getAnchorX(self._gounlinkextend.transform)
	self._uiRootTrans = ViewMgr.instance:getUIRoot().transform
	self._lockedAnimator = self._golocked:GetComponent("Animator")
	self._unlinkextendPlayer = ZProj.ProjAnimatorPlayer.Get(self._gounlinkextend)
	self._linkextendPlayer = ZProj.ProjAnimatorPlayer.Get(self._golinkedextend)
	self._redDotComp = RedDotController.instance:addNotEventRedDot(self._goreddot, self._isShowRedDot, self)

	local audioId = AudioEnum.VersionActivity2_2Investigate.play_ui_activity_act

	gohelper.addUIClickAudio(self._btncloselink.gameObject, audioId)
	gohelper.addUIClickAudio(self._btncloseunlink.gameObject, audioId)
	gohelper.addUIClickAudio(self._btnextendlink.gameObject, audioId)
	gohelper.addUIClickAudio(self._btnextendunlink.gameObject, audioId)
end

function InvestigateOpinionItem:_isShowRedDot()
	local var_13_0 = not self._inExtendView and self._mo and InvestigateController.showClueRedDot(self._mo.id) or false

	return (false or nil) and true
end

function InvestigateOpinionItem:_hideReddot()
	if not self._redDotComp.isShowRedDot or not self._mo then
		return
	end

	InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.ReddotClue, self._mo.id)
	self._redDotComp:refreshRedDot()
end

function InvestigateOpinionItem:setInExtendView(value)
	self._inExtendView = value

	gohelper.setActive(self._btnextendunlink, not value)
	gohelper.setActive(self._btnextendlink, not value)
end

function InvestigateOpinionItem:_updateStatus(status)
	TaskDispatcher.cancelTask(self._frameUpdateLine, self)

	for i, v in ipairs(self._statusGoList) do
		gohelper.setActive(v, i == status)
	end

	local oldStatus = self._curStatus

	self._curStatus = status

	self._statusHandler[status](self, oldStatus)
end

function InvestigateOpinionItem:_lockHandler()
	local isActive = DungeonMapModel.instance:getElementById(self._mo.mapElement)

	gohelper.setActive(self._btngoto, isActive)
	gohelper.setActive(self._btnlocktip, not isActive)
	gohelper.setActive(self._btnlocktip, true)
	self._simagelock:LoadImage(self._mo.mapResLocked)
end

function InvestigateOpinionItem:_unlinkedHandler(oldStatus)
	if not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.ClueUnlock, self._mo.id) then
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.ClueUnlock, self._mo.id)
		gohelper.setActive(self._golocked, true)
		gohelper.setActive(self._btnlocktip, false)
		self._lockedAnimator:Play("unlock")
	end
end

function InvestigateOpinionItem:_unlinkedExtendHandler()
	self._btncloseunlink.button.enabled = true
	self._txtdecunlinkextend.text = self._mo.detailedDesc

	self._unlinkextendPlayer:Play(self:_getFullAnimName("open"), self._openunlinkExtendHandler, self)
end

function InvestigateOpinionItem:_openunlinkExtendHandler()
	return
end

function InvestigateOpinionItem:_linkedHandler(oldStatus)
	if self._inExtendView then
		gohelper.setActive(self._golineeffect, false)

		return
	end

	self:_initLineEffect()
	self:_setLineStartPos()
	self:_setLineEndPos()
	gohelper.setActive(self._golineeffect, true)
end

function InvestigateOpinionItem:_linkedExtendHandler(oldStatus)
	self._btncloselink.button.enabled = true
	self._txtdeclinkextend.text = self._mo.detailedDesc

	gohelper.setActive(self._golineeffect, true)

	if oldStatus == InvestigateEnum.OpinionStatus.UnlinkedExtend then
		TaskDispatcher.cancelTask(self._frameUpdateLine, self)
		TaskDispatcher.runDelay(self._frameUpdateLine, self, 0)
		self._linkextendPlayer:Play(self:_getFullAnimName("idle"), self._openlinkExtendHandler, self)

		return
	end

	self:_startFrameUpdateLine()
	self._linkextendPlayer:Play(self:_getFullAnimName("open"), self._openlinkExtendHandler, self)
end

function InvestigateOpinionItem:_openlinkExtendHandler()
	TaskDispatcher.cancelTask(self._frameUpdateLine, self)
end

function InvestigateOpinionItem:_startFrameUpdateLine()
	TaskDispatcher.cancelTask(self._frameUpdateLine, self)
	TaskDispatcher.runRepeat(self._frameUpdateLine, self, 0)
end

function InvestigateOpinionItem:_frameUpdateLine()
	self:_initLineEffect()
	self:_setLineStartPos()
	self:_setLineEndPos()
end

function InvestigateOpinionItem:_editableAddEvents()
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function InvestigateOpinionItem:_editableRemoveEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
end

function InvestigateOpinionItem:_onDragBegin(param, pointerEventData)
	local showEffect = self:_canShowEffect()

	if not self._collider2D or showEffect or self._curStatus == InvestigateEnum.OpinionStatus.Locked then
		return
	end

	self._dragBeginPos = self:getDragWorldPos(pointerEventData)

	self:_initLineEffect()
	self:_setLineStartPos(true)
	gohelper.setActive(self._golineeffect, true)
	gohelper.setActive(self._goDragTip, true)
	self:_hideReddot()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_gudu_kaishi)
end

function InvestigateOpinionItem:_onDragEnd(param, pointerEventData)
	gohelper.setActive(self._goDragTip, false)

	if not self._dragBeginPos then
		return
	end

	self._dragBeginPos = nil

	local pos = self:getDragWorldPos(pointerEventData)

	if self._collider2D then
		local isOverlapPoint = self._collider2D:OverlapPoint(pos)

		if self._collider2D then
			if self._curStatus == InvestigateEnum.OpinionStatus.Unlinked then
				if not InvestigateEnum.OpinionStatus.Linked then
					do
						local status = InvestigateEnum.OpinionStatus.LinkedExtend

						self:_updateStatus(status)
						InvestigateRpc.instance:sendPutClueRequest(self._mo.infoID, self._mo.id)
					end

					local showEffect = self:_canShowEffect()

					gohelper.setActive(self._golineeffect, showEffect)
				end
			end
		end
	end
end

function InvestigateOpinionItem:_canShowEffect()
	return self._curStatus == InvestigateEnum.OpinionStatus.Linked or self._curStatus == InvestigateEnum.OpinionStatus.LinkedExtend
end

function InvestigateOpinionItem:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	local pos = self:getDragWorldPos(pointerEventData)
	local x, y = recthelper.rectToRelativeAnchorPos2(pos, self._uiRootTrans)

	self:_setLinePosition(self._imagelineMat, self._endKey, x, y)
	self:_setLinePosition(self._imagelineupMat, self._endKey, x, y)

	self._godot.transform.position = pos
end

function InvestigateOpinionItem:getDragWorldPos(pointerEventData)
	local mainCamera = CameraMgr.instance:getUICamera()
	local refPos = self.viewGO.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(pointerEventData.position, mainCamera, refPos))
end

function InvestigateOpinionItem:_initLineEffect()
	if self._startKey then
		return
	end

	self._imagelineMat = UnityEngine.GameObject.Instantiate(self._imageline.material)
	self._imageline.material = self._imagelineMat
	self._imagelineupMat = UnityEngine.GameObject.Instantiate(self._imagelineup.material)
	self._imagelineup.material = self._imagelineupMat
	self._matTempVector = Vector4(0, 0, 0, 0)

	local _shader = UnityEngine.Shader

	self._startKey = _shader.PropertyToID("_StartVec")
	self._endKey = _shader.PropertyToID("_EndVec")
end

function InvestigateOpinionItem:_setLineStartPos(setAsLastSibling)
	local go = self._statusGoList[self._curStatus]
	local holeGo = gohelper.findChild(go, "img_hole")
	local pos = holeGo.transform.position
	local x, y = recthelper.rectToRelativeAnchorPos2(pos, self._uiRootTrans)

	self:_setLinePosition(self._imagelineMat, self._startKey, x, y)
	self:_setLinePosition(self._imagelineupMat, self._startKey, x, y)

	if setAsLastSibling then
		gohelper.setAsLastSibling(self._opinionGo)
	end
end

function InvestigateOpinionItem:_setLineEndPos()
	local pos = self._nodeEndGo.transform.position
	local x, y = recthelper.rectToRelativeAnchorPos2(pos, self._uiRootTrans)

	self:_setLinePosition(self._imagelineMat, self._endKey, x, y)
	self:_setLinePosition(self._imagelineupMat, self._endKey, x, y)

	self._godot.transform.position = pos
end

function InvestigateOpinionItem:_setLinePosition(mat, key, x, y)
	self._matTempVector.x = x
	self._matTempVector.y = y

	mat:SetVector(key, self._matTempVector)
end

function InvestigateOpinionItem:_onScreenSizeChange()
	return
end

function InvestigateOpinionItem:_doScreenSizeChange()
	local go

	if self._curStatus == InvestigateEnum.OpinionStatus.LinkedExtend or self._curStatus == InvestigateEnum.OpinionStatus.UnlinkedExtend then
		go = self._statusGoList[self._curStatus]
	end

	if not go then
		return
	end

	local trans = go.transform
	local rootTrans = self._uiRootTrans
	local width = recthelper.getWidth(trans)

	recthelper.setAnchorX(trans, self._defaultPosX)

	local posX = self._defaultPosX
	local relativePos = recthelper.rectToRelativeAnchorPos(trans.position, rootTrans)
	local relativePosX = relativePos.x
	local rootWidth = recthelper.getWidth(rootTrans)
	local halfWidthDelta = rootWidth * 0.5 - width * 0.5
	local minX = -halfWidthDelta

	if relativePosX < minX then
		recthelper.setAnchorX(trans, posX + minX - relativePosX)

		return
	end

	local maxX = halfWidthDelta

	if maxX < relativePosX then
		recthelper.setAnchorX(trans, posX + maxX - relativePosX)

		return
	end
end

function InvestigateOpinionItem:setIndex(index, num)
	self._index = index
	self._num = num
end

function InvestigateOpinionItem:_getFullAnimName(name)
	return (string.format("%s_%s", self:_getPosAnimName(), name))
end

function InvestigateOpinionItem:_getPosAnimName()
	if self._num == 1 then
		return InvestigateEnum.ExtendAnimName.Middle
	end

	if self._num == 3 and self._index == 2 then
		return InvestigateEnum.ExtendAnimName.Middle
	end

	if self._index == 1 then
		return InvestigateEnum.ExtendAnimName.Left
	end

	return InvestigateEnum.ExtendAnimName.Right
end

function InvestigateOpinionItem:onUpdateMO(mo, collider2D, opinionGo, nodeEndGo, dragTipGo)
	self._mo = mo
	self._collider2D = collider2D
	self._opinionGo = opinionGo
	self._nodeEndGo = nodeEndGo
	self._goDragTip = dragTipGo
	self._mapElementConfig = self._mo.mapElement ~= 0 and lua_chapter_map_element.configDict[self._mo.mapElement]

	if self:_isUnlocked() then
		if InvestigateOpinionModel.instance:getLinkedStatus(self._mo.id) then
			if not InvestigateEnum.OpinionStatus.Linked then
				local status = InvestigateEnum.OpinionStatus.Unlinked

				self:_updateStatus(status)
			end
		end
	else
		self:_updateStatus(InvestigateEnum.OpinionStatus.Locked)
	end

	local iconUrl = self._mo.res

	self._simageopinionlink:LoadImage(iconUrl)
	self._simageopinionlinkextend:LoadImage(iconUrl)
	self._simageopinionunlink:LoadImage(iconUrl)
	self._simageopinionunlinkextend:LoadImage(iconUrl)
	self._redDotComp:refreshRedDot()
end

function InvestigateOpinionItem:_isUnlocked()
	return InvestigateOpinionModel.instance:isUnlocked(self._mo.id)
end

function InvestigateOpinionItem:onSelect(isSelect)
	return
end

function InvestigateOpinionItem:onDestroyView()
	self._dragBeginPos = nil

	TaskDispatcher.cancelTask(self._frameUpdateLine, self)
end

return InvestigateOpinionItem
