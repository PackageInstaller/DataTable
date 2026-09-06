-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passwordlock/view/PasswordlockmainView.lua

module("logic.extensions.passwordlock.view.PasswordlockmainView", package.seeall)

local PasswordlockmainView = class("PasswordlockmainView", ViewComponent)

PasswordlockmainView.NumberPasswordNum = 6
PasswordlockmainView.State = {
	Verify = 3,
	UnLock = 4,
	Lock = 1,
	ChangePassword = 2
}
PasswordlockmainView.ChangePasswordState = {
	NewPassword_2 = 3,
	OldPassword = 1,
	NewPassword_1 = 2
}
PasswordlockmainView.PasswordType = {
	Number = 2,
	Finger = 1,
	None = 0
}
PasswordlockmainView.LockState = {
	Second = 2,
	First = 1
}

function PasswordlockmainView:ctor()
	PasswordlockmainView.super.ctor(self)
end

function PasswordlockmainView:unbindEvents()
	PasswordlockmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnForget:RemoveClickListener()
	self._btnChange:RemoveClickListener()

	for i, v in ipairs(self._numberGoItems) do
		v.btn:RemoveClickListener()
	end

	self._btnReturn:RemoveClickListener()
end

function PasswordlockmainView:bindEvents()
	PasswordlockmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)

	for index, item in ipairs(self._goItems) do
		local go = item.go

		BeginDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onBeginDrag(_go, index)
		end)
		EndDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onEndDrag(_go, index)
		end)
		DragHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onDrag(_go, index)
		end)
		PointerEnterHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onPointerEnter(_go, index)
		end)
	end

	for i, v in ipairs(self._numberGoItems) do
		v.btn:AddClickListener(GameUtil.handler(self._onClickNumber, self, i))
	end

	self._btnForget:AddClickListener(self._onClickbtnForget, self)
	self._btnChange:AddClickListener(self._onClickbtnChange, self)
	PointerEnterHandler.Get(self._btnClose.gameObject):AddLuaHandler(function(_go, eventData)
		self:_onPointerEnterBtnClose(_go)
	end)
	PointerExitHandler.Get(self._btnClose.gameObject):AddLuaHandler(function(_go, eventData)
		self:_onPointerExitBtnClose(_go)
	end)
	self._btnReturn:AddClickListener(self._onClickbtnReturn, self)
end

function PasswordlockmainView:buildUI()
	PasswordlockmainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._linePrefab = self:getGo("finger/line")
	self._goLineFollow = self:getGo("finger/lineFollow")
	self._goItems = {}
	self._fingerRootGo = self:getGo("finger/root")

	for i = 1, PasswordLockController.MAX_LENGTH do
		self._goItems[i] = {
			go = goutil.findChild(self._fingerRootGo, "cell_" .. i),
			txtNum = goutil.findChildTextComponent(self._fingerRootGo, "cell_" .. i .. "/txtNum")
		}
		self._goItems[i].txtNum.text = i
	end

	local fingerRoot2 = self:getGo("finger/root2")

	goutil.setActive(fingerRoot2, true)

	self._nodeItems = {}

	for i = 1, 9 do
		self._nodeItems[i] = goutil.findChild(fingerRoot2, "cell_" .. i)
	end

	self._rootRectTr = self:getGo("finger/root"):GetComponent(goutil.Type_RectTransform)
	self._btnForget = self:getBtn("btnForget")
	self._txtDesc = self:getTxt("txtDesc")

	goutil.setActive(self._linePrefab, false)
	goutil.setActive(self._goLineFollow, false)

	self._btnChange = self:getBtn("btnChange")
	self._fingerGo = self:getGo("finger")
	self._numberGo = self:getGo("number")
	self._numberPreviewItems = {}

	local pwdpreviewGo = self:getGo("number/pwdpreview")

	for i = 1, PasswordlockmainView.NumberPasswordNum do
		self._numberPreviewItems[i] = {
			txtNum = goutil.findChildTextComponent(pwdpreviewGo, "cell_" .. i .. "/txt")
		}
		self._numberPreviewItems[i].txtNum.text = ""
	end

	self._numberGoItems = {}

	local numberRoot = self:getGo("number/root")

	for i = 1, PasswordLockController.MAX_LENGTH do
		self._numberGoItems[i] = {
			btn = Framework.ButtonAdapter.Get(goutil.findChild(numberRoot, "cell_" .. i)),
			txtNum = goutil.findChildTextComponent(numberRoot, "cell_" .. i .. "/txtNum")
		}
		self._numberGoItems[i].txtNum.text = i
	end

	self._txtBtnChange = self:getTxt("btnChange/txt")
	self._btnCloseTr = self:getGo("btnClose").transform
	self._btnReturn = self:getBtn("number/btnReturn")
	self._txtLockTipGo = self:getGo("txtLockTip")
	self._txtBtnChange = self:getTxt("btnChange/txt")
	self._iconBtnChange = self:getGo("btnChange/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtTitle = self:getTxt("txtTitle")
end

function PasswordlockmainView:onExit()
	PasswordlockmainView.super.onExit(self)

	self._isDraging = false

	self:_destroyLines()
end

function PasswordlockmainView:onEnter()
	PasswordlockmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SetSecondaryPwdRes, self.close, self)
	self.addGEvent(self, GlobalNotify.ValidInputSecondaryPwdRes, self._onValidInputSecondaryPwdRes, self)
	self.addGEvent(self, GlobalNotify.ChangeSecondaryPwdRes, self.close, self)
	self.addGEvent(self, GlobalNotify.ClearSecondaryPwdRes, self.close, self)

	self._salt = PasswordLockModel.instance:getLocalPasswordSalt()
	self._curState = self:getFirstParam() or PasswordlockmainView.State.Lock
	self._indexMap = {}
	self._lineGos = {}
	self._pwdList = {}
	self._changePasswordState = PasswordlockmainView.ChangePasswordState.OldPassword
	self._isChangePassword = self._curState == PasswordlockmainView.State.ChangePassword

	local key = PasswordLockController.playerSecondaryPwdTypePre .. tostring(LoginModel.instance.sessionId)
	local pwdType = PasswordLockModel.instance:getPwdType()

	self._pwdType = pwdType <= 0 and PasswordlockmainView.PasswordType.Finger or pwdType
	self._lockPasswordState = PasswordlockmainView.LockState.First

	if self._curState == PasswordlockmainView.State.Lock then
		self._pwdType = PasswordlockmainView.PasswordType.Finger
	end

	self:_onPointerExitBtnClose()
	self:_updateUI()
	self:_hideNodes()
	self:_setBtnChangeInfo()
end

function PasswordlockmainView:_onClickbtnClose()
	self:close()
end

function PasswordlockmainView:_onBeginDrag(go, index)
	if self:_checkPwdFailCountIsMax() then
		FloatWordMgr.instance:show("今日验证失败次数已达上限，请明日再试")

		return
	end

	self._isDraging = true
	self._dragIndex = index

	self:_clear()
	self:_addIndex(index)
	self:_creatCurLine()
end

function PasswordlockmainView:_onDrag(go, eventData)
	if not self._isDraging then
		return
	end

	self:_followFinger()
end

function PasswordlockmainView:_onEndDrag(go, eventData)
	if self._isDraging then
		self:_finishDrag()
	end
end

function PasswordlockmainView:_finishDrag()
	self._isDraging = false

	if self._isEnterBtnClose or not self:_checkFingerPassWord() then
		self:_onPointerExitBtnClose()
		self:_updateUI()

		return
	end

	self:_beforeTrySendPassword()
end

function PasswordlockmainView:_onPointerEnter(go, index)
	if not self._isDraging then
		return
	end

	if self._dragIndex == index then
		return
	end

	if self._indexMap[index] then
		return
	end

	self:_saveLine(self._dragIndex, index)

	self._dragIndex = index
end

function PasswordlockmainView:_checkFingerPassWord()
	if #self._pwdList < PasswordLockController.MIN_FINGER_LENGTH then
		FloatWordMgr.instance:show(string.format("密码个数要大于%s个", PasswordLockController.MIN_FINGER_LENGTH))

		return false
	end

	return true
end

function PasswordlockmainView:_addIndex(index)
	if self._indexMap[index] then
		return
	end

	self._indexMap[index] = index

	table.insert(self._pwdList, index)
end

function PasswordlockmainView:_hideLastLine()
	goutil.setActive(self._curLine, false)
end

function PasswordlockmainView:_clear()
	self._indexMap = {}
	self._pwdList = {}
	self._passwordCount = 0

	self:_destroyLines()
	self:_hideNodes()
	self:_setNumberPreItemsEmpty()
end

function PasswordlockmainView:_destroyLines()
	goutil.setActive(self._curLine, false)

	for i, go in ipairs(self._lineGos) do
		goutil.destroy(go)
	end

	self._lineGos = {}
end

function PasswordlockmainView:_creatCurLine()
	if not self._curLine then
		self._curLine = self._goLineFollow

		self._curLine.transform:SetParent(self._fingerRootGo.transform)
	end

	goutil.setActive(self._curLine, true)
	self:_setNodeActive(self._dragIndex)
end

function PasswordlockmainView:_saveLine(srcIndex, destIndex)
	self:_addIndex(destIndex)

	local goSrc = self._goItems[srcIndex].go
	local goDest = self._goItems[destIndex].go
	local x1, y1, z1 = Framework.TransformUtil.GetLocalPos(goSrc.transform, 0, 0, 0)
	local x2, y2, z2 = Framework.TransformUtil.GetLocalPos(goDest.transform, 0, 0, 0)
	local lineGo = goutil.cloneAndSetParent(self._linePrefab, self._fingerRootGo.transform)

	self:_setLineParams(lineGo, x1, y1, x2, y2)
	table.insert(self._lineGos, lineGo)
	goutil.setActive(lineGo, true)
	self:_setNodeActive(srcIndex)
	self:_setNodeActive(destIndex)
end

function PasswordlockmainView:_onClickbtnForget()
	local text = "忘记安全锁密码时，可以申请强制关闭安全锁，申请后安全锁将在三天后自动关闭"

	TipsFacade.instance:openPopupWindow("强制解锁", text, function()
		PlayerAgent.instance:sendPM_ReqResetSecondaryPwdReq()
		self:close()
	end, nil, "立即申请")
end

function PasswordlockmainView:_updateUI()
	self:_clear()

	local pwdTypeStr = self._pwdType == PasswordlockmainView.PasswordType.Finger and "手势密码" or "数字密码"
	local titleFormatStr = "%s"

	if self._curState == PasswordlockmainView.State.Lock then
		titleFormatStr = not PasswordLockModel.instance:checkClientPasswordUnlock() and "请输入%s验证" or self._lockPasswordState == PasswordlockmainView.LockState.Second and "请再次输入%s上锁" or "请输入%s上锁"
	elseif self._curState == PasswordlockmainView.State.ChangePassword then
		if self._changePasswordState == PasswordlockmainView.ChangePasswordState.OldPassword then
			titleFormatStr = "请输入旧的%s"
		elseif self._changePasswordState == PasswordlockmainView.ChangePasswordState.NewPassword_1 then
			titleFormatStr = "请输入新的%s"
		elseif self._changePasswordState == PasswordlockmainView.ChangePasswordState.NewPassword_2 then
			titleFormatStr = "请再次输入%s"
		end
	elseif self._curState == PasswordlockmainView.State.Verify then
		titleFormatStr = "请输入%s验证"
	elseif self._curState == PasswordlockmainView.State.UnLock then
		titleFormatStr = "请输入%s解锁"
	end

	self._txtTitle.text = string.format(titleFormatStr, pwdTypeStr)

	self:_updatePwdTypeActive()
end

function PasswordlockmainView:_followFinger()
	if self._curLine then
		local item = self._goItems[self._dragIndex]

		if item then
			local screenPos = UGUIToolHelper.GetTouchPosition()
			local localPos = goutil.screenToLocalPos(screenPos, self._rootRectTr)
			local x1, y1 = Framework.TransformUtil.GetLocalPos(item.go.transform, 0, 0, 0)

			self:_setLineParams(self._curLine, x1, y1, localPos.x, localPos.y)
		end
	end
end

function PasswordlockmainView:_setLineParams(lineGo, x1, y1, x2, y2)
	local posX = (x1 + x2) / 2
	local posY = (y1 + y2) / 2
	local x = x2 - x1
	local y = y2 - y1
	local angle_z = GoUtil.Angle(x, y, 0, 1, 0, 0)
	local dir = {
		z = 0,
		x = x,
		y = y
	}
	local new = Vector3.Cross(dir, Vector3.right)

	if new.z > 0 then
		angle_z = -angle_z
	end

	Framework.TransformUtil.SetLocalPos(lineGo.transform, posX, posY, 0)
	Framework.TransformUtil.SetLocalRotation(lineGo.transform, 0, 0, angle_z)

	local len = GameUtil.distance(x1, y1, 0, x2, y2, 0)

	GameUtil.setWidth(lineGo, len)
end

function PasswordlockmainView:_trySendPassword()
	if self._curState ~= PasswordlockmainView.State.ChangePassword and not PasswordLockModel.instance:checkClientPasswordUnlock() then
		PlayerAgent.instance:sendPM_ValidInputSecondaryPwdReq(self._curPassword)

		return
	end

	if self._curState == PasswordlockmainView.State.Lock then
		if self._lockPasswordState == PasswordlockmainView.LockState.First then
			self._firstLockPassword = self._curPassword
			self._lockPasswordState = PasswordlockmainView.LockState.Second

			self:_updateUI()

			return
		elseif self._lockPasswordState == PasswordlockmainView.LockState.Second then
			if self._firstLockPassword ~= self._curPassword then
				FloatWordMgr.instance:show("两次密码不一致")

				self._lockPasswordState = PasswordlockmainView.LockState.First

				self:_updateUI()

				return
			end

			PlayerAgent.instance:sendPM_SetSecondaryPwdReq(self._curPassword, self._pwdType)
		end
	elseif self._curState == PasswordlockmainView.State.ChangePassword then
		if self._changePasswordState == PasswordlockmainView.ChangePasswordState.OldPassword then
			self._changePassword_curpwd = self._curPassword

			PlayerAgent.instance:sendPM_ValidInputSecondaryPwdReq(self._curPassword)
		elseif self._changePasswordState == PasswordlockmainView.ChangePasswordState.NewPassword_1 then
			self._newPassword = self._curPassword
			self._changePasswordState = PasswordlockmainView.ChangePasswordState.NewPassword_2

			self:_updateUI()
		elseif self._changePasswordState == PasswordlockmainView.ChangePasswordState.NewPassword_2 then
			if self._newPassword ~= self._curPassword then
				self._newPassword = 0
				self._changePasswordState = PasswordlockmainView.ChangePasswordState.NewPassword_1

				self:_updateUI()
				FloatWordMgr.instance:show("两次手势密码不一致，请重新输入")

				return
			end

			PlayerAgent.instance:sendPM_ChangeSecondaryPwdReq(self._changePassword_curpwd, self._salt, self._newPassword, self._pwdType)
		end
	elseif self._curState == PasswordlockmainView.State.UnLock then
		PlayerAgent.instance:sendPM_ClearSecondaryPwdReq(self._curPassword, self._salt)
	elseif self._curState == PasswordlockmainView.State.Verify then
		PlayerAgent.instance:sendPM_ValidInputSecondaryPwdReq(self._curPassword)
	end
end

function PasswordlockmainView:_onValidInputSecondaryPwdRes(status)
	if status == 0 then
		if self._curState == PasswordlockmainView.State.Verify then
			self:close()

			return
		end

		self:_onValidInputSuccess()
	end

	self:_clear()
end

function PasswordlockmainView:_onValidInputSuccess()
	self._salt = PasswordLockModel.instance:getLocalPasswordSalt()

	if self._isChangePassword then
		self._changePasswordState = PasswordlockmainView.ChangePasswordState.NewPassword_1

		self:_updateUI()

		return
	end

	if self._curState == PasswordlockmainView.State.ChangePassword then
		self:_updateUI()
	else
		self:_trySendPassword()
	end
end

function PasswordlockmainView:_hideNodes()
	for k, v in pairs(self._nodeItems) do
		goutil.setActive(v, false)
	end
end

function PasswordlockmainView:_setNodeActive(index)
	goutil.setActive(self._nodeItems[index], true)
end

function PasswordlockmainView:_checkPwdFailCountIsMax()
	if not PasswordLockModel.instance:checkClientPasswordUnlock() and PasswordLockModel.instance:getTodayInputPwdFailCount() >= PasswordLockController.MAX_VALID_TIEMS then
		return true
	end
end

function PasswordlockmainView:_onClickbtnChange()
	self._pwdType = self._pwdType == PasswordlockmainView.PasswordType.Finger and PasswordlockmainView.PasswordType.Number or PasswordlockmainView.PasswordType.Finger

	if self._curState == PasswordlockmainView.State.Lock then
		self._lockPasswordState = PasswordlockmainView.LockState.First
	elseif self._curState == PasswordlockmainView.State.ChangePassword then
		self._changePasswordState = PasswordlockmainView.ChangePasswordState.NewPassword_1
	end

	self._pwdList = {}

	self:_setNumberPreItemsEmpty()
	self:_updatePwdTypeActive()
	self:_updateUI()
	self:_setBtnChangeInfo()
end

function PasswordlockmainView:_updatePwdTypeActive()
	goutil.setActive(self._fingerGo, self._pwdType == PasswordlockmainView.PasswordType.Finger)
	goutil.setActive(self._numberGo, self._pwdType == PasswordlockmainView.PasswordType.Number)

	self._txtBtnChange.text = self._pwdType == PasswordlockmainView.PasswordType.Finger and "设置数字" or "设置手势"

	goutil.setActive(self._btnForget.gameObject, self._curState ~= PasswordlockmainView.State.Lock)

	local canChange = self._curState == PasswordlockmainView.State.Lock or self._curState == PasswordlockmainView.State.ChangePassword and self._changePasswordState ~= PasswordlockmainView.ChangePasswordState.OldPassword

	goutil.setActive(self._btnChange.gameObject, canChange)
	goutil.setActive(self._txtLockTipGo, canChange)
end

function PasswordlockmainView:_onClickNumber(num)
	table.insert(self._pwdList, num)

	for i, v in ipairs(self._numberPreviewItems) do
		v.txtNum.text = self._pwdList[i] or ""
	end

	if #self._pwdList == PasswordlockmainView.NumberPasswordNum then
		self:_beforeTrySendPassword()

		return
	end
end

function PasswordlockmainView:_beforeTrySendPassword()
	self._curPassword = table.concat(self._pwdList, "")

	self:_hideLastLine()
	self:_trySendPassword()
end

function PasswordlockmainView:_setNumberPreItemsEmpty()
	for i, v in ipairs(self._numberPreviewItems) do
		v.txtNum.text = ""
	end
end

function PasswordlockmainView:_onPointerEnterBtnClose(go)
	self._isEnterBtnClose = true

	Framework.TransformUtil.SetLocalScale(self._btnCloseTr, 1.2, 1.2, 1.2)
end

function PasswordlockmainView:_onPointerExitBtnClose(go)
	self._isEnterBtnClose = false

	Framework.TransformUtil.SetLocalScale(self._btnCloseTr, 0.9, 0.9, 0.9)
end

function PasswordlockmainView:_onClickbtnReturn()
	if #self._pwdList > 0 then
		table.remove(self._pwdList)

		for i, v in ipairs(self._numberPreviewItems) do
			v.txtNum.text = self._pwdList[i] or ""
		end
	else
		FloatWordMgr.instance:show("无需回退")
	end
end

function PasswordlockmainView:_setBtnChangeInfo()
	self._iconBtnChange:SetState(self._pwdType == PasswordlockmainView.PasswordType.Finger and 0 or 1)

	self._txtBtnChange.text = self._pwdType == PasswordlockmainView.PasswordType.Finger and "数字密码" or "手势密码"
end

return PasswordlockmainView
