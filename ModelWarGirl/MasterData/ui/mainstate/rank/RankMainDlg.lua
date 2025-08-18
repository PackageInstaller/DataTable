-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Rank\\RankMainDlg.lua

local RankListPanel = require("UI/MainState/Rank/RankListPanel")
local ResOpActTower = require("ClientData/ResOpActTower")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local BtnPlayerRankCellMine = require("UI/MainState/Rank/BtnPlayerRankCellMine")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local EventConst = require("EventConst")
local strClassName = "RankMainDlg"
local RankMainDlg = Class(strClassName, UIControls.Window)

function RankMainDlg:ctor()
	self:initUI()
end

function RankMainDlg:initUI()
	self.panelRankList = RankListPanel(self, "BgPanel/PlayerRankList")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")
	self.txtNone = UIControls.Panel(self, "BgPanel/TextNone")
	self.txtNoneContent = UIControls.Label(self, "BgPanel/TextNone/Text")
	self.txtTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.txtSubTitle = UIControls.Label(self, "BgPanel/TextTitle/TextTitle2")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnAward = UIControls.Button(self, "BgPanel/BtnAward")

	self.btnAward:addEventClick(self.onBtnAwardClick)

	self.panelTime = UIControls.Panel(self, "BgPanel/TimePanel")
	self.txtTime = UIControls.Label(self, "BgPanel/TimePanel/TextTime")
	self.txtTimeTitle = UIControls.Label(self, "BgPanel/TimePanel/TextTitle")
	self.btnTabMix = UIControls.Button(self, "BgPanel/TabMix", "Text")

	self.btnTabMix:addEventClick(self.onBtnTabMixClick)

	self.btnTabLimit1 = UIControls.Button(self, "BgPanel/TabLimit1", "Text")

	self.btnTabLimit1:addEventClick(self.onBtnTabMixClick)

	self.btnTabLimit2 = UIControls.Button(self, "BgPanel/TabLimit2", "Text")

	self.btnTabLimit2:addEventClick(self.onBtnTabMixClick)

	self.panelTextNoneMine = UIControls.Panel(self, "BgPanel/TextNoneMine")
	self.txtNoneMine = UIControls.Label(self, "BgPanel/TextNoneMine/TextContent")
	self.btnMixinDic = {
		self.btnTabMix,
		self.btnTabLimit1,
		self.btnTabLimit2
	}
	self.slotOnActivityDataChange = Slot(self.onActivityDataChange, self)
end

function RankMainDlg:onOpen()
	RankMainDlg.super.onOpen(self)
	EventCenter.addEventListener(EventConst.ACTIVITY_DATA_CHANGE, self.slotOnActivityDataChange)
end

function RankMainDlg:onClose()
	EventCenter.removeEventListener(EventConst.ACTIVITY_DATA_CHANGE, self.slotOnActivityDataChange)
	RankMainDlg.super.onClose(self)
end

function RankMainDlg:onActivityDataChange(param, actType)
	if actType == Const.ACT_TYPE_PET_MAZE then
		self:refreshPetMazeShow()
	end
end

function RankMainDlg:initByRankType(typeRank, exArgs)
	self.typeRank = typeRank
	self.rankUIInfo = UIConst.RANK_UI_INFO[self.typeRank]

	self.txtTitle:setText(self.rankUIInfo.title)
	self.txtSubTitle:setVisible(self.rankUIInfo.hideTitle2 == nil)
	self.txtSubTitle:setText(self.rankUIInfo.title2 or "")

	if self.typeRank == Const.RANK_TYPE_BOSSTOWER3 then
		if CurAvatar.myCircle then
			local rankData = CurAvatar.myCircle:getBossRankData()

			self:setRankData(rankData)
		else
			self:emptyRankData()
		end
	elseif self.typeRank == Const.RANK_TYPE_CIRCLE_BATTLE_FEAT then
		if CurAvatar.myCircle then
			local rankData = CurAvatar.myCircle:getRankBattleFeatData()

			self:setRankData(rankData)
		else
			self:emptyRankData()
		end
	elseif self.typeRank == Const.RANK_TYPE_ACTIVITY_PLOT then
		if exArgs and exArgs[1] and exArgs[2] then
			self.plotActObj = exArgs[1]
			self.plotLevelIdx = exArgs[2]

			RPC.opActPlotGetRank(self.plotActObj.opId, exArgs[2])
		end
	elseif self.typeRank == Const.RANK_TYPE_SEASON_TOWER_SCORE then
		if exArgs then
			self.seasonTowerId = exArgs

			RPC.rankCacheGetPage(Const.RANK_CACHE_TYPE_SEASON_TOWER, self.seasonTowerId, 0, 2)
		end
	elseif self.typeRank == Const.RANK_TYPE_WORLDBOSS then
		if exArgs == nil then
			RPC.rankCacheGetPage(Const.RANK_CACHE_TYPE_WORLD_BOSS, 1, 0, 2)
		end
	elseif self.typeRank == Const.RANK_TYPE_SNEAK_BATTLE then
		RPC.rankCacheGetPage(Const.RANK_CACHE_TYPE_SNEAK_BATTLE, 1, 0, 2)
	elseif self.typeRank == Const.RANK_TYPE_SEASON_TOWER_LAYER then
		if exArgs then
			local seasonTowerId = exArgs

			self.seasonTowerIdDic = {}

			local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_SEASON_TOWER)

			if actObj then
				local actData = actObj.actData

				if actData then
					local oneTowerData = actData:getOneTowerData(seasonTowerId)

					if oneTowerData then
						local groupId = 0
						local limit1Id = 0
						local limit2Id = 0
						local defaultTowerType = 0

						if oneTowerData.towerType == Const.SEASON_TOWER_TYPE_LIMIT then
							for groupTowerId, weekConfig in pairs(actData.thisWeekConfig) do
								if weekConfig.first and weekConfig.first == seasonTowerId then
									groupId = groupTowerId
									limit1Id = seasonTowerId
									limit2Id = weekConfig.second
									defaultTowerType = 2

									break
								elseif weekConfig.second and weekConfig.second == seasonTowerId then
									groupId = groupTowerId
									limit1Id = weekConfig.first
									limit2Id = seasonTowerId
									defaultTowerType = 3

									break
								end
							end
						else
							groupId = seasonTowerId
							limit1Id = oneTowerData.lockTower[1]
							limit2Id = oneTowerData.lockTower[2]
							defaultTowerType = 1
						end

						self.seasonTowerIdDic[1] = groupId
						self.seasonTowerIdDic[2] = limit1Id
						self.seasonTowerIdDic[3] = limit2Id

						self.btnMixinDic[1]:setText(actData.thisWeekConfig[groupId].name)
						self.btnMixinDic[1]:setVisible(true)

						if actData.clientTowerData[limit1Id] then
							self.btnMixinDic[2]:setText(actData.clientTowerData[limit1Id].name)
							self.btnMixinDic[2]:setVisible(true)
						else
							self.btnMixinDic[2]:setVisible(false)
						end

						if actData.clientTowerData[limit2Id] then
							self.btnMixinDic[3]:setText(actData.clientTowerData[limit2Id].name)
							self.btnMixinDic[3]:setVisible(true)
						else
							self.btnMixinDic[3]:setVisible(false)
						end

						self:onBtnTabMixClick(self.btnMixinDic[defaultTowerType])
					end
				end
			end
		end
	elseif self.typeRank == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER then
		local rankData = CurAvatar:getCachedCircleBattleLayerRankData()

		if rankData then
			self:setRankData(rankData)
		end
	elseif self.typeRank == Const.RANK_TYPE_CAT_RACE then
		for i = 1, 2 do
			self.btnMixinDic[i]:setVisible(true)
			self.btnMixinDic[i]:setVisible(true)
		end

		self.btnMixinDic[1]:setText(Lang.get(489))
		self.btnMixinDic[2]:setText(Lang.get(748))
		self:onBtnTabMixClick(self.btnMixinDic[1])
	elseif self.typeRank == Const.RANK_TYPE_NEW_MAZE then
		RPC.rankCacheGetPage(Const.RANK_CACHE_TYPE_NEW_MAZE, 1, 0, 2)
	elseif self.typeRank == Const.RANK_TYPE_PET_MAZE then
		RPC.rankCacheGetPage(Const.RANK_CACHE_TYPE_PET_MAZE, 1, 0, 6)
	else
		CurAvatar:onRankListRequestNextPage(self.typeRank)
	end

	if self.isOpenedByHideMode then
		self.btnAward:setVisible(false)
		self.panelTime:setVisible(false)
	else
		self.btnAward:setVisible(self.rankUIInfo.showBtnAward ~= nil)
		self.panelTime:setVisible(self.rankUIInfo.showPanelTime ~= nil)

		if self.panelTime:getVisible() then
			local leftTime = 0
			local isTypeMatch = false

			if self.typeRank == Const.RANK_TYPE_WORLDBOSS then
				isTypeMatch = true

				self.txtNoneContent:setText(ClientUtils.getClientNotice(275))

				leftTime = WorldBossCommon.getCurBossLeftTime()

				if exArgs then
					for i = 1, exArgs do
						self.btnMixinDic[i]:setVisible(true)
					end

					self.btnMixinDic[1]:setText(Lang.get(101565))
					self.btnMixinDic[2]:setText(Lang.get(101566))
					self:onBtnTabMixClick(self.btnMixinDic[1])
				end
			elseif self.typeRank == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER or self.typeRank == Const.RANK_TYPE_CIRCLE_BATTLE_FEAT then
				isTypeMatch = true

				local actObj = CurAvatar:getCircleBattleActivity()

				if actObj then
					leftTime = actObj.actData:getLeftTimeToEnd()
				end
			elseif self.typeRank == Const.RANK_TYPE_SNEAK_BATTLE then
				isTypeMatch = true

				local actObj = CurAvatar:getSneakBattleActivity()

				if actObj then
					leftTime = actObj.actData:getCurLeftTime()
				end
			end

			if isTypeMatch then
				ClientTimerManager.RemoveSecondTickUI(self.txtTime)
				ClientTimerManager.AddSecondTickUI(self.txtTime, leftTime, nil, "", "", nil, nil)
			end
		end
	end

	if self.typeRank == Const.RANK_TYPE_SEASON_TOWER_SCORE then
		self:refreshSeasonTowerShow()
	elseif self.typeRank == Const.RANK_TYPE_NEW_MAZE then
		self.txtNoneContent:setText(ResNewMazeDisplay[13060018].desc)
		self:refreshNewMazeShow()
	elseif self.typeRank == Const.RANK_TYPE_PET_MAZE then
		self:refreshPetMazeShow()
	elseif self.typeRank == Const.RANK_TYPE_SNEAK_BATTLE then
		self:refreshSneakBattleShow()
	end
end

function RankMainDlg:onBtnTabMixClick(sender)
	self.panelRankList.scrollRank:setTotalCount(0)

	for idx, btnTab in ipairs(self.btnMixinDic) do
		if btnTab == sender then
			self.selectIdx = idx

			if self.typeRank == Const.RANK_TYPE_SEASON_TOWER_LAYER then
				self.seasonTowerId = self.seasonTowerIdDic[idx]

				RPC.rankCacheGetPage(Const.RANK_CACHE_TYPE_SEASON_TOWER, self.seasonTowerId, 0, 2)
			elseif self.typeRank == Const.RANK_TYPE_CAT_RACE then
				local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_CAT_RACE)

				if actObj then
					local actData = actObj.actData

					if actData then
						if idx == Const.CAT_RACE_RANK_FRIEND then
							self.txtNoneContent:setText(Lang.get(1587))
							actData:requestFriendRankData(Slot(self.refreshRankListForCatRace, self))
						elseif idx == Const.CAT_RACE_RANK_CIRCLE then
							if not CurAvatar:isInCircle() or not CurAvatar.myCircle then
								self.txtNoneContent:setText(ClientUtils.getClientNotice(436))
							else
								self.txtNoneContent:setText(Lang.get(1587))
							end

							actData:requestCircleRankData(Slot(self.refreshRankListForCatRace, self))
						end
					end
				end
			elseif self.typeRank == Const.RANK_TYPE_WORLDBOSS then
				CurAvatar.onShowWorldBossRankIndex = idx

				if idx == 2 then
					self.txtNoneContent:setText(Lang.get(1587))
					self.btnAward:setVisible(false)
					self.panelTime:setVisible(false)
				else
					self.btnAward:setVisible(true)
					self.panelTime:setVisible(true)
					self.txtNoneContent:setText(ClientUtils.getClientNotice(275))
				end

				RPC.rankCacheGetPage(Const.RANK_CACHE_TYPE_WORLD_BOSS, idx, 0, 2)
			end
		end

		btnTab:setEnable(sender ~= btnTab)
	end

	if self.typeRank == Const.RANK_TYPE_SEASON_TOWER_LAYER then
		self:refreshSeasonTowerShow()
	elseif self.typeRank == Const.RANK_TYPE_NEW_MAZE then
		self.txtNoneContent:setText(ResNewMazeDisplay[13060018].desc)
		self:refreshNewMazeShow()
	end
end

function RankMainDlg:refreshRankListForCatRace(rankData)
	if rankData then
		self:setRankData(rankData)
	else
		self:emptyRankData()
	end
end

function RankMainDlg:refreshNewMazeShow()
	local leftTime = -1
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_NEW_MAZE)

	if actObj then
		local actData = actObj.actData

		if actData then
			leftTime = actData:getRemainOpenTime()

			if leftTime >= 0 then
				self.txtTimeTitle:setText(Lang.get(61812))
			end
		end
	end

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondTickUI(self.txtTime, leftTime, nil, "", "", nil, nil)
end

function RankMainDlg:refreshSeasonTowerShow()
	local leftTime = -1
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_SEASON_TOWER)

	if actObj then
		local actData = actObj.actData

		if actData then
			leftTime = actData:getRemainOpenTime()

			if leftTime >= 0 then
				self.txtTimeTitle:setText(Lang.get(30526))
			else
				self.txtTimeTitle:setText(Lang.get(30527))

				leftTime = actData:getFreezeOpenTime()
			end

			if self.typeRank == Const.RANK_TYPE_SEASON_TOWER_LAYER then
				local oneTowerData = actData:getOneTowerData(self.seasonTowerId)

				if oneTowerData then
					if oneTowerData.towerType == Const.SEASON_TOWER_TYPE_LIMIT then
						self.txtTitle:setText(oneTowerData.towerConfig.name)
					else
						self.txtTitle:setText(oneTowerData.weekConfig.name)
					end
				end
			end
		end
	end

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondTickUI(self.txtTime, leftTime, nil, "", "", nil, nil)
end

function RankMainDlg:refreshPetMazeShow()
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)
	local checkOpen = actObj ~= nil and actObj:isValid()

	if checkOpen then
		ClientTimerManager.RemoveSecondTickUI(self.txtTime)
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, actObj.actData:getSeasonLeftTime(), false, "%s", Slot(self.timerOver, self))
	else
		self:timerOver()
	end
end

function RankMainDlg:refreshSneakBattleShow(...)
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_SNEAK_BATTLE)
	local checkOpen = actObj ~= nil and actObj:isValid()

	if checkOpen then
		ClientTimerManager.RemoveSecondTickUI(self.txtTime)
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, actObj.actData:getCurLeftTime(), false, "%s", Slot(self.timerOver, self))
	else
		self:timerOver()
	end
end

function RankMainDlg:timerOver()
	self.txtTime:setText("")
end

function RankMainDlg:setRankData(rankData)
	if #rankData.dataList > 0 then
		self.txtNone:setVisible(false)
		self.panelRankList:setDataList(rankData.dataList, true)
		self:setSelfRankCell(rankData.selfData)
	else
		self:emptyRankData()
	end
end

function RankMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

function RankMainDlg:onBtnAwardClick(...)
	if Const.RANK_AWARD_TYPE_DIC[self.typeRank] then
		UIManager.getUI("rankingAwardDlg", true):show(self.rankIndex, Const.RANK_AWARD_TYPE_DIC[self.typeRank])
	end

	if self.typeRank == Const.RANK_TYPE_CIRCLE_BATTLE_FEAT then
		UIManager.getUI("circleBattleBossAwardDlg", true)
	end
end

function RankMainDlg:destroy(...)
	RankMainDlg.super.destroy(self)
	CurAvatar:onClearRankList()
end

function RankMainDlg:emptyRankData()
	self.panelRankList.scrollRank:setTotalCount(0)

	if self.selfRankCell then
		self.selfRankCell:destroy()

		self.selfRankCell = nil
	end

	self.txtNone:setVisible(true)
end

function RankMainDlg:setSelfRankCell(selfData)
	if self.isOpenedByHideMode then
		if self.selfRankCell then
			self.selfRankCell:destroy()

			self.selfRankCell = nil
		end

		self.panelTextNoneMine:setVisible(true)

		if self.typeRank == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER then
			self.txtNoneMine:setText(ClientUtils.getClientNotice(600))
		end
	elseif selfData then
		self.panelTextNoneMine:setVisible(false)

		if not self.selfRankCell then
			if self.mWindow.typeRank == Const.RANK_TYPE_HOUSEFAVOR then
				self.selfRankCell = BtnPlayerRankCellMine(self, "BgPanel/MyRankInfo", "System/Backyard/BtnBackyardRankMine", 0, 0, true)
			elseif self.mWindow.typeRank == Const.RANK_TYPE_SNEAK_BATTLE then
				self.selfRankCell = BtnPlayerRankCellMine(self, "BgPanel/MyRankInfo", "System/Rank/BtnSneakBattlePlayerRankMine", 0, 0, true)
			else
				self.selfRankCell = BtnPlayerRankCellMine(self, "BgPanel/MyRankInfo", "System/Rank/BtnPlayerRankMine", 0, 0, true)
			end
		end

		self.selfRankCell:setData(selfData)

		self.rankIndex = selfData.rank

		if self.rankIndex == -1 and self.typeRank == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER and CurAvatar.myCircle then
			local rankData = CurAvatar:getCircleRealRanking()

			if rankData then
				self:setSelfRankCell(rankData)
			end
		end
	end
end

return RankMainDlg
