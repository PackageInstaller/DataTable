-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\WorldBoss\\WorldBossRecordDlg.lua

local ResMonster = require("ClientData/ResMonster")
local ResHero = require("ClientData/ResHero")
local WorldBossRecordCell = Class("WorldBossRecordCell", UIControls.Child)

function WorldBossRecordCell:ctor(...)
	self:initUI()
end

function WorldBossRecordCell:initUI(...)
	self.imgQuality = UIControls.Image(self, "GridHero/ImgQuality")
	self.imgIcon = UIControls.Image(self, "GridHero/ImgIcon")
	self.imgFill = UIControls.Image(self, "Slider/FillArea/Fill")
	self.txtNum = UIControls.Label(self, "TextNum")
	self.txtName = UIControls.Label(self, "TextName")
	self.slider = UIControls.Slider(self, "Slider")
end

function WorldBossRecordCell:setData(data, isMine)
	local totalDamage = 0
	local name, iconPath

	if isMine == true then
		self.imgFill:setImage("Atlas/RankingAtlas", "BgIconBarGreen")

		totalDamage = self.mWindow.totalMyDamage
		name = ResHero[data.resid].hero_name
		iconPath = self.mWindow:getHeadIconPath(data.resid, BattleConst.CAMP_PLAYER)

		if iconPath == nil then
			iconPath = UIConst.getHeroHeadIconPath(data.resid)
		end
	else
		self.imgFill:setImage("Atlas/RankingAtlas", "BgIconBarRed")

		totalDamage = self.mWindow.totalBossDamage
		name = ResMonster[data.resid].name
		iconPath = self.mWindow:getHeadIconPath(data.resid, BattleConst.CAMP_MONSTER)

		if iconPath == nil then
			iconPath = UIConst.getMonsterHeadIconPath(data.resid)
		end
	end

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
	end

	self.txtNum:setText(data.damage)
	self.txtName:setText(name)
	self.slider:setValue(data.damage / totalDamage)
end

local strClassName = "WorldBossRecordDlg"
local WorldBossRecordDlg = Class(strClassName, UIControls.Window)

WorldBossRecordDlg.showType = {
	ELITE = 2,
	NOMAL = 1
}

function WorldBossRecordDlg:ctor(...)
	self:initUI()
end

function WorldBossRecordDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnReplay = UIControls.Button(self, "BgPanel/BgSelf/BtnReplay")

	self.btnReplay:addEventClick(self.onBtnReplayClick)

	self.txtNum = UIControls.Label(self, "BgPanel/BgSelf/TextNum")
	self.txtDes = UIControls.Label(self, "BgPanel/BgSelf/TextDes")
	self.panelEliteInfo = UIControls.Panel(self, "BgPanel/BgSelf/ElitePanel")
	self.txtNomalScore = UIControls.Label(self, "BgPanel/BgSelf/ElitePanel/TextDesNum1")
	self.txtEliteScore = UIControls.Label(self, "BgPanel/BgSelf/ElitePanel/TextDesNum2")
	self.txtEliteTips = UIControls.Label(self, "BgPanel/BgInfo/TextEliteTips")
	self.myRecordCells = {}
	self.bossRecordCells = {}

	for i = 1, 12 do
		if i <= 6 then
			local cell = WorldBossRecordCell(self, "BgPanel/BgInfo/SelfDataPanel", "System/WorldBoss/WorldBossRecordCell")

			table.insert(self.myRecordCells, cell)
		else
			local cell = WorldBossRecordCell(self, "BgPanel/BgInfo/EnemyDataPanel", "System/WorldBoss/WorldBossRecordCell")

			table.insert(self.bossRecordCells, cell)
		end
	end
end

function WorldBossRecordDlg:show(data)
	if #data > 1 then
		self.tabBtns = {}
		self.replayEnvs = {}

		for i = 1, #data do
			local btnTab = UIControls.Button(self, "BgPanel/Tab" .. i, "BgBtn")

			btnTab.index = i
			btnTab.data = data[i]

			btnTab:addEventClick(self.onClickTab)
			btnTab:setVisible(true)
			table.insert(self.replayEnvs, data[i])
			table.insert(self.tabBtns, btnTab)
		end

		self:onClickTab(self.tabBtns[1])
	else
		self:refreshUI(data)
	end
end

function WorldBossRecordDlg:refreshUI(data)
	self:checkShowEliteUI(data)

	local str = self.strDes or Lang.get(101664)

	self.data = data
	self.serverReplayData = data.data

	self:parseData()

	local name = data.name
	local recorMaxScore = tonumber(data.recorMaxScore)

	data.score = tonumber(data.score)

	if data.score < 0 then
		data.score = data.score + 4294967296
	end

	if recorMaxScore and recorMaxScore ~= 0 then
		if recorMaxScore < 0 then
			recorMaxScore = recorMaxScore + 4294967296
		end

		self.txtNum:setText(data.score .. "/" .. recorMaxScore)
		self.txtDes:setText(string.format(Lang.get(101665), name, str, str))
	else
		self.txtNum:setText(data.score)
		self.txtDes:setText(string.format(Lang.get(101666), name, str))
	end
end

function WorldBossRecordDlg:checkShowEliteUI(data)
	self.strDes = Lang.get(101664)

	local score2 = data.data.spec.world_boss.mode_two_score or 0

	if not tonumber(score2) or tonumber(score2) <= 0 then
		self.btnReplay:setVisible(true)
		self.txtEliteTips:setVisible(false)
		self.panelEliteInfo:setVisible(false)

		return
	end

	self.strDes = Lang.get(101594)

	self.btnReplay:setVisible(false)
	self.txtEliteTips:setVisible(true)
	self.panelEliteInfo:setVisible(true)

	local score1 = 0

	if data.recorMaxScore and tonumber(data.recorMaxScore) ~= 0 then
		data.recorMaxScore = tonumber(data.recorMaxScore)

		if data.recorMaxScore < 0 then
			data.recorMaxScore = data.recorMaxScore + 4294967296
		end

		score1 = data.recorMaxScore - score2
	else
		data.score = tonumber(data.score)

		if data.score < 0 then
			data.score = data.score + 4294967296
		end

		score1 = data.score - score2
	end

	self.txtNomalScore:setText(tonumber(score1))
	self.txtEliteScore:setText(tonumber(score2))
end

function WorldBossRecordDlg:onClickTab(sender)
	for _, btn in ipairs(self.tabBtns) do
		btn:setEnable(sender ~= btn)
	end

	self.selectIndex = sender.index

	self:refreshUI(sender.data)
end

local function _sortDamage(v1, v2)
	return v1.damage > v2.damage
end

function WorldBossRecordDlg:parseData(...)
	local members = {}
	local data = self.serverReplayData.camp.team or {}
	local myData, bossData = {}, {}

	self.totalMyDamage = 0
	self.totalBossDamage = 0

	if data[1] and data[1].member then
		for _, m in ipairs(data[1].member) do
			if ResHero[m.resid] then
				m.damage = tonumber(m.damage) or 0
				self.totalMyDamage = self.totalMyDamage + m.damage

				table.insert(myData, m)
			end
		end
	end

	if data[2] and data[2].member then
		for _, m in ipairs(data[2].member) do
			if ResMonster[m.resid] then
				m.damage = tonumber(m.damage) or 0
				self.totalBossDamage = self.totalBossDamage + m.damage

				table.insert(bossData, m)
			end
		end
	end

	table.sort(myData, _sortDamage)
	table.sort(bossData, _sortDamage)

	for i, cell in ipairs(self.myRecordCells) do
		if myData[i] then
			cell:setVisible(true)
			cell:setData(myData[i], true)
		else
			cell:setVisible(false)
		end
	end

	for i, cell in ipairs(self.bossRecordCells) do
		if bossData[i] then
			cell:setVisible(true)
			cell:setData(bossData[i], false)
		else
			cell:setVisible(false)
		end
	end
end

function WorldBossRecordDlg:getHeadIconPath(resId, camp)
	if self.battleInitInfo == nil then
		self.battleInitInfo = utils.getBattleInitInfo(self.serverReplayData.start_data)
	end

	for i, heroData in ipairs(self.battleInitInfo.heros or {}) do
		if heroData.camp == camp and heroData.heroID == resId then
			return heroData.heroObj:getIconPath(true)
		end
	end
end

function WorldBossRecordDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function WorldBossRecordDlg:onBtnReplayClick(...)
	if not CurAvatar:isBattleVersionMatch(self.serverReplayData.control.version) then
		MsgManager.clientNotice(178)

		return
	end

	local replayEnv = {}
	local serverData = self.serverReplayData

	if self.replayEnvs and #self.replayEnvs > 1 then
		replayEnv.multirePlayEnvsMode = true
		serverData = self.replayEnvs[self.selectIndex].data

		for i = 1, #self.replayEnvs do
			if self.replayEnvs[i] then
				local replayId = self.replayEnvs[i].data.replay_id
				local data = self.replayEnvs[i]
				local replayData = self.replayEnvs[i].data

				table.insert(replayEnv, {
					replayId = replayId,
					data = data,
					replayData = replayData
				})
			end
		end
	else
		replayEnv.replayId = self.serverReplayData.replay_id
		replayEnv.data = self.data
		replayEnv.replayData = self.serverReplayData
	end

	local ui = UIManager.getUI("rankMainDlg", nil, false)

	if ui then
		replayEnv.isFromRankDlg = true
	end

	local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

	replayState:recordReplayEnv(replayEnv)
	replayState:setServerReplayData(serverData)
	GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
end

return WorldBossRecordDlg
