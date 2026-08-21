-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleReplayRecordDlg.lua

local ResMonster = require("ClientData/ResMonster")
local ResHero = require("ClientData/ResHero")
local VersionUtils = require("System/VersionUtils")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local BattleReplayRecordCell = Class("BattleReplayRecordCell", UIControls.Child)

function BattleReplayRecordCell:ctor()
	self.bg = UIControls.Image(self, "")
	self.imgMvp = UIControls.Image(self, "ImgMvp")
	self.textNum = UIControls.Label(self, "TextNum")
	self.sliderRate = UIControls.Slider(self, "Slider")
	self.imgHero = UIControls.Image(self, "HeadPanel/ImgIcon")
	self.imgFriend = UIControls.Image(self, "ImgHelp")

	self.imgMvp:setVisible(false)
	self.imgFriend:setVisible(false)

	self.bgFill = UIControls.Image(self, "Slider/FillArea/Fill")
end

function BattleReplayRecordCell:setData(data, totalNum)
	if data.iconPath then
		self.imgHero:setImage(data.iconPath[1], data.iconPath[2])
	end

	self.textNum:setText(data.damage)

	if totalNum > 0 then
		self.sliderRate:setValue(0)
		self.sliderRate:setValue(data.damage / totalNum, 0.5)
	else
		self.sliderRate:setValue(0)
	end
end

local strClassName = "BattleReplayRecordDlg"
local BattleReplayRecordDlg = Class(strClassName, UIControls.Window)

function BattleReplayRecordDlg:ctor(...)
	self:initUI()
end

function BattleReplayRecordDlg:initUI(...)
	self.txtTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.txtTips = UIControls.Label(self, "BgPanel/TextTips")
	self.txtPower = UIControls.Label(self, "BgPanel/TextTitle1/TextNum")
	self.panelPower = UIControls.Panel(self, "BgPanel/TextTitle1")
	self.leftCells = {}
	self.rightCells = {}
	self.btnPlay = UIControls.Button(self, "BgPanel/BtnVideo")

	self.btnPlay:addEventClick(self.onBtnPlayClick)
end

function BattleReplayRecordDlg:show(serverReplayData)
	self.serverReplayData = serverReplayData

	self:parseData(serverReplayData)
end

local function _sortDamage(v1, v2)
	return v1.damage > v2.damage
end

function BattleReplayRecordDlg:setTitle()
	if self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		local title = CurAvatar:getLayerNameByLevel(CurAvatar.cachedBossExpandRecord.levelId)

		self.txtTitle:setText(title)
		self.txtPower:setText(self:getFormationPower())
		self.txtTips:setVisible(false)
		self.panelPower:setVisible(true)
	else
		self.txtTips:setVisible(true)
		self.panelPower:setVisible(false)
	end
end

function BattleReplayRecordDlg:getFormationPower(camp)
	camp = camp or BattleConst.CAMP_PLAYER

	local power = 0
	local formations = self.serverReplayData.start_data.start_common.formation

	for _, formation in ipairs(formations) do
		local _camp = formation.camp == BattleConst.CAMP_MONSTER and BattleConst.CAMP_MONSTER or BattleConst.CAMP_PLAYER

		if _camp == camp then
			power = power + CapacityHelper.getFormationCapacity(formation)
		end
	end

	return power
end

function BattleReplayRecordDlg:parseData(serverReplayData)
	local members = {}
	local data = serverReplayData.camp.team or {}

	self.battleType = serverReplayData.start_data.type

	self:setTitle()

	local leftData, rightData = {}, {}
	local maxDamage = 0

	if data[1] and data[1].member then
		for _, m in ipairs(data[1].member) do
			maxDamage = math.max(maxDamage, tonumber(m.damage) or 0)

			table.insert(leftData, self:wrapData(m, BattleConst.CAMP_PLAYER))
		end
	end

	if data[2] and data[2].member then
		for _, m in ipairs(data[2].member) do
			maxDamage = math.max(maxDamage, tonumber(m.damage) or 0)

			table.insert(rightData, self:wrapData(m, BattleConst.CAMP_MONSTER))
		end
	end

	table.sort(leftData, _sortDamage)
	table.sort(rightData, _sortDamage)

	for i, data in ipairs(leftData) do
		if not self.leftCells[i] then
			self.leftCells[i] = BattleReplayRecordCell(self, "BgPanel/BattleDataCellPanel1", "System/Battle/Result/BattleDataCell", 0, 0, true)
		end

		self.leftCells[i]:setData(data, maxDamage)
		self.leftCells[i].bgFill:setImage("Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew", "BarWe")
	end

	for i, data in ipairs(rightData) do
		if i > 10 then
			break
		end

		if not self.rightCells[i] then
			self.rightCells[i] = BattleReplayRecordCell(self, "BgPanel/BattleDataCellPanel2", "System/Battle/Result/BattleDataCell", 0, 0, true)
		end

		self.rightCells[i]:setData(data, maxDamage)
		self.rightCells[i].bgFill:setImage("Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew", "BarEnemy")
	end
end

function BattleReplayRecordDlg:wrapData(member, camp)
	local data = {}

	data.iconPath = self:getHeadIconPath(member.resid, camp)
	data.damage = tonumber(member.damage) or 0

	return data
end

function BattleReplayRecordDlg:getHeadIconPath(resId, camp)
	if self.battleInitInfo == nil then
		self.battleInitInfo = utils.getBattleInitInfo(self.serverReplayData.start_data)
	end

	for i, heroData in ipairs(self.battleInitInfo.heros or {}) do
		if heroData.camp == camp and heroData.heroID == resId then
			return heroData.heroObj:getIconPath(true)
		end
	end

	return UIConst.getHeroHeadIconPath(resId) or UIConst.getMonsterHeadIconPath(resId)
end

function BattleReplayRecordDlg:getPreReplayInfo(...)
	if self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		local ui = UIManager.tryGetUI("bossExpandMainDlg")

		if ui then
			local info = ui:getPreReplayInfo()

			if info then
				return {
					bossExpandData = info
				}
			end
		end
	end
end

function BattleReplayRecordDlg:onBtnPlayClick(...)
	if not CurAvatar:isBattleVersionMatch(self.serverReplayData.control.version) then
		MsgManager.clientNotice(178)

		return
	end

	local replayState = GameFsm.getState(Const.STATE_BATTLE_REPLAY)
	local info = self:getPreReplayInfo()

	if info then
		replayState:recordReplayEnv(info)
	end

	replayState:setServerReplayData(self.serverReplayData)
	GameFsm.translateState(Const.STATE_BATTLE_REPLAY)
end

return BattleReplayRecordDlg
