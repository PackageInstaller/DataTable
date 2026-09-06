-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraiseadoptView.lua

module("logic.extensions.pigraise.view.PigraiseadoptView", package.seeall)

local PigraiseadoptView = class("PigraiseadoptView", ViewComponent)

function PigraiseadoptView:ctor()
	PigraiseadoptView.super.ctor(self)

	self._cfg = PigraiseConfig.instance
end

function PigraiseadoptView:buildUI()
	PigraiseadoptView.super.buildUI(self)

	self._pig = self:getGo("BG/pig")
	self._drag = Framework.UIDragTrigger.Get(self:getGo("BG/drag"))
	self._btnClose = self:getBtn("BG/btnClose")
	self._settings = {}

	for i = 1, 2 do
		local t = {}

		t._path = "BG/setting/setting_" .. i
		t.go = self:getGo(t._path)

		if t.go == nil then
			return
		end

		t.txt = goutil.findChildTextComponent(t.go, "txt")
		t.btnMoveLeft = self:getBtn(t._path .. "/btnMoveLeft")
		t.btnMoveLeftGo = self:getGo(t._path .. "/btnMoveLeft")
		t.btnMoveRight = self:getBtn(t._path .. "/btnMoveRight")
		t.btnMoveRightGo = self:getGo(t._path .. "/btnMoveRight")
		t.curIndex = 1
		t.cfgs = self._cfg:getModelinfoCfgById(1, i)
		self._settings[i] = t

		self:_refreshSettingUI(i, t.curIndex)
	end

	self._finishUpdate = true
end

function PigraiseadoptView:bindEvents()
	PigraiseadoptView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._drag:AddDragListener(self._onDrag, self)

	for i = 1, #self._settings do
		if self._settings[i].go ~= nil then
			self._settings[i].btnMoveLeft:AddClickListener(function()
				self:_onClickSwitch(i, true)
			end)
			self._settings[i].btnMoveRight:AddClickListener(function()
				self:_onClickSwitch(i, false)
			end)
		end
	end
end

function PigraiseadoptView:unbindEvents()
	PigraiseadoptView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._drag:RemoveDragListener()

	for i = 1, #self._settings do
		if self._settings[i].go ~= nil then
			self._settings[i].btnMoveLeft:RemoveClickListener()
			self._settings[i].btnMoveRight:RemoveClickListener()
		end
	end
end

function PigraiseadoptView:destroyUI()
	PigraiseadoptView.super.destroyUI(self)
end

function PigraiseadoptView:onEnter()
	PigraiseadoptView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._isNotBtnClose = checkbool(params[1])

	GameUtil.SetActive(self._btnClose, not self._isNotBtnClose)
	GlobalDispatcher:addListener(GlobalNotify.PigRaiseModelUpdate, self._onModelUpdate, self)
	PigraiseModelMgr.instance:pushViewWithModel(self._pig, self._viewPresentor.viewName, 0.6, 140)
	self:_onModelUpdate()

	for i = 1, #self._settings do
		self:_refreshSettingUI(i, 1)
	end
end

function PigraiseadoptView:onEnterFinished()
	PigraiseadoptView.super.onEnterFinished(self)
end

function PigraiseadoptView:onExit()
	PigraiseadoptView.super.onExit(self)
	PigraiseModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	GlobalDispatcher:removeListener(GlobalNotify.PigRaiseModelUpdate, self._onModelUpdate, self)

	self._avatarMo = nil
end

function PigraiseadoptView:onExitFinished()
	PigraiseadoptView.super.onExitFinished(self)
end

function PigraiseadoptView:_onClickSwitch(settingId, isLeft)
	if not self._avatarPet and not self._finishUpdate then
		return
	end

	if isLeft then
		if not (self._settings[settingId].curIndex - 1) then
			local newIdx = self._settings[settingId].curIndex + 1

			self:_refreshSettingUI(settingId, newIdx)
		end
	end
end

function PigraiseadoptView:_refreshSettingUI(id, newIdx)
	local idx = checknumber(newIdx)
	local cfgs = self._settings[id].cfgs

	if cfgs and #cfgs > 0 then
		idx = Mathf.Clamp(idx, 1, #cfgs)

		goutil.setActive(self._settings[id].btnMoveLeftGo, idx ~= 1)
		goutil.setActive(self._settings[id].btnMoveRightGo, idx ~= #cfgs)

		self._settings[id].curIndex = idx
		self._settings[id].txt.text = cfgs[idx].name
		self._finishUpdate = false

		if self._avatarPet and not self._finishUpdate and self._avatarMo then
			self._avatarMo:setDataByCfgId(cfgs[idx].partId)
			self._avatarPet:updateByMo(self._avatarMo)
		end
	end
end

function PigraiseadoptView:_onModelUpdate()
	self._avatarPet = PigraiseModelMgr.instance:getAvatarPet()

	if not self._avatarMo then
		self._avatarMo = AvatarPetMo.New()

		self._avatarMo:copyDataByMo(self._avatarPet.avatarmo)
	end

	self._finishUpdate = true
end

function PigraiseadoptView:_onDrag(eventData)
	PigraiseModelMgr.instance:onModelTrun(eventData.delta.x)
end

return PigraiseadoptView
