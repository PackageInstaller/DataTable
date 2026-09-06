-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/NamingView.lua

module("logic.extensions.login.view.NamingView", package.seeall)

local inputLenLimit = 7
local regex = "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"
local resultCode = {}

resultCode[0] = "奥奇名可以由<color=#ffffff>2-7个汉字、大写字母、小写字母、数字、下划线</color>组成。"
resultCode[-1] = "奥奇名不能为空哦！"
resultCode[-2605] = "已经有小奥奇叫这个名字了哦"
resultCode[-2606] = "奥奇名不能<color=#ffffff>少于2个汉字或字母</color>哦！"
resultCode[-2607] = "名字不能长于<color=#ffffff>7个字的长度</color>"
resultCode[-2608] = "奥奇名只能由<color=#ffffff>汉字、字母、数字和下划线</color>等组成，不能含有空格或特殊符号哦！"
resultCode[-2609] = "有些字不太合适哦，再想想看？"
resultCode[-2610] = "该账户已创建角色，无法多次创建，请重登后再试，若有疑问请联系客服！"
resultCode[-2612] = "不能全部是数字哦！"
resultCode[-2613] = "不能全部是下划线哦！"
resultCode[-2615] = "不能修改预创角性别和名字！"

local NamingView = class("NamingView", ViewComponent)

function NamingView:bindEvents()
	self._inputRoleName:AddOnValueChanged(self._onValueChanged, self)
	self._btnLogin:AddClickListener(self._onClickCreateRole, self)
	self._btnRefresh:AddClickListener(self._onClickRefreshName, self)
	Framework.UIClickTrigger.Get(self._inputRoleName.input.gameObject):AddClickListener(self._onClickInput, self, nil)
end

function NamingView:unbindEvents()
	self._btnLogin:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._inputRoleName:RemoveOnValueChanged()
	Framework.UIClickTrigger.Get(self._inputRoleName.input.gameObject):RemoveClickListener()
end

function NamingView:buildUI()
	local goNaming = self:getGo("goNaming")

	self._inputRoleName = self:getInput("goNaming/inputRoleName")
	self._btnLogin = self:getBtn("goNaming/btnLogin")
	self._btnRefresh = self:getBtn("goNaming/btnRefresh")
	self._txtTips = goutil.findChildComponent(goNaming, "imgTips/txtTips", "Text")
	self._rectTips = goutil.findChildComponent(goNaming, "imgTips", "RectTransform")

	self._inputRoleName:SetCharacterLimit(inputLenLimit)
end

function NamingView:onEnter()
	self.registerLocalNotify(self, "createRoleSex", self._onSexChanged, self)
	GlobalDispatcher:addListener(PlayerAgent.CreatePlayerRes, self._onCreatePlayerRes, self)
	GlobalDispatcher:addListener(RoleController.ON_PRE_ROLE_CLICK_ENTER, self._onClickCreateRole, self)

	local info = RoleModel.instance.PreCreatePlayerInfo

	if info and not string.nilorempty(info.userName) then
		self._inputRoleName:SetText(info.userName)
		goutil.setActive(self._rectTips.gameObject, false)
	else
		self:_onClickRefreshName()
	end

	local v = FriendConfig.instance:getCommonValue("NO_RENAME_PERIOD")
	local times = string.split(v, "#")

	if #times == 2 and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
		self._inputRoleName.input.interactable = false
	end
end

function NamingView:onExit()
	GlobalDispatcher:removeListener(PlayerAgent.CreatePlayerRes, self._onCreatePlayerRes, self)
	GlobalDispatcher:removeListener(RoleController.ON_PRE_ROLE_CLICK_ENTER, self._onClickCreateRole, self)
	self.unregisterLocalNotify(self, "createRoleSex", self._onSexChanged, self)
	removetimer(self._doUpdateTips, self)

	self._lastStatus = nil
end

function NamingView:_onSexChanged(sex)
	self._sex = sex
end

function NamingView:_checkNameValid(name)
	local realLen, isAllNum, isAllUnderLine = self:getNameRealLen()
	local isValid = false

	if string.len(name) == 0 then
		self:_updateTips(-1)
	elseif not System.Text.RegularExpressions.Regex.IsMatch(name, regex) then
		self:_updateTips(-2608)
	elseif realLen < 2 then
		self:_updateTips(-2606)
	elseif isAllNum then
		self:_updateTips(-2612)
	elseif isAllUnderLine then
		self:_updateTips(-2613)
	elseif realLen > inputLenLimit then
		self:_updateTips(-2607)
	else
		isValid = true
	end

	return isValid
end

function NamingView:_updateTips(status)
	if not self._lastStatus then
		self._lastStatus = status

		settimer(0, self._doUpdateTips, self, false)
	else
		self:_doUpdateTips(status)
	end
end

function NamingView:_doUpdateTips(status)
	status = status or self._lastStatus

	removetimer(self._doUpdateTips, self)

	local var_9_0 = resultCode[status]

	if not resultCode[status] then
		if not MsgFlowMgr.instance:getResultCodeStr(status) then
			var_9_0 = ""

			local content = ""

			self._lastContent = content

			goutil.setActive(self._rectTips.gameObject, true)

			self._txtTips.text = content

			if status == -2615 or status == -2610 or status == -54 then
				TipsFacade.instance:openTipWindowNoX(lang("tip"), content, function()
					LoginController.instance:disconnect(function()
						ReConnectionMgr.instance:returnToLogin()
					end)
				end, BootstrapLanguage.sure)
			end
		end
	end
end

function NamingView:getRandomName()
	local name = ""
	local id
	local cfg = LoginConfig.instance:getRule(CreateRoleView._selectedSex == 0 and 2 or 1)

	print("str = " .. cfg.index)

	local arr = string.split(cfg.index, "#")

	for i = 1, 3 do
		local t = LoginConfig.instance:getCfgsByGroup(checknumber(arr[i]))

		if t and #t > 0 then
			name = name .. t[math.random(#t)].content
		end
	end

	local realLen = self:getNameRealLen()

	if realLen > inputLenLimit then
		return self:getRandomName()
	else
		return name
	end
end

function NamingView:getCharLen(char)
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

function NamingView:getNameRealLen(content)
	if string.nilorempty(content) then
		content = self._inputRoleName:GetText()
	end

	local result = StringUtil.utf8split(content)
	local isAllNum, isAllUnderLine = true, true

	for _, v in ipairs(result) do
		isAllNum = isAllNum and v >= "0" and v <= "9"
		isAllUnderLine = isAllUnderLine and v == "_"
	end

	return #result, isAllNum, isAllUnderLine
end

function NamingView:_onValueChanged()
	self:_updateTips(0)

	local value = self._inputRoleName:GetText()
	local t = StringUtil.utf8split(value)
	local len = 0
	local result = ""
	local count = math.min(inputLenLimit, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	self._inputRoleName:SetText(result)
	goutil.setActive(self._imgPen, len <= 0)
end

function NamingView:_onClickCreateRole()
	if self._isLocked then
		return
	end

	local name = self._inputRoleName:GetText()
	local isValid = self:_checkNameValid(name)

	if isValid then
		self._isLocked = true

		FloatWordMgr.instance:lock()
		RoleController.instance:createPlayerName(name, CreateRoleView._selectedSex, self._checkUpdateTips, self)
	end
end

function NamingView:_onCreatePlayerRes(status)
	if status ~= 0 then
		self._isLocked = false
	end
end

function NamingView:_checkUpdateTips(status)
	if string.nilorempty(resultCode[status]) then
		local str = MsgFlowMgr.instance:getResultCodeStr(status)

		FloatWordMgr.instance:show(str)
	else
		self:_updateTips(status)
	end
end

function NamingView:_onClickRefreshName()
	self._inputRoleName:SetText(self:getRandomName())
	goutil.setActive(self._rectTips.gameObject, false)
end

function NamingView:_onClickInput()
	if self._inputRoleName.input.isFocused then
		self:_updateTips(0)
	end
end

return NamingView
