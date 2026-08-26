-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/view/TowerV3a7CombatItem.lua

module("modules.logic.versionactivity3_7.towerv3a7.view.TowerV3a7CombatItem", package.seeall)

local TowerV3a7CombatItem = class("TowerV3a7CombatItem", ListScrollCellExtend)

function TowerV3a7CombatItem:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "#go_root/HeadMask/#simage_Head")
	self._imageSelfHP = gohelper.findChildImage(self.viewGO, "#go_root/#image_SelfHP")
	self._imageEnemyHP = gohelper.findChildImage(self.viewGO, "#go_root/#image_EnemyHP")
	self._goTarget = gohelper.findChild(self.viewGO, "#go_root/#go_Target")
	self._imageMask = gohelper.findChildImage(self.viewGO, "#go_root/#go_Target/#image_Mask")
	self._goMove = gohelper.findChild(self.viewGO, "#go_root/#go_Move")
	self._goMove2 = gohelper.findChild(self.viewGO, "#go_root/#go_Move/#go_Move2")
	self._goDrag = gohelper.findChild(self.viewGO, "#go_root/#go_Drag")
	self._goSelect = gohelper.findChild(self.viewGO, "#go_root/#go_Select")
	self._txthp = gohelper.findChildText(self.viewGO, "#go_root/#txt_hp")
	self._txtid = gohelper.findChildText(self.viewGO, "#go_root/#txt_id")
	self._goAddNum = gohelper.findChild(self.viewGO, "#go_root/#go_AddNum")
	self._goAdd = gohelper.findChild(self.viewGO, "#go_root/#go_Add")
	self._goReduceNum = gohelper.findChild(self.viewGO, "#go_root/#go_ReduceNum")
	self._goLose = gohelper.findChild(self.viewGO, "#go_root/#go_Lose")
	self._goBubble = gohelper.findChild(self.viewGO, "#go_root/#go_Bubble")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_root/#go_Bubble/Image_Bubble/#txt_Tips")
	self._goclick = gohelper.findChild(self.viewGO, "#go_root/#go_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerV3a7CombatItem:addEvents()
	return
end

function TowerV3a7CombatItem:removeEvents()
	return
end

function TowerV3a7CombatItem:_editableInitView()
	gohelper.setActive(self._goAdd, false)
	gohelper.setActive(self._goLose, false)

	self._btnClick = SLFramework.UGUI.UIClickListener.Get(self._goclick)
	self._addPool = self:getUserDataTb_()
	self._reducePool = self:getUserDataTb_()
	self._animator = self.viewGO:GetComponent("Animator")

	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.SelectChessMan, self._onSelectChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.CancelDragChessMan, self._onCancelDragChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.GMModifyChessHp, self._onGMModifyChessHp, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.GMRefreshChessManID, self._onGMRefreshChessManID, self)
end

function TowerV3a7CombatItem:_getAddTip()
	local time = TowerV3a7Model.instance:getTime()

	for i, v in ipairs(self._addPool) do
		if time - v.time > 0.5 then
			table.remove(self._addPool, i)

			return v.go
		end
	end

	return (gohelper.cloneInPlace(self._goAddNum))
end

function TowerV3a7CombatItem:_getReduceTip()
	local time = TowerV3a7Model.instance:getTime()

	for i, v in ipairs(self._reducePool) do
		if time - v.time > 0.5 then
			table.remove(self._reducePool, i)

			return v.go
		end
	end

	return (gohelper.cloneInPlace(self._goReduceNum))
end

function TowerV3a7CombatItem:_onGMRefreshChessManID()
	self:_updateHpState()
end

function TowerV3a7CombatItem:_onGMModifyChessHp(id, hp)
	if SLFramework.FrameworkSettings.IsEditor and self._mo.id == id then
		self._mo.health = hp

		logError("ModifyChessHp", self._mo.id, hp)
		self:_updateHpState()
	end
end

function TowerV3a7CombatItem:_onCancelDragChessMan(mo)
	if self._mo == mo and self._isDrag then
		self:_onEndDrag()
	end
end

function TowerV3a7CombatItem:_onSelectChessMan(mo)
	gohelper.setActive(self._goSelect, self._mo:getState() == TowerV3a7Enum.ChessState.Select)
end

function TowerV3a7CombatItem:_editableAddEvents()
	self._btnClick:AddClickListener(self._onBtnClick, self)
end

function TowerV3a7CombatItem:_editableRemoveEvents()
	self._btnClick:RemoveClickListener()
end

function TowerV3a7CombatItem:_onBtnClick()
	if SLFramework.FrameworkSettings.IsEditor and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftAlt) then
		logError("kill chess", self._mo.id)

		self._mo.health = 0

		self:_checkDead()

		return
	end

	if not self._isOwnCamp or self._mo:getState() ~= TowerV3a7Enum.ChessState.Normal then
		return
	end

	if self:_noDrag() then
		GameFacade.showToast(ToastEnum.V3a7TowerNoDragTip)
	end

	if self:_noControl() then
		return
	end

	TowerV3a7ChessManModel.instance:selectedChess(self._mo)
	AudioMgr.instance:trigger(TowerV3a7Enum.Audio.Audio4)
end

function TowerV3a7CombatItem:_noControl()
	return self._mo.skillType2 == TowerV3a7Enum.PassiveSkillType.Type2 or self._mo:getTargetRoomId() ~= 0 or TowerV3a7Model.instance:getPauseInteraction() or self._mo:isDead()
end

function TowerV3a7CombatItem:_noDrag()
	return self._mo.skillType2 == TowerV3a7Enum.PassiveSkillType.Type2 and not self._mo:isDead()
end

function TowerV3a7CombatItem:getMo()
	return self._mo
end

function TowerV3a7CombatItem:initMapRoomView(mapRoomView)
	self._mapRoomView = mapRoomView
end

function TowerV3a7CombatItem:onUpdateMO(mo, fromInit, roomId)
	self._mo = mo
	self._roomId = roomId
	self._isOwnCamp = mo.chessConfig.belong == TowerV3a7Enum.Camp.Own

	gohelper.setActive(self._imageSelfHP, self._isOwnCamp)
	gohelper.setActive(self._imageEnemyHP, not self._isOwnCamp)

	local icon = ResUrl.getHeadIconSmall(mo.chessConfig.head)

	self._simageHead:LoadImage(icon)

	if fromInit then
		self:_initDialog()
	end

	self:updateState()
	self:_updateHpState()

	if self._isOwnCamp then
		CommonDragHelper.instance:registerDragObj(self._goroot, self._onBeginDrag, self._onDrag, self._onEndDrag, self._onCheckDrag, self)
	end
end

function TowerV3a7CombatItem:_onBeginDrag(_, pointerEventData)
	self._isDrag = true

	gohelper.addChild(self._mapRoomView:getDragRoot(), self._goroot)
	CommonDragHelper.instance:refreshParent(self._goroot)

	local position = pointerEventData.position
	local trans = self._goroot.transform
	local anchorPos = recthelper.screenPosToAnchorPos(position, trans.parent)

	recthelper.setAnchor(trans, anchorPos.x, anchorPos.y)
	TowerV3a7ChessManModel.instance:selectedChess(self._mo)
	self._mo:setState(TowerV3a7Enum.ChessState.Drag)
	self:updateState()
end

function TowerV3a7CombatItem:_onDrag()
	return
end

function TowerV3a7CombatItem:_onEndDrag()
	if not self._isDrag then
		return
	end

	self._isDrag = false

	local param = {
		chessTrans = self._goroot.transform
	}

	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.DragFinishChessMan, param)
	gohelper.addChild(self.viewGO, self._goroot)
	recthelper.setAnchor(self._goroot.transform, 0, 0)
	CommonDragHelper.instance:refreshParent(self._goroot)

	if param.targetRoomMo and not self._mo:isDead() then
		TowerV3a7ChessManModel.instance:moveChess(param.targetRoomMo)
	else
		TowerV3a7ChessManModel.instance:selectedChess()
		self._mo:setState(TowerV3a7Enum.ChessState.Normal)
		self:updateState()
	end
end

function TowerV3a7CombatItem:_onCheckDrag()
	if self:_noDrag() then
		GameFacade.showToast(ToastEnum.V3a7TowerNoDragTip)
	end

	return self._mo:isDead() or self._mo:getState() ~= TowerV3a7Enum.ChessState.Normal or self:_noControl()
end

function TowerV3a7CombatItem:_updateHpState()
	self._txthp.text = self._mo.health

	if SLFramework.FrameworkSettings.IsEditor then
		self._txtid.text = TowerV3a7Enum.ShowID and self._mo.id or ""
	end

	if self._isOwnCamp then
		self._imageSelfHP.fillAmount = self._mo.health / self._mo.maxHealth
	else
		self._imageEnemyHP.fillAmount = self._mo.health / self._mo.maxHealth
	end
end

function TowerV3a7CombatItem:_initDialog()
	if string.nilorempty(self._mo.chessConfig.dialogue1) then
		return
	end

	self._txtTips.text = self._mo.chessConfig.dialogue1

	gohelper.setActive(self._goBubble, true)
	TaskDispatcher.runDelay(self._hideInitDialog, self, TowerV3a7Enum.AppearDialogTime)
end

function TowerV3a7CombatItem:_hideInitDialog()
	gohelper.setActive(self._goBubble, false)
end

function TowerV3a7CombatItem:updateState()
	local state = self._mo:getState(self._roomId)

	self._isDstMoving = state == TowerV3a7Enum.ChessState.DstMoving

	gohelper.setActive(self._goMove, state == TowerV3a7Enum.ChessState.SrcMoving)
	gohelper.setActive(self._goTarget, self._isDstMoving)
	gohelper.setActive(self._goDrag, state == TowerV3a7Enum.ChessState.Drag)
	gohelper.setActive(self._goSelect, state == TowerV3a7Enum.ChessState.Select)
	TaskDispatcher.cancelTask(self._frameUpdate, self)

	if self._isDstMoving then
		TaskDispatcher.runRepeat(self._frameUpdate, self, 0)
	end
end

function TowerV3a7CombatItem:_frameUpdate()
	if self._isDstMoving then
		local progress = self._mo:getDstMovingProgress()

		self._imageMask.fillAmount = progress

		if progress <= 0 then
			TaskDispatcher.cancelTask(self._frameUpdate, self)

			if self._mo:isDead() then
				return
			end

			TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.MoveFinishChessMan, self._mo)

			local paramStr = string.format("%s_%s", self._mo.id, self._mo:getLocation())

			TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.GuideMoveFinishChessMan, paramStr)
		end
	end
end

function TowerV3a7CombatItem:_checkDead()
	if self._mo:isDead() then
		TaskDispatcher.cancelTask(self._deadDestory, self)
		TaskDispatcher.runDelay(self._deadDestory, self, 0.5)
		TaskDispatcher.cancelTask(self._playCloseAnim, self)
		TaskDispatcher.runDelay(self._playCloseAnim, self, 0.3)
		AudioMgr.instance:trigger(TowerV3a7Enum.Audio.Audio7)

		local dialogue2 = self._mo.chessConfig.dialogue2

		if not string.nilorempty(dialogue2) then
			self._txtTips.text = dialogue2

			gohelper.setActive(self._goBubble, true)
		end

		if self._isDrag then
			self:_onEndDrag()
			CommonDragHelper.instance:unregisterDragObj(self._goroot)
		end

		if self._mo:getState() == TowerV3a7Enum.ChessState.Select then
			TowerV3a7ChessManModel.instance:selectedChess()
		end
	end
end

function TowerV3a7CombatItem:_playCloseAnim()
	self._animator:Play("close")
end

function TowerV3a7CombatItem:_deadDestory()
	gohelper.destroy(self.viewGO)
	TowerV3a7Model.instance:addDelayExecute(function()
		TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.StoryDeadChessMan, self._mo)
	end)
	TowerV3a7Model.instance:addDelayExecute(function()
		TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.DeadChessMan, self._mo)
		TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.GuideDeadChessMan, self._mo.id)
	end)
end

function TowerV3a7CombatItem:updateHp()
	if not self._mo.isAfterBattle then
		return
	end

	self._mo.isAfterBattle = false

	self:_checkDead()
	self:_updateHpState()
	self:_showTip()
end

function TowerV3a7CombatItem:_showTip()
	local time = TowerV3a7Model.instance:getTime()

	gohelper.setActive(self._goAdd, false)
	gohelper.setActive(self._goLose, false)

	for i, value in ipairs(self._mo.hurtList) do
		local isAdd = value > 0
		local go = isAdd and self:_getAddTip() or self:_getReduceTip()

		gohelper.setActive(self._goAdd, isAdd)
		gohelper.setActive(self._goLose, not isAdd)

		local txt = gohelper.findChildText(go, "Num")

		txt.text = (isAdd and "+" or "") .. value

		recthelper.setAnchorY(go.transform, (i - 1) * 30)
		gohelper.setActive(go, false)
		gohelper.setActive(go, true)

		if isAdd then
			table.insert(self._addPool, {
				time = time,
				go = go
			})
		else
			table.insert(self._reducePool, {
				time = time,
				go = go
			})
		end
	end
end

function TowerV3a7CombatItem:onDestroyView()
	TaskDispatcher.cancelTask(self._frameUpdate, self)
	TaskDispatcher.cancelTask(self._hideInitDialog, self)
	TaskDispatcher.cancelTask(self._deadDestory, self)
	TaskDispatcher.cancelTask(self._playCloseAnim, self)
	CommonDragHelper.instance:unregisterDragObj(self._goroot)
end

return TowerV3a7CombatItem
