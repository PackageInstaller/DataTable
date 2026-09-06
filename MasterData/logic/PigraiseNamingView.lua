-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraiseNamingView.lua

module("logic.extensions.pigraise.view.PigraiseNamingView", package.seeall)

local PigraiseNamingView = class("PigraiseNamingView", ViewComponent)
local inputLenLimit = 7
local resultCode = {}

resultCode[0] = "猪猪名可以由<color=#ffffff>2-7个汉字、大写字母、小写字母、数字、下划线</color>组成。"
resultCode[-1501] = "已拥有宠物了，不能再领养了"
resultCode[-1502] = "猪猪需要一个名字，给赐个名呗"
resultCode[-1503] = "猪猪名字不能<color=#ffffff>少于2个汉字或字母</color>哦！"
resultCode[-1504] = "猪猪名字太长了"
resultCode[-1505] = "有些字不太合适猪猪哦，再想想看？"
resultCode[-1513] = "猪猪名字格式有误哦(只能由汉字、字母、数字和下划线等组成，且不能全为数字或下划线)"

function PigraiseNamingView:ctor()
	PigraiseNamingView.super.ctor(self)
end

function PigraiseNamingView:bindEvents()
	self._inputPigName:AddOnValueChanged(self._onValueChanged, self)
	self._btnSure:AddClickListener(self._onClickCreateRole, self)
	Framework.UIClickTrigger.Get(self._inputPigName.input.gameObject):AddClickListener(self._onClickInput, self, nil)

	self._callback = AnimalsAgent.instance:addHandler(AnimalsAgent.PM_AnimalsGinPigRes, self._creatPigSuc, self, self._creatPigError)
end

function PigraiseNamingView:unbindEvents()
	self._btnSure:RemoveClickListener()
	self._inputPigName:RemoveOnValueChanged()
	Framework.UIClickTrigger.Get(self._inputPigName.input.gameObject):RemoveClickListener()
	AnimalsAgent.instance:removeHandler(AnimalsAgent.PM_AnimalsGinPigRes, self._callback)
end

function PigraiseNamingView:buildUI()
	local goNaming = self:getGo("BG/goNaming")

	self._inputPigName = self:getInput("BG/goNaming/inputPigName")
	self._btnSure = self:getBtn("BG/goNaming/btnSure")
	self._txtTips = goutil.findChildComponent(goNaming, "imgTips/txtTips", "Text")
	self._rectTips = goutil.findChildComponent(goNaming, "imgTips", "RectTransform")

	self._inputPigName:SetCharacterLimit(inputLenLimit)
end

function PigraiseNamingView:destroyUI()
	return
end

function PigraiseNamingView:onEnter()
	return
end

function PigraiseNamingView:onEnterFinished()
	return
end

function PigraiseNamingView:onExit()
	self._lastStatus = nil
end

function PigraiseNamingView:onExitFinished()
	return
end

function PigraiseNamingView:_checkNameValid(name)
	local realLen = self:_getNameRealLen()
	local isValid = false

	if string.len(name) == 0 then
		self:_updateTips(-1502)
	elseif realLen < 2 then
		self:_updateTips(-1503)
	elseif realLen > inputLenLimit then
		self:_updateTips(-1504)
	else
		isValid = true
	end

	return isValid
end

function PigraiseNamingView:_updateTips(status)
	if not self._lastStatus then
		self._lastStatus = status

		settimer(0, self._doUpdateTips, self, false)
	else
		self:_doUpdateTips(status)
	end
end

function PigraiseNamingView:_doUpdateTips(status)
	status = status or self._lastStatus

	removetimer(self._doUpdateTips, self)

	if not resultCode[status] then
		self._lastContent = resultCode[status]

		goutil.setActive(self._rectTips.gameObject, true)

		self._txtTips.text = resultCode[status]
	end
end

function PigraiseNamingView:_getCharLen(char)
	char = tostring(char)

	if char >= "A" and char <= "Z" then
		return 2
	elseif char == "m" then
		return 1
	elseif char >= "a" and char <= "z" then
		return 1
	else
		return 1
	end
end

function PigraiseNamingView:_getNameRealLen(content)
	if string.nilorempty(content) then
		content = self._inputPigName:GetText()
	end

	local result = StringUtil.utf8split(content)

	return #result
end

function PigraiseNamingView:_onValueChanged()
	self:_updateTips(0)

	local value = self._inputPigName:GetText()
	local t = StringUtil.utf8split(value)
	local len = 0
	local result = ""
	local count = math.min(inputLenLimit, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	self._inputPigName:SetText(result)
	goutil.setActive(self._imgPen, len <= 0)
end

function PigraiseNamingView:_onClickCreateRole()
	if self._isLocked then
		return
	end

	local name = self._inputPigName:GetText()
	local isValid = self:_checkNameValid(name)

	if isValid then
		self._isLocked = true

		FloatWordMgr.instance:lock()

		local hair, tail, skin = PigraiseModelMgr.instance:getModelInfo()

		PigraiseController.instance:adoptReq(name, hair, tail, skin)
	end
end

function PigraiseNamingView:_creatPigSuc()
	self._isLocked = false
	self._isCreated = true

	self:close()
	PigraiseController.instance:getStateReq()
end

function PigraiseNamingView:_creatPigError(handlerObj, status, msg)
	if string.nilorempty(resultCode[status]) then
		-- block empty
	else
		self:_updateTips(status)
	end

	self._isLocked = false
end

function PigraiseNamingView:_onClickInput()
	if self._inputPigName.input.isFocused then
		self:_updateTips(0)
	end
end

function PigraiseNamingView:_finishGetPig()
	if self._isCreated then
		self:close()
	end
end

return PigraiseNamingView
