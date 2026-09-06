-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/GroupRegressInviteView.lua

module("logic.extensions.groupregress.view.GroupRegressInviteView", package.seeall)

local GroupRegressInviteView = class("GroupRegressInviteView", ViewComponent)
local BindResultTips = {
	[0] = "成功加入队伍！",
	"不能绑定自己的邀请码",
	"邀请码无效",
	"对方邀请码使用达上限，无法加入",
	"系统繁忙请重试"
}

function GroupRegressInviteView:buildUI()
	GroupRegressInviteView.super.buildUI(self)

	self._inputInviteCode = self:getInput("InputC_Search")
	self._btnSure = self:getGo("btnSure")
	self._tagWarning = self:getGo("tagWarning")
	self._btnTask = self:getGo("btnTask")
end

function GroupRegressInviteView:bindEvents()
	GroupRegressInviteView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
end

function GroupRegressInviteView:unbindEvents()
	GroupRegressInviteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnTask)
end

function GroupRegressInviteView:onEnter()
	GroupRegressInviteView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = GroupRegressController.instance:getSubMo(self._activityId)

	local bindInviteOpenContext = GroupRegressController.instance:consumeBindInviteOpenContext(self._activityId)

	self._inviteCode = bindInviteOpenContext and bindInviteOpenContext.inviteCode

	if not string.nilorempty(self._inviteCode) then
		self._inputInviteCode:SetText(self._inviteCode)
	end

	self:_updateWarning()
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressGetInfoRes, self._onHandleGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressBindRes, self._onHandleBindRes, self)
end

function GroupRegressInviteView:onExit()
	GroupRegressInviteView.super.onExit(self)
end

function GroupRegressInviteView:_onHandleGetInfoRes()
	self:_updateWarning()
end

function GroupRegressInviteView:_isActivePlayer()
	return self._subMo:getPlayerType() == GroupRegressEnum.PlayerType.Active
end

function GroupRegressInviteView:_canBindInvite()
	local playerType = self._subMo:getPlayerType()

	return not string.nilorempty(playerType) and playerType ~= GroupRegressEnum.PlayerType.Active
end

function GroupRegressInviteView:_updateWarning()
	local isActivePlayer = self:_isActivePlayer()

	GameUtil.SetActive(self._btnSure, self:_canBindInvite())
	GameUtil.SetActive(self._tagWarning, isActivePlayer)
end

function GroupRegressInviteView:_onClickBtnSure()
	if not self:_canBindInvite() then
		self:_updateWarning()

		return
	end

	local inviteCode = self:_getInviteCode()

	if string.nilorempty(inviteCode) then
		FloatWordMgr.instance:show("请输入邀请码")

		return
	end

	GroupRegressController.instance:sendPM_GroupRegressBindReq(self._activityId, inviteCode)
end

function GroupRegressInviteView:_getInviteCode()
	local inputText = self._inputInviteCode:GetText() or ""
	local cleanText = string.gsub(inputText, "%s", "")
	local inviteCode = string.match(cleanText, "%【(.-)%】")

	return inviteCode or cleanText
end

function GroupRegressInviteView:_onHandleBindRes()
	local resultCode = self._subMo:getBindResultCode()

	if not BindResultTips[resultCode] then
		FloatWordMgr.instance:show(BindResultTips[resultCode])

		if resultCode == 0 then
			self._inputInviteCode:SetText("")
			GroupRegressController.instance:sendPM_GroupRegressGetInfoReq(self._activityId)
		end
	end
end

function GroupRegressInviteView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

return GroupRegressInviteView
