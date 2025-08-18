-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleLimitDlg.lua

local ResNewPveShow = require("ClientData/ResNewPveShow")
local SneakBattleLimitLibCell = Class("SneakBattleLimitLibCell", UIControls.ScrollViewLoopCell)

function SneakBattleLimitLibCell:ctor(...)
	self:initUI()
end

function SneakBattleLimitLibCell:initUI(...)
	self.bgSlc = UIControls.Image(self, "ContentPanel/BgSlc")
	self.imgIcon = UIControls.Image(self, "ContentPanel/ImgIcon")
	self.txtTitle = UIControls.Label(self, "ContentPanel/TextTitle")
	self.txtDesc = UIControls.Label(self, "ContentPanel/TextDesc")
	self.imgSlcTag = UIControls.Image(self, "ContentPanel/ImgSlcTag")
	self.txtTag = UIControls.Label(self, "ContentPanel/ImgSlcTag/TextTag")
	self.contentPanel = UIControls.Button(self, "ContentPanel")

	self.contentPanel:addEventClick(self.onContentPanelClick)
end

function SneakBattleLimitLibCell:setData(data)
	self.data = data

	self:refreshState()
end

function SneakBattleLimitLibCell:refreshState(...)
	if self.data then
		self.txtTitle:setText(self.data.name)
		self.txtDesc:setText(self.data.desc)
		self.imgIcon:setImage(self.data.icon_path, self.data.icon_name)

		if self.data.stage and self.data.stage ~= 0 then
			self.bgSlc:setVisible(true)
			self.imgSlcTag:setVisible(true)

			if self.data.stage then
				local txtShow = self.data.stage

				if self.data.stage < 10 then
					txtShow = utils.format("0%1s", self.data.stage)
				end

				self.txtTag:setText(txtShow)
			end
		else
			self.bgSlc:setVisible(false)
			self.imgSlcTag:setVisible(false)
		end
	end
end

function SneakBattleLimitLibCell:onContentPanelClick()
	if self.data and self._slotOnCellClick then
		self._slotOnCellClick(self)
	end
end

local SneakBattleLimitStageCell = Class("SneakBattleLimitStageCell", UIControls.Child)

function SneakBattleLimitStageCell:ctor(...)
	self:initUI()
end

function SneakBattleLimitStageCell:initUI(...)
	self.txtTitle = UIControls.Label(self, "ContentPanel/TextTitle")
	self.btnAdd = UIControls.Button(self, "ContentPanel/BtnAdd")

	self.btnAdd:addEventClick(self.onBtnAddClick)

	self.imgBtnAdd = UIControls.Image(self, "ContentPanel/ImgAdd")
	self.iconPanel = UIControls.Panel(self, "ContentPanel/IconPanel")
	self.imgIcon = UIControls.Image(self, "ContentPanel/IconPanel/ImgIcon")
	self.iconPanel = UIControls.Button(self, "ContentPanel/IconPanel")

	self.iconPanel:addEventClick(self.onIconPanelClick)

	self.imgSlc = UIControls.Image(self, "ContentPanel/ImgSlc")
	self.bgLocked = UIControls.Image(self, "ContentPanel/BgLocked")
end

function SneakBattleLimitStageCell:setData(data)
	self.data = data

	self:refreshState()
end

function SneakBattleLimitStageCell:refreshState(...)
	if self.data then
		self.txtTitle:setText(self.data.stage_name)

		if self.data.need_limit and self.data.need_limit == 1 then
			self.bgLocked:setVisible(false)
			self.btnAdd:setVisible(true)
			self.imgBtnAdd:setVisible(true)

			if self.data.limit and self.data.limit ~= 0 then
				self.iconPanel:setVisible(true)

				if self.mParent.actData then
					self.resData = self.mParent.actData:getLimitResDataById(self.data.limit)

					if self.resData then
						self.imgIcon:setImage(self.resData.icon_path, self.resData.icon_name)
					end
				end
			else
				self.iconPanel:setVisible(false)
			end
		else
			self.bgLocked:setVisible(true)
			self.btnAdd:setVisible(false)
			self.imgBtnAdd:setVisible(false)
			self.iconPanel:setVisible(false)
		end
	end

	self:refreshEditState()
end

function SneakBattleLimitStageCell:refreshEditState(...)
	if self.mParent.inEdit then
		-- block empty
	else
		self.btnAdd:setVisible(false)
		self.imgBtnAdd:setVisible(false)
	end
end

function SneakBattleLimitStageCell:onBtnAddClick()
	if self.mParent.inEdit then
		if not self.add then
			self.add = true

			self.imgSlc:setVisible(true)
		else
			self.add = false

			self.imgSlc:setVisible(false)
		end

		if self._slotOnCellClick then
			self._slotOnCellClick(self)
		end
	end
end

function SneakBattleLimitStageCell:onIconPanelClick()
	if not self.mParent.inEdit and self.resData then
		self.mParent:checkShowOneLimitInfo(self, self.iconPanel)
	end
end

local SneakBattleLimitDlg = Class("SneakBattleLimitDlg", UIControls.Window)

function SneakBattleLimitDlg:ctor(...)
	self:initUI()
end

function SneakBattleLimitDlg:initUI()
	self.btnEdit = UIControls.Button(self, "BgPanel/BtnEdit")

	self.btnEdit:addEventClick(self.onBtnEditClick)

	self.btnDeny = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnDeny:addEventClick(self.onBtnDenyClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnAllClear = UIControls.Button(self, "BgPanel/BtnAllClear")

	self.btnAllClear:addEventClick(self.onBtnAllClearClick)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.levelAwardList = UIControls.ScrollViewLoopV(self, "LimitPanel/LevelAwardList", 0, self.onCellChanged)
	self.limitPanel = UIControls.Image(self, "LimitPanel")
	self.libCells = {}
	self.uiAni = UIControls.UIAni(self, "")
	self.stageCells = {}
	self.uIClickThrough = UIControls.Button(self, "BgPanel/UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.bgInfo = UIControls.Image(self, "BgPanel/BgInfo")
	self.txtLimitTitle = UIControls.Label(self, "BgPanel/BgInfo/TextTitle")
	self.txtLImitDesc = UIControls.Label(self, "BgPanel/BgInfo/TextDesc")
end

function SneakBattleLimitDlg:setData(actData)
	self.actData = actData or self.actData

	if self.actData then
		local limitData = self.actData:getSortedLimitData()

		self.limitData = utils.deepcopy(limitData)

		self.levelAwardList:setTotalCount(#self.limitData)

		local stageData = self.actData:getNowLevelStageData()

		self.stageData = utils.deepcopy(stageData)

		if self.stageData then
			for index, data in ipairs(self.stageData) do
				if not self.stageCells[index] then
					local newCell = SneakBattleLimitStageCell(self, "BgPanel/ListLimit", "System/SneakBattle/SneakBattleLimitCell2")

					newCell:setVisible(true)

					newCell._slotOnCellClick = Slot(self.onStageCellClick, self)
					self.stageCells[index] = newCell
				end

				self.stageCells[index]:setData(data)
			end
		end
	end
end

function SneakBattleLimitDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = SneakBattleLimitLibCell(sender, "System/SneakBattle/SneakBattleLimitCell1", newIdx, 0, 0)
		targetCell.index = newIdx
		targetCell._slotOnCellClick = Slot(self.onLimitCellClick, self)
	end

	self.libCells[targetCell.index] = nil
	self.libCells[newIdx] = targetCell

	targetCell:setData(self.limitData[newIdx])
end

function SneakBattleLimitDlg:refreshUI(...)
	if self.stageCells then
		for index, cell in ipairs(self.stageCells) do
			cell.imgSlc:setVisible(index == self.selectStage)
			cell.imgBtnAdd:setVisible(index ~= self.selectStage)

			if self.stageData and self.stageData[index] then
				cell:setData(self.stageData[index])
			end

			cell:refreshState()
		end
	end

	if self.libCells then
		for index, cell in pairs(self.libCells) do
			cell:setData(self.limitData[index])
		end
	end
end

function SneakBattleLimitDlg:onStageCellClick(sender)
	if self.inEdit and sender and sender.data then
		if self.selectStage == sender.data.stage then
			self.selectStage = 0
		else
			self.selectStage = sender.data.stage
		end

		self:refreshUI()
	end
end

function SneakBattleLimitDlg:checkShowOneLimitInfo(sender, btn)
	if sender and sender.resData then
		self.txtLimitTitle:setText(sender.resData.name)
		self.txtLImitDesc:setText(sender.resData.desc)

		local btnPos = btn:getAbsPosition()

		self.bgInfo:setAbsPosition(btnPos.x + 2, btnPos.y)
		self.uIClickThrough:setVisible(true)
		self.bgInfo:setVisible(true)
	end
end

function SneakBattleLimitDlg:onUIClickThroughClick()
	self.uIClickThrough:setVisible(false)
	self.bgInfo:setVisible(false)
end

function SneakBattleLimitDlg:onLimitCellClick(sender)
	if self.inEdit and sender and sender.data and self.selectStage and self.selectStage ~= 0 then
		local preLimitId = 0

		if self.stageData then
			local data = self.stageData[self.selectStage]

			if data then
				preLimitId = data.limit

				if data.limit ~= sender.data.id then
					data.limit = sender.data.id
				else
					data.limit = 0
				end
			end
		end

		local preStage = 0

		if self.limitData then
			for _, limit in pairs(self.limitData) do
				if sender.data.id == limit.id then
					preStage = limit.stage
					limit.stage = 0
				end
			end

			for _, limit in pairs(self.limitData) do
				if limit.id == sender.data.id then
					limit.stage = self.selectStage
				end

				if limit.id == preLimitId then
					limit.stage = 0
				end
			end
		end

		if preStage ~= 0 and preStage ~= self.selectStage and self.stageData and self.stageData[preStage] then
			self.stageData[preStage].limit = 0
		end

		self:refreshUI()
	end
end

function SneakBattleLimitDlg:refreshEditState(flag)
	if flag then
		self.uiAni:startAni("ShowLimitList", true)
	else
		self.uiAni:startAni("HideLimitList", true)
	end

	self.inEdit = flag

	self.limitPanel:setVisible(flag)
	self.btnConfirm:setVisible(flag)
	self.btnAllClear:setVisible(flag)
	self.btnDeny:setVisible(flag)
	self.btnEdit:setVisible(not flag)

	self.selectStage = nil

	self:refreshUI()
end

function SneakBattleLimitDlg:onBtnEditClick()
	if self.actData then
		if self.actData.curPassStage == 0 then
			self:refreshEditState(true)
		elseif ResNewPveShow[13090007] and ResNewPveShow[13090007].desc then
			MsgManager.notice(ResNewPveShow[13090007].desc)
		end
	end
end

function SneakBattleLimitDlg:checkCanSaveLimit(...)
	if self.stageData then
		for index, data in ipairs(self.stageData) do
			if data.need_limit and data.need_limit == 1 and (not data.limit or data.limit == 0) then
				return false
			end
		end
	end

	return true
end

function SneakBattleLimitDlg:onBtnConfirmClick()
	if self:checkCanSaveLimit() then
		self:sendLimitsToSvr()
		UIManager.getUI("sneakBattleTeamSetDlg", true):setData(self.actData)
		self:setVisible(false)
	elseif ResNewPveShow[13090003] and ResNewPveShow[13090003].desc then
		MsgManager.notice(ResNewPveShow[13090003].desc)
	end
end

function SneakBattleLimitDlg:sendLimitsToSvr(...)
	if self.actData and self.actData.actObject then
		local opId = self.actData.actObject.opId

		if opId then
			local datas = {}

			if self.stageData then
				for index, data in ipairs(self.stageData) do
					if data.need_limit and data.need_limit == 1 then
						local oneData = {}

						oneData.stage = data.stage
						oneData.limit = data.limit

						table.insert(datas, oneData)
					end
				end
			end

			RPC.newPveChooseLimits(opId, datas)
		end
	end
end

function SneakBattleLimitDlg:onBtnDenyClick()
	self:setData()
	self:refreshEditState(false)
end

function SneakBattleLimitDlg:clearAllSelectData(...)
	if self.limitData then
		for index, data in ipairs(self.limitData) do
			if data.stage and data.stage ~= 0 then
				data.stage = 0
			end
		end
	end

	if self.stageData then
		for index, data in ipairs(self.stageData) do
			if data.limit and data.limit ~= 0 then
				data.limit = 0
			end
		end
	end

	self:refreshUI()
end

function SneakBattleLimitDlg:onBtnAllClearClick()
	self:clearAllSelectData()
	self:refreshUI()
end

function SneakBattleLimitDlg:onBtnCloseClick()
	if self.inEdit then
		if ResNewPveShow[13090020] then
			MsgManager.notice(ResNewPveShow[13090020].desc)
		end

		return
	end

	self:setVisible(false)
end

return SneakBattleLimitDlg
