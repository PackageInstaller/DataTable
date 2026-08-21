-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\EquipRecycle\\ActivityEquipRecyclePanel.lua

local ResClientNotice = require("ClientData/ResClientNotice")
local GridEquipRecycleEquipAddCell = Class("GridEquipRecycleEquipAddCell", UIControls.Child)

function GridEquipRecycleEquipAddCell:ctor(...)
	self:initUI()
end

function GridEquipRecycleEquipAddCell:initUI(...)
	self.btnAdd = UIControls.Button(self, "BtnAdd")

	self.btnAdd:addEventClick(self.onBtnAddClick)

	self.txtNum = UIControls.Label(self, "BtnAdd/TxtNum")
	self.gridEquip = UIControls.EquipGridChild(self, "GridEquipItem", "System/Common/Grid/GridEquipItem", 0, 0, true)
	self.btnEdit = UIControls.Button(self, "BtnEdit")

	self.btnEdit:addEventClick(self.onBtnEditClick)
end

function GridEquipRecycleEquipAddCell:setData(data)
	self.txtNum:setText(self.index)

	if self.index == 1 then
		if self.mParent.data and self.mParent.data.startTime and self.mParent.data.startTime ~= 0 then
			self:playStateAnimator("Cell1Recycle")
		else
			self:playStateAnimator("Container1First")
		end
	else
		self:playStateAnimator("Container1")
	end

	self.data = data

	if self.data then
		self.gridEquip:setVisible(true)
		self.btnAdd:setVisible(false)
		self.gridEquip:setObj(self.data)

		if self.index ~= 1 then
			self.btnEdit:setVisible(true)
		end
	else
		self.gridEquip:setVisible(false)
		self.btnAdd:setVisible(true)
		self.btnEdit:setVisible(false)
	end
end

function GridEquipRecycleEquipAddCell:onBtnEditClick()
	local ui = UIManager.getUI("activityEquipRecycleEditDlg", true)

	if ui then
		if self.mParent.data.isRent then
			ui:setListIndex(2)
		else
			ui:setListIndex(1)
		end

		ui:setData(self.mParent.actData)
	end
end

function GridEquipRecycleEquipAddCell:onBtnAddClick()
	local ui = UIManager.getUI("activityEquipRecycleEditDlg", true)

	if ui then
		if self.mParent.data.isRent then
			ui:setListIndex(2)
		else
			ui:setListIndex(1)
		end

		ui:setData(self.mParent.actData)
	end
end

local ActivityEquipRecyclePanel = Class("ActivityEquipRecyclePanel", UIControls.Child)

function ActivityEquipRecyclePanel:ctor(...)
	self:initUI()
end

function ActivityEquipRecyclePanel:initUI(...)
	self.ani = UIControls.UIAni(self, "")
	self.rewardPanel = UIControls.Panel(self, "RewardPanel")
	self.btnAwardDis = UIControls.Button(self, "RewardPanel/BtnDis")

	self.btnAwardDis:addEventClick(self.onBtnAwardDisClick)

	self.btnEdit = UIControls.Button(self, "ChoiceListPanel/FuncPanel/BtnEdit")

	self.btnEdit:addEventClick(self.onBtnEditClick)

	self.btnGet = UIControls.Button(self, "RewardPanel/BtnGet")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.iconNewGetAward = UIControls.RedDot(self, "RewardPanel/BtnGet/BgGet/IconNew")
	self.imgRecycling = UIControls.UIAni(self, "ChoiceListPanel/FirstPanel/ImgRecycling")
	self.btnStop = UIControls.Button(self, "ChoiceListPanel/FuncPanel/BtnStop")

	self.btnStop:addEventClick(self.onBtnStopClick)

	self.txtImmediately = UIControls.Label(self, "ChoiceListPanel/FirstPanel/TextImmediately")
	self.panelFirstTime = UIControls.Panel(self, "ChoiceListPanel/FirstPanel/TextTime")
	self.txtFirstTime = UIControls.Label(self, "ChoiceListPanel/FirstPanel/TextTime/Time")
	self.panelTotalTime = UIControls.Panel(self, "ChoiceListPanel/TextTime")
	self.txtTotalTime = UIControls.Label(self, "ChoiceListPanel/TextTime/Time")
	self.txtUnlockItemNum = UIControls.Label(self, "LockPanel/BtnUnlock/TextNum")
	self.iconUnlockItem = UIControls.Image(self, "LockPanel/BtnUnlock/Icon")
	self.txtOpRemainTime = UIControls.Label(self, "LockPanel/TextTipsPanel/TextTips2")
	self.txtNotStart = UIControls.Label(self, "ChoiceListPanel/TextNotStart")
	self.equipFirstItem = UIControls.Panel(self, "ChoiceListPanel/FirstPanel/EquipFirstItem")
	self.itemCells = {}
	self.lockPanel = UIControls.Panel(self, "LockPanel")
	self.btnUnlock = UIControls.Button(self, "LockPanel/BtnUnlock")

	self.btnUnlock:addEventClick(self.onBtnUnlockClick)

	self.bgChoiceListPanel = UIControls.Image(self, "ChoiceListPanel/Bg")
	self.imageChoiceListPanel = UIControls.Image(self, "ChoiceListPanel/BgFirst/Image")
	self.firstPanel = UIControls.Panel(self, "ChoiceListPanel/FirstPanel")
	self.rewardPanel = UIControls.Panel(self, "RewardPanel")
end

function ActivityEquipRecyclePanel:setListIndex(index)
	self.listIndex = index
end

function ActivityEquipRecyclePanel:setData(actData)
	ClientTimerManager.RemoveSecondTickUI(self.txtFirstTime)
	ClientTimerManager.RemoveSecondTickUI(self.txtTotalTime)
	ClientTimerManager.RemoveSecondTickUI(self.txtOpRemainTime)
	self.iconNewGetAward:clearHint()

	self.actData = actData or self.actData

	if self.actData then
		self.listIndex = self.listIndex or 1

		if self.listIndex == 1 then
			self.data = self.actData.mainWorkShopData

			self.iconNewGetAward:addHint({
				UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_NORMAL
			})
		else
			self.data = self.actData.rentWorkShopData

			self.iconNewGetAward:addHint({
				UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_RENT
			})
		end

		if self.data then
			if #self.itemCells == 0 then
				for i = 1, 6 do
					local newCell

					if i == 1 then
						newCell = GridEquipRecycleEquipAddCell(self, "ChoiceListPanel/FirstPanel/EquipFirstItem", "System/Activity/ActivityEquipRecycle/GridEquipRecycleContainer1")
					else
						newCell = GridEquipRecycleEquipAddCell(self, "ChoiceListPanel/EquipList/Content", "System/Activity/ActivityEquipRecycle/GridEquipRecycleContainer1")
					end

					newCell.index = i

					newCell:setVisible(true)
					table.insert(self.itemCells, newCell)
				end
			end

			local firstRemainTime = 0
			local totalRemainTime = 0
			local opRemainTime = self.actData.actObject:getRemainOpenTime()

			if self.data.isRent then
				ClientTimerManager.AddSecondFormatTickUI(self.txtOpRemainTime, opRemainTime)

				firstRemainTime, totalRemainTime = self.actData:getRentListRemainTime()

				self.lockPanel:setVisible(not self.data.unLock)

				if not self.data.unLock then
					self.bgChoiceListPanel:setVisible(false)
					self.imageChoiceListPanel:setVisible(false)
					self.firstPanel:setVisible(false)
					self.rewardPanel:setVisible(false)
				else
					self.bgChoiceListPanel:setVisible(true)
					self.imageChoiceListPanel:setVisible(true)
					self.firstPanel:setVisible(true)
					self.rewardPanel:setVisible(true)
				end

				self.txtImmediately:setVisible(self.data.unLock and not self.data.finishAtOnce and self.data.startTime == 0)

				local unlockedItemId, unLockedItemNum = self.actData:getUnlockItemResData()

				if unlockedItemId and unlockedItemId ~= 0 then
					local item = BaseObject.GetObject(unlockedItemId)

					if item.resData then
						self.iconUnlockItem:setImage(UIConst.ITEM_ICON_PATH .. item.resData.sourceIconPath, item.resData.sourceIcon)
					end

					self.txtUnlockItemNum:setText(unLockedItemNum)
				end
			else
				firstRemainTime, totalRemainTime = self.actData:getNormarListRemainTime()

				self.lockPanel:setVisible(false)
				self.bgChoiceListPanel:setVisible(true)
				self.imageChoiceListPanel:setVisible(true)
				self.firstPanel:setVisible(true)
				self.rewardPanel:setVisible(true)
				self.txtImmediately:setVisible(false)
			end

			if self.data.equipList and #self.data.equipList ~= 0 then
				if self.data.startTime and self.data.startTime ~= 0 then
					self.imgRecycling:stopAni("StopRecycling")
					self.imgRecycling:startAniLoop("LoopRecycling")
					self.txtFirstTime:setVisible(true)
					self.txtTotalTime:setVisible(true)
					ClientTimerManager.AddSecondFormatTickUI(self.txtFirstTime, firstRemainTime)
					ClientTimerManager.AddSecondFormatTickUI(self.txtTotalTime, totalRemainTime)
					self.panelFirstTime:setVisible(true)
					self.panelTotalTime:setVisible(true)
					self.txtNotStart:setVisible(false)
					self.btnStop:setVisible(true)
					self.btnEdit:setVisible(false)
				else
					self.imgRecycling:stopAni("LoopRecycling")
					self.imgRecycling:startAniLoop("StopRecycling")
					self.panelFirstTime:setVisible(false)
					self.panelTotalTime:setVisible(false)
					self.txtNotStart:setVisible(true)
					self.btnStop:setVisible(false)
					self.btnEdit:setVisible(true)
				end

				for i = 1, 6 do
					self.itemCells[i]:setData(self.data.equipList[i])
				end
			else
				self.txtFirstTime:setVisible(false)
				self.txtTotalTime:setVisible(false)

				for i = 1, 6 do
					self.itemCells[i]:setData()
				end

				self.imgRecycling:stopAni("LoopRecycling")
				self.imgRecycling:startAniLoop("StopRecycling")
				self.btnStop:setVisible(false)
				self.btnEdit:setVisible(true)
				self.panelFirstTime:setVisible(false)
				self.panelTotalTime:setVisible(false)
				self.txtNotStart:setVisible(true)
			end

			if self.data.finishList and #self.data.finishList ~= 0 then
				self.rewardPanel:playStateAnimator("RewardBtnGet")
			else
				self.rewardPanel:playStateAnimator("RewardBtnDis")
			end
		end
	end
end

function ActivityEquipRecyclePanel:onUnlockTime(...)
	self.ani:startAni("EquipRecyclePanelUnlock", true)
end

function ActivityEquipRecyclePanel:onChangeData(actData)
	self.ani:addEventAnimateCue(Functor(self.setData, self, actData))
	self.ani:startAni("EquipRecyclePanelChange", true)
end

function ActivityEquipRecyclePanel:onBtnAwardDisClick()
	MsgManager.notice(Lang.get(101574))
end

function ActivityEquipRecyclePanel:onBtnEditClick()
	if self.actData and self.data then
		if self.data.equipList and #self.data.equipList ~= 0 then
			if self.data.startTime == 0 then
				RPC.opActEquipRecycleStart(self.actData.actObject.opId, self.listIndex)
			end
		else
			MsgManager.notice(Lang.get(101575))
		end
	end
end

function ActivityEquipRecyclePanel:onBtnStopClick()
	if self.actData then
		local function funY(self)
			RPC.opActEquipRecycleStop(self.actData.actObject.opId, self.listIndex, 1)
		end

		UIManager.showConfirmWithId(1132, Slot(funY, self), nil)
	end
end

function ActivityEquipRecyclePanel:onBtnUnlockClick()
	if self.actData then
		local unlockedItemId, unLockedItemNum = self.actData:getUnlockItemResData()
		local have = CurAvatar:getItemNumById(unlockedItemId)

		if unLockedItemNum <= have then
			local function funY(self)
				RPC.opActEquipRecycleUnlockWorkShop(self.actData.actObject.opId)
			end

			UIManager.showConfirmWithId(1133, Slot(funY, self), nil)
		else
			MsgManager.notice(ResClientNotice[777].notice)
		end
	end
end

function ActivityEquipRecyclePanel:onBtnGetClick()
	local ui = UIManager.getUI("activityEquipRecycleRewardDlg", true)

	if ui then
		ui:setListIndex(self.listIndex)
		ui:setData(self.actData)
	end
end

return ActivityEquipRecyclePanel
