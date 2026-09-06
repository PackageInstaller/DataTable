-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsMatchingView.lua

module("logic.extensions.goddessglory.view.GuessPetsMatchingView", package.seeall)

local GuessPetsMatchingView = class("GuessPetsMatchingView", ViewComponent)
local UnityTime = UnityEngine.Time

function GuessPetsMatchingView:buildUI()
	GuessPetsMatchingView.super.buildUI(self)

	self._matchingNode = self:getGo("matching")
	self._btnClose = self:getBtn("matching/btnCancel")
	self._txtTime = self:getTxt("matching/txtTime")
	self._successNode = self:getGo("success")
	self._playersNode = self:getGo("matching/players"):GetComponent(ComponentType.UILayoutSingleLine)
end

function GuessPetsMatchingView:bindEvents()
	GuessPetsMatchingView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function GuessPetsMatchingView:unbindEvents()
	GuessPetsMatchingView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GuessPetsMatchingView:onEnter()
	GuessPetsMatchingView.super.onEnter(self)
	self:_startMatching()
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsPlayerEnter, self._onGuessPetsPlayerEnter, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsPlayerExit, self._onGuessPetsPlayerExit, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsExitMatching, self._onGuessPetsExitMatching, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsMatchingSuccess, self._onGuessPetsMatchingSuccess, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsMatchingFailed, self._onGuessPetsMatchingFailed, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGuessPetsGameAbort, self._onGuessPetsGameAbort, self)
end

function GuessPetsMatchingView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsGameAbort, self._onGuessPetsGameAbort, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsMatchingFailed, self._onGuessPetsMatchingFailed, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsMatchingSuccess, self._onGuessPetsMatchingSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsExitMatching, self._onGuessPetsExitMatching, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsPlayerEnter, self._onGuessPetsPlayerEnter, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGuessPetsPlayerExit, self._onGuessPetsPlayerExit, self)
	GuessPetsMatchingView.super.onExit(self)

	for i = 1, self._playersNode.transform.childCount do
		local go = self._playersNode.transform:GetChild(i - 1).gameObject
		local headcell = goutil.findChild(go, "headcell")

		HeadItemController.instance:resetHeadCell(headcell)
	end

	removetimer(self._updateMatchingTime, self)

	self._startMatchTime = nil

	self:_stopMatchingEff()
	self:_stopMatchSuccessEff()
end

function GuessPetsMatchingView:_startMatching()
	self:_playMatchingEff()

	self._startMatchTime = UnityTime.realtimeSinceStartup

	GuessPetController.instance:startMatchingPlayers()
	self:_refreshView()
end

function GuessPetsMatchingView:_refreshView()
	removetimer(self._updateMatchingTime, self)

	if GuessPetModel.instance:isMaxMatchingPlayers() then
		-- block empty
	else
		self._successNode:SetActive(false)
		self._matchingNode:SetActive(true)
		self:_refreshPlayers()
		self:_updateMatchingTime()
		settimer(1, self._updateMatchingTime, self)
	end
end

function GuessPetsMatchingView:_updateMatchingTime()
	local deltaTime = UnityTime.realtimeSinceStartup - self._startMatchTime

	if deltaTime <= GuessPetModel.instance:getMaxMatchingSec() then
		local min = math.floor(deltaTime / 60)
		local sec = math.floor(deltaTime % 60)

		self._txtTime.text = string.format("%02d:%02d", min, sec)
	else
		self:_onMatchingTimeout()
	end
end

function GuessPetsMatchingView:_onMatchingTimeout()
	FloatWordMgr.instance:show("目前没有匹配玩家，请稍后再试")
	GuessPetController.instance:setMatchingRemainTime(0)
	self:close()
end

function GuessPetsMatchingView:_refreshPlayers()
	local maxPlayer = GuessPetModel.instance:getMaxPlayerCount()
	local childCount = self._playersNode.transform.childCount

	while childCount < maxPlayer do
		childCount = childCount + 1

		UGUIToolHelper.AddChild(self._playersNode.gameObject, self._playersNode.transform:GetChild(0).gameObject)
	end

	local currPlayers = GuessPetModel.instance:getMatchingPlayers()

	for i = 1, maxPlayer do
		local go = self._playersNode.transform:GetChild(i - 1).gameObject
		local playerInfo = currPlayers[i]
		local wait = goutil.findChild(go, "wait")
		local headcell = goutil.findChild(go, "headcell")
		local txtName = goutil.findChildTextComponent(go, "txtName")

		if not playerInfo then
			wait:SetActive(true)
			headcell:SetActive(false)

			txtName.text = "<color=#ffffff>待加入...</color>"
		else
			HeadItemController.instance:setHeadCellByInfo(headcell, playerInfo)

			txtName.text = currPlayers[i].userId == RoleModel.instance:getUserId() and string.format("<color=#62f6ff>%s</color>", playerInfo.userName) or string.format("<color=#ffffff>%s</color>", playerInfo.userName)

			wait:SetActive(false)
			headcell:SetActive(true)
		end

		go:SetActive(true)
	end

	for i = maxPlayer + 1, childCount do
		local go = self._playersNode.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._playersNode:Layout()
end

function GuessPetsMatchingView:_onClickClose()
	GuessPetController.instance:cancelMatchingPlayers()
end

function GuessPetsMatchingView:_onGuessPetsPlayerEnter()
	self:_refreshView()
end

function GuessPetsMatchingView:_onGuessPetsPlayerExit()
	self:_refreshView()
end

function GuessPetsMatchingView:_onGuessPetsExitMatching()
	self:close()
end

function GuessPetsMatchingView:_onGuessPetsMatchingSuccess()
	self._successNode:SetActive(true)
	self._matchingNode:SetActive(false)
	removetimer(self._updateMatchingTime, self)
	self:_playMatchSuccessEff()
end

function GuessPetsMatchingView:_onGuessPetsMatchingFailed()
	self:close()
end

function GuessPetsMatchingView:_onGuessPetsGameAbort()
	self:close()
end

function GuessPetsMatchingView:_playMatchingEff()
	self:_stopMatchingEff()

	local effPath = "20220401/caijingling/fx_ui_pipeizhong_cjl.prefab"

	self._matchingEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true)

	self._matchingEff:setParent(self.mainGO.transform)
	self._matchingEff:setLocalPos(0, 0, 0)
	self._matchingEff:setScale(1)
end

function GuessPetsMatchingView:_stopMatchingEff()
	if self._matchingEff then
		UIEffectManager.instance:stopEffect(self._matchingEff)

		self._matchingEff = nil
	end
end

function GuessPetsMatchingView:_playMatchSuccessEff()
	self:_stopMatchSuccessEff()

	local effPath = "20220401/caijingling/fx_ui_pipeichenggong_cjl.prefab"

	self._matchSuccessEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, false)

	self._matchSuccessEff:setParent(self.mainGO.transform)
	self._matchSuccessEff:setLocalPos(0, 0, 0)
	self._matchSuccessEff:setScale(1)
	self._matchSuccessEff:setEffTime(1.5)

	function self._matchSuccessEff.finishHandler()
		GuessPetController.instance:setPlayedMatchEff(true)
	end
end

function GuessPetsMatchingView:_stopMatchSuccessEff()
	if self._matchSuccessEff then
		UIEffectManager.instance:stopEffect(self._matchSuccessEff)

		self._matchSuccessEff = nil
	end
end

return GuessPetsMatchingView
