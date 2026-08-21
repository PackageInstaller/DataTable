-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\OnceTowerRecordDlg.lua

local DragTwoPages = require("UI/Control/DragTwoPages")
local ResOnceTower = require("ClientData/ResOnceTower")
local ResRandClient = require("ClientData/ResRandClient")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local Monster = require("Common/Object/Monster")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local EventConst = require("EventConst")
local ResRecommendFormationCondition = require("ClientData/ResRecommendFormationCondition")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local OnceTowerRecordCell = require("UI/MainState/OtherBattle/OnceTowerRecordCell")
local OnceTowerRecordDlg = Class("OnceTowerRecordDlg", UIControls.Window)

function OnceTowerRecordDlg:ctor()
	self.recordCells = {}

	for index = 1, 3 do
		local newCell = OnceTowerRecordCell(self, "BgPanel/PlayerVideoListNew/Content", "System/OneTimeTower/PlayerLineUpInfoCell")

		table.insert(self.recordCells, newCell)
	end

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.panelEmpty = UIControls.Panel(self, "BgPanel/NoContent")
end

function OnceTowerRecordDlg:onOpen()
	OnceTowerRecordDlg.super.onOpen(self)

	self.slotOnFormationDataNotify = Slot(self.onFormationDataNotify, self)

	EventCenter.addEventListener(EventConst.FORMATION_DATA_NOTIFY, self.slotOnFormationDataNotify)
end

function OnceTowerRecordDlg:onClose()
	OnceTowerRecordDlg.super.onClose(self)
	EventCenter.removeEventListener(EventConst.FORMATION_DATA_NOTIFY, self.slotOnFormationDataNotify)

	CurAvatar.checkJustShowReplayHeroInfo = nil
end

function OnceTowerRecordDlg:onCloseClick()
	self:setVisible(false)
end

function OnceTowerRecordDlg:setData(replayType, data, progress, extra)
	self.replayType = replayType
	self.data = data
	self.progress = progress
	self.extra = extra

	if self.extra and type(self.extra) == "table" then
		self.battleType = self.extra.battleType
		self.formationIndex = self:getFormationIndex()
	end

	local count = self.data and #self.data or 0

	if count == 0 then
		self.panelEmpty:setVisible(true)
	else
		self.panelEmpty:setVisible(false)

		for index, cell in ipairs(self.recordCells) do
			local info = data[index]

			if info then
				cell:setVisible(true)
				cell:setData(info.record, info.comm, self.extra, self.formationIndex)
			else
				cell:setVisible(false)
			end
		end
	end
end

function OnceTowerRecordDlg:onFormationDataNotify(formationIdx)
	for _, cell in ipairs(self.recordCells) do
		if cell.formationIdx == formationIdx then
			if self.extra and self.extra.onBattleClick then
				self.extra.onBattleClick()
			end

			break
		end
	end
end

function OnceTowerRecordDlg:getFormationIndex()
	if not self.extra or not self.battleType then
		return nil
	end

	if self.battleType == BattleConst.FORMATION_TYPE_ASYNC_PVP then
		return Const.FORMATION_ASYNC_DEFEND
	elseif self.battleType == BattleConst.BATTLE_TYPE_MAZE then
		return Const.FORMATION_MAZE
	elseif self.battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
		if self.extra.type then
			return Const["FORMATION_EQUIP_TOWER_" .. self.extra.type]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		if self.extra.type then
			return Const["FORMATION_BOSS_CHOOSE_" .. self.extra.type]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_ACTIVITY or self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
		return Const.FORMATION_FORCE_EMPTY
	elseif self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		if self.extra.type then
			return Const.FORMATION_WORLD_BOSS[self.extra.type]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		if self.extra.towerId then
			return Const.SEASON_TOWER_FORMATION_CONFIG[self.extra.towerId]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_RENT then
		return Const.FORMATION_RENT
	elseif self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		return Const.FORMATION_CIRCLE_BATTLE
	elseif self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		if self.extra.towerId then
			return Const.FORMATION_BOSS_EXPAND[self.extra.towerId]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		return Const.FORMATION_NEW_MAZE
	end

	return Const.FORMATION_MAIN_STAGE
end

function OnceTowerRecordDlg:cacheReplayData(data, isShowHero)
	if data == nil then
		return
	end

	if not self.replayDataDic then
		self.replayDataDic = {}
	end

	local replayId = data.replay_id

	self.replayDataDic[replayId] = data

	if isShowHero then
		for _, cell in pairs(self.recordCells) do
			if cell ~= nil and cell.replayId == replayId then
				cell:refreshHeroScroll(data)
			end
		end
	end
end

function OnceTowerRecordDlg:getReplayData(replayId)
	return self.replayDataDic and self.replayDataDic[replayId]
end

return OnceTowerRecordDlg
