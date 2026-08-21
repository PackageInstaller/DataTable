-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityPlotAchieveDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityPlotStage = require("ClientData/ResOpActivityPlotStage")
local ResOpActivityPlotAchieve = require("ClientData/ResOpActivityPlotAchieve")
local ResClientNotice = require("ClientData/ResClientNotice")
local ActivityPlotAchieveTabCell = Class("ActivityPlotAchieveTabCell", UIControls.Child)

function ActivityPlotAchieveTabCell:ctor()
	self.imgComplete = UIControls.Panel(self, "ImgComplete")
	self.textCell = UIControls.Label(self, "Text")
	self.iconNew = UIControls.Panel(self, "IconNew")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onTabBtnClick)
end

function ActivityPlotAchieveTabCell:setData(stageData)
	self.stageId = stageData.stage
	self.stageData = stageData

	self.textCell:setText(self.stageData.achieve_title or "")
end

function ActivityPlotAchieveTabCell:setSelected(selected)
	self.btnSensor:setEnable(not selected)
end

function ActivityPlotAchieveTabCell:updateState(isFinished, hasNew)
	self.imgComplete:setVisible(isFinished)
	self.iconNew:setVisible(hasNew)
end

function ActivityPlotAchieveTabCell:onTabBtnClick(isFinished, hasNew)
	self.mParent:onTabBtnClick(self)
end

local ActivityPlotAchieveContentCell = Class("ActivityPlotAchieveContentCell", UIControls.ScrollViewLoopCell)

function ActivityPlotAchieveContentCell:ctor()
	self.panelNoFinish = UIControls.Panel(self, "ImgUnfinish")
	self.btnGet = UIControls.Button(self, "BtnConfirm", "Text")

	self.btnGet:addEventClick(self.onBtnGet)

	self.textTitle = UIControls.Label(self, "TxtTitle")
	self.textDesc = UIControls.Label(self, "TxtDes")
	self.awardGrids = {}
	self.imgBg = UIControls.Image(self, "")
	self.textSweep = UIControls.Label(self, "TxtTimes")
end

function ActivityPlotAchieveContentCell:setData(achieveData, isFinished, isGot, sweepInfo)
	self.achieveData = achieveData

	self.textTitle:setText(achieveData.title or "")
	self.textDesc:setText(achieveData.desc or "")

	if sweepInfo then
		self.textSweep:setText(utils.format(Lang.get(30623), sweepInfo[1], sweepInfo[2]))
	else
		self.textSweep:setText("")
	end

	ClientUtils.CreateBonusGrid(self, self.awardGrids, "IconPanel", achieveData.award, true, 3, true)

	if isGot then
		self.btnGet:setVisible(false)
		self.panelNoFinish:setVisible(false)
		self.textTitle:setFontColor(self.mParent.labelColors[1])
		self.textDesc:setFontColor(self.mParent.labelColors[2])
		self.textSweep:setFontColor(self.mParent.labelColors[1])
		self.imgBg:setImage("Atlas/ActivityAtlas/" .. self.mParent.atlasPrefabKey, "BgTargetCell02")
	elseif isFinished then
		self.btnGet:setVisible(true)
		self.panelNoFinish:setVisible(false)
		self.textTitle:setFontColor(self.mParent.labelColors[3])
		self.textDesc:setFontColor(self.mParent.labelColors[4])
		self.textSweep:setFontColor(self.mParent.labelColors[3])
		self.imgBg:setImage("Atlas/ActivityAtlas/" .. self.mParent.atlasPrefabKey, "BgTargetCell01")
	else
		self.btnGet:setVisible(false)
		self.panelNoFinish:setVisible(true)
		self.textTitle:setFontColor(self.mParent.labelColors[3])
		self.textDesc:setFontColor(self.mParent.labelColors[4])
		self.textSweep:setFontColor(self.mParent.labelColors[3])
		self.imgBg:setImage("Atlas/ActivityAtlas/" .. self.mParent.atlasPrefabKey, "BgTargetCell01")
	end

	for _, grid in ipairs(self.awardGrids) do
		grid:setGet(isGot)
	end
end

function ActivityPlotAchieveContentCell:onBtnGet()
	self.mParent:onBtnGet(self)
end

local strClassName = "ActivityPlotAchieveDlg"
local ActivityPlotAchieveDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityPlotAchieveDlg, ActivityPanelMixin)

function ActivityPlotAchieveDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.tabCells = {}
	self.contentCells = {}
	self.panelContent = UIControls.Panel(self, "MainInfoPanel/TargetList")
	self.scrollContent = UIControls.ScrollViewLoopV(self, "MainInfoPanel/TargetList", 0, self.onCellChanged)
	self.panelOver = UIControls.RawImage(self, "MainInfoPanel/LogPanel")
	self.textOverData = UIControls.Label(self, "MainInfoPanel/LogPanel/Txt1")
	self.textOverTitle = UIControls.Label(self, "MainInfoPanel/LogPanel/Txt2")
	self.textOverContent = UIControls.Label(self, "MainInfoPanel/LogPanel/Txt3")
end

function ActivityPlotAchieveDlg:_setData()
	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.cellPrefabKey = self.replaceableCellPath[2]
	else
		self.cellPrefabKey = "ActivityFlot"
	end

	if self.replaceableCellPath and self.replaceableCellPath[3] then
		self.atlasPrefabKey = self.replaceableCellPath[3]
	else
		self.atlasPrefabKey = "ActivityFlotAtlas/ActivityFlotAtlas1"
	end

	self.labelColors = {}

	if self.replaceableColorPath and self.replaceableColorPath[1] and ResColor[self.replaceableColorPath[1]] then
		table.insert(self.labelColors, ResColor[self.replaceableColorPath[1]])
	else
		table.insert(self.labelColors, ResColor.GREYDIS)
	end

	if self.replaceableColorPath and self.replaceableColorPath[2] and ResColor[self.replaceableColorPath[2]] then
		table.insert(self.labelColors, ResColor[self.replaceableColorPath[2]])
	else
		table.insert(self.labelColors, ResColor.GREYDIS)
	end

	if self.replaceableColorPath and self.replaceableColorPath[3] and ResColor[self.replaceableColorPath[3]] then
		table.insert(self.labelColors, ResColor[self.replaceableColorPath[3]])
	else
		table.insert(self.labelColors, ResColor.ORANGEBTN)
	end

	if self.replaceableColorPath and self.replaceableColorPath[4] and ResColor[self.replaceableColorPath[4]] then
		table.insert(self.labelColors, ResColor[self.replaceableColorPath[4]])
	else
		table.insert(self.labelColors, ResColor.WHITE)
	end

	local actId = self.actObj.actId
	local stageorders = {}

	self.stageMap = {}

	for achId, achInfo in ipairs(ResOpActivityPlotAchieve[actId] or {}) do
		if achInfo.client_index then
			local actClientData = self.actObj.actData.clientData[achInfo.client_index]
			local stage = actClientData.stage

			if stage then
				if not self.stageMap[stage] then
					self.stageMap[stage] = {}

					table.insert(stageorders, stage)
				end

				table.insert(self.stageMap[stage], achInfo)
			end
		end
	end

	for index, stageId in ipairs(stageorders) do
		local newTabCell = ActivityPlotAchieveTabCell(self, "MainInfoPanel/TabPanel/Content", "System/Activity/" .. self.cellPrefabKey .. "/BtnFlotTableCell")

		newTabCell:setData(ResOpActivityPlotStage[actId][stageId])
		newTabCell:setVisible(true)

		self.tabCells[index] = newTabCell
	end
end

function ActivityPlotAchieveDlg:onShowAchieve(pageData, stageId)
	self.stageId = stageId

	self:onShowActivity(pageData)
end

function ActivityPlotAchieveDlg:_onShow()
	for index, cell in ipairs(self.tabCells) do
		local stageId = cell.stageId
		local allOver = self:isOneStageOver(stageId)
		local hasNew = self:isStageHasNew(stageId)

		cell:updateState(allOver, hasNew)

		if not self.stageId and not allOver then
			self.stageId = stageId
		end
	end

	for index, cell in ipairs(self.tabCells) do
		if cell.stageId == (self.stageId or 1) then
			self:onTabBtnClick(cell)

			break
		end
	end
end

function ActivityPlotAchieveDlg:isOneStageOver(stageId)
	local actData = self.actObj.actData
	local achieveData = self.stageMap[stageId]

	for _, achInfo in ipairs(achieveData) do
		if not actData:isAchieveGot(achInfo.index) then
			return false
		end
	end

	return true
end

function ActivityPlotAchieveDlg:isStageHasNew(stageId)
	local actData = self.actObj.actData
	local achieveData = self.stageMap[stageId]

	for _, achInfo in ipairs(achieveData) do
		if not actData:isAchieveGot(achInfo.index) and actData:isAchieveFinished(achInfo.index) then
			return true
		end
	end

	return false
end

function ActivityPlotAchieveDlg:onTabBtnClick(sender)
	local actData = self.actObj.actData

	for _, cell in ipairs(self.tabCells) do
		cell:setSelected(cell == sender)
	end

	local stageId = sender.stageId

	self.stageId = stageId

	if self:isOneStageOver(stageId) then
		self.panelOver:setVisible(true)
		self.panelContent:setVisible(false)

		local stageData = sender.stageData

		if stageData.achieve_finish_icon then
			self.panelOver:setImage(stageData.achieve_finish_icon)
		end

		self.textOverTitle:setText(stageData.achieve_finish_title or "")
		self.textOverContent:setText(stageData.achieve_finish_content or "")
		self.textOverData:setText(stageData.achieve_finish_data or "")

		if self.stageId == self.preNotAllOver then
			self:playAni("ShowLogImage")
		end

		self.preNotAllOver = nil
	else
		self.preNotAllOver = stageId

		self.panelOver:setVisible(false)
		self.panelContent:setVisible(true)

		self.achs = self.stageMap[stageId] or {}

		local jumpIdx

		for index, achInfo in ipairs(self.achs) do
			if actData:isAchieveFinished(achInfo.index) and not actData:isAchieveGot(achInfo.index) then
				jumpIdx = index

				break
			end
		end

		self.scrollContent:setTotalCount(#self.achs, jumpIdx)
	end
end

function ActivityPlotAchieveDlg:onCellChanged(sender, targetCell, newIdx)
	local actData = self.actObj.actData

	if targetCell == nil then
		targetCell = ActivityPlotAchieveContentCell(sender, "System/Activity/" .. self.cellPrefabKey .. "/TargetListCell", newIdx)
	else
		self.contentCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local achData = self.achs[newIdx]

	if achData then
		targetCell:setData(achData, actData:isAchieveFinished(achData.index), actData:isAchieveGot(achData.index), actData:getSweepInfo(achData.index))
	end

	self.contentCells[newIdx] = targetCell
end

function ActivityPlotAchieveDlg:onBtnClose()
	self:setVisible(false)
end

function ActivityPlotAchieveDlg:playAVG()
	local avgId = table.remove(self.activeAVG, 1)

	if avgId then
		UIManager.playAVG(avgId, nil, Slot(self.playAVG, self))
	elseif self.activeLevelDetailData.battle_id then
		local battleData = {}

		battleData.actData = {}
		battleData.actData.opId = self.actObj.opId
		battleData.actData.actId = self.actObj.actId
		battleData.actData.nodeIndex = self.activeLevelDetailData.target_index

		CurAvatar:enterFormation(self.activeLevelDetailData.battle_id, BattleConst.BATTLE_TYPE_ACTIVITY, battleData)
	end
end

function ActivityPlotAchieveDlg:updateActivityData()
	self:_onShow()
end

function ActivityPlotAchieveDlg:onBtnGet(cell)
	local achieveData = cell.achieveData

	if achieveData then
		if self.actObj:isValid() then
			RPC.opActPlotGetAchieveAward(self.actObj.opId, achieveData.index)
		else
			MsgManager.notice(Lang.get(1870))
		end
	end
end

return ActivityPlotAchieveDlg
