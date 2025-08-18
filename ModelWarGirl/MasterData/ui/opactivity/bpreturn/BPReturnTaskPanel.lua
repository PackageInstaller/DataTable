-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\BPReturn\\BPReturnTaskPanel.lua

local ResRandClient = require("ClientData/ResRandClient")
local BpGetCell = Class("BpReturnGetCell", UIControls.ScrollViewLoopCell)
local BG_ImageData = {
	filePath = "Atlas/ReturnAtlas/ReturnBPAtlas2",
	spriteName = {
		"BgTaskBottomBlack",
		"BgTaskBottomYellow",
		"BgTaskBottomAsh"
	}
}

BpGetCell.ResSpecialTask = {
	[58] = "",
	[5] = "",
	[59] = "",
	[60] = ""
}
BpGetCell.ResSpecialTask_recharge = {
	[30] = ""
}

function BpGetCell:ctor()
	self.imgBg = UIControls.Image(self, "Bg")
	self.sliderSchedule = UIControls.Slider(self, "Bg/Slider")
	self.textProgress = UIControls.Label(self, "Bg/Slider/TextProgress")
	self.textRule = UIControls.Label(self, "Bg/TextRule")
	self.awardData = {}
	self.btnJump = UIControls.Button(self, "Bg/MultiPanel/BtnGo")

	self.btnJump:addEventClick(self.onJumpClick)
	self.btnJump:setVisible(false)

	self.btnConfirm = UIControls.Button(self, "Bg/MultiPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onConfirmClick)
	self.btnConfirm:setVisible(false)

	self.textState = UIControls.Label(self, "Bg/MultiPanel/TextState")

	self.textState:setText(Lang.get(74))

	self.textLimit = UIControls.Label(self, "Bg/MultiPanel/TextLimit")
	self.outAnim = UIControls.UIAni(self, "")
end

function BpGetCell:setCellData(data, desc, serverData)
	self.outAnim:startAni("FadeResetReturnBPGetCell")

	self.data = data
	self.desc = desc[self.data.type] or {}
	self.serverData = serverData[self.data.type] or {}

	if self.desc.max_round and self.desc.max_round > 1 then
		self.textLimit:setText(utils.format(Lang.get(30598), self.serverData.round or 0, self.desc.max_round))
		self.textLimit:setVisible(true)
	end

	local state = data.state

	self.imgBg:setImage(BG_ImageData.filePath, BG_ImageData.spriteName[state] or BG_ImageData.spriteName[3])

	if state == Const.ACT_ACHIEVE_STATE_GOT then
		self.sliderSchedule:setVisible(false)
		self.textState:setVisible(true)
		self.btnConfirm:setVisible(false)
		self.btnJump:setVisible(false)
	elseif state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.sliderSchedule:setVisible(true)
		self.btnConfirm:setVisible(true)
		self.textState:setVisible(false)
		self.btnJump:setVisible(false)
	elseif state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		self.sliderSchedule:setVisible(true)

		if self.desc and self.desc.jump_id then
			self.btnJump:setVisible(true)
		else
			self.btnJump:setVisible(false)
		end

		self.textState:setVisible(false)
		self.btnConfirm:setVisible(false)
	end

	if self.serverData.progress then
		if self.serverData.progress >= self.data.param then
			if self.ResSpecialTask[self.data.type] then
				self.textProgress:setText("1/1")
				self.sliderSchedule:setValue(1)
			elseif self.ResSpecialTask_recharge[self.data.type] then
				self.textProgress:setText(self.data.param / 100 .. "/" .. self.data.param / 100)
				self.sliderSchedule:setValue(1)
			else
				self.textProgress:setText(self.data.param .. "/" .. self.data.param)
				self.sliderSchedule:setValue(self.data.param / self.data.param)
			end
		elseif self.ResSpecialTask[self.data.type] then
			self.textProgress:setText("0/1")
			self.sliderSchedule:setValue(0)
		elseif self.ResSpecialTask_recharge[self.data.type] then
			self.textProgress:setText(self.serverData.progress / 100 .. "/" .. self.data.param / 100)
			self.sliderSchedule:setValue(self.serverData.progress / self.data.param)
		else
			self.textProgress:setText(self.serverData.progress .. "/" .. self.data.param)
			self.sliderSchedule:setValue(self.serverData.progress / self.data.param)
		end
	elseif self.ResSpecialTask[self.data.type] then
		self.textProgress:setText("0/1")
		self.sliderSchedule:setValue(0)
	elseif self.ResSpecialTask_recharge[self.data.type] then
		self.textProgress:setText("0/" .. self.data.param / 100)
		self.sliderSchedule:setValue(0)
	else
		self.textProgress:setText("0/" .. self.data.param)
		self.sliderSchedule:setValue(0)
	end

	self.textRule:setText(data.desc_name or "")

	for i, v in ipairs(self.awardData) do
		self.awardData[i]:setVisible(false)
	end

	local award = ResRandClient[self.data.award] or {}

	for i = 1, #award.show_ids do
		if not self.awardData[i] then
			self.awardData[i] = UIControls.getGridAwardContainer(self, "Bg/GridAward")
		end

		self.awardData[i]:setObj(BaseObject.GetObject(award.show_ids[i], award.show_nums[i]))

		self.awardData[i].grid.mDisableWays = true

		self.awardData[i]:setVisible(true)
		self.awardData[i]:setState(nil, state == Const.ACT_ACHIEVE_STATE_GOT, nil)

		self.awardData[i].itemId = award.show_ids[i]
		self.awardData[i].itemNum = award.show_nums[i]
	end
end

function BpGetCell:onJumpClick()
	if self.desc and self.desc.jump_id then
		JumpGuideManager.jump(self.desc.jump_id)
	end
end

function BpGetCell:onConfirmClick()
	if self.data.param > 1 then
		self.outAnim:startAni("ChangeReturnBPGetCell")
	else
		self.outAnim:startAni("FadeReturnBPGetCell")
	end

	self:getAward()
	self.btnConfirm:setVisible(false)
	self.mParent:cacheAwardTimes(self.awardData[1].itemId, self.awardData[1].itemNum)
end

function BpGetCell:getAward()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.mParent.opId, self.data.index, self.data.type), self.mParent.opId)
end

local BPReturnTaskPanel = Class("BPReturnTaskPanel", UIControls.Panel)

function BPReturnTaskPanel:ctor()
	self.scrollBPGetItems = UIControls.ScrollViewLoopV(self, self.mPath .. "/BPGetList", 0, self.onBPGetCellChanged)
	self.txtDes = UIControls.Label(self, self.mPath .. "/TipsPanel/TextDes")
	self.panelLvInfo = UIControls.Panel(self, self.mPath .. "/TipsPanel/LvInfo")
	self.txtLevel = UIControls.Label(self, self.mPath .. "/TipsPanel/LvInfo/TextLv")
	self.aniUpgrade = UIControls.UIAni(self, self.mPath .. "/TipsPanel/LvInfo/TextLv")
	self.txtPoint = UIControls.Label(self, self.mPath .. "/TipsPanel/LvInfo/BPPoint/TextBPPoint")
	self.txtPoint1 = UIControls.Label(self, self.mPath .. "/TipsPanel/LvInfo/BPPoint/TextBPPoint1")
	self.slider = UIControls.Slider(self, self.mPath .. "/TipsPanel/LvInfo/Slider")
	self.panelLvFullInfo = UIControls.Panel(self, self.mPath .. "/TipsPanel/LvFullInfo")

	self.panelLvFullInfo:setVisible(false)

	self.txtFullPoint = UIControls.Label(self, self.mPath .. "/TipsPanel/LvFullInfo/BPFullPoint/TextBPPoint")
	self.clientData = {}
end

function BPReturnTaskPanel:refreshTaskUI()
	local round, curLv, nextLv, overScore = self.mParent:modf()

	self.lv = round

	if curLv == -1 and nextLv == -1 then
		self.isFull = true

		self.panelLvInfo:setVisible(false)
	else
		self.isFull = false

		self.panelLvInfo:setVisible(true)

		if not self.isNewData then
			if Const.REVIEW_VERSION then
				self.txtLevel:setText(utils.format(Lang.get(111360), round))
			else
				self.txtLevel:setText(utils.format("Lv.%1s", round))
			end

			self.txtPoint:setText(curLv)
			self.txtPoint1:setText("/" .. nextLv)
			self.slider:setValue(curLv / nextLv)

			self.isNewData = nil
		end

		self.curLv = curLv
		self.nextLv = nextLv
	end

	if self.isFull then
		if overScore then
			self.txtDes:setText(Lang.get(51406))
		else
			self.txtDes:setText(Lang.get(51407))
		end
	else
		local freezeTime = tonumber(self.mParent:getFreezeTime())

		if freezeTime > 7 then
			self.txtDes:setText(Lang.get(51408))
		elseif freezeTime <= 7 then
			self.txtDes:setText(Lang.get(51409))
		end
	end
end

function BPReturnTaskPanel:onSubTabClick(isNewData, data)
	self.isNewData = isNewData
	self.data = data

	self:setData(data)
	self:refreshTaskUI()
end

function BPReturnTaskPanel:setData(data)
	self.fakeSliderValue = nil

	if not data.actData then
		self.scrollBPGetItems:setTotalCount(0)

		return
	end

	self.opId = data.opId
	self.actData = data.actData
	self.clientData = self.actData:getActivityClientShowData()
	self.serverData = data.actData.serverData or {}
	self.clientData = self:sortCell(self.clientData)
	self.desc = data.actData:getDesc()

	self.scrollBPGetItems:setTotalCount(#self.clientData)
end

function BPReturnTaskPanel:sortCell(data)
	local tab = {}

	for _, clientCell in ipairs(data) do
		local state = self.actData:getAchieveState(clientCell.type, clientCell.index)

		clientCell.state = state

		if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
			table.insert(tab, clientCell)
		end
	end

	for _, clientCell in ipairs(data) do
		if clientCell.state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			table.insert(tab, clientCell)
		end
	end

	for _, clientCell in ipairs(data) do
		if clientCell.state == Const.ACT_ACHIEVE_STATE_GOT then
			table.insert(tab, clientCell)
		end
	end

	return tab
end

function BPReturnTaskPanel:onBPGetCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BpGetCell(sender, "System/Return/ActivityReturnBPGetCell", newIdx, 0, 0)
	else
		targetCell.mIndex = newIdx
	end

	targetCell:setCellData(self.clientData[newIdx], self.desc, self.serverData)
end

function BPReturnTaskPanel:fakeSliderUpdate(fakeDataLast)
	if fakeDataLast.lv < self.lv then
		local scale = 0.5
		local upgradeTimes = self.lv - fakeDataLast.lv

		self.coSlider = coroutine.start(function()
			for i = 1, upgradeTimes do
				self.txtPoint:jumpTo(fakeDataLast.curLv, fakeDataLast.nextLv, scale / upgradeTimes)
				self.slider:setValue(1, scale / upgradeTimes)
				coroutine.wait(scale / upgradeTimes)

				fakeDataLast.lv = fakeDataLast.lv + 1
				fakeDataLast.curLv = self.curLv

				self.aniUpgrade:startAni("ReturnBPTextLvUp")

				if Const.REVIEW_VERSION then
					self.txtLevel:setText(utils.format(Lang.get(111360), fakeDataLast.lv))
				else
					self.txtLevel:setText(utils.format("Lv.%1s", fakeDataLast.lv))
				end

				self.slider:setValue(0)
				self.txtPoint:jumpTo(0, self.curLv, scale / upgradeTimes)
				self.slider:setValue(self.curLv / self.nextLv, scale / upgradeTimes)

				if upgradeTimes > 2 then
					coroutine.wait(scale / upgradeTimes)
				end
			end
		end)
	else
		self.txtPoint:jumpTo(fakeDataLast.curLv, self.curLv, 0.2)
		self.slider:setValue(self.curLv / self.nextLv, 0.2)
	end
end

function BPReturnTaskPanel:tryUpdateSlider()
	self:fakeSliderUpdate(self.fakeDataLast)

	self.awardItemId = nil
	self.awardItemNum = nil
	self.fakeDataLast = nil
end

function BPReturnTaskPanel:onClose()
	if self.coSlider then
		coroutine.stop(self.coSlider)

		self.coSlider = nil
	end
end

function BPReturnTaskPanel:onGetActivityBonus()
	if not self.isFull then
		local bonusUI = UIManager.getUI("commonBonusDlg")

		if bonusUI and self.awardItemId then
			bonusUI:setSpecialCustomizeFlyConfig(self.awardItemId, self.txtPoint)
			bonusUI:setFlyEndCB(Slot(self.tryUpdateSlider, self))
		end
	end
end

function BPReturnTaskPanel:cacheAwardTimes(itemId, itemNum)
	self.awardItemId = itemId
	self.awardItemNum = itemNum
	self.fakeDataLast = {
		curLv = self.curLv,
		nextLv = self.nextLv,
		lv = self.lv
	}

	self.mParent:cacheAwardTimes()
end

return BPReturnTaskPanel
