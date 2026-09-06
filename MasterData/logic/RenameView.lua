-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/RenameView.lua

module("logic.extensions.roleinfo.view.RenameView", package.seeall)

local RenameView = class("RenameView", ViewComponent)
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
resultCode[-2612] = "不能全部是数字哦！"
resultCode[-2613] = "不能全部是下划线哦！"

local itemCfg = "4:9:0"
local itemCount = 1
local costCfg = "105:142:1"

function RenameView:ctor()
	RenameView.super.ctor(self)
end

function RenameView:buildUI()
	RenameView.super.buildUI(self)

	self._inputRoleName = self:getInput("inputRoleName")

	self._inputRoleName:SetCharacterLimit(inputLenLimit)

	self._rectTips = self:getGo("imgTips")
	self._txtTips = self:getTxt("imgTips/txtTips")
	self._btnRefresh = self:getBtn("btnRefresh")
	self.btnOK = self:getBtn("btnOK")
	self.btnClose = self:getBtn("btnClose")
	self.item = self:getGo("item")
	self.txtNum = self:getTxt("txtNum")
end

function RenameView:bindEvents()
	RenameView.super.bindEvents(self)
	self.btnClose:AddClickListener(self.close, self)
	self._btnRefresh:AddClickListener(self._onClickRefreshName, self)
	self._inputRoleName:AddOnValueChanged(self._onValueChanged, self)
	Framework.UIClickTrigger.Get(self._inputRoleName.input.gameObject):AddClickListener(self._onClickInput, self, nil)
	self.btnOK:AddClickListener(self._onClickCreateRole, self)
end

function RenameView:unbindEvents()
	RenameView.super.unbindEvents(self)
	self._btnRefresh:RemoveClickListener()
	self.btnClose:RemoveClickListener()
	self.btnOK:RemoveClickListener()
	self._inputRoleName:RemoveOnValueChanged()
	Framework.UIClickTrigger.Get(self._inputRoleName.input.gameObject):RemoveClickListener()
end

function RenameView:destroyUI()
	RenameView.super.destroyUI(self)
end

function RenameView:onEnter()
	RenameView.super.onEnter(self)
	self._inputRoleName:SetText(RoleModel.instance:getUserName())
	MaterialMgr.setCellByCfg(itemCfg, self.item)

	local myCount = MaterialMgr.getMatCount(itemCfg)

	self.txtNum.text = myCount >= itemCount and "(" .. myCount .. "/" .. itemCount .. ")" or "(" .. GameUtil.HtmlColorTxt(myCount, GameUtil.goods_color_list[5]) .. "/" .. itemCount .. ")"
end

function RenameView:onEnterFinished()
	RenameView.super.onEnterFinished(self)
end

function RenameView:onExit()
	RenameView.super.onExit(self)
	MaterialMgr.resetAll(self.item)
end

function RenameView:onExitFinished()
	RenameView.super.onExitFinished(self)
end

function RenameView:_onClickRefreshName()
	self._inputRoleName:SetText(LoginConfig.instance:getRandomName())
	goutil.setActive(self._rectTips.gameObject, false)
end

function RenameView:_onClickInput()
	if self._inputRoleName.input.isFocused then
		self:_updateTips(0)
	end
end

function RenameView:_updateTips(status)
	if not self._lastStatus then
		self._lastStatus = status

		settimer(0, self._doUpdateTips, self, false)
	else
		self:_doUpdateTips(status)
	end
end

function RenameView:_doUpdateTips(status)
	status = status or self._lastStatus

	removetimer(self._doUpdateTips, self)

	if not resultCode[status] then
		goutil.setActive(self._rectTips.gameObject, true)

		self._txtTips.text = resultCode[status]
	end
end

function RenameView:_onValueChanged()
	self:_updateTips(0)

	local value = self._inputRoleName:GetText()
	local t = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(inputLenLimit, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	self._inputRoleName:SetText(result)
end

function RenameView:_onClickCreateRole()
	if self._isLocked then
		return
	end

	local name = self._inputRoleName:GetText()

	if name == RoleModel.instance:getUserName() then
		TipsFacade.instance:openCommonTips(lang("名字没有改动"))
	else
		local isValid = self:_checkNameValid(name)

		if isValid then
			if MaterialMgr.getMatCount(itemCfg) >= itemCount then
				TipsFacade.instance:openPopupWindow(lang("tip"), lang("改名成功后会触发重新登录流程，同时改名成功后需要等待<color=#eb4642>24小时</color>才能重新使用改名功能。确定要继续吗？"), function()
					self._isLocked = true

					PlayerAgent.instance:sendPM_ChangeUserNameReq(name, false, self.onRenameOk, self, self.onRenameError)
				end)
			else
				local costNum = MaterialFacade.instance:getGoodCostByStr(costCfg)
				local cfgName = MaterialModel.instance:getMaterialsNameByStr(itemCfg)
				local matStr1 = TipsFacade.instance:getContentMatStr(itemCfg, 50, -10, true)

				TipsFacade.instance:openPopupCostDiamondView(costNum, langPara("您的%s%s不足%s个，可以消耗%s钻石直接改名,是否确认？\n(注意：改名成功后会触发重新登录流程,同时改名成功后需要等待<color=#eb4642>24小时</color>才能重新使用改名功能。)", matStr1, cfgName, itemCount, costNum), function()
					self._isLocked = true

					PlayerAgent.instance:sendPM_ChangeUserNameReq(name, true, self.onRenameOk, self, self.onRenameError)
				end)
			end
		end
	end
end

function RenameView:onRenameOk(msg)
	self._isLocked = false

	self:close()
	RoleAgent.instance:sendExitGameReq()
end

function RenameView:onRenameError(msg, status)
	self._isLocked = false
end

function RenameView:_checkNameValid(name)
	local realLen, isAllNum, isAllUnderLine = LoginConfig.instance:getNameRealLen(name)
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

return RenameView
