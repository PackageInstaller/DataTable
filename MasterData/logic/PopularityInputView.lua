-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularityInputView.lua

module("logic.extensions.popularitylist.view.PopularityInputView", package.seeall)

local PopularityInputView = class("PopularityInputView", ViewComponent)

function PopularityInputView:buildUI()
	PopularityInputView.super.buildUI(self)

	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtLimitNameCol = goutil.findChildTextComponent(self.mainGO, "scrollerview/Viewport/Content/nameCol/txtLimit")
	self._txtLimitDescCol = goutil.findChildTextComponent(self.mainGO, "scrollerview/Viewport/Content/descCol/txtLimit")
	self._nameColInputField = self:getInput("scrollerview/Viewport/Content/nameCol/input")
	self._descColInputField = self:getInput("scrollerview/Viewport/Content/descCol/input")
	self._maxNameStrLength = 20
	self._maxDescStrLength = 200
end

function PopularityInputView:bindEvents()
	PopularityInputView.super.bindEvents(self)
	self._nameColInputField:SetCharacterLimit(self._maxNameStrLength)
	self._nameColInputField:AddOnValueChanged(self._onValueChangedAboutName, self)
	self._descColInputField:SetCharacterLimit(self._maxDescStrLength)
	self._descColInputField:AddOnValueChanged(self._onValueChangedAboutDesc, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function PopularityInputView:unbindEvents()
	PopularityInputView.super.unbindEvents(self)
	self._nameColInputField:RemoveOnValueChanged()
	self._descColInputField:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function PopularityInputView:onEnter()
	PopularityInputView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	self._id = checknumber(params[2])

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失id")

		return
	end

	self:_onValueChangedAboutName("")
	self:_onValueChangedAboutDesc("")
	GlobalDispatcher:addListener(GlobalNotify.PopularityListSkinVoteRes, self._handleSkinVoteRes, self)
end

function PopularityInputView:onExit()
	PopularityInputView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PopularityListSkinVoteRes, self._handleSkinVoteRes, self)
end

function PopularityInputView:_onValueChangedAboutName(str)
	str = tostring(str)

	local limitedLen = self._maxNameStrLength
	local result, len = self:_getLimitStr(str, limitedLen)

	self._txtLimitNameCol.text = string.format("%s/%s", len, limitedLen)

	self._nameColInputField:SetText(result)
end

function PopularityInputView:_onValueChangedAboutDesc(str)
	str = tostring(str)

	local limitedLen = self._maxDescStrLength
	local result, len = self:_getLimitStr(str, limitedLen)

	self._txtLimitDescCol.text = string.format("%s/%s", len, limitedLen)

	self._descColInputField:SetText(result)
end

function PopularityInputView:_getLimitStr(value, limitedLen)
	local t = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(limitedLen, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	return result, count
end

function PopularityInputView:_onClickBtnSure()
	local nameStr = self._nameColInputField:GetText()
	local descStr = self._descColInputField:GetText()
	local res_1 = self:_getInpuStrResult(nameStr)

	if res_1 == GameEnum.ResultCode.IsNil then
		FloatWordMgr.instance:show(lang("精灵名字不能为空"))

		return
	elseif res_1 == GameEnum.ResultCode.PunctuationFailed then
		FloatWordMgr.instance:show(lang("全都输入空格，无法提交哦"))

		return
	end

	local res_2 = self:_getInpuStrResult(descStr)

	if res_2 == GameEnum.ResultCode.IsNil then
		FloatWordMgr.instance:show(lang("期待理由不能为空"))

		return
	elseif res_2 == GameEnum.ResultCode.PunctuationFailed then
		FloatWordMgr.instance:show(lang("全都输入空格，无法提交哦"))

		return
	end

	local comment = string.format("%s\n%s", nameStr, descStr)

	PopularityListController:sendPM_SkinVoteReq(self._activityId, self._id, comment)
end

function PopularityInputView:_getInpuStrResult(str)
	local result = GameEnum.ResultCode.Success

	if string.nilorempty(str) then
		result = GameEnum.ResultCode.IsNil
	elseif self:_isPunctuationFailed(str) then
		result = GameEnum.ResultCode.PunctuationFailed
	end

	return result
end

function PopularityInputView:_isPunctuationFailed(str)
	return string.match(str, "^%s*$")
end

function PopularityInputView:_handleSkinVoteRes()
	FloatWordMgr.instance:show(lang("提交成功"))
	self:close()
end

return PopularityInputView
