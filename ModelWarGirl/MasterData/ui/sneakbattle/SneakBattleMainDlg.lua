-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleMainDlg.lua

local ResNewPveBuff = require("ClientData/ResNewPveBuff")
local ResNewPveIndex = require("ClientData/ResNewPveIndex")
local ResNewPveLevel = require("ClientData/ResNewPveLevel")
local ResNewPveStage = require("ClientData/ResNewPveStage")
local ResNewPveShow = require("ClientData/ResNewPveShow")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local SneakBattleTabCell = Class("SneakBattleStageTabCell", UIControls.Child)

function SneakBattleTabCell:ctor(...)
	self:initUI()
end

function SneakBattleTabCell:initUI(...)
	self.tabNml = UIControls.Button(self, "TabNml")

	self.tabNml:addEventClick(self.onTabNmlClick)

	self.tabDis = UIControls.Button(self, "TabDis")

	self.tabDis:addEventClick(self.onTabDisClick)

	self.txtName = UIControls.Label(self, "TabNml/Text")
	self.txtNum = UIControls.Label(self, "TabNml/TextNum")
	self.txtDisName = UIControls.Label(self, "TabDis/Text")
	self.txtDisNum = UIControls.Label(self, "TabDis/TextNum")
	self.iconNew = UIControls.Image(self, "TabNml/IconNew")
end

function SneakBattleTabCell:setData(data)
	if data then
		self.data = data
		self.level = data.level

		self.txtNum:setText(data.decorated_name)
		self.txtDisNum:setText(data.decorated_name)
		self.txtName:setText(data.level_name)
		self.txtDisName:setText(data.level_name)
	end
end

function SneakBattleTabCell:refreshState(data)
	self.state = data

	if data.unLock then
		self.tabNml:setVisible(true)
		self.tabDis:setVisible(false)
	else
		self.tabNml:setVisible(false)
		self.tabDis:setVisible(true)
	end
end

function SneakBattleTabCell:onTabNmlClick()
	if self.level then
		self.mParent:setSelectLevel(self.level)
	end
end

function SneakBattleTabCell:onTabDisClick()
	if ResNewPveShow and ResNewPveShow[13090001] then
		MsgManager.notice(ResNewPveShow[13090001].desc)
	end
end

local SneakBattleStageAwardCell = Class("SneakBattleStageAwardCell", UIControls.ScrollViewLoopCell)

function SneakBattleStageAwardCell:ctor(...)
	self:initUI()
end

function SneakBattleStageAwardCell:initUI(...)
	self.txtTitle = UIControls.Label(self, "ContentPanel/TextTitle")
	self.imgReceived = UIControls.Image(self, "ContentPanel/ImgReceived")
	self.awardPanel = UIControls.Panel(self, "ContentPanel/AwardPanel")
	self.itemCells = {}
end

function SneakBattleStageAwardCell:setData(resData, showIds, showNums, state)
	if resData then
		self.txtTitle:setText(resData.stage_name)
	end

	if showIds then
		if #showIds == 0 then
			self.imgReceived:setVisible(true)
			self.awardPanel:setVisible(false)
		else
			self.imgReceived:setVisible(false)
			self.awardPanel:setVisible(true)

			for index, id in ipairs(showIds) do
				if not self.itemCells[index] then
					self.itemCells[index] = UIControls.getGridAwardContainer(self, "ContentPanel/AwardPanel")
				end

				local fakeItem = BaseObject.GetObject(showIds[index], showNums[index])

				self.itemCells[index]:setVisible(true)
				self.itemCells[index]:setObj(fakeItem)
				self.itemCells[index]:setState(false, state)

				if self.itemCells[index].grid then
					self.itemCells[index].grid.mDisableWays = true
				end
			end

			local count = #showIds

			for index = count + 1, #self.itemCells do
				self.itemCells[index]:setVisible(false)
			end
		end
	end
end

local SneakBattleMainDlg = Class("SneakBattleMainDlg", UIControls.Window)

MixinClass(SneakBattleMainDlg, ActivityPanelMixin)

function SneakBattleMainDlg:initUI(...)
	self.bg = UIControls.RawImage(self, "Bg")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnRank = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnRank")

	self.btnRank:addEventClick(self.onBtnRankClick)

	self.btnAward = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnAward")

	self.btnAward:addEventClick(self.onBtnAwardClick)

	self.iconNewAward = UIControls.RedDot(self, "MainInfoPanel/FuncPanel/BtnAward/IconNew")
	self.btnNotice = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnNotice")

	self.btnNotice:addEventClick(self.onBtnNoticeClick)

	self.btnBattle = UIControls.Button(self, "MainInfoPanel/AwardInfoPanel/BtnBattle")

	self.btnBattle:addEventClick(self.onBtnBattleClick)

	self.imgName = UIControls.Image(self, "MainInfoPanel/BossInfoPanel/ImgName")
	self.iconBuff = UIControls.Image(self, "MainInfoPanel/BossInfoPanel/BattleBuffInfo/Icon")
	self.txtBuffTitle = UIControls.Label(self, "MainInfoPanel/BossInfoPanel/BattleBuffInfo/TextTitle")
	self.txtBuffDesc = UIControls.Label(self, "MainInfoPanel/BossInfoPanel/BattleBuffInfo/TextDesc")
	self.txtProgress = UIControls.Label(self, "MainInfoPanel/AwardInfoPanel/LevelInfoPanel/TextProgress")
	self.txtLimit = UIControls.Label(self, "MainInfoPanel/AwardInfoPanel/LevelInfoPanel/TextLimit")
	self.txtRemainTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.awardCells = {}
	self.levelCells = {}
	self.levelAwardList = UIControls.ScrollViewLoopV(self, "MainInfoPanel/AwardInfoPanel/LevelAwardList", 0, self.onAwardCellChanged)
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.boosPanels = {}

	for i = 1, 3 do
		local path = "BossPanel" .. i
		local newPanel = UIControls.Panel(self, path)

		newPanel.imgs = {}

		for ni = 1, 4 do
			newPanel.imgs[ni] = UIControls.Image(self, path .. "/Img" .. ni)
		end

		self.boosPanels[i] = newPanel
	end

	self.txtAwardTips = UIControls.Label(self, "MainInfoPanel/AwardInfoPanel/ImgTitle/TextTips")

	self:setData()
end

function SneakBattleMainDlg:setData(...)
	ClientTimerManager.RemoveSecondTickUI(self.txtRemainTime)

	self.actData = CurAvatar:getSneakBattleActivityData()

	if self.actData then
		self.actData:checkNewSelectLevel()
		self.iconNewAward:addHint({
			UIConst.RD_HINT_SNEAK_BATTLE_AWARD
		})

		local remainTime = self.actData:getCurLeftTime()
		local frozenTime = self.actData:getConfigFrozenTime()

		if remainTime and remainTime >= 0 then
			if frozenTime <= remainTime then
				remainTime = remainTime - frozenTime

				local function onTimeOut(...)
					ClientTimerManager.RemoveSecondTickUI(self.txtRemainTime)
					ClientTimerManager.AddSecondFormatTickUI(self.txtRemainTime, frozenTime, false, Lang.get(48695))
				end

				ClientTimerManager.AddSecondFormatTickUI(self.txtRemainTime, remainTime, false, Lang.get(48657), Slot(onTimeOut, self))
			else
				ClientTimerManager.AddSecondFormatTickUI(self.txtRemainTime, remainTime, false, Lang.get(48695))
			end
		else
			self.txtRemainTime:setText(Lang.get(30121))
		end

		self.type = self.actData.type or 1

		self.bg:setImage("NoAlpha/SneakBattle/BgBattlefield0" .. self.type)
		self.imgName:setImage("Atlas/SneakBattleAtlas/SneakBattleBossTitleAtlas", "TxtSneakBattleBoss" .. self.type)

		self.nowSelectLevel = self.nowSelectLevel or self.actData.nowSelectLevel

		if not self.nowSelectLevel or self.nowSelectLevel == 0 then
			self.nowSelectLevel = 1
		end

		local buffData = self.actData:getBuffResData()

		if buffData then
			self.txtBuffTitle:setText(buffData.name)
			self.txtBuffDesc:setText(buffData.desc)
			self.iconBuff:setImage(buffData.icon_path, buffData.icon_name)
		end

		local levelResData = ResNewPveLevel[self.type]

		if levelResData then
			for index, data in ipairs(levelResData) do
				if not self.levelCells[index] then
					local newCell = SneakBattleTabCell(self, "MainInfoPanel/AwardInfoPanel/TabList/Content", "System/SneakBattle/TabSneakBattle")

					newCell.index = index

					newCell:setVisible(true)
					newCell:setData(data)

					self.levelCells[index] = newCell
				end
			end

			local count = #levelResData

			for i = count + 1, #self.levelCells do
				self.levelCells[i]:setVisible(false)
			end
		end

		self:setSelectLevel(self.actData.nowSelectLevel)

		if self.actData:checkShowInherit() then
			local ui = UIManager.getUI("sneakBattleInheritDlg", true):setData()

			RPC.newPvePopUp(self.actData.actObject.opId)
		end

		self:refreshRedDot()
		self.btnAward:setVisible(self.actData:checkAccomplishAwardOpen())
		self.btnRank:setVisible(self.actData:checkRankOpen())
		self.btnNotice:setVisible(self.actData:checkNextWeekOpen())
	end
end

function SneakBattleMainDlg:refreshRedDot(...)
	if self.actData then
		self.actData:checkNew()
	end
end

function SneakBattleMainDlg:setSelectLevel(level)
	self.nowSelectLevel = level or self.nowSelectLevel

	self.txtAwardTips:setVisible(self.nowSelectLevel ~= 1)

	if self.levelCells then
		for index, cell in ipairs(self.levelCells) do
			cell.tabNml:setEnable(self.nowSelectLevel ~= cell.level)
		end
	end

	if self.actData then
		self.libData = self.actData:getStageResDataByLevel(self.nowSelectLevel)

		if self.libData then
			local index = self.actData:getMaxWeekAwardStage(self.nowSelectLevel)

			index = math.min(#self.libData - 5, math.max(1, index))

			self.levelAwardList:setTotalCount(#self.libData, index)

			local count = 0

			for _, data in ipairs(self.libData) do
				if data.need_limit and data.need_limit == 1 then
					count = count + 1
				end
			end

			self.txtLimit:setText(count)
		end

		local level = self.nowSelectLevel
		local stage = self.actData:getLevelMaxProgress(self.nowSelectLevel)

		if stage and stage ~= 0 then
			local levelName = self.actData:getLevelName(self.nowSelectLevel)
			local stageName = self.actData:getStageName(level, stage)

			self.txtProgress:setText(utils.format("%1s-%2s", levelName, stageName))
		else
			self.txtProgress:setText(Lang.get(96065))
		end

		for index, cell in ipairs(self.levelCells) do
			local state = self.actData:getLevelState(cell.level)

			cell:refreshState(state)
		end

		for i = 1, #self.boosPanels do
			self.boosPanels[i]:setVisible(self.type == i)

			if self.type == i then
				local imgs = self.boosPanels[i].imgs

				for index, img in ipairs(imgs) do
					img:setVisible(index < self.nowSelectLevel)
				end
			end
		end

		if self.nowSelectLevel == 2 and not self.inBeginner then
			local can = self.actData:checkCanEnterNewLevel(self.nowSelectLevel)

			if can then
				self.inBeginner = true

				BeginnerManager.CheckSneakBattleSecondLevel()
			end
		end
	end
end

function SneakBattleMainDlg:onAwardCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = SneakBattleStageAwardCell(sender, "System/SneakBattle/SneakBattleLevelAwardCell", newIdx, 0, 0)
		targetCell.index = newIdx
	end

	self.awardCells[targetCell.index] = nil
	self.awardCells[newIdx] = targetCell

	if self.libData and self.libData[newIdx] then
		targetCell:setData(self.libData[newIdx], self.actData:getLevelWeekAwardShow(self.nowSelectLevel, self.libData[newIdx].stage))
	end
end

function SneakBattleMainDlg:onBtnBattleClick()
	if self.actData then
		if self.actData:isInFrozenTime() == true then
			if ResNewPveShow and ResNewPveShow[13090008] then
				MsgManager.notice(ResNewPveShow[13090008].desc)
			end
		elseif self.nowSelectLevel == self.actData.nowSelectLevel then
			UIManager.getUI("sneakBattleLevelMainDlg", true):setData(self.actData)
		else
			local can, desc = self.actData:checkCanEnterNewLevel(self.nowSelectLevel)

			if can then
				RPC.newPveChooseLevel(self.actData.actObject.opId, self.nowSelectLevel)
			else
				MsgManager.notice(desc)
			end
		end
	end
end

function SneakBattleMainDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(473)
end

function SneakBattleMainDlg:onBtnAwardClick()
	UIManager.getUI("sneakBattleAwardDlg", true):setData(self.actData)
end

function SneakBattleMainDlg:onBtnRankClick()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_SNEAK_BATTLE)
end

function SneakBattleMainDlg:onBtnNoticeClick()
	if self.actData.modeIndex then
		UIManager.getUI("sneakBattleAnnounceDlg", true):setData(self.actData.modeIndex + 1)
	end
end

function SneakBattleMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

return SneakBattleMainDlg
