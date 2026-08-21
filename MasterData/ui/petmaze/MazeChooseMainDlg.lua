-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\MazeChooseMainDlg.lua

local MazeNode = Class("MazeChooseMainDlg_MazeNode", UIControls.Panel)

function MazeNode:ctor()
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(self.onClickBtn)

	self.imgBgPass = UIControls.Panel(self, self.mPath .. "/BgStatus/ImgPass")
	self.labelMazzTime = UIControls.Label(self, self.mPath .. "/BgStatus/TextTime")
	self.timeUpPanel = UIControls.Panel(self, self.mPath .. "/IconTimeUp")
	self.redDot = UIControls.RedDot(self, self.mPath .. "/IconNew")

	self.redDot:addHint({
		UIConst.RD_HINT_MAZE
	})

	self.slotUpdateMazzTime = Slot(self.refreshView, self)
end

function MazeNode:refreshView()
	self:updateMazzTime()
end

function MazeNode:updateMazzTime()
	self.imgBgPass:setVisible(false)
	self.labelMazzTime:setVisible(false)
	self.timeUpPanel:setVisible(false)
	ClientTimerManager.RemoveSecondTickUI(self.labelMazzTime)
	ClientTimerManager.stopGlobalTimer("mazeResetTip")

	if not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_MAZE) then
		local mazzTime, isShowPass = CurAvatar:getNextMazeRefreshSeconds()

		self.imgBgPass:setVisible(isShowPass)

		if mazzTime > 0 then
			if not isShowPass then
				local leftTipTime = mazzTime - 43200

				if leftTipTime > 0 then
					ClientTimerManager.startGlobalTimer("mazeResetTip", leftTipTime, Slot(self.slotUpdateMazzTime, self))
				else
					self.timeUpPanel:setVisible(true)
				end
			end

			self.labelMazzTime:setVisible(true)
			ClientTimerManager.AddSecondTickUI(self.labelMazzTime, mazzTime, nil, "", Lang.get(30556), Slot(self.slotUpdateMazzTime, self))
		end
	end
end

function MazeNode:onClickBtn()
	if CurAvatar.needResetMaze then
		UIManager.getUI("mazeChooseDlg", true):show()
	elseif CurAvatar:isThisMazeFinished() then
		UIManager.getUI("mazeChooseDlg", true):show(true)
	elseif CurAvatar.mazeData then
		GameFsm.translateState(Const.STATE_MAIN_MAZE)
	end
end

local PetMazeNode = Class("MazeChooseMainDlg_PetMazeNode", UIControls.Panel)

function PetMazeNode:ctor()
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(self.onClickBtn)

	self.timeUpPanel = UIControls.Panel(self, self.mPath .. "/IconTimeUp")
	self.imgBgPass = UIControls.Image(self, self.mPath .. "/BgStatus/ImgPass")
	self.labelMazzTime = UIControls.Label(self, self.mPath .. "/BgStatus/TextTime")
	self.redDot = UIControls.RedDot(self, self.mPath .. "/IconNew")

	self.redDot:addHint({
		UIConst.RD_HINT_PET_MAZE
	})

	self.slotUpdateMazzTime = Slot(self.refreshView, self)
end

function PetMazeNode:refreshView()
	self.timeUpPanel:setVisible(false)
	self.labelMazzTime:setVisible(false)
	self.imgBgPass:setVisible(false)
	ClientTimerManager.RemoveSecondTickUI(self.labelMazzTime)
	ClientTimerManager.stopGlobalTimer("petMazeResetTip")

	self.actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)

	if self.actObj then
		local isShowPass = self.actObj.actData:checkPass()
		local mazzTime = self.actObj.actData:getSeasonLeftTime()

		self.imgBgPass:setVisible(isShowPass)

		if mazzTime > 0 then
			if not isShowPass then
				local leftTipTime = mazzTime - 43200

				if leftTipTime > 0 then
					ClientTimerManager.startGlobalTimer("petMazeResetTip", leftTipTime, self.slotUpdateMazzTime)
				else
					self.timeUpPanel:setVisible(true)
				end
			end

			self.labelMazzTime:setVisible(true)
			ClientTimerManager.AddSecondFormatTickUI(self.labelMazzTime, mazzTime, false, Lang.get(30590), self.slotUpdateMazzTime)
		end
	end
end

function PetMazeNode:onClickBtn()
	CurAvatar:jumpToShowActivity(self.actObj.actId)
end

local MazeChooseMainDlg = Class("MazeChooseMainDlg", UIControls.Window)

function MazeChooseMainDlg:ctor()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.mazeNode = MazeNode(self, "MainInfoPanel/BtnMazz")
	self.petMazeNode = PetMazeNode(self, "MainInfoPanel/BtnMazzPet")
end

function MazeChooseMainDlg:onOpen()
	MazeChooseMainDlg.super.onOpen(self)
	self.mazeNode:refreshView()
	self.petMazeNode:refreshView()
end

function MazeChooseMainDlg:onClickBtnClose()
	self:setVisible(false)
end

return MazeChooseMainDlg
