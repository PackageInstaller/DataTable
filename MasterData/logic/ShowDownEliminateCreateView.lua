-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateCreateView.lua

module("logic.extensions.showdown.view.ShowDownEliminateCreateView", package.seeall)

local ShowDownEliminateCreateView = class("ShowDownEliminateCreateView", ViewComponent)
local inputLenLimit = 5
local regex = "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"

function ShowDownEliminateCreateView:ctor()
	ShowDownEliminateCreateView.super.ctor(self)
end

function ShowDownEliminateCreateView:bindEvents()
	ShowDownEliminateCreateView.super.bindEvents(self)
	self._input:AddOnValueChanged(self._onValueChanged, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ShowDownEliminateCreateView:unbindEvents()
	ShowDownEliminateCreateView.super.unbindEvents(self)
	self._btnReset:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._input:RemoveOnValueChanged()
end

function ShowDownEliminateCreateView:buildUI()
	ShowDownEliminateCreateView.super.buildUI(self)

	self._input = self:getInput("InputField")

	self._input:SetCharacterLimit(inputLenLimit)

	self._btnReset = self:getBtn("btnReset")
	self._btnSure = self:getBtn("btnSure")
	self._txtTips = self:getTxt("txtTips")
	self._imgEmblem = self:getGo("imgEmblemBg/imgEmblem")
	self._tipsStrs = {
		[-1] = "战队名可以由<color=#ffffff>2-5个汉字、大写字母、小写字母、数字、下划线</color>组成",
		[-23004] = "该战队名称不可用 请重试！",
		[-23019] = "该战队名称不可用 请重试！"
	}
end

function ShowDownEliminateCreateView:onEnter()
	ShowDownEliminateCreateView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._teamId = checknumber(params[2])
	self._activityType = ShowDownController.instance:getActivityType()
	self._activityId = ShowDownController.instance:getActivityId()
	self._txtTips.text = string.format("在预选赛排名第<color=#0083E7FF>%s</color>名", self._teamId)
	self._iconCfgs = ShowDownConfig.instance:getTeamIconCfg(self._activityId)

	local teamData = ShowDownConfig.instance:getTeamData(self._activityId)

	self._teamLogoId = teamData.defaultTeamIcon

	self:_resetEmblem()
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_SetMyTeamInfoRes, self._onCreateSuc, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownTeam_SetMyTeamInfoError, self._updateTips, self)
end

function ShowDownEliminateCreateView:onExit()
	ShowDownEliminateCreateView.super.onExit(self)
	uGuiUtil.clearImage(self._imgEmblem)
end

function ShowDownEliminateCreateView:_onClickReset()
	if self._iconCfgs and #self._iconCfgs > 0 then
		self._teamLogoId = (self._teamLogoId + 1) % #self._iconCfgs

		if self._teamLogoId == 0 then
			self._teamLogoId = #self._iconCfgs
		end

		self:_resetEmblem()
	end
end

function ShowDownEliminateCreateView:_resetEmblem()
	if self._iconCfgs then
		local iconCfg = self._iconCfgs[self._teamLogoId]

		if iconCfg then
			uGuiUtil.clearImage(self._imgEmblem)

			if iconCfg then
				local path = GameUrl.getItemIconUrl(iconCfg.iconPath)

				if not GameUtil.isEmptyString(path) then
					uGuiUtil.setSpriteToImage(self._imgEmblem, uGuiUtil.SpriteType.BigBg, path)
				end
			end
		end
	end
end

function ShowDownEliminateCreateView:_onClickSure()
	local name = self._input:GetText()
	local isValid = self:_checkNameValid(name)

	if isValid then
		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("是否确认使用该名称与队徽,确认后将不可更改", name), function()
			local req = ShowDownQualifyAndTeamExtension_pb.PM_ShowDownTeam_SetMyTeamInfoReq()
			local teamInfo = req.teamInfo

			teamInfo.teamId = self._teamId
			teamInfo.teamName = name
			teamInfo.teamLogo = self._teamLogoId

			ShowDownController.instance:sendPM_ShowDownTeam_SetMyTeamInfoReq(self._activityId, teamInfo)
		end)
	end
end

function ShowDownEliminateCreateView:_checkNameValid(name)
	local realLen, isAllNum, isAllUnderLine = LoginConfig.instance:getNameRealLen(name)
	local isValid = false

	if string.len(name) == 0 then
		self:_updateTips(-1)
	elseif not System.Text.RegularExpressions.Regex.IsMatch(name, regex) then
		self:_updateTips(-1)
	elseif realLen < 2 then
		self:_updateTips(-1)
	elseif isAllNum then
		self:_updateTips(-1)
	elseif isAllUnderLine then
		self:_updateTips(-1)
	elseif realLen > inputLenLimit then
		self:_updateTips(-1)
	else
		isValid = true
	end

	return isValid
end

function ShowDownEliminateCreateView:_updateTips(status)
	if not self._tipsStrs[status] then
		local showTips = string.format("信息设置错误：%s", status)

		FloatWordMgr.instance:show(self._tipsStrs[status])
	end
end

function ShowDownEliminateCreateView:_onValueChanged()
	local value = self._input:GetText()
	local t = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(5, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	self._input:SetText(result)
end

function ShowDownEliminateCreateView:_onCreateSuc()
	self:close()
	FloatWordMgr.instance:show("设置完成")
end

return ShowDownEliminateCreateView
