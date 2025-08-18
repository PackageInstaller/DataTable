-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\MainBattleSkipDlg.lua

local MainBattleSkipDlg = Class("MainBattleSkipDlg", UIControls.Window)

function MainBattleSkipDlg:ctor(...)
	self:initUI()
end

function MainBattleSkipDlg:initUI(...)
	self.fightText = UIControls.Label(self, "BgPanel/FightText")
	self.levelNum = UIControls.Label(self, "BgPanel/LevelNum")
	self.timeLineNode = UIControls.Panel(self, "BgPanel/TimeLineNode")
	self.imgOver = UIControls.Image(self, "BgPanel/TimeLineNode/ImgOver")
	self.timeLineNode = UIControls.Panel(self, "BgPanel/TimeLineNode")
	self.panelTiaoguan = UIControls.Panel(self, "BgPanel/TimeLineNode/tiaoguan")
	self.back = UIControls.Panel(self, "BgPanel/TimeLineNode/tiaoguan/back")
	self.awardCells = {}
	self.panelAni = UIControls.UIAni(self, "BgPanel")
	self.efx = UIControls.LazyEffectPlayer(self, "BgPanel/TimeLineNode/Efx")

	self:onShow()
end

function MainBattleSkipDlg:onShow()
	self.showData = CurAvatar:getSkipStageData()

	if self.showData and #self.showData ~= 0 then
		if self.timerInit then
			self.timerInit:Stop()

			self.timerInit = nil
		end

		self:setShow()

		self.timerInit = Timer.New(Slot(self.setShow, self), 5, #self.showData)

		self.timerInit:Start()

		local maxStageData = self.showData[#self.showData]

		if maxStageData then
			RPC.stageSkip(maxStageData.season, maxStageData.chapter, maxStageData.level)
		end
	end
end

function MainBattleSkipDlg:setShow()
	if not self.showIdx then
		self.showIdx = 0
	else
		self.showIdx = self.showIdx + 1
	end

	if self.showIdx == 0 then
		self.levelNum:setVisible(false)
	elseif self.showData and self.showData[self.showIdx] then
		self.panelAni:startAni("ChangeLevel", true)
		self.levelNum:setText(utils.format("%1s-%2s", self.showData[self.showIdx].chapter, self.showData[self.showIdx].level))
		self.levelNum:setVisible(true)

		if self.showData[self.showIdx].showAward then
			local awardData = self.showData[self.showIdx].showAward

			for idx, id in ipairs(awardData.show_ids) do
				if not self.awardCells[idx] then
					self.awardCells[idx] = UIControls.getGridAwardContainer(self, "BgPanel/AwardItemList/Content")
				end

				local num = awardData.show_nums[idx] or 1
				local fakeItem = BaseObject.GetObject(id, num)

				self.awardCells[idx]:setVisible(true)
				self.awardCells[idx]:setObj(fakeItem)

				if self.awardCells[idx].grid then
					self.awardCells[idx].grid.mDisableWays = true
				end
			end

			local count = #awardData.show_ids + 1

			for i = count, #self.awardCells do
				self.awardCells[i]:setVisible(false)
			end
		end

		if self.showIdx == #self.showData then
			self:setEndShow()
		end
	end
end

function MainBattleSkipDlg:setEndShow(...)
	self.fightText:setText(Lang.get(103602))
	self.panelTiaoguan:setVisible(false)
	self.imgOver:setVisible(true)
	self.efx:setVisible(false)
end

function MainBattleSkipDlg:destroy()
	if self.timerInit then
		self.timerInit:Stop()

		self.timerInit = nil
	end

	MainBattleSkipDlg.super.destroy(self)
end

return MainBattleSkipDlg
