-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\OnceTowerRecordCell.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResRecommendFormationCondition = require("ClientData/ResRecommendFormationCondition")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local GridHeroLineUp = Class("GridHeroLineUp", UIControls.ScrollViewLoopCell)

function GridHeroLineUp:ctor()
	self.panelNoHero = UIControls.Panel(self, "ImgNoHero")
	self.gridHero = UIControls.GridHeroInfoChild(self, "GridHero", "System/Common/Grid/GridHeroInfo")
end

function GridHeroLineUp:setData(hero)
	self.gridHero:setHero(hero)

	local checkNoHave = CurAvatar:getHeroCountByResId(hero.id) == 0

	self.panelNoHero:setVisible(checkNoHave)
end

local OnceTowerRecordCell = Class("OnceTowerRecordCell", UIControls.Child)

function OnceTowerRecordCell:ctor()
	self.btnConfirm = UIControls.Button(self, "PlayerVideoPanel/BtnConfirm")

	self.btnConfirm:addEventClick(function()
		self:queryReplayData(nil)
	end)

	self.textName = UIControls.Label(self, "PlayerVideoPanel/TextName")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "PlayerVideoPanel/GridPlayerPanel", "System/Common/Grid/GridPlayerCommon")
	self.textPower = UIControls.Label(self, "PlayerVideoPanel/TextPowerTitle/TextPower")
	self.btnPull = UIControls.Button(self, "PlayerVideoPanel/BtnPull")
	self.heroPanel = UIControls.Panel(self, "LineUpPanel")
	self.heroScroll = UIControls.ScrollViewLoopH(self, "LineUpPanel/HeroList", 0, self.onCellChanged)
	self.btnPullBack = UIControls.Button(self, "LineUpPanel/BtnPullBack")
	self.btnQuickEnter = UIControls.Button(self, "LineUpPanel/QuickWearPanel/BtnQuickWearHigh")
	self.btnQuickDis = UIControls.Button(self, "LineUpPanel/QuickWearPanel/BtnQuickWearDis")
	self.togWear = UIControls.Toggle(self, "LineUpPanel/QuickWearPanel/OptionWear")
	self.quickWearPanel = UIControls.Panel(self, "LineUpPanel/QuickWearPanel")

	self.btnQuickDis:addEventClick(self.onclickQuickDis)
	self.btnQuickEnter:addEventClick(self.copyWears)
	self.togWear:setOn(false)
	self.togWear:addEventValueChanged(self.onTogChange)
	self.btnPull:addEventClick(function()
		self:queryReplayData(true)
	end)
	self.btnPullBack:addEventClick(function()
		self:setPanelState(false)
	end)

	self.isShowHero = false
end

function OnceTowerRecordCell:setData(info, comm, extra, formationIndex)
	self.info = info
	self.playerComm = comm

	local playerName = utils.GetPlayerName(comm.name)

	self.extra = extra
	self.formationIdx = formationIndex

	self.textName:setText(playerName)
	self.btnHead:setCommInfo(comm, true, self)

	if self.mParent.replayType == Const.BATTLE_REPLAY_SEASON_TOWER then
		if #info == 2 then
			local power = info[1].power + info[2].power

			self.textPower:setText(math.floor(power / 2))
		else
			self.textPower:setText(info[1].power)
		end

		self.replayId = info[1].replay_id
	else
		self.textPower:setText(info.power)

		self.replayId = info.replay_id
	end

	self.battleType = BattleConst.BATTLE_TYPE_ONCETOWER

	if self.mParent.replayType == Const.BATTLE_REPLAY_BOSS_EXPAND then
		self.battleType = BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND
	end

	self.checkCanEnter = self.extra and self.extra.checkCanEnter

	if self.checkCanEnter and ResRecommendFormationCondition then
		local config = ResRecommendFormationCondition[self.extra.battleType]

		if config then
			self.checkCanEnter = not ConditionLimitManager.inLimitState(config.conditionId)
		end
	end

	self.quickWearPanel:setVisible(self.checkCanEnter)
	self:setPanelState(false)
end

function OnceTowerRecordCell:onTogChange(sender, isOn)
	if isOn then
		local confirmui = UIManager.getUI("confirmui", true)

		if confirmui then
			confirmui:showFromId(1081, nil, Slot(self.setTogFalse, self))
		end
	end
end

function OnceTowerRecordCell:setTogFalse()
	self.togWear:setOn(false)
end

function OnceTowerRecordCell:queryReplayData(checkJustShowReplayHeroInfo)
	local replayEnv = {}

	if self.mParent.replayType == Const.BATTLE_REPLAY_PASS then
		replayEnv.battlePassProgress = self.mParent.progress
		replayEnv.replayData = self.mParent.data
	elseif self.mParent.replayType == Const.BATTLE_REPLAY_ONCE_TOWER then
		replayEnv.onceTowerLayer = self.mParent.progress
	elseif self.mParent.replayType == Const.BATTLE_REPLAY_EQUIP_TOWER then
		replayEnv.equipTowerData = self.mParent.progress
	elseif self.mParent.replayType == Const.BATTLE_REPLAY_BOSS_TOWER then
		replayEnv.bossTowerData = self.mParent.progress
	elseif self.mParent.replayType == Const.BATTLE_REPLAY_BOSS_EXPAND then
		replayEnv.bossExpandData = self.mParent.progress
	elseif self.mParent.replayType == Const.BATTLE_REPLAY_SEASON_TOWER then
		replayEnv.seasonTowerData = self.mParent.progress
	end

	GameFsm.getState(Const.STATE_BATTLE_REPLAY):recordReplayEnv(replayEnv)

	local replayData = self.mWindow:getReplayData(self.info.replay_id)

	if not replayData then
		CurAvatar.checkJustShowReplayHeroInfo = checkJustShowReplayHeroInfo

		if self.mParent.replayType == Const.BATTLE_REPLAY_SEASON_TOWER then
			CurAvatar:requestSeasonTowerReplay(self.info, self.playerComm)
		else
			RPC.pVEBattleReplay(self.info.replay_id, self.battleType)
		end
	else
		CurAvatar.checkJustShowReplayHeroInfo = nil

		if checkJustShowReplayHeroInfo then
			self:refreshHeroScroll(replayData)
		else
			CurAvatar:onPVEBattleReplayResp(replayData)
		end
	end
end

function OnceTowerRecordCell:refreshHeroScroll(data)
	if not data then
		return
	end

	self.replayData = data

	if not self.gridHeros then
		self.gridHeros = {}
	end

	if not self.heros then
		self.heros = {}
		self.heroDic = {}
		self.heroIdList = {}
		self.heroIdxDic = {}

		for _, campInfo in ipairs(data.start_data.start_common.formation) do
			for _, heroInfo in ipairs(campInfo.item) do
				if heroInfo.idx ~= 0 then
					local heroObj = utils.getIntactHeroObj(heroInfo.hero.base, heroInfo.equip, heroInfo.artifact, heroInfo.relic, heroInfo.paint_level, heroInfo.ability, nil, nil, heroInfo.skin, heroInfo.base, heroInfo.develop, heroInfo.new_paint_level, heroInfo.new_paint_relate_level, heroInfo.season_relic, heroInfo.stick)

					self.heroIdxDic[heroObj.id] = heroInfo.idx

					table.insert(self.heros, heroObj)

					self.heroDic[heroObj.id] = heroObj

					table.insert(self.heroIdList, heroObj.id)
				end
			end
		end
	end

	local heroCount = #self.heros

	self.heroScroll:setTotalCount(heroCount)

	if heroCount > 5 then
		self.heroScroll:openScroll(false, true)
	else
		self.heroScroll:cancelScroll()
	end

	self:setPanelState(true)

	if self.checkCanEnter then
		local hasAllHero = self:checkHaveAllHeros()

		self.btnQuickEnter:setEnable(hasAllHero)
		self.btnQuickDis:setVisible(not hasAllHero)
	end
end

function OnceTowerRecordCell:setPanelState(isShow)
	self.isShowHero = isShow

	self.btnPull:setVisible(not isShow)
	self.heroPanel:setVisible(isShow)
end

function OnceTowerRecordCell:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = GridHeroLineUp(sender, "System/Common/Grid/GridHeroLineUp", newIdx)

		targetCell.gridHero.btnHeroHead:clearEventClick()
		targetCell.gridHero.btnHeroHead:addEventClick(Functor(self.onHeroCellClick, self, newIdx))
	else
		self.gridHeros[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.gridHeros[newIdx] = targetCell

	local curHero = self.heros[newIdx]

	targetCell:setData(curHero)
end

function OnceTowerRecordCell:onHeroCellClick(index)
	local ui = UIManager.getUI("roleInfoHeroDlg")

	ui:setData(self.heros, index, self.mWindow)

	local roleInfo = {}

	roleInfo.commInfo = self.playerComm
	roleInfo.commInfo.headFrameId = roleInfo.commInfo and roleInfo.commInfo.head_frame_id
	roleInfo.commInfo.name = roleInfo.commInfo and utils.GetPlayerName(roleInfo.commInfo.name)

	ui:setPlayerInfo(roleInfo)
	ui:setTipId(Const.INFO_NOTICE_ROLE_INFO_HERO)
end

function OnceTowerRecordCell:checkHaveAllHeros()
	if not self.heroDic or utils.getTableElemCount(self.heroDic, true) == 0 then
		return false
	end

	for _, hero in pairs(self.heroDic) do
		if CurAvatar:getHeroCountByResId(hero.id) == 0 then
			return false
		end
	end

	return true
end

function OnceTowerRecordCell:copyWears()
	local maxStarHeroDic = CurAvatar:getHeroIdMaxStarHeroDic()

	if self.togWear:isOn() then
		local heroNum = #self.heroIdList

		for i = 1, heroNum - 1 do
			for j = 1, heroNum - i do
				local leftId = self.heroIdList[j]
				local rightId = self.heroIdList[j + 1]

				if maxStarHeroDic[leftId].star < maxStarHeroDic[rightId].star or maxStarHeroDic[leftId].level < maxStarHeroDic[rightId].level then
					self.heroIdList[j] = rightId
					self.heroIdList[j + 1] = leftId
				end
			end
		end

		local myAllWearDic = {}

		myAllWearDic.equips = utils.copyTable(CurAvatar.bagEquips)
		myAllWearDic.artifacts = utils.copyTable(CurAvatar.bagArtifacts)
		myAllWearDic.relics = utils.copyTable(CurAvatar.bagRelics)

		local myHeroWearDic = {}

		for _, heroId in pairs(self.heroIdList) do
			myHeroWearDic[heroId] = myHeroWearDic[heroId] or {}
			myHeroWearDic[heroId].equips = myHeroWearDic[heroId].equips or {}

			local myHeroWear = myHeroWearDic[heroId]
			local equipDic = myHeroWear.equips
			local hero = self.heroDic[heroId]
			local banType = hero:getEquipBanPropType()
			local bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic = CurAvatar:getBagEquipMaxRank(nil, myAllWearDic, heroId, true)
			local bagEquipMaxSuitRankDic = bagEquipMaxRankDic[banType]
			local suitNeedWearNumDic = self:getSuitDataDic(hero)
			local suitEquipInfoDic = {}

			for suitId, _ in pairs(suitNeedWearNumDic) do
				suitEquipInfoDic[suitId] = bagEquipMaxSuitRankDic[suitId] or {}
			end

			local wearEquipDic = CurAvatar:getBestEquipsBySuits(banType, suitEquipInfoDic, suitNeedWearNumDic, 1)

			if not wearEquipDic then
				local maxScore = 0

				for suitId, _ in pairs(suitNeedWearNumDic) do
					local needNum = ResEquipSuit[suitId].need_num
					local tmpTable = {}

					tmpTable[suitId] = needNum

					local tmpEquipDic, tmpScore = CurAvatar:getBestEquipsBySuits(banType, suitEquipInfoDic, tmpTable, 1)

					if tmpEquipDic then
						if needNum == 4 then
							wearEquipDic = tmpEquipDic

							break
						elseif needNum == 2 and maxScore < tmpScore then
							wearEquipDic = tmpEquipDic
							maxScore = tmpScore
						end
					end
				end
			end

			if wearEquipDic then
				for pos, equip in pairs(wearEquipDic) do
					equipDic[pos] = equip.gid
					myAllWearDic.equips[equip.gid] = nil
				end
			end

			local artifact = hero:getArtifact()

			if artifact then
				local tmpArtifact = CurAvatar:getArtifactById(artifact.id, myAllWearDic.artifacts)

				if tmpArtifact then
					myHeroWear.artifact = tmpArtifact.gid
					myAllWearDic.artifacts[tmpArtifact.gid] = nil
				end
			end

			local relic = hero:getRelic()

			if relic and myAllWearDic.relics and myAllWearDic.relics[relic.id] then
				myHeroWear.relic = relic.id
				myAllWearDic.relics[relic.id] = nil
			end
		end

		for _, heroId in pairs(self.heroIdList) do
			local hero = self.heroDic[heroId]
			local banType = hero:getEquipBanPropType()
			local myHeroWear = myHeroWearDic[heroId]
			local equipDic = myHeroWear.equips
			local leftPosNum = 6 - utils.getTableElemCount(equipDic)
			local bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic = CurAvatar:getBagEquipMaxRank(nil, myAllWearDic, heroId, true)
			local bagEquipMaxSuitRankDic = bagEquipMaxRankDic[banType]

			if leftPosNum >= 4 then
				local reSuitData = hero:getRecSuit()
				local suitId = reSuitData.suit_id
				local suitMaxScoreEquipList = CurAvatar:getPosEquipListBySuitId(banType, suitId, bagEquipMaxSuitRankDic)
				local tmpEquipList = {}
				local tmpNum = 0

				for _, equip in ipairs(suitMaxScoreEquipList) do
					if not equipDic[equip.part] then
						table.insert(tmpEquipList, equip)

						tmpNum = tmpNum + 1

						if tmpNum >= reSuitData.need_num then
							for _, tmpEquip in ipairs(tmpEquipList) do
								equipDic[tmpEquip.part] = tmpEquip.gid
								myAllWearDic.equips[tmpEquip.gid] = nil
							end

							break
						end
					end
				end
			end

			local posMaxScoreEquipDic = bagEquipMaxSuitRankDic[0]

			for pos = 1, 6 do
				if not equipDic[pos] then
					local equip = posMaxScoreEquipDic[pos]

					if equip then
						equipDic[pos] = equip.gid
						myAllWearDic.equips[equip.gid] = nil
					end
				end
			end

			if not myHeroWear.artifact then
				local artifact
				local maxRankScore = 0

				if bagCustomMadeArtifactDic[heroId] then
					maxRankScore = bagCustomMadeArtifactDic[heroId].rank
					artifact = bagCustomMadeArtifactDic[heroId].obj
				end

				if bagArtifactMaxRankDic[hero.career] then
					for mechanismType, maxInfo in pairs(bagArtifactMaxRankDic[hero.career]) do
						if maxRankScore < maxInfo.rank then
							maxRankScore = maxInfo.rank
							artifact = maxInfo.obj
						end
					end
				end

				if bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL] then
					for mechanismType, maxInfo in pairs(bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL]) do
						if maxRankScore < maxInfo.rank then
							maxRankScore = maxInfo.rank
							artifact = maxInfo.obj
						end
					end
				end

				if artifact then
					myHeroWear.artifact = artifact.gid
					myAllWearDic.artifacts[artifact.gid] = nil
				end
			end

			if not myHeroWear.relic then
				local relic = CurAvatar:getBestRelic(hero, myAllWearDic, true)

				if relic then
					myHeroWear.relic = relic.id
					myAllWearDic.relics[relic.id] = nil
				end
			end
		end

		local myHeroWearList = {}

		for heroId, myHeroWear in pairs(myHeroWearDic) do
			local tmpWear = {}

			tmpWear.hero_gid = maxStarHeroDic[heroId].gid
			tmpWear.artifact_id = myHeroWear.artifact
			tmpWear.relic_id = myHeroWear.relic

			local equips = {}

			for _, gid in pairs(myHeroWear.equips) do
				table.insert(equips, gid)
			end

			tmpWear.equip_id = equips

			table.insert(myHeroWearList, tmpWear)
		end

		RPC.equipTeamWear(myHeroWearList)
	end

	if not self.formationResult then
		self.formationResult = {}

		for _, heroId in pairs(self.heroIdList) do
			local gid = maxStarHeroDic[heroId].gid

			table.insert(self.formationResult, {
				idx = self.heroIdxDic[heroId],
				gid = gid
			})
		end
	end

	local petId
	local power = 0

	for _, pet in pairs(CurAvatar.petDic) do
		local tmpPower = CapacityHelper.getPetCapacity(pet)

		if power < tmpPower then
			petId = pet.id
			power = tmpPower
		end
	end

	RPC.formationUpdate(self.formationIdx, self.formationResult, petId)
end

function OnceTowerRecordCell:getSuitDataDic(hero)
	local equips = hero:getEquips()
	local suitNeedWearDic = {}

	if equips then
		local tmpSuitInfo = {}

		for _, equip in pairs(equips) do
			local suitId = equip.suitId
			local suitNum = tmpSuitInfo[suitId] ~= nil and tmpSuitInfo[suitId] + 1 or 1

			tmpSuitInfo[suitId] = suitNum

			if ResEquipSuit[suitId] then
				local needNum = ResEquipSuit[suitId].need_num

				if needNum > 0 and suitNum == needNum then
					suitNeedWearDic[suitId] = suitNeedWearDic[suitId] and suitNeedWearDic[suitId] + needNum or needNum
					tmpSuitInfo[suitId] = 0
				end
			end
		end
	end

	return suitNeedWearDic
end

function OnceTowerRecordCell:onclickQuickDis()
	MsgManager.notice(Lang.get(71296))
end

return OnceTowerRecordCell
