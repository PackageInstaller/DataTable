-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityPlotInfoDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityPlotStage = require("ClientData/ResOpActivityPlotStage")
local ResSpecialBattleAvg = require("ClientData/ResSpecialBattleAvg")
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local ActivityPlotLevelCell = Class("ActivityPlotLevelCell", UIControls.Child)

function ActivityPlotLevelCell:ctor()
	self.panelOpen = UIControls.Panel(self, "Content/BtnOpen")
	self.btnOpen = UIControls.Button(self, "")

	self.btnOpen:addEventClick(self.onLevelClick)

	self.imgBg = UIControls.RawImage(self, "Content/Image")
	self.imgType = UIControls.Image(self, "Content/ImgType")
	self.panelLock = UIControls.Panel(self, "Content/ImgLock")
	self.panelSelf = UIControls.Panel(self, "")
	self.panelShowEff = UIControls.Panel(self, "EfxShow")
	self.contentEff = UIControls.UIAni(self, "Content")
	self.beforeBtn = UIControls.Panel(self, "Content/BtnOpen/BgFir")
	self.afterBtn = UIControls.Panel(self, "Content/BtnOpen/BgSec")

	if UIControls.checkControlFunc(self, "Content/ImgLock/TextTitle") then
		self.textLockTitle = UIControls.Label(self, "Content/ImgLock/TextTitle")
		self.textLockDes = UIControls.Label(self, "Content/ImgLock/TextDes")
		self.textFirTitle = UIControls.Label(self, "Content/BtnOpen/BgFir/TextTitle")
		self.textFirDes = UIControls.Label(self, "Content/BtnOpen/BgFir/TextDes")
		self.textSecTitle = UIControls.Label(self, "Content/BtnOpen/BgSec/TextTitle")
		self.textSecDes = UIControls.Label(self, "Content/BtnOpen/BgSec/TextDes")
	end

	if UIControls.checkControlFunc(self, "Content/BtnOpen/BgFir/ImgType") then
		self.imgTypeFir = UIControls.Image(self, "Content/BtnOpen/BgFir/ImgType")
	end

	if UIControls.checkControlFunc(self, "Content/BtnOpen/BgSec/ImgType") then
		self.imgTypeSec = UIControls.Image(self, "Content/BtnOpen/BgSec/ImgType")
	end
end

function ActivityPlotLevelCell:normalShowEff()
	if self.levelState ~= Const.COMMON_STATE_LOCK and self.levelState ~= Const.COMMON_STATE_NML then
		self.panelShowEff:setVisible(false)
		self.panelShowEff:setVisible(true)
	end
end

function ActivityPlotLevelCell:playShowEff()
	self.panelLock:setVisible(true)
	self.contentEff:startAni("UnlockPlot", true)

	self.preLockAnim = true
end

function ActivityPlotLevelCell:setData(levelDetailData, levelState)
	self.levelDetailData = levelDetailData
	self.levelState = levelState

	if self.levelDetailData.name_icon then
		self.imgBg:setImage(self.levelDetailData.name_icon)
	end

	if self.levelDetailData.battle_id then
		self.imgType:setImage("Atlas/ActivityAtlas/ActivityFlotAtlas/ActivityFlotAtlas", "IconBattle")
	else
		self.imgType:setImage("Atlas/ActivityAtlas/ActivityFlotAtlas/ActivityFlotAtlas", "IconAvg")
	end

	if levelState == Const.COMMON_STATE_LOCK or levelState == Const.COMMON_STATE_NML then
		self.panelLock:setVisible(true)
		self.panelOpen:setVisible(false)
		self.imgType:setVisible(false)
		self.panelSelf:setObjGray(true)

		if self.preLockAnim then
			self.contentEff:startAni("ResetLockPlot", true)

			self.preLockAnim = false
		end
	else
		self.panelLock:setVisible(false)
		self.panelOpen:setVisible(true)
		self.imgType:setVisible(true)
		self.panelSelf:setObjGray(false)

		if levelState == Const.COMMON_STATE_COMPLETE then
			self.beforeBtn:setVisible(false)
			self.afterBtn:setVisible(true)
		else
			self.beforeBtn:setVisible(true)
			self.afterBtn:setVisible(false)
		end
	end

	if self.imgTypeFir and self.imgTypeSec then
		self.imgType:setVisible(false)

		local path = "Atlas/ActivityAtlas/ActivityPlot14019Atlas/PlotInfoAtlas"

		if self.mParent.replaceableCellPath and self.mParent.replaceableCellPath[4] then
			path = self.mParent.replaceableCellPath[4]
		end

		self.imgTypeFir:setVisible(true)
		self.imgTypeSec:setVisible(true)

		local iconName = "IconWatch"

		if self.levelDetailData.battle_id then
			iconName = "IconFight"
		end

		self.imgTypeFir:setImage(path, iconName)
		self.imgTypeSec:setImage(path, iconName)
	end

	if levelDetailData.story_title and self.textLockTitle then
		self.textLockTitle:setText(levelDetailData.story_title)
		self.textLockDes:setText(levelDetailData.story_desc or "")
		self.textFirTitle:setText(levelDetailData.story_title)
		self.textFirDes:setText(levelDetailData.story_desc or "")
		self.textSecTitle:setText(levelDetailData.story_title)
		self.textSecDes:setText(levelDetailData.story_desc or "")
	end
end

function ActivityPlotLevelCell:onLevelClick()
	if self.levelState == Const.COMMON_STATE_LOCK or self.levelState == Const.COMMON_STATE_NML then
		MsgManager.clientNotice(257)
	else
		self.mParent:onLevelClick(self)
	end
end

local ActivityPlotStageCell = Class("ActivityPlotStageCell", UIControls.Child)

function ActivityPlotStageCell:ctor()
	self.btnNml = UIControls.Button(self, "BtnFlot", "Text")

	self.btnNml:addEventClick(self.onStageClick)

	self.btnDis = UIControls.Button(self, "BtnFlotDis", "Text")

	self.btnDis:addEventClick(self.onStageClick)
end

function ActivityPlotStageCell:setData(stageData, state)
	self.stageData = stageData
	self.locked = state == Const.COMMON_STATE_LOCK or state == Const.COMMON_STATE_NML

	self.btnNml:setVisible(not self.locked)
	self.btnNml:setText(stageData.stage_title or "")
	self.btnDis:setVisible(self.locked)
	self.btnDis:setText(stageData.stage_title or "")
end

function ActivityPlotStageCell:setSelected(isSelected)
	if not self.locked then
		self.btnNml:setEnable(not isSelected)
	end
end

function ActivityPlotStageCell:onStageClick()
	self.mParent:onStageClick(self)
end

local ActivityPlotStagePanel = Class("ActivityPlotStagePanel", UIControls.Panel)

function ActivityPlotStagePanel:ctor()
	self.btnNml = UIControls.Button(self, self.mPath, "TextTitle")

	self.btnNml:addEventClick(self.onStageClick)
end

function ActivityPlotStagePanel:setData(stageData, state)
	self.stageData = stageData
	self.locked = state == Const.COMMON_STATE_LOCK or state == Const.COMMON_STATE_NML

	if self.locked then
		self:setObjGray(true, true)
	else
		self:setObjGray(false, true)
	end
end

function ActivityPlotStagePanel:setSelected(isSelected)
	if not self.locked then
		self.btnNml:setEnable(not isSelected)
	else
		self.btnNml:setEnable(true)
	end
end

function ActivityPlotStagePanel:onStageClick()
	self.mParent:onStageClick(self)
end

local strClassName = "ActivityPlotInfoDlg"
local ActivityPlotInfoDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityPlotInfoDlg, ActivityPanelMixin)

local MAX_LEVEL_NUM = 5

function ActivityPlotInfoDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.stageCells = {}
end

function ActivityPlotInfoDlg:onShowPlotInfo(pageData, stageId)
	self.stageId = stageId

	self:onShowActivity(pageData)
end

function ActivityPlotInfoDlg:_setData()
	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.cellPrefabKey = self.replaceableCellPath[2]
	else
		self.cellPrefabKey = "ActivityFlot"
	end

	if not self.levelCells then
		self.levelCells = {}

		for index = 1, MAX_LEVEL_NUM do
			local newCell

			if index % 2 == 1 then
				newCell = ActivityPlotLevelCell(self, "MainInfoPanel/FlotInfoPanel/Content", "System/Activity/" .. self.cellPrefabKey .. "/FlotPanelDown")
			else
				newCell = ActivityPlotLevelCell(self, "MainInfoPanel/FlotInfoPanel/Content", "System/Activity/" .. self.cellPrefabKey .. "/FlotPanelUp")
			end

			self.levelCells[index] = newCell
		end
	end

	if self.stageId == nil then
		local nextLevel, nextStage = self.actObj.actData:getNextSelectNode()

		self.stageId = nextStage
	end

	local actId = self.actObj.actId

	self.levelData = {}
	self.stageData = {}

	for stageId, info in ipairs(ResOpActivityPlotStage[actId] or {}) do
		if info.stage_type == Const.ACT_TYPE_PLOT_MODE_STORY then
			table.insert(self.stageData, info)

			self.levelData[stageId] = {}
		end
	end

	for detailId, detailInfo in ipairs(self.actObj.actData.clientData or {}) do
		if self.levelData[detailInfo.stage] then
			table.insert(self.levelData[detailInfo.stage], detailInfo)
		end
	end

	self.miscData = self.actObj.actData.miscData

	local moneyList = {
		100001,
		100002
	}

	if self.miscData and self.miscData.cost_item_id then
		table.insert(moneyList, 1, self.miscData.cost_item_id)
	end

	self.panelFund:settingFund(moneyList)
end

function ActivityPlotInfoDlg:_onShow()
	local actData = self.actObj.actData
	local nowStageCell
	local maxStageNum = #self.stageData

	for index = #self.stageCells + 1, maxStageNum do
		if UIControls.checkControlFunc(self, "MainInfoPanel/BtnFlotPanel/Plot" .. index) then
			local newCell = ActivityPlotStagePanel(self, "MainInfoPanel/BtnFlotPanel/Plot" .. index)

			table.insert(self.stageCells, newCell)
		else
			local newCell = ActivityPlotStageCell(self, "MainInfoPanel/BtnFlotPanel", "System/Activity/" .. self.cellPrefabKey .. "/BtnFlotCell")

			table.insert(self.stageCells, newCell)
		end
	end

	for index, cell in ipairs(self.stageCells) do
		local stageData = self.stageData[index]

		if stageData then
			cell:setVisible(true)

			local state = actData:getStageState(stageData.stage)

			cell:setData(stageData, state)

			if stageData.stage == self.stageId then
				nowStageCell = cell
			end
		else
			cell:setVisible(false)
		end
	end

	if nowStageCell then
		self:onStageClick(nowStageCell)
	else
		self:onStageClick(self.stageCells[1])
	end
end

function ActivityPlotInfoDlg:onStageClick(sender)
	local unlockTime = self.actObj.actData:getStageUnlockedTime(sender.stageData.stage)
	local openTime = unlockTime - ClientUtils.getServerTime()

	if openTime > 0 then
		local notice = string.format(sender.stageData.unlock_desc_pre, utils.calcTimeTxt(openTime))

		MsgManager.notice(notice)

		return
	end

	local state = self.actObj.actData:getStageState(sender.stageData.stage)

	if state == Const.COMMON_STATE_NML then
		MsgManager.clientNotice(269)

		return
	end

	local actData = self.actObj.actData

	for _, cell in ipairs(self.stageCells) do
		cell:setSelected(sender == cell)
	end

	self.stageId = sender.stageData.stage

	local levelData = self.levelData[sender.stageData.stage] or {}

	for index = 1, MAX_LEVEL_NUM do
		local cell = self.levelCells[index]
		local detailData = levelData[index]

		if detailData then
			cell:setVisible(true)

			local levelState = actData:getLevelState(detailData.index)

			cell:setData(detailData, levelState)
			cell:normalShowEff()
		else
			cell:setVisible(false)
		end
	end

	local newLevel = CurAvatar:getNewDataCache(Const.NEW_DATA_CACHE_PLOT)

	if newLevel then
		for index = 1, MAX_LEVEL_NUM do
			local cell = self.levelCells[index]

			if cell.levelDetailData and cell.levelDetailData.index == newLevel then
				cell:playShowEff()
			end
		end
	end
end

function ActivityPlotInfoDlg:onLevelClick(sender)
	self.activeLevelDetailData = sender.levelDetailData
	self.activeAVG = {
		self.activeLevelDetailData.plot_avg1,
		self.activeLevelDetailData.plot_avg2,
		self.activeLevelDetailData.plot_avg3,
		self.activeLevelDetailData.plot_avg4,
		self.activeLevelDetailData.plot_avg5,
		self.activeLevelDetailData.plot_avg6,
		self.activeLevelDetailData.plot_avg7,
		self.activeLevelDetailData.plot_avg8
	}

	if self.actObj.actData:getLevelState(self.activeLevelDetailData.index) ~= Const.COMMON_STATE_NEXT then
		local pveId = self.activeLevelDetailData.battle_id
		local battleConfig = ResSpecialBattleAvg[pveId]

		if battleConfig then
			if battleConfig.pre_battle_avg then
				table.insert(self.activeAVG, battleConfig.pre_battle_avg)
			end

			if battleConfig.pre_result_avg then
				table.insert(self.activeAVG, battleConfig.pre_result_avg)
			end

			if battleConfig.after_result_avg then
				table.insert(self.activeAVG, battleConfig.after_result_avg)
			end
		end
	end

	self:playAVG()
end

function ActivityPlotInfoDlg:playAVG()
	local avgId = table.remove(self.activeAVG, 1)

	if avgId then
		UIManager.playAVG(avgId, nil, Slot(self.playAVG, self))
	elseif self.actObj.actData:getLevelState(self.activeLevelDetailData.index) == Const.COMMON_STATE_NEXT then
		if self.activeLevelDetailData.battle_id then
			local battleData = {}

			battleData.actData = {}
			battleData.actData.opId = self.actObj.opId
			battleData.actData.actId = self.actObj.actId
			battleData.actData.nodeIndex = self.activeLevelDetailData.index

			CurAvatar:activityRPC(Functor(CurAvatar.enterFormation, CurAvatar, self.activeLevelDetailData.battle_id, BattleConst.BATTLE_TYPE_ACTIVITY, battleData), self.actObj.opId)
		else
			CurAvatar:activityRPC(Functor(RPC.opActPlotPassCurStage, self.actObj.opId, self.activeLevelDetailData.index), self.actObj.opId)
		end
	end
end

function ActivityPlotInfoDlg:onBtnClose()
	self:setVisible(false)
end

function ActivityPlotInfoDlg:updateActivityData()
	self:_onShow()
end

return ActivityPlotInfoDlg
