-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SendHero\\ActivitySendHeroBuidingDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivitySendHeroBuildingUnlockCell = Class("ActivitySendHeroBuildingUnlockCell", UIControls.Child)

function ActivitySendHeroBuildingUnlockCell:ctor()
	self:initUI()
end

function ActivitySendHeroBuildingUnlockCell:initUI()
	self.efxUnlock = UIControls.Panel(self, "EfxPanel")
	self.panelUnlock = UIControls.Panel(self, "UnLockPanel")
	self.btnUp = UIControls.Button(self, "UnLockPanel/BtnSubmit")

	self.btnUp:addEventClick(self.onBtnUpClick)

	self.newBtnUp = UIControls.Panel(self, "UnLockPanel/BtnSubmit/IconNew")
	self.textCost = UIControls.Label(self, "UnLockPanel/BtnSubmit/TxtCurrencyNum")
	self.bonusGrids = {}
	self.textNameUnlock = UIControls.Label(self, "UnLockPanel/TxtLvTitle")
	self.panelItemLock = UIControls.Panel(self, "UnLockPanel/GridAward/LockPanel")
	self.panelLock = UIControls.Panel(self, "LockPanel")
	self.textNameLock = UIControls.Label(self, "LockPanel/TxtLvTitle")
end

function ActivitySendHeroBuildingUnlockCell:setData(levelData, nowLevel, preLevelData)
	self.levelData = levelData
	self.thisLevel = levelData.level
	self.miscData = self.mParent.miscData
	self.buildItemId = self.miscData.build_item_id

	ClientUtils.CreateBonusGrid(self, self.bonusGrids, "UnLockPanel/GridAward", self.levelData.award, true)

	if nowLevel >= self.thisLevel then
		self.panelLock:setVisible(false)
		self.panelUnlock:setVisible(true)
		self.btnUp:setVisible(false)
		self.textNameUnlock:setText(levelData.desc)
		self.panelItemLock:setVisible(false)
	elseif self.thisLevel == nowLevel + 1 then
		self.panelLock:setVisible(false)
		self.panelUnlock:setVisible(true)
		self.btnUp:setVisible(true)
		self.textCost:setText(preLevelData.cost)
		self.textNameUnlock:setText(levelData.desc)

		self.hasNum = ClientUtils.getMoney(self.buildItemId)
		self.needNum = preLevelData.cost

		if self.hasNum >= self.needNum then
			self.textCost:setFontColor(ResColor.WHITE)
			self.newBtnUp:setVisible(true)
		else
			self.textCost:setFontColor(ResColor.RED)
			self.newBtnUp:setVisible(false)
		end

		self.panelItemLock:setVisible(true)
	else
		self.panelLock:setVisible(true)
		self.panelUnlock:setVisible(false)
		self.textNameLock:setText(levelData.desc)
	end
end

function ActivitySendHeroBuildingUnlockCell:onBtnUpClick()
	if self.hasNum >= self.needNum then
		RPC.opActHomeDispatchBuild(self.mParent.actObj.opId, self.mParent.buildingId)
	else
		MsgManager.clientNotice(self.mParent.miscData.no_building_up_notice)
	end
end

function ActivitySendHeroBuildingUnlockCell:playUnlockAnim()
	self:playAni("SubmitUnlock")
end

local strClassName = "ActivitySendHeroBuidingDlg"
local ActivitySendHeroBuidingDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivitySendHeroBuidingDlg, ActivityPanelMixin)

function ActivitySendHeroBuidingDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.buildCells = {}
	self.bgBuild = UIControls.RawImage(self, "BgPanel/ImgDec")
end

function ActivitySendHeroBuidingDlg:_setData()
	self.buildingLevelData = self.actObj.actData.buildingLevelData
	self.miscData = self.actObj.actData.miscData
end

function ActivitySendHeroBuidingDlg:onShowBuilding(buildingId)
	if self.buildingId then
		return
	end

	self.buildingId = buildingId
	self.selectData = self.buildingLevelData[self.buildingId]

	if self.selectData[0].level_detail_icon then
		self.bgBuild:setImage("NoAlpha/" .. self.selectData[0].level_detail_icon)
	end

	for level = 0, 10 do
		if self.selectData[level] then
			local newCell = ActivitySendHeroBuildingUnlockCell(self, "BgPanel/LvSubmitPanel/Content", "System/Activity/ActivityDispatch/LvSubmitCell")

			table.insert(self.buildCells, newCell)
		end
	end

	self:refreshData()
end

function ActivitySendHeroBuidingDlg:onBtnClose()
	self:setVisible(false)
end

function ActivitySendHeroBuidingDlg:refreshData()
	local preLevel = self.nowLevel

	self.nowLevel = self.actObj.actData:getBuildingLevel(self.buildingId)

	for index, cell in ipairs(self.buildCells) do
		if self.selectData[index - 1] then
			cell:setVisible(true)
			cell:setData(self.selectData[index - 1], self.nowLevel, self.selectData[index - 2])
		else
			cell:setVisible(false)
		end
	end

	if preLevel and preLevel < self.nowLevel then
		for index, cell in ipairs(self.buildCells) do
			if preLevel < cell.thisLevel or cell.thisLevel <= self.nowLevel + 1 then
				cell:playUnlockAnim()
			end
		end
	end
end

function ActivitySendHeroBuidingDlg:updateActivityData()
	self:refreshData()
end

function ActivitySendHeroBuidingDlg:updateRelatedActivityData()
	self:refreshData()
end

return ActivitySendHeroBuidingDlg
