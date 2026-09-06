-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/view/GroupRechargeMatchView.lua

module("logic.extensions.grouprecharge.view.GroupRechargeMatchView", package.seeall)

local GroupRechargeMatchView = class("GroupRechargeMatchView", ViewComponent)
local UnityTime = UnityEngine.Time

function GroupRechargeMatchView:ctor()
	GroupRechargeMatchView.super.ctor(self)
end

function GroupRechargeMatchView:unbindEvents()
	GroupRechargeMatchView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GroupRechargeMatchView:bindEvents()
	GroupRechargeMatchView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function GroupRechargeMatchView:buildUI()
	GroupRechargeMatchView.super.buildUI(self)

	self._matchingNode = self:getGo("matching")
	self._btnClose = self:getBtn("matching/btnCancel")
	self._txtTime = self:getTxt("matching/txtTime")
	self._successNode = self:getGo("success")
	self._playersNode = self:getGo("matching/players"):GetComponent(ComponentType.UILayoutSingleLine)
end

function GroupRechargeMatchView:onExit()
	GroupRechargeMatchView.super.onExit(self)

	local controller = GroupRechargeController.instance

	controller:unregisterLocalNotify(GroupRechargeController.E_PersonalMatchingRes, self._onMatchResp, self)
	controller:unregisterLocalNotify(GroupRechargeController.E_TeamMatchingRes, self._onMatchResp, self)
	controller:unregisterLocalNotify(GroupRechargeController.E_NotifyMatchingSuccessRes, self._onMatchSuc, self)
	controller:unregisterLocalNotify(GroupRechargeController.E_NotifyMatchingFailRes, self._onMatchFail, self)
	GroupRechargeAgent.instance:sendPM_GroupRechargeCancelMatchingReq()

	for i = 1, self._playersNode.transform.childCount do
		local go = self._playersNode.transform:GetChild(i - 1).gameObject
		local headcell = goutil.findChild(go, "headcell")

		HeadItemController.instance:resetHeadCell(headcell)
	end

	removetimer(self._updateMatchingTime, self)

	self._startMatchTime = nil

	self:_stopMatchingEff()
	self:_stopMatchSuccessEff()

	self._players = {}
end

function GroupRechargeMatchView:onEnter()
	GroupRechargeMatchView.super.onEnter(self)

	local controller = GroupRechargeController.instance

	controller:registerLocalNotify(GroupRechargeController.E_PersonalMatchingRes, self._onMatchResp, self)
	controller:registerLocalNotify(GroupRechargeController.E_TeamMatchingRes, self._onMatchResp, self)
	controller:registerLocalNotify(GroupRechargeController.E_NotifyMatchingSuccessRes, self._onMatchSuc, self)
	controller:registerLocalNotify(GroupRechargeController.E_NotifyMatchingFailRes, self._onMatchFail, self)

	self._players = {}
	self._maxMatchTime = GroupRechargeModel.instance.activityConf.maxMatchSec

	self:_startMatching()
end

function GroupRechargeMatchView:_startMatching()
	self:_playMatchingEff()

	self._startMatchTime = UnityTime.realtimeSinceStartup

	if GroupRechargeModel.instance:getTeamInfo():isInTeam() then
		GroupRechargeAgent.instance:sendPM_GroupRechargeTeamMatchingReq()
	else
		GroupRechargeAgent.instance:sendPM_GroupRechargePersonalMatchingReq()
	end

	self:_refreshView()
end

function GroupRechargeMatchView:_refreshView()
	removetimer(self._updateMatchingTime, self)

	if #self._players == 2 then
		-- block empty
	else
		self._successNode:SetActive(false)
		self._matchingNode:SetActive(true)
		self:_refreshPlayers()
		self:_updateMatchingTime()
		settimer(1, self._updateMatchingTime, self)
	end
end

function GroupRechargeMatchView:_updateMatchingTime()
	local deltaTime = UnityTime.realtimeSinceStartup - self._startMatchTime
	local min = math.floor(deltaTime / 60)
	local sec = math.floor(deltaTime % 60)

	self._txtTime.text = string.format("%02d:%02d", min, sec)
end

function GroupRechargeMatchView:_onMatchResp(status)
	if status ~= 0 then
		self:close()
	end
end

function GroupRechargeMatchView:_onMatchSuc(status, msg)
	if status == 0 then
		table.insert(self._players, msg.captainHeadInfo)
		table.insert(self._players, msg.memberHeadInfo)
		self._successNode:SetActive(true)
		self._matchingNode:SetActive(false)
		removetimer(self._updateMatchingTime, self)
		self:_refreshPlayers()
		self:_playMatchSuccessEff()
	end
end

function GroupRechargeMatchView:_onMatchFail(status, msg)
	if status == 0 then
		if msg.reason == -1 then
			FloatWordMgr.instance:show("目前没有匹配玩家，请稍后再试")
		end

		self:close()
	end
end

function GroupRechargeMatchView:_refreshPlayers()
	local currentPlayerCount = #self._players
	local childCount = self._playersNode.transform.childCount

	while childCount < currentPlayerCount do
		childCount = childCount + 1

		UGUIToolHelper.AddChild(self._playersNode.gameObject, self._playersNode.transform:GetChild(0).gameObject)
	end

	for i = 1, currentPlayerCount do
		local go = self._playersNode.transform:GetChild(i - 1).gameObject
		local playerInfo = self._players[i]
		local headcell = goutil.findChild(go, "headcell")
		local txtName = goutil.findChildTextComponent(go, "txtName")

		if not playerInfo then
			headcell:SetActive(false)

			txtName.text = ""
		else
			HeadItemController.instance:setHeadCellByInfo(headcell, playerInfo)

			txtName.text = self._players[i].userId == RoleModel.instance:getUserId() and string.format("<color=#62f6ff>%s</color>", playerInfo.userName) or string.format("<color=#ffffff>%s</color>", playerInfo.userName)

			headcell:SetActive(true)
		end

		go:SetActive(true)
	end

	for i = currentPlayerCount + 1, childCount do
		local go = self._playersNode.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._playersNode:Layout()
end

function GroupRechargeMatchView:_onClickClose()
	self:close()
end

function GroupRechargeMatchView:_playMatchingEff()
	self:_stopMatchingEff()

	local effPath = "20220401/caijingling/fx_ui_pipeizhong_cjl.prefab"

	self._matchingEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true)

	self._matchingEff:setParent(self.mainGO.transform)
	self._matchingEff:setLocalPos(0, 0, 0)
	self._matchingEff:setScale(1)
end

function GroupRechargeMatchView:_stopMatchingEff()
	if self._matchingEff then
		UIEffectManager.instance:stopEffect(self._matchingEff)

		self._matchingEff = nil
	end
end

function GroupRechargeMatchView:_playMatchSuccessEff()
	self:_stopMatchSuccessEff()

	local effPath = "20220401/caijingling/fx_ui_pipeichenggong_cjl.prefab"

	self._matchSuccessEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, false)

	self._matchSuccessEff:setParent(self.mainGO.transform)
	self._matchSuccessEff:setLocalPos(0, 0, 0)
	self._matchSuccessEff:setScale(1)
	self._matchSuccessEff:setEffTime(2)

	function self._matchSuccessEff.finishHandler()
		self:close()
	end
end

function GroupRechargeMatchView:_stopMatchSuccessEff()
	if self._matchSuccessEff then
		UIEffectManager.instance:stopEffect(self._matchSuccessEff)

		self._matchSuccessEff = nil
	end
end

return GroupRechargeMatchView
