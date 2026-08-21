-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseCrystalAchieveDlg.lua

local ResCrystalAchieve = require("ClientData/ResCrystalAchieve")
local ResHero = require("ClientData/ResHero")
local STATE_ORDER_FINISH = 0
local STATE_ORDER_NOT_ENOUGH = 1
local STATE_ORDER_ENOUGH = 2
local ACHIEVE_TAB_CONFIG = {
	{
		Const.CRYSTAL_TYPE_HERO,
		Lang.get(55839)
	},
	{
		Const.CRYSTAL_TYPE_ARTIFACT,
		Lang.get(55840)
	},
	{
		Const.CRYSTAL_TYPE_RELIC,
		Lang.get(55843)
	},
	{
		Const.CRYSTAL_TYPE_SKIN,
		Lang.get(55842)
	},
	{
		Const.CRYSTAL_TYPE_FURNITURE,
		Lang.get(55841)
	},
	{
		Const.CRYSTAL_TYPE_HEADFRAME,
		Lang.get(55844)
	}
}
local RearHouseAchieveCell = Class("RearHouseAchieveCell", UIControls.ScrollViewLoopCell)

function RearHouseAchieveCell:ctor()
	self.textCondition = UIControls.Label(self, "ContentPanel/TextName")
	self.textTitle = UIControls.Label(self, "ContentPanel/TextTitle")
	self.panelNew = UIControls.Image(self, "ContentPanel/ImgTitleState")
	self.gridCondition = UIControls.GridSimpleContainerChild(self, "ContentPanel/GridPanel", "System/Common/Grid/GridContainer", 0, 0, true)
	self.gridCondition.isShowPreviewTips = true
	self.panelFinish = UIControls.Panel(self, "ContentPanel/IconCollect")
	self.btnGet = UIControls.Button(self, "ContentPanel/BtnConfirm")

	self.btnGet:addEventClick(self.onGetClick)

	self.btnJump = UIControls.Button(self, "ContentPanel/BtnGo")

	self.btnJump:addEventClick(self.onJumpClick)

	self.awardGrids = {}
	self.aniGetEfx = UIControls.Panel(self, "ContentPanel/Efx")
	self.imgBg = UIControls.Image(self, "ContentPanel")
end

function RearHouseAchieveCell:setData(data)
	self.aniGetEfx:setVisible(false)

	self.achieveData = data[1]
	self.achieveStateOrder = data[2]

	self.textTitle:setText(self.achieveData.title or "")
	self.textCondition:setText(self.achieveData.des or "")
	ClientUtils.CreateBonusGrid(self, self.awardGrids, "ContentPanel/GridAward", self.achieveData.award_id, true, nil, true)

	for _, grid in ipairs(self.awardGrids) do
		grid:setGet(self.achieveStateOrder == STATE_ORDER_FINISH)
	end

	self.panelNew:setVisible(self.achieveStateOrder == STATE_ORDER_ENOUGH)
	self.panelFinish:setVisible(self.achieveStateOrder == STATE_ORDER_FINISH)
	self.btnGet:setVisible(self.achieveStateOrder == STATE_ORDER_ENOUGH)
	self.btnJump:setVisible(self.achieveStateOrder == STATE_ORDER_NOT_ENOUGH)

	self.needClientItem = self:getNeedClientItem()

	self.gridCondition:setObj(self.needClientItem)

	if self.achieveStateOrder == STATE_ORDER_FINISH then
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardCrystalLvUpAltas3", "BgEntryLaser")
	elseif self.achieveStateOrder == STATE_ORDER_ENOUGH then
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardCrystalLvUpAltas3", "BgEntryYellow")
	else
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardCrystalLvUpAltas3", "BgEntryAsh")
	end
end

function RearHouseAchieveCell:getNeedClientItem()
	local clientItem = BaseObject.GetObject(self.achieveData.item_id)

	if self.achieveData.type == Const.CRYSTAL_TYPE_HERO then
		local star, paintLevel = CurAvatar:getHeroStarFromProficient(self.achieveData.item_id, self.achieveData.progress)

		clientItem.star = star
		clientItem.paintLevel = paintLevel
	elseif self.achieveData.type == Const.CRYSTAL_TYPE_ARTIFACT then
		clientItem.enhanceLevel = self.achieveData.progress
	elseif self.achieveData.type == Const.CRYSTAL_TYPE_RELIC then
		clientItem.enhanceLevel = self.achieveData.progress
	end

	return clientItem
end

function RearHouseAchieveCell:onGetClick()
	self.aniGetEfx:setVisible(true)
	self.btnGet:setVisible(false)
	coroutine.start(self.rpcGetBonus, self)
end

function RearHouseAchieveCell:rpcGetBonus()
	coroutine.wait(0.5)

	local oneData = {}

	oneData.type = self.achieveData.type
	oneData.item_id = self.achieveData.item_id
	oneData.index = self.achieveData.index

	RPC.collectAchieveGetAward({
		oneData
	})
end

function RearHouseAchieveCell:onJumpClick()
	CurAvatar:jumpToShowItem(self.achieveData.item_id, self, self.achieveData.progress)
end

local RearHouseCrystalAchieveTabBtn = Class("RearHouseCrystalAchieveTabBtn", UIControls.Child)

function RearHouseCrystalAchieveTabBtn:ctor()
	self.btnSelf = UIControls.Button(self, "", "Text")

	self.btnSelf:addEventClick(self.onSelfClick)

	self.rdNew = UIControls.Panel(self, "IconNew")
	self.imgBg = UIControls.Image(self, "Mask/Icon")
end

function RearHouseCrystalAchieveTabBtn:setConfig(btnConfig)
	self.btnConfig = btnConfig
	self.achieveType = btnConfig[1]

	self.btnSelf:setText(btnConfig[2])

	self.achieveData = ResCrystalAchieve[self.achieveType] or {}
end

function RearHouseCrystalAchieveTabBtn:setSelected(isSelected)
	self.btnSelf:setEnable(not isSelected)

	if isSelected then
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardCrystalLvUpAltas3", "IconTab0" .. self.achieveType .. "Sel")
	else
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardCrystalLvUpAltas3", "IconTab0" .. self.achieveType .. "Nml")
	end
end

function RearHouseCrystalAchieveTabBtn:onSelfClick(sender)
	self.mParent:onSelectTabBtn(self)
end

local function SortByState(dataA, dataB)
	if dataA[2] ~= dataB[2] then
		return dataA[2] > dataB[2]
	elseif dataA[4] ~= dataB[4] then
		return dataA[4] > dataB[4]
	else
		return dataA[3] < dataB[3]
	end
end

function RearHouseCrystalAchieveTabBtn:refreshState()
	self.newEnable = false
	self.sortedData = {}

	for key, kInfo in pairs(self.achieveData) do
		if self.achieveType == Const.CRYSTAL_TYPE_HERO and not ResHero[key] then
			-- block empty
		else
			for kId, oneData in ipairs(kInfo) do
				if not oneData.valid_time_id or ClientUtils.isTimeConfigPassed(oneData.valid_time_id) then
					local idState = CurAvatar:getCrystalAchieveState(oneData)
					local stateOrder = STATE_ORDER_ENOUGH

					if idState == Const.ACT_ACHIEVE_STATE_GOT then
						stateOrder = STATE_ORDER_FINISH
					elseif idState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
						stateOrder = STATE_ORDER_NOT_ENOUGH
					end

					if idState == Const.ACT_ACHIEVE_STATE_ENOUGH then
						self.newEnable = true
					end

					if stateOrder == STATE_ORDER_ENOUGH or stateOrder == STATE_ORDER_NOT_ENOUGH or kId == #kInfo then
						table.insert(self.sortedData, {
							oneData,
							stateOrder,
							key,
							oneData.progress or 1
						})

						break
					end
				end
			end
		end
	end

	table.sort(self.sortedData, SortByState)
	self.rdNew:setVisible(self.newEnable)

	return self.newEnable
end

local strClassName = "RearHouseCrystalAchieveDlg"
local RearHouseCrystalAchieveDlg = Class(strClassName, UIControls.Window)

function RearHouseCrystalAchieveDlg:ctor()
	self:initUI()
end

function RearHouseCrystalAchieveDlg:initUI()
	self.closeBtn = UIControls.Button(self, "BgPanel/ImgBg/BtnClose")

	self.closeBtn:addEventClick(self.onClickClose)

	self.tabBtns = {}

	for index, btnConfig in ipairs(ACHIEVE_TAB_CONFIG) do
		local newBtn = RearHouseCrystalAchieveTabBtn(self, "BgPanel/TabPanel/TabList/Content", "System/Backyard/TabBackyardCollect")

		newBtn:setVisible(true)
		newBtn:setConfig(btnConfig)
		table.insert(self.tabBtns, newBtn)
	end

	self.textNowTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.btnGetAll = UIControls.Button(self, "BgPanel/BtnGetAll")

	self.btnGetAll:addEventClick(self.onGetAllClick)

	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "BgPanel/ContentList")

	self.scroll:addEventCellChanged(self.onCellChanged)
end

function RearHouseCrystalAchieveDlg:onOpen()
	RearHouseCrystalAchieveDlg.super.onOpen(self)
	self:refreshState()
	self:onSelectTabBtn(self.nowRDBtn or self.tabBtns[1])
end

function RearHouseCrystalAchieveDlg:refreshState()
	self.nowRDBtn = nil

	for index, btn in ipairs(self.tabBtns) do
		if btn:refreshState() and not self.nowRDBtn then
			self.nowRDBtn = btn
		end
	end
end

function RearHouseCrystalAchieveDlg:onSelectTabBtn(tab)
	for _, btn in ipairs(self.tabBtns) do
		btn:setSelected(btn == tab)
	end

	self.selTab = tab
	self.achieveType = tab.achieveType

	self.textNowTitle:setText(tab.btnConfig[2])

	self.sortedData = tab.sortedData

	self.scroll:setTotalCount(#self.sortedData, 1)
	self.btnGetAll:setEnable(tab.newEnable)
end

function RearHouseCrystalAchieveDlg:onClickClose()
	self:setVisible(false)
end

function RearHouseCrystalAchieveDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = RearHouseAchieveCell(sender, "System/Backyard/BackyardAchiDiceCell", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setData(self.sortedData[newIdx])
end

function RearHouseCrystalAchieveDlg:onRefreshCrystalAchieveDlg()
	self:refreshState()

	self.sortedData = self.selTab.sortedData

	for index, cell in pairs(self.cells) do
		if self.sortedData[index] then
			cell:setData(self.sortedData[index])
		end
	end

	self.btnGetAll:setEnable(self.selTab.newEnable)
end

function RearHouseCrystalAchieveDlg:onGetAllClick()
	local allEnoughData = {}
	local enoughData = {}

	table.insert(allEnoughData, enoughData)

	local cType = self.selTab.achieveType
	local typeInfo = CurAvatar.crystalAchieveData[cType] or {}

	for key, allInfo in pairs(self.selTab.achieveData) do
		local keyInfo = typeInfo[key]

		if keyInfo then
			local nowProgress = keyInfo[1]
			local nowGot = keyInfo[2]

			for id, aData in ipairs(allInfo) do
				if not aData.valid_time_id or ClientUtils.isTimeConfigPassed(aData.valid_time_id) then
					if nowProgress >= aData.progress then
						if not nowGot[id] then
							local oneData = {}

							oneData.type = cType
							oneData.item_id = key
							oneData.index = id

							if #enoughData > 500 then
								enoughData = {}

								table.insert(allEnoughData, enoughData)
							end

							table.insert(enoughData, oneData)
						end
					else
						break
					end
				end
			end
		end
	end

	if #enoughData > 0 then
		for _, eData in ipairs(allEnoughData) do
			RPC.collectAchieveGetAward(eData)
		end
	end
end

function RearHouseCrystalAchieveDlg:destroy()
	RearHouseCrystalAchieveDlg.super.destroy(self)

	local rearHouseCrystalDetailDlg = UIManager.tryGetUI("rearHouseCrystalDetailDlg")

	if rearHouseCrystalDetailDlg then
		rearHouseCrystalDetailDlg:onRefreshCostNum()
	end
end

return RearHouseCrystalAchieveDlg
