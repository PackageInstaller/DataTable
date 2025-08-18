-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SnowNightBP\\TaskContentInfoPanel.lua

local strClassName = "TaskContentInfoPanel"
local TaskContentInfoPanel = Class(strClassName, UIControls.Child)
local SnowOrNightBPTaskCell = require("UI/OpActivity/SnowNightBP/SnowOrNightBPTaskCell")
local ResOpActivityConditionLimit = require("ClientData/ResOpActivityConditionLimit")

function TaskContentInfoPanel:ctor()
	self:initUI()
end

function TaskContentInfoPanel:initUI()
	self.imgBg = UIControls.Image(self, "AwardPanel/Bg")
	self.textState = UIControls.Label(self, "AwardPanel/TextRule")
	self.textRule1 = UIControls.Label(self, "AwardPanel/BgTextRule/TextRule1")
	self.bgTextRule = UIControls.Image(self, "AwardPanel/BgTextRule")
	self.btnConfirm = UIControls.Button(self, "AwardPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.panelTaskCellList = {}
	self.taskCellList = {}

	for i = 1, 4 do
		local panelTaskCell = UIControls.Panel(self, "TaskContent/TaskCell" .. i)

		self.panelTaskCellList[i] = panelTaskCell
	end

	self.bounsGridCells = {}
end

function TaskContentInfoPanel:setTaskContentInfo(actData, groupId)
	self.actData = actData
	self.groupId = groupId
	self.resAchieveGroup = self.actData.clientAchieveGroup[self.groupId]

	if self.resAchieveGroup then
		self.isUnlock, self.lockDesc = CurAvatar:checkActivityConditionLimit(self.resAchieveGroup.condition_id)

		local achieveDataList = self.actData:getAchieveDataListByGroup(self.groupId)

		for idx, panelTaskCell in ipairs(self.panelTaskCellList) do
			if achieveDataList[idx] then
				panelTaskCell:setVisible(true)

				if not self.taskCellList[idx] then
					self.taskCellList[idx] = SnowOrNightBPTaskCell(self, "TaskContent/TaskCell" .. idx, self.mWindow.prefabFolderPath .. "/SnowOrNightBPTaskCell", 0, 0, true)
				end

				self.taskCellList[idx]:setAchieveData(achieveDataList[idx])
			else
				panelTaskCell:setVisible(false)
			end
		end

		if self.resAchieveGroup.condition_id and ResOpActivityConditionLimit[self.resAchieveGroup.condition_id] then
			self.bgTextRule:setVisible(not self.isUnlock)
			self.textRule1:setText(ResOpActivityConditionLimit[self.resAchieveGroup.condition_id].unlock_desc or Lang.get(52064))
		end

		local bgSpriteName = self.isUnlock and "BgArticlesGiftNml" or "BgArticlesGiftDis"

		self.imgBg:setImage(self.mWindow.atlasFolderPath .. "/SnowOrNightBPAtlas", bgSpriteName)

		local groupAwardAchieveData = self.actData:getGroupAwardAchieveData(self.groupId)
		local groupAwardAchieveState

		if groupAwardAchieveData then
			groupAwardAchieveState = self.actData:getAchieveState(groupAwardAchieveData.type, groupAwardAchieveData.index)
		end

		if not self.isUnlock then
			self.textState:setText(Lang.get(195))
			self.textState:setVisible(true)
			self.btnConfirm:setVisible(false)
		elseif not self.actData:isAllCompleteFromGroup(self.groupId) then
			self.textState:setText(Lang.get(99))
			self.textState:setVisible(true)
			self.btnConfirm:setVisible(false)
		else
			self.textState:setText(Lang.get(74))
			self.textState:setVisible(groupAwardAchieveState == Const.ACT_ACHIEVE_STATE_GOT)
			self.btnConfirm:setVisible(groupAwardAchieveState ~= Const.ACT_ACHIEVE_STATE_GOT)
		end

		if groupAwardAchieveData then
			ClientUtils.CreateBonusGrid(self, self.bounsGridCells, "AwardPanel/AwardItem", groupAwardAchieveData.award, true, nil, true)

			for _, gridAward in ipairs(self.bounsGridCells) do
				if self.isUnlock then
					gridAward:changeGetImg(self.mWindow.atlasFolderPath .. "/SnowOrNightBPAtlas", "BgCheck")
					gridAward:setState(false, groupAwardAchieveState == Const.ACT_ACHIEVE_STATE_GOT)
				else
					gridAward:changeGetImg(self.mWindow.atlasFolderPath .. "/SnowOrNightBPAtlas", "BgLock")
					gridAward:setState(false, true)
				end
			end
		end
	end
end

function TaskContentInfoPanel:onBtnConfirmClick()
	local groupAwardAchieveData = self.actData:getGroupAwardAchieveData(self.groupId)

	if groupAwardAchieveData then
		local groupAwardAchieveState = self.actData:getAchieveState(groupAwardAchieveData.type, groupAwardAchieveData.index)

		if self.actData:isAllCompleteFromGroup(self.groupId) and groupAwardAchieveState ~= Const.ACT_ACHIEVE_STATE_GOT then
			CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mWindow.actObj.opId, groupAwardAchieveData.index, groupAwardAchieveData.type), self.mWindow.actObj.opId)
		end
	end
end

return TaskContentInfoPanel
