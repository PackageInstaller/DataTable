-- chunkname: @modules/logic/autochess/main/view/AutoChessFriendBattleView.lua

module("modules.logic.autochess.main.view.AutoChessFriendBattleView", package.seeall)

local AutoChessFriendBattleView = class("AutoChessFriendBattleView", BaseView)
local chessLinesPosOffsetX = {
	100,
	100,
	105
}
local chessPlayerLinesPosX = {
	-463,
	-480,
	-490
}
local chessPlayerLinesPosY = {
	228,
	144,
	60
}
local chessEnenyLinesPosX = 70
local chessEnemyLinesPosY = {
	228,
	144,
	60
}
local chessEnemyLinesPosOffsetX = {
	100,
	100,
	110
}

function AutoChessFriendBattleView:onInitView()
	self._goBadgeRoot = gohelper.findChild(self.viewGO, "#go_BadgeRoot")
	self._goReward = gohelper.findChild(self.viewGO, "root/#go_Reward")
	self._goRewardItem = gohelper.findChild(self.viewGO, "root/#go_Reward/reward/#go_RewardItem")
	self._playerBadge = gohelper.findChildText(self.viewGO, "root/Player/Badge/#txt_badge")
	self._playerName = gohelper.findChildText(self.viewGO, "root/Player/#txt_Name")
	self._playerIconRoot = gohelper.findChild(self.viewGO, "root/Player/HeroHeadIcon")
	self._btnPlayerAreaClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/Player/#btn_Check")
	self._playerHeadicon = gohelper.findChildSingleImage(self.viewGO, "root/Player/HeroHeadIcon/#simage_headicon")
	self._goPlayerChess1 = gohelper.findChild(self.viewGO, "root/Player/Chess/chess1")
	self._goPlayerChess2 = gohelper.findChild(self.viewGO, "root/Player/Chess/chess2")
	self._goPlayerChess3 = gohelper.findChild(self.viewGO, "root/Player/Chess/chess3")
	self._goPlayerSnapChess = gohelper.findChild(self.viewGO, "root/Player/image_bg/chessbg/simage_chessbg/snapChess/go_Chess")
	self._goPlayerLeaderMesh = gohelper.findChild(self.viewGO, "root/Player/image_bg/chessbg/simage_chessbg/snapChess/#go_LeaderMesh")
	self._enemyRoot = gohelper.findChild(self.viewGO, "root/Enemy")
	self._emptyEnemy = gohelper.findChild(self.viewGO, "root/Enemy_empty")
	self._enemyBadge = gohelper.findChildText(self.viewGO, "root/Enemy/Badge/#txt_badge")
	self._enemyName = gohelper.findChildText(self.viewGO, "root/Enemy/#txt_Name")
	self._enemyIconRoot = gohelper.findChild(self.viewGO, "root/Enemy/HeroHeadIcon")
	self._enemyHeadicon = gohelper.findChildSingleImage(self.viewGO, "root/Enemy/HeroHeadIcon/#simage_headicon")
	self._goEnemyChess1 = gohelper.findChild(self.viewGO, "root/Enemy/Chess/chess1")
	self._goEnemyChess2 = gohelper.findChild(self.viewGO, "root/Enemy/Chess/chess2")
	self._goEnemyChess3 = gohelper.findChild(self.viewGO, "root/Enemy/Chess/chess3")
	self._goEnemySnapChess = gohelper.findChild(self.viewGO, "root/Enemy/image_bg/chessbg/simage_chessbg/snapChess/go_Chess")
	self._goEnemyLeaderMesh = gohelper.findChild(self.viewGO, "root/Enemy/image_bg/chessbg/simage_chessbg/snapChess/#go_LeaderMesh")
	self._goSelfEmptyState = gohelper.findChild(self.viewGO, "root/Player_emptyGroup")
	self._goEnemyEmptyState = gohelper.findChild(self.viewGO, "root/Enemy_emptyGroup")
	self._btnEmptyStateGoFight = gohelper.findChildButtonWithAudio(self._goSelfEmptyState, "#btn_Fight")
	self._btnEnemyAreaClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/Enemy/#btn_Check")
	self._btnEnemySwitchLeft = gohelper.findChildButtonWithAudio(self.viewGO, "root/Enemy/#btn_SwitchLeft")
	self._btnEnemySwitchRight = gohelper.findChildButtonWithAudio(self.viewGO, "root/Enemy/#btn_SwitchRight")
	self._goRecord = gohelper.findChild(self.viewGO, "root/#btn_Record/txt_Record")
	self._goRecordGray = gohelper.findChild(self.viewGO, "root/#btn_Record/txt_RecordGrey")
	self._btnBattleRecord = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Record")
	self._btnBattleStart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Start")
	self._imageBattleStart = gohelper.findChildImage(self.viewGO, "root/#btn_Start")
	self._btnFriendList = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Friend")
	self._btnJumpToFriend = gohelper.findChildButtonWithAudio(self.viewGO, "root/Enemy_empty/#btn_AddFriend")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessFriendBattleView:addEvents()
	self._btnBattleStart:AddClickListener(self.onClickBattleStart, self)
	self._btnBattleRecord:AddClickListener(self.onClickBattleRecord, self)
	self._btnFriendList:AddClickListener(self.onClickFriendList, self)
	self._btnJumpToFriend:AddClickListener(self.onClickJumpToFriend, self)
	self._btnEnemySwitchRight:AddClickListener(self.onClickNextFriendBtn, self)
	self._btnEnemySwitchLeft:AddClickListener(self.onClickLastFriendBtn, self)
	self._btnEmptyStateGoFight:AddClickListener(self.onClickGoFight, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.SelectFriendSnapshot, self.requestNewFriendSnapshot, self)
	self.addEventCb(self, Activity182Controller.instance, Activity182Event.UpdateInfo, self._onUpdateInfo, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.FriendsInfoChanged, self._onFriendInfoUpdate, self)
end

function AutoChessFriendBattleView:removeEvents()
	self._btnBattleStart:RemoveClickListener()
	self._btnBattleRecord:RemoveClickListener()
	self._btnFriendList:RemoveClickListener()
	self._btnEnemySwitchRight:RemoveClickListener()
	self._btnEnemySwitchLeft:RemoveClickListener()
	self._btnJumpToFriend:RemoveClickListener()
	self._btnEmptyStateGoFight:RemoveClickListener()
end

function AutoChessFriendBattleView:onClickBattleStart()
	if self._enemySnap then
		local enemyInfo = self._enemySnap.playerInfo

		if self._selfSnap then
			local mySelfInfo = self._selfSnap.playerInfo
			local hasRecord = mySelfInfo and mySelfInfo.userId ~= 0
			local hasFriend = enemyInfo and enemyInfo.userId ~= 0
			local canStart = hasRecord and hasFriend

			if not canStart then
				return
			end

			local curFriendIdx = self._curFriendIdx
			local actInfo = Activity182Model.instance:getActMo(self._actId)
			local friendList = actInfo:getFriendInfoList()
			local curFriendInfo = friendList[curFriendIdx]
			local friendUserId = curFriendInfo.userId

			AutoChessRpc.instance:sendAutoChessEnterFriendFightSceneRequest(self._actId, AutoChessEnum.ModuleId.Friend, friendUserId)
		end
	end
end

function AutoChessFriendBattleView:onClickBattleRecord()
	local actInfo = Activity182Model.instance:getActMo(self._actId)
	local friendFightRecords = actInfo:getFriendFightRecords()
	local hasNoRecord = friendFightRecords and #friendFightRecords == 0

	if hasNoRecord then
		GameFacade.showToastString(luaLang("activityweekwalkdeepview_empty"))

		return
	end

	AutoChessController.instance:openFriendBattleRecordView()
end

function AutoChessFriendBattleView:onGotFriendFightRecordAndOpenRecordView()
	self:refreshBtnState()
	AutoChessController.instance:openFriendBattleRecordView()
end

function AutoChessFriendBattleView:onClickFriendList()
	AutoChessController.instance:openFriendListView()
end

function AutoChessFriendBattleView:onClickNextFriendBtn()
	local curFriendIdx = self._curFriendIdx
	local actInfo = Activity182Model.instance:getActMo(self._actId)
	local friendList = actInfo:getFriendInfoList()
	local nextFriendInfo = friendList[curFriendIdx + 1]

	if not nextFriendInfo then
		return
	end

	self:requestNewFriendSnapshot(nextFriendInfo.userId)
end

function AutoChessFriendBattleView:onClickLastFriendBtn()
	local curFriendIdx = self._curFriendIdx
	local actInfo = Activity182Model.instance:getActMo(self._actId)
	local friendList = actInfo:getFriendInfoList()
	local lastFriendInfo = friendList[curFriendIdx - 1]

	if not lastFriendInfo then
		return
	end

	self:requestNewFriendSnapshot(lastFriendInfo.userId)
end

function AutoChessFriendBattleView:requestNewFriendSnapshot(userId)
	self._curFriendUserId = userId

	Activity182Rpc.instance:sendAct182GetFriendSnapshotsRequest(self._actId, self._curFriendUserId, self.onChangeFriendSnapshot, self)
end

function AutoChessFriendBattleView:onClickGoFight()
	AutoChessController.instance:openMainView()
	self:closeThis()
end

function AutoChessFriendBattleView:onChangeFriendSnapshot()
	self:resetSnapView()

	local actInfo = Activity182Model.instance:getActMo(self._actId)
	local friendList = actInfo:getFriendInfoList()

	for idx, friendInfo in ipairs(friendList) do
		if friendInfo.userId == self._curFriendUserId then
			self._curFriendIdx = idx

			break
		end
	end

	self._selfSnap = actInfo.snapshot
	self._enemySnap = actInfo:getCurFriendSnapshot()

	self:refreshPlayerInfoView()

	local warZones = self._selfSnap.warZones
	local autoChessMaster = self._selfSnap.master

	self:refreshMonsterInfoView(warZones, autoChessMaster, true)

	if self._enemySnap then
		warZones = self._enemySnap.warZones
		autoChessMaster = self._enemySnap.master

		self:refreshMonsterInfoView(self._enemySnap.warZones, self._enemySnap.master, false)
	end

	self:refreshChangeFriendBtn()
end

function AutoChessFriendBattleView:onClickJumpToFriend()
	JumpController.instance:jump(JumpEnum.JumpView.SocialView)
end

function AutoChessFriendBattleView:_onUpdateInfo()
	Activity182Rpc.instance:sendAct182GetFriendFightRecordsRequest(self._actId, self.onGotFriendFightRecordCallback, self)
end

function AutoChessFriendBattleView:_onFriendInfoUpdate()
	Activity182Rpc.instance:sendAct182GetHasSnapshotFriendRequest(self._actId, self.onGotSnapshotFriendCallback, self)
end

function AutoChessFriendBattleView:onGotFriendFightRecordCallback()
	self:refreshBtnState()
end

function AutoChessFriendBattleView:onGotSnapshotFriendCallback()
	self:refreshSnapView()
	self:refreshChangeFriendBtn()
	self:refreshBtnState()
end

function AutoChessFriendBattleView:_editableInitView()
	self._actId = Activity182Model.instance:getCurActId()

	Activity182Rpc.instance:sendAct182GetFriendFightRecordsRequest(self._actId, self.onGotFriendFightRecordCallback, self)

	self._chessGoList = self:getUserDataTb_()
	self._leaderMeshGo = nil
	self._enemyLeaderMeshGo = nil

	self:resetSnapView()
end

function AutoChessFriendBattleView:onUpdateParam()
	return
end

function AutoChessFriendBattleView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.AutoChess.play_ui_fuleyuan_comity_open)

	self._actId = Activity182Model.instance:getCurActId()

	self:refreshSnapView()
	self:refreshChangeFriendBtn()
	self:refreshBtnState()
end

function AutoChessFriendBattleView:refreshSnapView()
	self._curFriendIdx = 1

	local actInfo = Activity182Model.instance:getActMo(self._actId)

	self._selfSnap = actInfo.snapshot
	self._enemySnap = actInfo:getCurFriendSnapshot()

	self:refreshPlayerInfoView()

	local warZones = self._selfSnap.warZones
	local autoChessMaster = self._selfSnap.master

	self:refreshMonsterInfoView(warZones, autoChessMaster, true)

	if self._enemySnap then
		warZones = self._enemySnap.warZones
		autoChessMaster = self._enemySnap.master

		self:refreshMonsterInfoView(self._enemySnap.warZones, self._enemySnap.master, false)
	end
end

function AutoChessFriendBattleView:resetSnapView()
	if self._chessGoList and #self._chessGoList > 0 then
		for _, go in ipairs(self._chessGoList) do
			gohelper.destroy(go)
		end
	end

	gohelper.setActive(self._goPlayerChess1, false)
	gohelper.setActive(self._goPlayerChess2, false)
	gohelper.setActive(self._goPlayerChess3, false)
	gohelper.setActive(self._goEnemyChess1, false)
	gohelper.setActive(self._goEnemyChess2, false)
	gohelper.setActive(self._goEnemyChess3, false)
	gohelper.setActive(self._goPlayerSnapChess, false)
	gohelper.setActive(self._goPlayerLeaderMesh, false)
	gohelper.setActive(self._goEnemySnapChess, false)
	self:refreshBtnState()
end

function AutoChessFriendBattleView:refreshPlayerInfoView()
	local playerInfo = self._selfSnap.playerInfo

	if playerInfo and playerInfo.userId ~= 0 then
		self._playerRankCfg = lua_auto_chess_rank.configDict[self._actId][playerInfo.rank]

		if not self._playerRankCfg then
			self._playerBadge.text = luaLang("autochess_badgeitem_noget")
		end

		self._playerBadge.text = self._playerRankCfg.name

		self._playerIconRoot:SetActive(true)

		local curPlayerInfo = PlayerModel.instance:getPlayinfo()

		self._playerName.text = curPlayerInfo.name

		local portraitId = curPlayerInfo.portrait

		self._playerLiveHeadIcon = self._playerLiveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._playerHeadicon)

		self._playerLiveHeadIcon:setLiveHead(portraitId)
	else
		gohelper.setActive(self._goSelfEmptyState, true)
	end

	if self._enemySnap then
		local enemyInfo = self._enemySnap.playerInfo

		if enemyInfo and enemyInfo.userId ~= 0 then
			gohelper.setActive(self._enemyRoot, true)
			gohelper.setActive(self._emptyEnemy, false)

			self._enemyRankCfg = lua_auto_chess_rank.configDict[self._actId][enemyInfo.rank]

			if not self._enemyRankCfg then
				self._enemyBadge.text = luaLang("autochess_badgeitem_noget")
			end

			local curEnemyInfo = SocialModel.instance:getPlayerMO(enemyInfo.userId)

			curEnemyInfo = curEnemyInfo or enemyInfo
			self._enemyBadge.text = self._enemyRankCfg.name
			self._enemyName.text = curEnemyInfo.name

			self._enemyIconRoot:SetActive(true)

			local portraitId = curEnemyInfo.portrait

			self._enemyLiveHeadIcon = self._enemyLiveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._enemyHeadicon)

			self._enemyLiveHeadIcon:setLiveHead(portraitId)
		else
			gohelper.setActive(self._enemyRoot, false)
			gohelper.setActive(self._emptyEnemy, true)
		end
	end
end

function AutoChessFriendBattleView:refreshMonsterInfoView(warZones, masterData, isMySelf)
	local chessDatas = {}

	for _, zone in ipairs(warZones) do
		local id = zone.id
		local positions = zone.positions

		for _, positionData in ipairs(positions) do
			local chessData = positionData.chess
			local chessData = {}

			chessData.zoneId = id
			chessData.chessId = chessData.id
			chessData.idx = positionData.index
			chessDatas[#chessDatas + 1] = chessData
		end
	end

	local chessgoName = isMySelf and "_goPlayerChess" or "_goEnemyChess"

	if isMySelf then
		if not self._goPlayerSnapChess then
			local snapChessGo = self._goEnemySnapChess

			for i, chessData in ipairs(chessDatas) do
				local chessCfg = AutoChessConfig.instance:getChessCfg(chessData.chessId)

				if i <= 3 then
					local chessGo = self[chessgoName .. i]

					gohelper.setActive(chessGo, true)

					local goMesh = gohelper.findChild(chessGo, "Mesh")
					local chessMesh = MonoHelper.addNoUpdateLuaComOnceToGo(goMesh, AutoChessMeshComp)

					chessMesh:setData(chessCfg.image)
				end

				local go = gohelper.cloneInPlace(snapChessGo, chessData.chessId)

				self._chessGoList[#self._chessGoList + 1] = go

				gohelper.setActive(go, true)

				local goMesh = gohelper.findChild(go, "Mesh")
				local comp1 = MonoHelper.addNoUpdateLuaComOnceToGo(goMesh, AutoChessMeshComp)

				comp1:setData(chessCfg.image)

				local chessPosX, chessPosY = 0

				if isMySelf then
					chessPosX = chessPlayerLinesPosX[chessData.zoneId] + chessData.idx * chessLinesPosOffsetX[chessData.zoneId]
					chessPosY = chessPlayerLinesPosY[chessData.zoneId]
				else
					chessPosX = chessEnenyLinesPosX + (chessData.idx - 5) * chessEnemyLinesPosOffsetX[chessData.zoneId]
					chessPosY = chessEnemyLinesPosY[chessData.zoneId]
				end

				recthelper.setAnchor(go.transform, chessPosX, chessPosY)

				local x, y, z = transformhelper.getLocalScale(go.transform)

				x = isMySelf and -1 * x or x

				transformhelper.setLocalScale(go.transform, x, y, z)
			end

			if not masterData then
				return
			end

			if isMySelf then
				if not self._goPlayerLeaderMesh then
					local snapLeaderGo = self._goEnemyLeaderMesh
					local masterId = masterData.id
					local leaderCfg = lua_auto_chess_master.configDict[masterId]

					if leaderCfg then
						local comp = MonoHelper.addNoUpdateLuaComOnceToGo(snapLeaderGo, AutoChessMeshComp)

						comp:setData(leaderCfg.image, false, true)
					end
				end
			end
		end
	end
end

function AutoChessFriendBattleView:refreshChangeFriendBtn()
	local curFriendIdx = self._curFriendIdx
	local actInfo = Activity182Model.instance:getActMo(self._actId)
	local friendList = actInfo:getFriendInfoList()

	gohelper.setActive(self._btnEnemySwitchRight.gameObject, curFriendIdx < #friendList)
	gohelper.setActive(self._btnEnemySwitchLeft.gameObject, curFriendIdx > 1)
end

function AutoChessFriendBattleView:refreshBtnState()
	if self._enemySnap then
		local enemyInfo = self._enemySnap.playerInfo

		if self._selfSnap then
			local mySelfInfo = self._selfSnap.playerInfo
			local hasRecord = mySelfInfo and mySelfInfo.userId ~= 0
			local hasFriend = enemyInfo and enemyInfo.userId ~= 0
			local canStart = hasRecord and hasFriend

			SLFramework.UGUI.GuiHelper.SetColor(self._imageBattleStart, canStart and "#FFFFFF" or "#B0B0B0")

			local actInfo = Activity182Model.instance:getActMo(self._actId)
			local friendFightRecords = actInfo:getFriendFightRecords()
			local hasFightRecord = false

			if friendFightRecords then
				for _, record in ipairs(friendFightRecords) do
					hasFightRecord = true
				end
			end

			local recordBtnGray = not hasFightRecord

			gohelper.setActive(self._goRecord, not recordBtnGray)
			gohelper.setActive(self._goRecordGray, recordBtnGray)
			ZProj.UGUIHelper.SetGrayscale(self._btnBattleRecord.gameObject, recordBtnGray)
		end
	end
end

return AutoChessFriendBattleView
