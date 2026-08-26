-- chunkname: @modules/logic/partygame/view/common/PartyGameCommonView.lua

module("modules.logic.partygame.view.common.PartyGameCommonView", package.seeall)

local PartyGameCommonView = class("PartyGameCommonView", BaseView)

function PartyGameCommonView:onInitView()
	self._goplayerlist = gohelper.findChild(self.viewGO, "root/#go_playerlist_common")
	self.partygamebattlebar = gohelper.findChild(self.viewGO, "root/partygamebattlebar_ver")
	self.partygamebattlebar = self.partygamebattlebar or gohelper.findChild(self.viewGO, "root/partygamebattlebar_hori")
	self.partygamewaitbar = gohelper.findChild(self.viewGO, "root/partygamewaitbar")
	self.partygameteambar = gohelper.findChild(self.viewGO, "root/partygameteambar")
	self.partygameteambar = self.partygameteambar or gohelper.findChild(self.viewGO, "root/partygamebattlebar_ver/root/partygameteambar")
	self.partygameteambar = self.partygameteambar or gohelper.findChild(self.viewGO, "root/partygamebattlebar_hori/root/partygameteambar")
	self.partygamecountdown = gohelper.findChild(self.viewGO, "root/partygamecountdown")
	self.partygamecountdown = self.partygamecountdown or gohelper.findChild(self.viewGO, "root/partygamebattlebar_ver/root/partygamecountdown")
	self.partygamecountdown = self.partygamecountdown or gohelper.findChild(self.viewGO, "root/partygamebattlebar_hori/root/partygamecountdown")
	self.partygamestartui = gohelper.findChild(self.viewGO, "root/partygamestartui")
	self.partygameroundtip = gohelper.findChild(self.viewGO, "root/partygameroundtip")

	local go = gohelper.create2d(self.viewGO, "partygameendui")

	self._enduiloader = PrefabInstantiate.Create(go)

	self._enduiloader:startLoad("modules/party_game/ui/viewres/common/component/partygameendui.prefab", self._onLoadEndUIFinish, self)
end

function PartyGameCommonView:addEvents()
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.LogicCalFinish, self.updateView, self)
	self.addEventCb(self, PartyGameController.instance, PartyGameEvent.PartyLittleGameEnd, self.updateView, self)
end

function PartyGameCommonView:_onLoadEndUIFinish()
	MonoHelper.addNoUpdateLuaComOnceToGo(self._enduiloader:getInstGO(), PartyGameEndUI)
end

function PartyGameCommonView:onOpen()
	self.curGame = PartyGameController.instance:getCurPartyGame()

	self:onCreateCompData()

	if self.partyGameBattleBarData == nil then
		self.partyGameBattleBarData = {
			partyGameCountDownData = self.partyGameCountDownData
		}
	end

	self.uiComps = {}

	local comps = {
		{
			self.partygamewaitbar,
			PartyGameWaitBar
		},
		{
			self.partygamebattlebar,
			PartyGameBattleBar,
			self.partyGameBattleBarData
		},
		{
			self.partygameteambar,
			PartyGameTeamBar
		},
		{
			self.partygamecountdown,
			PartyGameCountDown,
			self.partyGameCountDownData
		},
		{
			self.partygamestartui,
			PartyGameStartUI
		},
		{
			self.partygameroundtip,
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

	if self._goplayerlist then
		local itemRes = self.viewContainer:getSetting().otherRes.playerInfo
		local go = self.viewContainer:getResInst(itemRes, self._goplayerlist)

		self._playerInfoComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PlayerInfoComp)

		self._playerInfoComp:Init()
	end

	self:onCreate()
	self:updateView()
end

function PartyGameCommonView:createUIComp(info)
	if info[1] then
		local comps = GameFacade.createLuaCompByGo(info[1], info[2], info[3], self.viewContainer)

		table.insert(self.uiComps, comps)

		return comps
	end
end

function PartyGameCommonView:onClose()
	return
end

function PartyGameCommonView:onDestroyView()
	if self._playerInfoComp then
		self._playerInfoComp:onDestroy()
	end

	self:onDestroy()
end

function PartyGameCommonView:updateView(logicFrame)
	if self.curGame == nil then
		return
	end

	if self._playerInfoComp then
		self._playerInfoComp:viewDataUpdate()
	end

	self:onViewUpdate(logicFrame)
end

function PartyGameCommonView:onCreateCompData()
	self.partyGameCountDownData = nil
end

function PartyGameCommonView:onCreate()
	return
end

function PartyGameCommonView:onDestroy()
	return
end

function PartyGameCommonView:onViewUpdate(logicFrame)
	return
end

return PartyGameCommonView
