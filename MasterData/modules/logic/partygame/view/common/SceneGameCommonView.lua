-- chunkname: @modules/logic/partygame/view/common/SceneGameCommonView.lua

module("modules.logic.partygame.view.common.SceneGameCommonView", package.seeall)

local SceneGameCommonView = class("SceneGameCommonView", BaseView)

function SceneGameCommonView:onInitView()
	self._gosceneUI = gohelper.findChild(self.viewGO, "#go_sceneUI")
	self._animTips = gohelper.findChildAnim(self.viewGO, "root/toplefttips")
	self._txttip = gohelper.findChildText(self.viewGO, "root/toplefttips/bg/#txt_tip")
	self._btnopen = gohelper.findChildButtonWithAudio(self.viewGO, "root/toplefttips/#btn_open")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/toplefttips/#btn_close")
	self._goplayerlist = gohelper.findChild(self.viewGO, "root/#go_playerlist")
	self._goendui = gohelper.findChild(self.viewGO, "root/partygameendui")
	self._goJoystick = gohelper.findChild(self.viewGO, "#go_Joystick")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")

	gohelper.setActive(self._btnopen, false)
	gohelper.setActive(self._btnclose, true)
	MonoHelper.addNoUpdateLuaComOnceToGo(self._goendui, PartyGameEndUI)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SceneGameCommonView:addEvents()
	self._btnopen:AddClickListener(self._btnopenOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SceneGameCommonView:removeEvents()
	self._btnopen:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function SceneGameCommonView:_btnopenOnClick()
	self._animTips:Play("open")
	gohelper.setActive(self._btnopen, false)
	gohelper.setActive(self._btnclose, true)
end

function SceneGameCommonView:_btncloseOnClick()
	self._animTips:Play("close")
	gohelper.setActive(self._btnopen, true)
	gohelper.setActive(self._btnclose, false)
end

function SceneGameCommonView:_editableInitView()
	self._partygamewaitbar = gohelper.findChild(self.viewGO, "root/partygamewaitbar")
	self._partygamebattlebar = gohelper.findChild(self.viewGO, "root/partygamebattlebar_ver")
	self._partygamebattlebar = self._partygamebattlebar or gohelper.findChild(self.viewGO, "root/partygamebattlebar_hori")
	self._partygameteambar = gohelper.findChild(self.viewGO, "root/partygameteambar")
	self._partygameteambar = self._partygameteambar or gohelper.findChild(self.viewGO, "root/partygamebattlebar_ver/root/partygameteambar")
	self._partygameteambar = self._partygameteambar or gohelper.findChild(self.viewGO, "root/partygamebattlebar_hori/root/partygameteambar")
	self._partygamecountdown = gohelper.findChild(self.viewGO, "root/partygamecountdown")
	self._partygamecountdown = self._partygamecountdown or gohelper.findChild(self.viewGO, "root/partygamebattlebar_ver/root/partygamecountdown")
	self._partygamecountdown = self._partygamecountdown or gohelper.findChild(self.viewGO, "root/partygamebattlebar_hori/root/partygamecountdown")
	self._partygamestartui = gohelper.findChild(self.viewGO, "root/partygamestartui")
	self._partygameroundtip = gohelper.findChild(self.viewGO, "root/partygameroundtip")

	self:onCreateCompData()

	if self.partyGameBattleBarData == nil then
		self.partyGameBattleBarData = {
			partyGameCountDownData = self.partyGameCountDownData
		}
	end

	self.uiComps = {}

	local comps = {
		{
			self._partygamewaitbar,
			PartyGameWaitBar
		},
		{
			self._partygamebattlebar,
			PartyGameBattleBar,
			self.partyGameBattleBarData
		},
		{
			self._partygameteambar,
			PartyGameTeamBar
		},
		{
			self._partygamecountdown,
			PartyGameCountDown,
			self.partyGameCountDownData
		},
		{
			self._partygamestartui,
			PartyGameStartUI
		},
		{
			self._partygameroundtip,
			PartyGameRoundTip
		}
	}

	self.partyGameWaitBar = self:createUIComp(comps[1])
	self.partyGameBattleBar = self:createUIComp(comps[2])
	self.partyGameTeamBar = self:createUIComp(comps[3])
	self.partyGameCountDown = self:createUIComp(comps[4])
	self.partyGameStartUI = self:createUIComp(comps[5])
	self.partyGameRoundTip = self:createUIComp(comps[6])

	for i, comp in ipairs(self.uiComps) do
		comp:setData(comp.dataParam)
	end

	local itemRes = self.viewContainer:getSetting().otherRes.joystick
	local go = self.viewContainer:getResInst(itemRes, self._goJoystick)

	self._JoystickItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, JoystickComp)
	self._playerSceneUIComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gosceneUI, CommonSceneUIComp)
end

function SceneGameCommonView:onCreateCompData()
	self.partyGameCountDownData = nil
end

function SceneGameCommonView:createUIComp(info)
	if info[1] then
		local comps = GameFacade.createLuaCompByGo(info[1], info[2], info[3], self.viewContainer)

		table.insert(self.uiComps, comps)

		return comps
	end
end

function SceneGameCommonView:onUpdateParam()
	return
end

function SceneGameCommonView:onOpen()
	self._curGame = PartyGameController.instance:getCurPartyGame()

	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self._viewDataUpdate, self)
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.PartyLittleGameEnd, self._viewDataUpdate, self)
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.ScoreChange, self.playerScoreChange, self)
	self:initGameView()
end

function SceneGameCommonView:initGameView()
	local co = self._curGame:getGameConfig()

	self._txttip.text = co.desc
end

function SceneGameCommonView:onClose()
	self.removeEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self._viewDataUpdate, self)
	self.removeEventCb(self, PartyGameController.instance, PartyGameEvent.PartyLittleGameEnd, self._viewDataUpdate, self)
	self.removeEventCb(self, PartyGameController.instance, PartyGameEvent.ScoreChange, self.playerScoreChange, self)
end

function SceneGameCommonView:onDestroyView()
	if self._playerInfoComp then
		self._playerInfoComp:onDestroy()
	end
end

function SceneGameCommonView:viewUpdate(logicFrame)
	return
end

function SceneGameCommonView:_viewDataUpdate(logicFrame)
	if self._curGame == nil or self._curGame._csGameBase == nil then
		return
	end

	if not self._playerInfoComp then
		self:createPlayerInfoComp()
	end

	if self._playerSceneUIComp ~= nil then
		self._playerSceneUIComp:initPlayer()
	end

	if self._playerInfoComp then
		self._playerInfoComp:viewDataUpdate()
	end

	self:viewUpdate(logicFrame)
end

function SceneGameCommonView:createPlayerInfoComp()
	local itemRes = self.viewContainer:getSetting().otherRes.playerInfo
	local go = self.viewContainer:getResInst(itemRes, self._goplayerlist)

	self._playerInfoComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PlayerInfoComp)

	if self._playerInfoComp then
		self._playerInfoComp:Init()
	end
end

function SceneGameCommonView:playerScoreChange(uid, scoreDiff)
	if self._playerSceneUIComp then
		self._playerSceneUIComp:showScoreDiff(uid, scoreDiff)
	end
end

return SceneGameCommonView
