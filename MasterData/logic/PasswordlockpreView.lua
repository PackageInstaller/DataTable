-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passwordlock/view/PasswordlockpreView.lua

module("logic.extensions.passwordlock.view.PasswordlockpreView", package.seeall)

local PasswordlockpreView = class("PasswordlockpreView", ViewComponent)

function PasswordlockpreView:ctor()
	PasswordlockpreView.super.ctor(self)
end

function PasswordlockpreView:unbindEvents()
	PasswordlockpreView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSave:RemoveClickListener()
end

function PasswordlockpreView:bindEvents()
	PasswordlockpreView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnSave:AddClickListener(self._onClickbtnSave, self)
end

function PasswordlockpreView:buildUI()
	PasswordlockpreView.super.buildUI(self)

	self._linePrefab = self:getGo("finger/line")
	self._goItems = {}

	local root = self:getGo("finger/root")

	for i = 1, 9 do
		self._goItems[i] = {
			go = goutil.findChild(root, "cell_" .. i)
		}
		goutil.findChildTextComponent(root, "cell_" .. i .. "/txtNum").text = i
	end

	local root2 = self:getGo("finger/root2")

	self._nodeItems = {}

	for i = 1, 9 do
		self._nodeItems[i] = goutil.findChild(root2, "cell_" .. i)
	end

	self._rootGo = self:getGo("finger/root")
	self._btnClose = self:getBtn("btnClose")

	goutil.setActive(self._linePrefab, false)

	self._btnSave = self:getBtn("btnSave")
	self._txtTip = self:getTxt("txtTip")
	self._txtFingerNum = self:getTxt("finger/txtNum")
	self._numberPreviewItems = {}

	local pwdpreviewGo = self:getGo("number/pwdpreview")

	for i = 1, PasswordlockmainView.NumberPasswordNum do
		self._numberPreviewItems[i] = {
			txtNum = goutil.findChildTextComponent(pwdpreviewGo, "cell_" .. i .. "/txt")
		}
		self._numberPreviewItems[i].txtNum.text = ""
	end

	self._fingerGo = self:getGo("finger")
	self._numberGo = self:getGo("number")

	goutil.setActive(self._btnSave.gameObject, PhotoPicker.isCanPhoto())
end

function PasswordlockpreView:onExit()
	PasswordlockpreView.super.onExit(self)
	self:_destroyLines()
end

function PasswordlockpreView:onEnter()
	PasswordlockpreView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._lineGos = {}
	self._passwordNumStr = tostring(params[1])
	self._pwdType = params[2]

	self:_hideNodes()
	self:_updateUI()
end

function PasswordlockpreView:_updateUI()
	goutil.setActive(self._fingerGo, self._pwdType == PasswordlockmainView.PasswordType.Finger)
	goutil.setActive(self._numberGo, self._pwdType == PasswordlockmainView.PasswordType.Number)

	self._txtTip.text = string.format("小奥奇你的%s密码为", self._pwdType == PasswordlockmainView.PasswordType.Finger and "手势" or "数字")

	if self._pwdType == PasswordlockmainView.PasswordType.Finger then
		self._txtFingerNum.text = self._passwordNumStr

		for i = 1, #self._passwordNumStr - 1 do
			local srcIndex = checknumber(string.sub(self._passwordNumStr, i, i))
			local destIndex = checknumber(string.sub(self._passwordNumStr, i + 1, i + 1))

			self:_saveLine(srcIndex, destIndex)
		end
	else
		for i = 1, #self._passwordNumStr do
			self._numberPreviewItems[i].txtNum.text = string.sub(self._passwordNumStr, i, i)
		end
	end
end

function PasswordlockpreView:_saveLine(srcIndex, destIndex)
	local goSrc = self._goItems[srcIndex].go
	local goDest = self._goItems[destIndex].go
	local x1, y1, z1 = Framework.TransformUtil.GetLocalPos(goSrc.transform, 0, 0, 0)
	local x2, y2, z2 = Framework.TransformUtil.GetLocalPos(goDest.transform, 0, 0, 0)
	local posX = (x1 + x2) / 2
	local posY = (y1 + y2) / 2
	local len = GameUtil.distance(x1, y1, 0, x2, y2, 0)
	local lineGo = goutil.cloneAndSetParent(self._linePrefab, self._rootGo.transform)

	table.insert(self._lineGos, lineGo)
	Framework.TransformUtil.SetLocalPos(lineGo.transform, posX, posY, 0)
	goutil.setActive(lineGo, true)
	GameUtil.setWidth(lineGo, len)

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

	self:_setNodeActive(srcIndex)
	self:_setNodeActive(destIndex)
	Framework.TransformUtil.SetLocalRotation(lineGo.transform, 0, 0, angle_z)
end

function PasswordlockpreView:_destroyLines()
	for i, go in ipairs(self._lineGos) do
		goutil.destroy(go)
	end

	self._lineGos = {}
end

function PasswordlockpreView:_onClickbtnClose()
	self:close()
end

function PasswordlockpreView:_setNodeActive(index)
	goutil.setActive(self._nodeItems[index], true)
end

function PasswordlockpreView:_hideNodes()
	for k, v in pairs(self._nodeItems) do
		goutil.setActive(v, false)
	end
end

function PasswordlockpreView:_onClickbtnSave()
	if not Framework.OSDef.isEditor and not PhotoPicker.isCanPhoto() then
		FloatWordMgr.instance:show("游戏更新到最新版本后开放此功能")

		return
	end

	Framework.SnapshotTaker.Instance:TakeSnapshot(self._onGetTexture2D, self)
end

function PasswordlockpreView:_onGetTexture2D(texture2d)
	local path = string.format("%s/passwordlockpre_%s.png", UnityEngine.Application.persistentDataPath, self._passwordNumStr)

	if texture2d then
		print("保存到", path)
		Framework.TextureUtil.SaveTextureToPath(texture2d, path)
		PhotoPicker.saveImageToAlbum("aqsy_mima", "aqsy", path)
	end
end

return PasswordlockpreView
