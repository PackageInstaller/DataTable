-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\NewYear\\ActivityNewYearSpeedUpDlg.lua

local ResTalkTitle = require("ClientData/ResTalkTitle")
local ActivityNewYearSpeedUpCell = Class("ActivityNewYearSpeedUpCell", UIControls.Child)

function ActivityNewYearSpeedUpCell:ctor()
	self.panelLock = UIControls.Panel(self, "LockPanel")
	self.textLock = UIControls.Label(self, "LockPanel/TxtLock")
	self.panelFree = UIControls.Panel(self, "FreePanel")
	self.panelFreeze = UIControls.Panel(self, "FrozenPanel")
	self.panelAward = UIControls.Panel(self, "AwardPanel")
	self.textCookingTime = UIControls.Label(self, "AwardPanel/TimeProgress/TxtTime")
	self.sliderCookingTime = UIControls.Slider(self, "AwardPanel/TimeProgress")
	self.imgFood = UIControls.Image(self, "AwardPanel/GirdFood")
	self.textFood = UIControls.Label(self, "AwardPanel/TxtAwardTitle")
	self.btnSpeedUp = UIControls.Button(self, "AwardPanel/BtnSpeedUp")

	self.btnSpeedUp:addEventClick(self.onSpeedUpClick)

	self.imgSpeedUp = UIControls.Image(self, "AwardPanel/BtnSpeedUp/Icon")
	self.bonusGrid = {}
end

function ActivityNewYearSpeedUpCell:setData(pos, unlocked, posInfo, iconPath, hasNum)
	self.pos = pos
	self.posInfo = posInfo

	if iconPath then
		self.imgSpeedUp:setImage(iconPath[1], iconPath[2])
	end

	if not unlocked then
		self.panelLock:setVisible(true)
		self.textLock:setText(posInfo.unlock_desc or "")
		self.panelFree:setVisible(false)
		self.panelFreeze:setVisible(false)
		self.panelAward:setVisible(false)
	else
		self.panelLock:setVisible(false)

		local nowFood = posInfo[1]

		if nowFood then
			ClientUtils.CreateBonusGrid(self, self.bonusGrid, "AwardPanel/AwardList", nowFood.resData.reward_id, nil, nil, true)
			self.textFood:setText(nowFood.resData.name or "")
			self.panelFree:setVisible(false)
			self.panelFreeze:setVisible(false)
			self.panelAward:setVisible(true)

			if nowFood.resData.icon_path and nowFood.resData.icon then
				self.imgFood:setImage(nowFood.resData.icon_path, nowFood.resData.icon)
			end

			local costTime = nowFood.endTime - nowFood.startTime
			local startTime = nowFood.startTime
			local curPassed = ClientUtils.getServerTime() - startTime

			self.sliderCookingTime:setValue(curPassed / costTime)

			if curPassed < costTime then
				self.sliderCookingTime:setValue(1, costTime - curPassed)
				ClientTimerManager.AddSecondTickUI(self.textCookingTime, costTime - curPassed)
			end

			self.btnSpeedUp:setEnable(hasNum > 0)
		else
			if self.mParent.actData.actObject:inFreeze() then
				self.panelFreeze:setVisible(true)
				self.panelFree:setVisible(false)
			else
				self.panelFreeze:setVisible(false)
				self.panelFree:setVisible(true)
			end

			self.panelAward:setVisible(false)
		end
	end
end

function ActivityNewYearSpeedUpCell:onSpeedUpClick()
	local nowFood = self.posInfo[1]
	local needTime = nowFood.endTime - ClientUtils.getServerTime()

	if needTime < self.mParent.miscData.speed_up_time then
		UIManager.showConfirmWithId(self.mParent.miscData.speed_up_confirm_id or 1038, Slot(self._realRpcItem, self))
	else
		self:_realRpcItem()
	end
end

function ActivityNewYearSpeedUpCell:_realRpcItem()
	if self.mParent.actData.actObject:isValid() then
		if not self.mParent.inRpc then
			self.mParent.inRpc = true

			RPC.opActOnHookRoleSpeedUp(self.mParent.actData.actObject.opId, self.pos, self.mParent.needItemId)
		end
	else
		MsgManager.notice(Lang.get(1870))
	end
end

local strClassName = "ActivityNewYearSpeedUpDlg"
local ActivityNewYearSpeedUpDlg = Class(strClassName, UIControls.Window)

function ActivityNewYearSpeedUpDlg:ctor()
	self:initUI()
end

local MAX_POS_NUM = 6

function ActivityNewYearSpeedUpDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.posCells = {}
	self.btnItem = UIControls.Button(self, "BgPanel/BtnIcon")

	self.btnItem:addEventClick(self.onItemClick)

	self.textItem = UIControls.Label(self, "BgPanel/HavePanel/TextNum")
end

function ActivityNewYearSpeedUpDlg:onShow(actData)
	if self.inRpc then
		MsgManager.clientNotice(actData.miscData.success_notice)

		self.inRpc = nil
	end

	self.actData = actData
	self.miscData = actData.miscData
	self.needItemId = self.miscData.speed_up_item
	self.hasNum = ClientUtils.getMoney(self.needItemId)

	local cellPath = "System/Activity/ActivityNewYearEve"
	local clientTemplate = actData.actObject.clientTemplateData

	if clientTemplate and clientTemplate.src_replace and clientTemplate.src_replace[1] then
		cellPath = "System/Activity/" .. clientTemplate.src_replace[1]
	end

	if #self.posCells == 0 then
		for index = 1, MAX_POS_NUM do
			local newCell = ActivityNewYearSpeedUpCell(self, "BgPanel/EveSpeedUpPanel/Content", cellPath .. "/EveSpeedUpCell")

			newCell:setVisible(true)
			table.insert(self.posCells, newCell)
		end
	end

	local iconPath = ClientUtils.getMoneyIcon(self.needItemId)

	for pos, cell in ipairs(self.posCells) do
		local unlocked, posInfo = actData:getCookingData(pos)

		cell:setData(pos, unlocked, posInfo, iconPath, self.hasNum)
	end

	if iconPath then
		self.btnItem:setImage(iconPath[1], iconPath[2])
	end

	self.textItem:setText(self.hasNum)
end

function ActivityNewYearSpeedUpDlg:onItemClick()
	BaseObject.ShowObjectTips(self.needItemId, self.hasNum, self)
end

function ActivityNewYearSpeedUpDlg:onCloseClick()
	self:setVisible(false)
end

return ActivityNewYearSpeedUpDlg
