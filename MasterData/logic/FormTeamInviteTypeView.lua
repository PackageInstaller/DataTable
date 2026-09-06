-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamInviteTypeView.lua

module("logic.extensions.formteam.view.FormTeamInviteTypeView", package.seeall)

local FormTeamInviteTypeView = class("FormTeamInviteTypeView", ViewComponent)

function FormTeamInviteTypeView:ctor()
	FormTeamInviteTypeView.super.ctor(self)
end

function FormTeamInviteTypeView:unbindEvents()
	FormTeamInviteTypeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFirend)
	GameUtil.rmClickHandler(self._btnFamily)
	GameUtil.rmClickHandler(self._btnZone)
	GameUtil.rmClickHandler(self._btnAll)
end

function FormTeamInviteTypeView:bindEvents()
	FormTeamInviteTypeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFirend, self._onClickFriend, self)
	GameUtil.addClickHandler(self._btnFamily, self._onClickFamily, self)
	GameUtil.addClickHandler(self._btnZone, self._onClickZone, self)
	GameUtil.addClickHandler(self._btnAll, self._onClickAll, self)
end

function FormTeamInviteTypeView:buildUI()
	FormTeamInviteTypeView.super.buildUI(self)

	self._btnFirend = self:getGo("btnFirend")
	self._btnFamily = self:getGo("btnFamily")
	self._btnZone = self:getGo("zone/btn")
	self._conZone = self:getGo("zone/myNum/imgIcon")
	self._txtNumZone = self:getTxt("zone/myNum/txtNum")
	self._btnAll = self:getGo("all/btn")
	self._allMyNumGo = self:getGo("all/myNum")
	self._conAll = self:getGo("all/myNum/imgIcon")
	self._txtNumAll = self:getTxt("all/myNum/txtNum")
	self._btnClose = self:getGo("btnClose")
end

function FormTeamInviteTypeView:onExit()
	FormTeamInviteTypeView.super.onExit(self)
end

function FormTeamInviteTypeView:onEnter()
	FormTeamInviteTypeView.super.onEnter(self)

	local teamCfg = self:getFirstParam()
	local tabCfg = FormTeamConfig.instance:getTabCfgByTabId(teamCfg.typeId)
	local teamInfo = FormTeamModel.instance:getCurTeamInfo()
	local dataT = {
		tpId = 76,
		params = {
			teamId = teamInfo.id,
			groupId = teamInfo.groupId,
			teamCode = teamInfo.code,
			typeName = tabCfg.name,
			bossName = teamCfg.name,
			zdlLimit = teamInfo.zdlLimit
		}
	}

	self._content = GameUtil.jsonToString(dataT)

	local matInfo = ChatConfig.instance:GetSendMat(GameEnum.ChatChannel.World)

	MaterialMgr.setIcon(self._conZone, matInfo[1].type, matInfo[1].id)

	self._txtNumZone.text = MaterialModel.instance:getMaterialsNumber(matInfo[1].type, matInfo[1].id)
	matInfo = ChatConfig.instance:GetSendMat(GameEnum.ChatChannel.Help)

	goutil.setActive(self._allMyNumGo, matInfo)

	if matInfo and #matInfo > 0 then
		MaterialMgr.setIcon(self._conAll, matInfo[1].type, matInfo[1].id)

		self._txtNumAll.text = MaterialModel.instance:getMaterialsNumber(matInfo[1].type, matInfo[1].id)
	end
end

function FormTeamInviteTypeView:_onClickFriend()
	UIStateManager.instance:push(ViewName.FormTeamInviteView)
	self:close()
end

function FormTeamInviteTypeView:_onClickFamily()
	if FamilyController.instance:checkFamilyOpen(true) then
		ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.League, GameEnum.ChatType.System, self._content)
	end

	self:close()
end

function FormTeamInviteTypeView:_onClickZone()
	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.World, GameEnum.ChatType.System, self._content)
	self:close()
end

function FormTeamInviteTypeView:_onClickAll()
	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Help, GameEnum.ChatType.System, self._content)
	self:close()
end

return FormTeamInviteTypeView
