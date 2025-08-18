-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\HeroCrystalAchieveDlg.lua

local ResHeroCrystalAchieve = require("ClientData/ResHeroCrystalAchieve")
local HeroCrystalAchieveCell = Class("HeroCrystalAchieveCell", UIControls.ScrollViewLoopCell)

function HeroCrystalAchieveCell:ctor()
	self.imgBg = UIControls.Image(self, "Bg")
	self.slider = UIControls.Slider(self, "Slider")
	self.textSlider = UIControls.Label(self, "Slider/TextProgress")
	self.textNeed = UIControls.Label(self, "TextRule")
	self.textBonus = UIControls.Label(self, "TextSystemUnlock")
	self.panelAward = UIControls.Panel(self, "AwardPanel")
	self.awardGrids = {}
	self.btnGet = UIControls.Button(self, "BtnConfirm", "")

	self.btnGet:addEventClick(self.onGetClick)

	self.panelFinish = UIControls.Panel(self, "TextState")
	self.panelNotEnough = UIControls.Panel(self, "TextUnFinish")
end

function HeroCrystalAchieveCell:setData(data, curLevel)
	self.data = data
	self.dataId = data.id

	local achState = Const.ACT_ACHIEVE_STATE_NOT_ENOUGH

	if CurAvatar.crystalLevelAchieve[self.dataId] then
		achState = Const.ACT_ACHIEVE_STATE_GOT
	elseif curLevel >= self.data.need_level then
		if self.data.award then
			achState = Const.ACT_ACHIEVE_STATE_ENOUGH
		else
			achState = Const.ACT_ACHIEVE_STATE_GOT
		end
	end

	self.panelFinish:setVisible(achState == Const.ACT_ACHIEVE_STATE_GOT)
	self.panelNotEnough:setVisible(achState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH)
	self.btnGet:setVisible(achState == Const.ACT_ACHIEVE_STATE_ENOUGH)
	self.textSlider:setText(math.floor(curLevel / 10) .. "/" .. math.floor(data.need_level / 10))
	self.textNeed:setText(string.format(Lang.get(62574), math.floor(data.need_level / 10)))

	if achState == Const.ACT_ACHIEVE_STATE_GOT then
		self.slider:setValue(1)
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardCrystalLvUpAtlas4", "BgTask03")
	elseif achState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
		self.slider:setValue(curLevel / data.need_level)
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardCrystalLvUpAtlas4", "BgTask02")
	else
		self.slider:setValue(1)
		self.imgBg:setImage("Atlas/BackyardAtlas/BackyardCrystalLvUpAtlas4", "BgTask01")
	end

	if data.award then
		self.panelAward:setVisible(true)
		self.textBonus:setVisible(false)
		ClientUtils.CreateBonusGrid(self, self.awardGrids, "AwardPanel", data.award, true, nil, true)
	else
		self.panelAward:setVisible(false)
		self.textBonus:setVisible(true)
		self.textBonus:setText(data.bonus_desc)
	end

	for _, grid in ipairs(self.awardGrids) do
		grid:setGet(achState == Const.ACT_ACHIEVE_STATE_GOT)
	end
end

function HeroCrystalAchieveCell:onGetClick()
	RPC.crystalMsgGetAward({
		self.dataId
	})
end

local strClassName = "HeroCrystalAchieveDlg"
local HeroCrystalAchieveDlg = Class(strClassName, UIControls.Window)

function HeroCrystalAchieveDlg:ctor()
	self:initUI()
end

function HeroCrystalAchieveDlg:initUI()
	self.closeBtn = UIControls.Button(self, "MainInfoPanel/Bg/BtnClose")

	self.closeBtn:addEventClick(self.onClickClose)

	self.textNowLevel = UIControls.Label(self, "MainInfoPanel/Bg/AwardInfoPanel/ImgNewLv/TextLvNum")
	self.textNextLevel = UIControls.Label(self, "MainInfoPanel/Bg/AwardInfoPanel/ImgBg/TextLvInfo")
	self.textNextLockDesc = UIControls.Label(self, "MainInfoPanel/Bg/AwardInfoPanel/ImgBg/TextSystemUnlock")
	self.panelNextAward = UIControls.Panel(self, "MainInfoPanel/Bg/AwardInfoPanel/ImgBg/AwardPanel")
	self.nextAwardGrids = {}
	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "MainInfoPanel/Bg/CrystalLvInfoPanel")

	self.scroll:addEventCellChanged(self.onCellChanged)
end

function HeroCrystalAchieveDlg:onOpen()
	HeroCrystalAchieveDlg.super.onOpen(self)
	self:refreshState()
end

function HeroCrystalAchieveDlg:refreshState()
	self.sortedData = ResHeroCrystalAchieve
	self.curLevel = CurAvatar.crystalNewLevel

	local startIdx = self:refreshNextState()

	self.scroll:setTotalCount(#self.sortedData, math.max(1, startIdx))
end

function HeroCrystalAchieveDlg:refreshNextState()
	local getDict = CurAvatar.crystalLevelAchieve
	local startIdx = 0

	for id, info in ipairs(self.sortedData) do
		if info.need_level > self.curLevel or info.award and not getDict[id] then
			break
		end

		startIdx = id
	end

	local nextBigBonus

	for index = startIdx + 1, #self.sortedData do
		local sData = self.sortedData[index]

		if sData and sData.big_award_flag then
			nextBigBonus = sData

			break
		end
	end

	self.textNowLevel:setText(math.floor(self.curLevel / 10))

	if nextBigBonus then
		self.textNextLevel:setText(string.format(Lang.get(62574), math.floor(nextBigBonus.need_level / 10)))

		if nextBigBonus.award then
			self.textNextLockDesc:setVisible(false)
			self.panelNextAward:setVisible(true)
			ClientUtils.CreateBonusGrid(self, self.nextAwardGrids, "MainInfoPanel/Bg/AwardInfoPanel/ImgBg/AwardPanel", nextBigBonus.award, true, nil, true)
		else
			self.textNextLockDesc:setVisible(true)
			self.textNextLockDesc:setText(nextBigBonus.bonus_desc or "")
			self.panelNextAward:setVisible(false)
		end
	else
		self.textNextLevel:setText(Lang.get(63159))
		self.textNextLockDesc:setVisible(false)
		self.panelNextAward:setVisible(false)
	end

	return startIdx
end

function HeroCrystalAchieveDlg:onClickClose()
	self:setVisible(false)
end

function HeroCrystalAchieveDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = HeroCrystalAchieveCell(sender, "System/Backyard/BackyardCrystalLvAwardInfoCell", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setData(self.sortedData[newIdx], self.curLevel)
end

function HeroCrystalAchieveDlg:onCrystalMsgGetAwardResp(allIds)
	for newIdx, cell in pairs(self.cells) do
		if allIds[cell.dataId] then
			cell:setData(self.sortedData[newIdx], self.curLevel)
		end
	end

	self:refreshNextState()
end

return HeroCrystalAchieveDlg
