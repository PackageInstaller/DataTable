-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyTrialView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyTrialView", package.seeall)

local PartyGameLobbyTrialView = class("PartyGameLobbyTrialView", BaseView)

function PartyGameLobbyTrialView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_fullbg")
	self._gotab1 = gohelper.findChild(self.viewGO, "root/top/#go_tab1")
	self._btntabone = gohelper.findChildButtonWithAudio(self.viewGO, "root/top/#go_tab1/#btn_tab_one")
	self._gotab2 = gohelper.findChild(self.viewGO, "root/top/#go_tab2")
	self._btntabmultiple = gohelper.findChildButtonWithAudio(self.viewGO, "root/top/#go_tab2/#btn_tab_multiple")
	self._scrolllevel = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_level")
	self._goprocess = gohelper.findChild(self.viewGO, "root/#go_process")
	self._gopos1 = gohelper.findChild(self.viewGO, "root/#go_process/process_1/#go_pos_1")
	self._gopos2 = gohelper.findChild(self.viewGO, "root/#go_process/process_1/#go_pos_2")
	self._gopos3 = gohelper.findChild(self.viewGO, "root/#go_process/process_2/#go_pos_3")
	self._gopos4 = gohelper.findChild(self.viewGO, "root/#go_process/process_3/#go_pos_4")
	self._btnrandom = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_process/#btn_random")
	self._gocd = gohelper.findChild(self.viewGO, "root/#go_process/#btn_random/#go_cd")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_process/#btn_start")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyTrialView:addEvents()
	self._btntabone:AddClickListener(self._btntaboneOnClick, self)
	self._btntabmultiple:AddClickListener(self._btntabmultipleOnClick, self)
	self._btnrandom:AddClickListener(self._btnrandomOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function PartyGameLobbyTrialView:removeEvents()
	self._btntabone:RemoveClickListener()
	self._btntabmultiple:RemoveClickListener()
	self._btnrandom:RemoveClickListener()
	self._btnstart:RemoveClickListener()
end

local TabType = {
	MULTIPLE = 2,
	ONE = 1
}

function PartyGameLobbyTrialView:_btntaboneOnClick()
	self:refreshTab(TabType.ONE)
end

function PartyGameLobbyTrialView:_btntabmultipleOnClick()
	self:refreshTab(TabType.MULTIPLE)
end

function PartyGameLobbyTrialView:_btnrandomOnClick()
	if self._randomInCd then
		return
	end

	local gameIds = PartyGameLobbyModel.instance:getRandomPartyFullLineGames()

	for i = 1, #gameIds do
		PartyGameTrialPlayModel.instance:updateSelectTrialGameId(gameIds[i].id, i, true)
	end

	self:_updateLineGameItem()
	self:_startRandomCd()
end

function PartyGameLobbyTrialView:_btnstartOnClick()
	local gameIds = PartyGameTrialPlayModel.instance:getAllSelectGameIds()

	if not PartyGameTrialPlayModel.instance:canEnterTrial() then
		return
	end

	PartyGameTrialPlayModel.instance:recordTrialPlayGame(gameIds)

	local id = gameIds[1]

	PartyGameTrialController.instance:enterTrial(id)
	PartyGameTrialPlayModel.instance:clearSelectGameIds()
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.LoginView)
	ViewMgr.instance:closeView(ViewName.SimulateLoginView)
end

local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function PartyGameLobbyTrialView:_editableInitView()
	self._goContent = gohelper.findChild(self._scrolllevel.gameObject, "Viewport/Content")
	self._imageCd = gohelper.findChildImage(self.viewGO, "root/#go_process/#btn_random/#go_cd")
	self._goOneAni = self._gotab1:GetComponent(gohelper.Type_Animator)
	self._goMultipleAni = self._gotab2:GetComponent(gohelper.Type_Animator)
	self._goScrollLevel = self._scrolllevel.gameObject
	self._startBtnEffect = ZProj_UIEffectsCollection.Get(self._btnstart.gameObject)
	self._goVxRefresh = gohelper.findChild(self.viewGO, "root/#go_process/#btn_random/vx_refresh")

	gohelper.setActive(self._goVxRefresh, false)
end

function PartyGameLobbyTrialView:onUpdateParam()
	return
end

function PartyGameLobbyTrialView:refreshTab(tabType)
	self._curTab = tabType or TabType.ONE

	self._goOneAni:Play(self._curTab == TabType.ONE and "select" or "unselect", 0, 0)
	self._goMultipleAni:Play(self._curTab == TabType.MULTIPLE and "select" or "unselect", 0, 0)
	gohelper.setActive(self._goScrollLevel, self._curTab == TabType.ONE)
	gohelper.setActive(self._goprocess, self._curTab == TabType.MULTIPLE)
end

function PartyGameLobbyTrialView:onOpen()
	self.addEventCb(self, PartyGameTrialController.instance, PartyGameLobbyEvent.TrialSelectFinish, self._updateLineGameItem, self)

	local playerInfo = PlayerModel.instance:getPlayinfo()
	local uid = playerInfo.userId
	local name = playerInfo.name

	PartyGameTrialController.instance:setPlayerInfo(uid, name)

	local robotName = lua_partygame_const.configDict[190003]

	PartyGameTrialController.instance:setRobotName(robotName.value)
	PartyGameTrialController.instance:initPlayerSkin()

	local allPartyGameConfig = PartyGameLobbyModel.instance:getAllOnLineGameConfig()
	local itemRes = self.viewContainer:getSetting().otherRes.item
	local item = self:getResInst(itemRes, self._goContent, "HelpSelectItem")

	gohelper.setActive(item, false)
	gohelper.CreateObjList(self, self._onPartyGameItem, allPartyGameConfig, self._goContent, item, PartyGameTrialSelectOneItem)
	self:refreshTab()
	self:_updateLineGameItem()

	self._imageCd.fillAmount = 0
end

function PartyGameLobbyTrialView:_onPartyGameItem(item, data, index)
	item:UpdateGameInfo(data)
end

function PartyGameLobbyTrialView:_updateLineGameItem()
	if self._lineGameItem == nil then
		self._lineGameItem = self:getUserDataTb_()

		local itemRes = self.viewContainer:getSetting().otherRes.item

		for i = 1, 4 do
			local itemGo = self:getResInst(itemRes, self["_gopos" .. i], "SelectItem" .. i)
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, PartyGameTrialLineItem)

			item:initIndex(i)

			self._lineGameItem[i] = item
		end
	end

	for i, item in pairs(self._lineGameItem) do
		local gameId = PartyGameTrialPlayModel.instance:getSelectGameId(i)

		item:UpdateGameInfo((gameId ~= -1 or nil) and (lua_partygame_param.configDict[gameId] or nil))
	end

	self:updateStartState()
end

PartyGameLobbyTrialView.RandomCdDuration = 3

function PartyGameLobbyTrialView:_startRandomCd()
	TaskDispatcher.cancelTask(self._updateRandomCd, self)

	self._randomCdTime = 0

	gohelper.setActive(self._gocd, true)

	self._imageCd.fillAmount = 1
	self._randomInCd = true

	TaskDispatcher.runRepeat(self._updateRandomCd, self, 0)
end

function PartyGameLobbyTrialView:_updateRandomCd()
	self._randomCdTime = self._randomCdTime + Time.deltaTime

	if self._randomCdTime >= PartyGameLobbyTrialView.RandomCdDuration then
		self:_stopRandomCd()
		gohelper.setActive(self._goVxRefresh, false)
		gohelper.setActive(self._goVxRefresh, true)
	else
		self._imageCd.fillAmount = 1 - self._randomCdTime / PartyGameLobbyTrialView.RandomCdDuration
	end
end

function PartyGameLobbyTrialView:_stopRandomCd()
	self._randomInCd = false

	TaskDispatcher.cancelTask(self._updateRandomCd, self)

	self._randomCdTime = 0
	self._imageCd.fillAmount = 0

	gohelper.setActive(self._gocd, false)
end

function PartyGameLobbyTrialView:onClose()
	PartyGameTrialPlayModel.instance:clearSelectGameIds()
	self.removeEventCb(self, PartyGameTrialController.instance, PartyGameLobbyEvent.TrialSelectFinish, self._updateLineGameItem, self)
	self:_stopRandomCd()
end

function PartyGameLobbyTrialView:updateStartState()
	if self._startBtnEffect then
		self._startBtnEffect:SetGray(not PartyGameTrialPlayModel.instance:canEnterTrial())
	end
end

function PartyGameLobbyTrialView:onDestroyView()
	return
end

return PartyGameLobbyTrialView
