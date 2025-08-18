-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityCollectWordsAchieveDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityAchieveDetail = require("ClientData/ResOpActivityAchieveDetail")
local ResItem = require("ClientData/ResItem")
local AchieveScoreAwardCell = Class("AchieveScoreAwardCell", UIControls.ScrollViewLoopCell)

function AchieveScoreAwardCell:ctor(...)
	self:initUI()
end

function AchieveScoreAwardCell:initUI(...)
	self.descTxt = UIControls.Label(self, "DesPanel/TextDes")
	self.icon = UIControls.Image(self, "DesPanel/Icon")
	self.processTxt = UIControls.Label(self, "TextNum")
	self.imgParaise = UIControls.Panel(self, "ImgParaise")
	self.imgSlider = UIControls.Panel(self, "ImgSlider")
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onSensorClick)
end

function AchieveScoreAwardCell:setData(achData)
	self.data = achData
	self.opId = self.mParent.actObj.opId

	local param = achData.param
	local award = achData.award
	local desc = achData.desc_name
	local highAward = achData.high_award

	self.needProcess = param

	self.descTxt:setText(desc or "")

	local iconPath = BaseObject.getItemIconPath(self.mParent.miscData.score_item_id or 510292)

	if iconPath then
		self.icon:setImage(iconPath[1], iconPath[2])
	end

	if highAward then
		self.imgParaise:setVisible(true)
	else
		self.imgParaise:setVisible(false)
	end

	self.processTxt:setVisible(true)

	for i, grid in pairs(self.awardGridList or {}) do
		grid:destroy()
	end

	self.awardGridList = {}

	for i, itemId in ipairs(ResRandClient[award].show_ids) do
		local itemNum = ResRandClient[award].show_nums[i]
		local show_flag = ResRandClient[award].show_flag or {}
		local fakeItem = BaseObject.GetObject(itemId, itemNum)
		local grid = UIControls.getGridAwardContainer(self, "GridAwardContainer")

		grid.mDisableWays = true

		grid:setObj(fakeItem)
		grid.imgGet:setImage("Atlas/HeroPoolAtlas/HeroPoolAtlas", "BgCompleted")
		grid:setVisible(true)

		if highAward then
			grid:setSpecEffect("Effects/UI/efx_ui_bingoGrid.prefab", "System/Common/Grid/GridEfxCell")
		end

		if fakeItem.subType == Const.ITEM_COLLECT_WORDS_PRIVILGEG then
			if show_flag[i] and show_flag[i] >= 1 then
				grid:setSpe(true, 3, show_flag[i])
			else
				grid:setSpe(false)
			end
		else
			grid:setSpe(false)
		end

		self.awardGridList[i] = grid
	end

	self:refreshState(achData.state, self.mParent.nowProcess)
end

function AchieveScoreAwardCell:refreshState(state, nowProcess)
	self.state = state

	self.processTxt:setText("")

	local stateName
	local isGot = false

	self.imgSlider:setVisible(false)

	if state == "Got" then
		stateName = "DisCellCollectWordsPointTask"
		isGot = true

		self.imgSlider:setVisible(true)
	elseif state == "CanGet" then
		stateName = "HighCellCollectWordsPointTask"

		self.imgSlider:setVisible(true)
	elseif state == "Focus" then
		stateName = "NmlCellCollectWordsPointTask"

		self.processTxt:setText(nowProcess .. "/" .. self.needProcess)
	elseif state == "Lock" then
		stateName = "NmlCellCollectWordsPointTask"
	end

	self:playStateAnimator(stateName)

	if isGot then
		for i, awardGrid in ipairs(self.awardGridList) do
			awardGrid:setObjGray(true)
		end

		self.icon:setImageGray(true)
	end
end

function AchieveScoreAwardCell:onSensorClick()
	if self.state == "CanGet" then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.data.index, self.data.type), self.opId)
	end
end

local ActivityCollectWordsAchieveDlg = Class("ActivityCollectWordsAchieveDlg", UIControls.Window)

MixinClass(ActivityCollectWordsAchieveDlg, ActivityPanelMixin)

function ActivityCollectWordsAchieveDlg:ctor(...)
	self.isCreateCell = false
end

function ActivityCollectWordsAchieveDlg:initUI()
	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellAtlas = "System/Activity/" .. self.replaceableCellPath[1] .. "/CellCollectWordsPointTask"
	else
		self.cellAtlas = "System/Activity/CollectWords/CellCollectWordsPointTask"
	end

	self.closeBtn = UIControls.Button(self, "BgPanel/BtnClose")

	self.closeBtn:addEventClick(self._onClickBlock)

	self.contentPanel = UIControls.ScrollViewLoopH(self, "BgPanel/AwardList")

	self.contentPanel:addEventCellChanged(self._onCellChanged)

	self.processSlider = UIControls.Slider(self, "BgPanel/AwardList/Viewport/Content/Slider")
	self.cellMountPath = "BgPanel/AwardList/Viewport/Content"
	self.specialPanel = UIControls.Panel(self, "BgPanel/SpecialAwardPanel")
	self.btnCellPointTask = UIControls.Button(self, "BgPanel/SpecialAwardPanel/CellPointTask")

	self.btnCellPointTask:addEventClick(self._onClickFocusAward)

	self.specialTxt = UIControls.Label(self, "BgPanel/SpecialAwardPanel/CellPointTask/DesPanel/TextDes")
	self.specialIcon = UIControls.Image(self, "BgPanel/SpecialAwardPanel/CellPointTask/DesPanel/Icon")
	self.btnAllGet = UIControls.Button(self, "BgPanel/BtnAllGet")

	self.btnAllGet:addEventClick(self._onClickAllGet)
end

function ActivityCollectWordsAchieveDlg:setParentActivity(parentActivity)
	self.parentActivity = parentActivity
	self.miscData = parentActivity.actData.miscData
end

function ActivityCollectWordsAchieveDlg:_setData()
	self.achieveData = {}

	local svrData

	for _, sData in pairs(self.actObj.actData.serverData) do
		svrData = sData
	end

	self.nowProcess = svrData and svrData.progress or 0

	local nowGot = svrData and svrData.got or {}

	for actType, cData in pairs(self.actObj.actData.clientData) do
		for _, data in ipairs(cData) do
			table.insert(self.achieveData, data)
		end
	end

	self.cells = {}

	local isFocusIdx, isCanGetIdx

	for i, data in ipairs(self.achieveData) do
		if self.nowProcess >= data.param then
			if nowGot[data.index] then
				data.state = "Got"
			else
				data.state = "CanGet"

				if not isCanGetIdx then
					isCanGetIdx = i
				end
			end
		elseif not isFocusIdx then
			data.state = "Focus"
			isFocusIdx = i
		else
			data.state = "Lock"
		end
	end

	isFocusIdx = isFocusIdx or #self.achieveData
	self.nowFocusIdx = isFocusIdx
	self.showIdx = isCanGetIdx and isCanGetIdx or isFocusIdx

	local idx = math.max(1, self.showIdx - 1)

	self.contentPanel:setTotalCount(#self.achieveData, idx)

	local iconPath = BaseObject.getItemIconPath(self.miscData.score_item_id or 510292)

	if iconPath then
		self.specialIcon:setImage(iconPath[1], iconPath[2])
	end

	if not isCanGetIdx then
		self.btnAllGet:setEnable(false)
	else
		self.btnAllGet:setEnable(true)
	end
end

function ActivityCollectWordsAchieveDlg:_onShow()
	return
end

function ActivityCollectWordsAchieveDlg:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = AchieveScoreAwardCell(sender, self.cellAtlas, newIdx, 0, 0)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	self.cells[newIdx]:setData(self.achieveData[newIdx])

	self.viewLastIdx = 1

	for i = newIdx, newIdx + 5 do
		if self.cells[i] and self.cells[i].mIndex > self.viewLastIdx then
			self.viewLastIdx = self.cells[i].mIndex
		end
	end

	if self.viewLastIdx == 8 then
		self.viewLastIdx = 7
	end

	self:_refreshFocusAwardPanel()
end

ActivityCollectWordsAchieveDlg.CELL_WIDTH = 150
ActivityCollectWordsAchieveDlg.CELL_SPACE = 30
ActivityCollectWordsAchieveDlg.CONTENT_WIDTH = 1070.1

function ActivityCollectWordsAchieveDlg:_focusCellByIndex(idx)
	idx = math.max(1, idx - 1)

	self.contentPanel:scrollToCell(idx, 3500)
end

function ActivityCollectWordsAchieveDlg:_refreshFocusAwardPanel()
	self.nextHighLight = nil

	if self.nowFocusIdx < #self.achieveData then
		for i = self.nowFocusIdx + 1, #self.achieveData do
			if self.achieveData[i].high_award and self.viewLastIdx and i > self.viewLastIdx - 2 then
				self.nextHighLight = i

				local award = self.achieveData[i].award

				if not self.specialAwardGridList then
					self.specialAwardGridList = {}
				end

				for i, itemId in ipairs(ResRandClient[award].show_ids) do
					local grid

					if self.specialAwardGridList[i] then
						grid = self.specialAwardGridList[i]
					else
						grid = UIControls.getGridAwardContainer(self, "BgPanel/SpecialAwardPanel/CellPointTask/GridAwardContainer")
					end

					local itemNum = ResRandClient[award].show_nums[i]
					local show_flag = ResRandClient[award].show_flag or {}
					local fakeItem = BaseObject.GetObject(itemId, itemNum)

					grid.mDisableWays = true

					grid:setObj(fakeItem)
					grid:setVisible(true)
					grid:setSpecEffect("Effects/UI/efx_ui_bingoGrid.prefab", "System/Task/GridEfxCellNoMask")

					if fakeItem.subType == Const.ITEM_COLLECT_WORDS_PRIVILGEG then
						if show_flag[i] and show_flag[i] >= 1 then
							grid:setSpe(true, 3, show_flag[i])
						else
							grid:setSpe(false)
						end
					else
						grid:setSpe(false)
					end

					self.specialAwardGridList[i] = grid
				end

				if #ResRandClient[award].show_ids + 1 <= #self.specialAwardGridList then
					for i = #ResRandClient[award].show_ids + 1, #self.specialAwardGridList do
						self.specialAwardGridList[i]:setVisible(false)
					end
				end

				self.specialTxt:setText(self.achieveData[i].desc_name or "")

				break
			end
		end
	end

	self.specialPanel:setVisible(self.nextHighLight ~= nil)
end

function ActivityCollectWordsAchieveDlg:updateActivityData(actObj)
	self:_setData()
end

function ActivityCollectWordsAchieveDlg:_onClickFocusAward(...)
	if self.nextHighLight then
		self:_focusCellByIndex(self.nextHighLight)
	end
end

function ActivityCollectWordsAchieveDlg:_onClickAllGet()
	self.btnAllGet:setEnable(true)

	for i, data in pairs(self.achieveData) do
		if data.state == "CanGet" then
			CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, data.index, data.type), self.actObj.opId)
		end
	end
end

function ActivityCollectWordsAchieveDlg:_onClickBlock(...)
	self:setVisible(false)
end

function ActivityCollectWordsAchieveDlg:onClose()
	local mainDlg = UIManager.tryGetUI("activityCollectWordsDlg")

	if mainDlg then
		mainDlg:checkRedNew()
	end

	ActivityCollectWordsAchieveDlg.super.onClose(self)
end

return ActivityCollectWordsAchieveDlg
