-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetRenameView.lua

module("logic.extensions.cutepet.view.CutePetRenameView", package.seeall)

local CutePetRenameView = class("CutePetRenameView", ViewComponent)
local inputLenLimit = 7
local regex = "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"
local resultCode = {}

resultCode[0] = "宠物名可以由<color=#ffffff>2-7个汉字、大写字母、小写字母、数字、下划线</color>组成。"
resultCode[-13526] = "宠物名不可为空"
resultCode[-13530] = "宠物名字不能<color=#ffffff>少于2个汉字或字母</color>哦！"
resultCode[-13528] = "宠物名字太长了"
resultCode[-1505] = "有些字不太合适宠物哦，再想想看？"
resultCode[-1513] = "宠物名字格式有误哦(只能由汉字、字母、数字和下划线等组成，且不能全为数字或下划线)"

function CutePetRenameView:ctor()
	CutePetRenameView.super.ctor(self)
end

function CutePetRenameView:destroyUI()
	CutePetRenameView.super.destroyUI(self)
end

function CutePetRenameView:onExitFinished()
	CutePetRenameView.super.onExitFinished(self)
end

function CutePetRenameView:onEnterFinished()
	CutePetRenameView.super.onEnterFinished(self)
end

function CutePetRenameView:unbindEvents()
	CutePetRenameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnOK)
	GameUtil.rmClickHandler(self._btnClose)
	self._inputName:RemoveOnValueChanged()
	Framework.UIClickTrigger.Get(self._inputName.input.gameObject):RemoveClickListener()
end

function CutePetRenameView:bindEvents()
	CutePetRenameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnOK, self._onClickOK, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	self._inputName:AddOnValueChanged(self._onValueChanged, self)
	Framework.UIClickTrigger.Get(self._inputName.input.gameObject):AddClickListener(self._onClickInput, self, nil)
end

function CutePetRenameView:onExit()
	CutePetRenameView.super.onExit(self)
end

function CutePetRenameView:buildUI()
	CutePetRenameView.super.buildUI(self)

	self._btnOK = self:getGo("btnOK")
	self._btnClose = self:getGo("btnClose")
	self._inputName = self:getInput("inputRoleName")

	self._inputName:SetCharacterLimit(inputLenLimit)
end

function CutePetRenameView:onEnter()
	CutePetRenameView.super.onEnter(self)

	self._petId = self:getFirstParam()
	self._petMo = CutePetModel.instance:getCutePeMo(self._petId)

	self._inputName:SetText(self._petMo.name)
end

function CutePetRenameView:_onClickInput()
	if self._inputName.input.isFocused then
		-- block empty
	end
end

function CutePetRenameView:_showTips(status)
	FloatWordMgr.instance:show(lang(resultCode[status] or ""))
end

function CutePetRenameView:_onValueChanged()
	local v = FriendConfig.instance:getCommonValue("NO_RENAME_PERIOD")
	local times = string.split(v, "#")

	if #times == 2 and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
		FloatWordMgr.instance:show("改名功能正在进行技术维护，具体开放时间请留意公告！")
		self._inputName:SetText(self._petMo.name)

		return
	end

	local value = self._inputName:GetText()
	local t = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(inputLenLimit, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	self._inputName:SetText(result)
end

function CutePetRenameView:_checkNameValid(name)
	local realLen, isAllNum, isAllUnderLine = LoginConfig.instance:getNameRealLen(name)
	local isValid = false

	if string.len(name) == 0 then
		self:_showTips(-13526)
	elseif not System.Text.RegularExpressions.Regex.IsMatch(name, regex) then
		self:_showTips(-13530)
	elseif realLen < 2 then
		self:_showTips(-13526)
	elseif isAllNum then
		self:_showTips(-1513)
	elseif isAllUnderLine then
		self:_showTips(-1513)
	elseif realLen > inputLenLimit then
		self:_showTips(-13528)
	else
		isValid = true
	end

	return isValid
end

function CutePetRenameView:_onClickOK()
	self._curName = self._inputName:GetText()

	local isValid = self:_checkNameValid(self._curName)

	if isValid == true then
		if self._petMo.name ~= self._curName then
			CutePetController.instance:sendPM_CutePetRenameReq(self._petMo.id, self._curName)
		end

		self:close()
	end
end

function CutePetRenameView:_onClickClose()
	if self._closeHandler then
		GameUtil.callBack(self._closeHandler)
		self:close()
	else
		self:close()
	end
end

return CutePetRenameView
