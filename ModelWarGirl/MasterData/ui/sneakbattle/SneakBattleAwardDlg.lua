-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleAwardDlg.lua

local ResNewPveLevel = require("ClientData/ResNewPveLevel")
local ResRandClient = require("ClientData/ResRandClient")
local SneakBattleAwardTypeCell = Class("SneakBattleAwardTypeCell", UIControls.Child)

function SneakBattleAwardTypeCell:ctor(...)
	self:initUI()
end

function SneakBattleAwardTypeCell:initUI()
	self.txt = UIControls.Label(self, "Text")
	self.iconNew = UIControls.Image(self, "IconNew")
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onBtnClick)

	self.bg = UIControls.Image(self, "Bg")
end

function SneakBattleAwardTypeCell:setData(data)
	if data then
		self.data = data

		self.txt:setText(data.name)

		if data.haveAward then
			self.iconNew:setVisible(true)
		else
			self.iconNew:setVisible(false)
		end
	end
end

function SneakBattleAwardTypeCell:onBtnClick()
	if self._soltOnTypeCellClick then
		self._soltOnTypeCellClick(self)
	end
end

local SneakBattleAwardCell = Class("SneakBattleAwardCell", UIControls.ScrollViewLoopCell)

function SneakBattleAwardCell:ctor()
	self:initUI()
end

function SneakBattleAwardCell:initUI(...)
	self.txt = UIControls.Label(self, "ContentPanel/Text")
	self.btnGet = UIControls.Button(self, "ContentPanel/BtnGet")
	self.txtReceived = UIControls.Label(self, "ContentPanel/TextReceived")
	self.txtNotYet = UIControls.Label(self, "ContentPanel/TextNotYet")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.cells = {}
end

function SneakBattleAwardCell:setData(data)
	if data then
		self.data = data

		self.txt:setText(data.desc)

		if data.can then
			self.btnGet:setVisible(true)
			self.txtNotYet:setVisible(false)
		else
			self.txtNotYet:setVisible(true)
			self.btnGet:setVisible(false)
		end

		if data.got then
			self.btnGet:setVisible(false)
			self.txt:setFontColor(ResColor.WHITE)
			self.txtReceived:setVisible(true)
		else
			self.txt:setFontColor(ResColor.BLACK)
			self.txtReceived:setVisible(false)
		end

		if data.award_id and ResRandClient[data.award_id] then
			local resData = ResRandClient[data.award_id]

			for i, v in ipairs(resData.show_ids) do
				local num = resData.show_nums[i] or 1

				if not self.cells[i] then
					self.cells[i] = UIControls.getGridAwardContainer(self, "ContentPanel/AwardPanel")
				end

				local fakeItem = BaseObject.GetObject(v, num)

				self.cells[i]:setVisible(true)
				self.cells[i]:setObj(fakeItem)

				if self.cells[i].grid then
					self.cells[i].grid.mDisableWays = true
				end
			end

			local count = #resData.show_ids + 1

			for i = count, #self.cells do
				self.cells[i]:setVisible(false)
			end
		end
	end
end

function SneakBattleAwardCell:onBtnGetClick()
	local actId = self.mParent.actData.actObject.opId
	local type = self.mParent.selectType

	if self.data then
		RPC.newPveGetAward(actId, type, self.data.id)
	end
end

local SneakBattleAwardTabCell = Class("SneakBattleAwardTabCell", UIControls.Child)

function SneakBattleAwardTabCell:ctor(...)
	self:initUI()
end

function SneakBattleAwardTabCell:initUI(...)
	self.tabLevel = UIControls.Button(self, "TabLevel")

	self.tabLevel:addEventClick(self.onTabLevelClick)

	self.txt = UIControls.Label(self, "TabLevel/Text")
	self.iconNew = UIControls.Image(self, "TabLevel/IconNew")
end

function SneakBattleAwardTabCell:setData(data)
	if data then
		self.type = data.type

		self.txt:setText(data.name)

		if data.haveAward then
			self.iconNew:setVisible(true)
		else
			self.iconNew:setVisible(false)
		end
	end
end

function SneakBattleAwardTabCell:onTabLevelClick()
	if self.type then
		self.mParent:setSelectType(self.type)
	end
end

local SneakBattleAwardDlg = Class("SneakBattleAwardDlg", UIControls.Window)

function SneakBattleAwardDlg:ctor(...)
	self:initUI()
end

function SneakBattleAwardDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/LevelAwardList", 0, self.onAwardCellChanged)
	self.awardCells = {}
	self.tabCells = {}
	self.typeCells = {}
end

function SneakBattleAwardDlg:setData(actData)
	self.actData = actData or self.actData

	if self.actData then
		self.typeData = self.actData:getAccomplishAwardAllTypeData()

		if self.typeData then
			for index, data in ipairs(self.typeData) do
				if not self.tabCells[index] then
					self.tabCells[index] = SneakBattleAwardTabCell(self, "BgPanel/ListTab", "System/SneakBattle/TabSneakBattleAward")

					self.tabCells[index]:setVisible(true)
				end

				self.tabCells[index]:setData(data)
			end
		end

		self.selectType = self.selectType or self.actData.type

		self:setSelectType(self.selectType)
	end
end

function SneakBattleAwardDlg:refreshUI(...)
	self:refreshRD()

	self.awardData = self.actData:getSortedAccomplishAwardData(self.selectType)

	if self.awardData then
		self.scrollView:setTotalCount(#self.awardData)
	end
end

function SneakBattleAwardDlg:onAwardCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = SneakBattleAwardCell(sender, "System/SneakBattle/SneakBattleAwardCell", newIdx, 0, 0)
		targetCell.index = newIdx
	end

	self.awardCells[targetCell.index] = nil
	self.awardCells[newIdx] = targetCell

	targetCell:setData(self.awardData[newIdx])
end

function SneakBattleAwardDlg:refreshRD()
	return
end

function SneakBattleAwardDlg:setSelectType(type)
	self.selectType = type or self.selectType

	for index, cell in ipairs(self.tabCells) do
		cell.tabLevel:setEnable(index ~= self.selectType)
	end

	self:refreshUI()
end

function SneakBattleAwardDlg:onBtnCloseClick()
	self:setVisible(false)
end

function SneakBattleAwardDlg:onBtnListBossClick()
	local showState = not self.listBossPanel:getVisible()

	self.listBossPanel:setVisible(showState)
	self.uIClickThrough:setVisible(showState)

	for index, cell in ipairs(self.typeCells) do
		cell.bg:setVisible(cell.data.type == self.selectType)
	end
end

function SneakBattleAwardDlg:onUIClickThroughClick()
	self.listBossPanel:setVisible(false)
	self.uIClickThrough:setVisible(false)
end

return SneakBattleAwardDlg
