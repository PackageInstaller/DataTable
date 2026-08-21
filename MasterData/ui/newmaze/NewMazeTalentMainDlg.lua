-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeTalentMainDlg.lua

local NewMazeTalentGrid = require("UI/NewMaze/NewMazeTalentGrid")
local strClassName = "NewMazeTalentMainDlg"
local NewMazeTalentMainDlg = Class(strClassName, UIControls.Window)

function NewMazeTalentMainDlg:ctor()
	self:initUI()
end

function NewMazeTalentMainDlg:initUI()
	self.btnPointTips = UIControls.Button(self, "MainInfoPanel/BtnEnergy")

	self.btnPointTips:addEventClick(self.onPointTipsClick)

	self.numPoint = UIControls.Label(self, "MainInfoPanel/BtnEnergy/TextNum")
	self.btnResetAll = UIControls.Button(self, "MainInfoPanel/BtnRefresh")

	self.btnResetAll:addEventClick(self.onResetAllClick)

	self.talentGrids = {}
	self.iconSelectTalent = UIControls.Image(self, "MainInfoPanel/SkillDetailPanel/SkillPanel/IconSkill")
	self.textSelectTalentName = UIControls.Label(self, "MainInfoPanel/SkillDetailPanel/SkillPanel/Text")
	self.panelCurLevel = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/SkillDescribePanel/CurrentPanel")
	self.nameCurLevel = UIControls.Label(self, "MainInfoPanel/SkillDetailPanel/SkillDescribePanel/CurrentPanel/TextLvNum")
	self.descCurLevel = UIControls.Label(self, "MainInfoPanel/SkillDetailPanel/SkillDescribePanel/CurrentPanel/TextCurrent")
	self.panelNextLevel = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/SkillDescribePanel/NextPanel")
	self.nameNextLevel = UIControls.Label(self, "MainInfoPanel/SkillDetailPanel/SkillDescribePanel/NextPanel/TextLvNum")
	self.descNextLevel = UIControls.Label(self, "MainInfoPanel/SkillDetailPanel/SkillDescribePanel/NextPanel/TextCurrent")
	self.btnPreviewDown = UIControls.Button(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnDown")

	self.btnPreviewDown:addEventClick(self.onPreviewDownClick)

	self.panelPreviewDownNml = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnDown/NmlPanel")
	self.panelPreviewDownDis = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnDown/DisPanel")
	self.btnPreviewAdd = UIControls.Button(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp")

	self.btnPreviewAdd:addEventClick(self.onPreviewAddClick)

	self.panelPreviewAddNml = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/NmlPanel")
	self.panelPreviewAddDis = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/DisPanel")
	self.panelPreviewAddNmlUnlock = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/NmlPanel/ImgUnlock")
	self.panelPreviewAddNmlUp = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/NmlPanel/ImgUp")
	self.panelPreviewAddDisUnlock = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/DisPanel/ImgUnlock")
	self.panelPreviewAddDisUp = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/DisPanel/ImgUp")
	self.panelMax = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/TextMax")
	self.panelLimit = UIControls.Label(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/TextLimit")
	self.panelCost = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/CostPanel")
	self.textCostTitle = UIControls.Label(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/CostPanel/TextTitle")
	self.textCostNum = UIControls.Label(self, "MainInfoPanel/SkillDetailPanel/LvEditPanel/BtnUp/CostPanel/TextNum")
	self.panelLevelUpEfx = UIControls.Panel(self, "MainInfoPanel/SkillDetailPanel/Efx")
	self.btnConfim = UIControls.Button(self, "MainInfoPanel/BtnConfirm")

	self.btnConfim:addEventClick(self.onConfimClick)

	self.panelConfirmNml = UIControls.Panel(self, "MainInfoPanel/BtnConfirm/NmlPanel")
	self.panelConfirmDis = UIControls.Panel(self, "MainInfoPanel/BtnConfirm/DisPanel")
	self.btnTips = UIControls.Button(self, "MainInfoPanel/BtnTips")

	self.btnTips:addEventClick(self.onTipsClick)

	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)
end

function NewMazeTalentMainDlg:onShow(actObj)
	self.actObj = actObj
	self.actData = actObj.actData
	self.maxPoint = self.actData:getAllTalentPoint()
	self.curCycle = self.actData.cycle
	self.miscData = self.actData.miscData

	if self.miscData.open_talent_group then
		for index = #self.talentGrids, #self.miscData.open_talent_group - 1 do
			local newGrid = NewMazeTalentGrid(self, "MainInfoPanel/GridSkillPanel/Content", "System/Rogue/GridRogueSkill")

			newGrid:setData(self.miscData.open_talent_group[index + 1])

			newGrid.mEventCellClick = Slot(self.onChooseClick, self)

			newGrid:setVisible(true)
			table.insert(self.talentGrids, newGrid)
		end
	end

	self:onRefreshGrid()
	self:onRefreshTalentPoint()
	self:onChooseClick(self.talentGrids[1])
end

function NewMazeTalentMainDlg:onRefreshGrid()
	self.talentState = self.actData.talentState
	self.havePoint = self.actData.talentPoint

	for index, grid in ipairs(self.talentGrids) do
		local groupId = grid.groupId
		local curLevel = 0

		for _, info in ipairs(self.talentState) do
			if info.group == groupId then
				curLevel = info.grade

				break
			end
		end

		grid:setLevel(curLevel, 0)
		grid:refreshUpEnable()
	end
end

function NewMazeTalentMainDlg:onChooseClick(sender)
	for index, grid in ipairs(self.talentGrids) do
		grid:setSelected(sender == grid)
	end

	self.selectGroupCell = sender

	local showData = self.selectGroupCell.groupData[1]

	if showData.iconPath then
		self.iconSelectTalent:setImage(showData.iconPath, showData.icon)
	end

	self.textSelectTalentName:setText(showData.name)
	self:refreshDetailInfo()
end

function NewMazeTalentMainDlg:refreshDetailInfo()
	self.nextAddEnable = false

	local level = self.selectGroupCell.level + self.selectGroupCell.previewLevel

	self.btnPreviewDown:setVisible(level > 0)

	if self.selectGroupCell.previewLevel > 0 then
		self.panelPreviewDownDis:setVisible(false)
		self.panelPreviewDownNml:setVisible(true)
	else
		self.panelPreviewDownDis:setVisible(true)
		self.panelPreviewDownNml:setVisible(false)
	end

	self.panelPreviewAddNmlUnlock:setVisible(level == 0)
	self.panelPreviewAddNmlUp:setVisible(level > 0)
	self.panelPreviewAddDisUnlock:setVisible(level == 0)
	self.panelPreviewAddDisUp:setVisible(level > 0)

	local curPoint = 0
	local groupData = self.selectGroupCell.groupData
	local curLevelData = groupData[level]

	if curLevelData then
		curPoint = curLevelData.need_point

		self.panelCurLevel:setVisible(true)

		if Const.REVIEW_VERSION then
			self.nameCurLevel:setText(Lang.get(1203) .. curLevelData.grade)
		else
			self.nameCurLevel:setText("Lv." .. curLevelData.grade)
		end

		self.descCurLevel:setText(curLevelData.desc)
	else
		self.panelCurLevel:setVisible(false)
	end

	self.nextLevelData = groupData[level + 1]

	if self.nextLevelData then
		self.panelNextLevel:setVisible(true)

		if Const.REVIEW_VERSION then
			self.nameNextLevel:setText(Lang.get(1203) .. self.nextLevelData.grade)
		else
			self.nameNextLevel:setText("Lv." .. self.nextLevelData.grade)
		end

		self.descNextLevel:setText(self.nextLevelData.desc)
		self.panelMax:setVisible(false)

		if self.nextLevelData.unlock_cycle and self.nextLevelData.unlock_cycle > self.curCycle then
			self.panelPreviewAddNml:setVisible(false)
			self.panelPreviewAddDis:setVisible(true)
			self.panelLimit:setVisible(true)
			self.panelLimit:setText(string.format(Lang.get(102595), self.nextLevelData.unlock_cycle))
			self.panelCost:setVisible(false)
		else
			self.panelLimit:setVisible(false)
			self.panelCost:setVisible(true)
			self.textCostNum:setText(self.nextLevelData.need_point - curPoint)

			if self.havePoint >= self.nextLevelData.need_point - curPoint then
				self.nextAddEnable = true

				self.panelPreviewAddNml:setVisible(true)
				self.panelPreviewAddDis:setVisible(false)
				self.textCostNum:setFontColor(ResColor.SNEAKBATTLE02)
				self.textCostTitle:setFontColor(ResColor.SNEAKBATTLE02)
			else
				self.panelPreviewAddNml:setVisible(false)
				self.panelPreviewAddDis:setVisible(true)
				self.textCostNum:setFontColor(ResColor.RED)
				self.textCostTitle:setFontColor(ResColor.RED)
			end
		end
	else
		self.panelNextLevel:setVisible(false)
		self.panelPreviewAddNml:setVisible(false)
		self.panelPreviewAddDis:setVisible(true)
		self.panelMax:setVisible(true)
		self.panelLimit:setVisible(false)
		self.panelCost:setVisible(false)
	end
end

function NewMazeTalentMainDlg:onRefreshTalentPoint()
	self.hasChanged = false

	local costPoint = 0

	for index, grid in ipairs(self.talentGrids) do
		local groupData = grid.groupData
		local level = grid.level + grid.previewLevel

		if grid.previewLevel > 0 then
			self.hasChanged = true
		end

		if groupData[level] then
			costPoint = costPoint + groupData[level].need_point
		end
	end

	self.havePoint = self.maxPoint - costPoint

	self.numPoint:setText(self.havePoint .. "/" .. self.maxPoint)

	if self.hasChanged then
		self.panelConfirmNml:setVisible(true)
		self.panelConfirmDis:setVisible(false)
	else
		self.panelConfirmNml:setVisible(false)
		self.panelConfirmDis:setVisible(true)
	end
end

function NewMazeTalentMainDlg:onPreviewDownClick()
	if not self.selectGroupCell then
		return
	end

	if self.selectGroupCell.previewLevel > 0 then
		self.selectGroupCell:setLevel(self.selectGroupCell.level, self.selectGroupCell.previewLevel - 1)
		self:onRefreshTalentPoint()
		self:refreshDetailInfo()

		for index, grid in ipairs(self.talentGrids) do
			grid:refreshUpEnable()
		end
	else
		MsgManager.notice(Lang.get(102267))
	end
end

function NewMazeTalentMainDlg:onPreviewAddClick()
	if not self.selectGroupCell then
		return
	end

	if self.nextLevelData then
		if self.nextLevelData.unlock_cycle and self.nextLevelData.unlock_cycle > self.curCycle then
			MsgManager.notice(Lang.get(79936) .. self.nextLevelData.unlock_cycle .. Lang.get(30602))
		elseif self.nextAddEnable then
			self.selectGroupCell:setLevel(self.selectGroupCell.level, self.selectGroupCell.previewLevel + 1)
			self:onRefreshTalentPoint()
			self:refreshDetailInfo()

			for index, grid in ipairs(self.talentGrids) do
				grid:refreshUpEnable()
			end
		else
			MsgManager.notice(Lang.get(103609))
		end
	else
		MsgManager.notice(Lang.get(103610))
	end
end

function NewMazeTalentMainDlg:onConfimClick()
	if self.hasChanged then
		local talentData = {}

		for index, grid in ipairs(self.talentGrids) do
			local groupData = grid.groupData
			local level = grid.level + grid.previewLevel

			if level > 0 then
				table.insert(talentData, {
					group = grid.groupId,
					grade = level
				})
			end
		end

		RPC.newMazeTalentSet(self.actObj.opId, talentData)
	else
		MsgManager.notice(Lang.get(103611))
	end
end

function NewMazeTalentMainDlg:onTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(518)
end

function NewMazeTalentMainDlg:onResetAllClick()
	RPC.newMazeTalentSet(self.actObj.opId, {})
end

function NewMazeTalentMainDlg:onCloseClick()
	if self.hasChanged then
		UIManager.showConfirmWithId(1135, Slot(self.setVisible, self))
	elseif self.actData:checkTalentEnable() then
		UIManager.showConfirmWithId(1136, Slot(self.setVisible, self))
	else
		self:setVisible(false)
	end
end

function NewMazeTalentMainDlg:onPointTipsClick()
	BaseObject.ShowObjectTips(self.miscData.talnetpoint_item_id, 1, self)
end

function NewMazeTalentMainDlg:onNewMazeTalentSetResp()
	self:onRefreshGrid()
	self:onRefreshTalentPoint()
	self:refreshDetailInfo()
end

return NewMazeTalentMainDlg
