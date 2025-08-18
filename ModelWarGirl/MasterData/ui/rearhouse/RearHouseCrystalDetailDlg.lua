-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseCrystalDetailDlg.lua

local ResCrystalLevelCost = require("ClientData/ResCrystalLevelCost")
local RearHouseCrystalDetailDlg = Class("RearHouseCrystalDetailDlg", UIControls.Window)

function RearHouseCrystalDetailDlg:ctor()
	self:initUI()
end

local MAX_STAR = 10

function RearHouseCrystalDetailDlg:initUI()
	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self.onClickClose)

	self.tipsBtn = UIControls.Button(self, "BtnTips")

	self.tipsBtn:addEventClick(self.onClickTips)

	self.textOldLv = UIControls.Label(self, "MainInfoPanel/TopPanel/TextOldLvNum")
	self.textNewLv = UIControls.Label(self, "MainInfoPanel/TopPanel/ImgNewLv/TextLvNum")
	self.aniActivityStars = {}
	self.panelActiveStars = {}

	for index = 1, MAX_STAR do
		local newAni = UIControls.UIAni(self, "MainInfoPanel/TopPanel/LvSlider/ImgLv" .. index)

		table.insert(self.aniActivityStars, newAni)

		local newStar = UIControls.Panel(self, "MainInfoPanel/TopPanel/LvSlider/ImgLv" .. index .. "/ImgHighlight")

		table.insert(self.panelActiveStars, newStar)
	end

	self.aniCapacity = UIControls.UIAni(self, "MainInfoPanel/BottomPanel/ImgShow")
	self.textNowCapacity = UIControls.Label(self, "MainInfoPanel/BottomPanel/ImgShow/ImgNow/Text")
	self.textNextCapacity = UIControls.Label(self, "MainInfoPanel/BottomPanel/ImgShow/ImgAfter/Text")
	self.panelNowCapactity = UIControls.Panel(self, "MainInfoPanel/BottomPanel/ImgShow/ImgNow")
	self.panelAfterCapactity = UIControls.Panel(self, "MainInfoPanel/BottomPanel/ImgShow/ImgAfter")
	self.panelArrow = UIControls.Panel(self, "MainInfoPanel/BottomPanel/ImgShow/ImgArrow")
	self.textMaxTips = UIControls.Label(self, "MainInfoPanel/BottomPanel/ImgShow/TextTips")
	self.btnUpgrade = UIControls.Button(self, "MainInfoPanel/BottomPanel/BtnUpgrade")

	self.btnUpgrade:addEventClick(self.onUpgradeClick)

	self.iconUpgrade = UIControls.Image(self, "MainInfoPanel/BottomPanel/BtnUpgrade/Icon")
	self.textNumUpgrade = UIControls.Label(self, "MainInfoPanel/BottomPanel/BtnUpgrade/TextNum")
	self.rdUpgrade = UIControls.RedDot(self, "MainInfoPanel/BottomPanel/BtnUpgrade/IconNew")

	self.rdUpgrade:addHint({
		UIConst.RD_HINT_REAR_HOUSE_CRYSTLE_UP
	})

	self.btnAchieve = UIControls.Button(self, "MainInfoPanel/BtnAchi")

	self.btnAchieve:addEventClick(self.onAchieveClick)

	self.rdAchieve = UIControls.RedDot(self, "MainInfoPanel/BtnAchi/IconNew")

	self.rdAchieve:addHint({
		UIConst.RD_HINT_REAR_HOUSE_ACHIEVE
	})

	self.levelAwardBtn = UIControls.Button(self, "MainInfoPanel/BtnLevelAward")

	self.levelAwardBtn:setVisible(Const.ENABLE_CRYSTAL_LEVEL_ACHIEVE)
	self.levelAwardBtn:addEventClick(self.onClickLevelAward)

	self.rdLevelAward = UIControls.RedDot(self, "MainInfoPanel/BtnLevelAward/IconNew")

	self.rdLevelAward:addHint({
		UIConst.RD_HINT_REAR_HOUSE_LEVEL_ACHIEVE
	})

	self.btnMaxLevel = UIControls.Button(self, "MainInfoPanel/BottomPanel/BtnInfo")

	self.btnMaxLevel:addEventClick(self.onMaxLevelClick)
end

function RearHouseCrystalDetailDlg:onOpen()
	RearHouseCrystalDetailDlg.super.onOpen(self)
	self:onRefreshData()
end

function RearHouseCrystalDetailDlg:onRefreshData(fromUpdata)
	self.inLevelUp = nil

	local crystalData = CurAvatar.crystalData

	if Const.REVIEW_VERSION then
		self.textOldLv:setText(Lang.get(1203) .. crystalData.level)
	else
		self.textOldLv:setText("LV." .. crystalData.level)
	end

	self.crystalNewLevel = CurAvatar.crystalNewLevel

	local levelData = ResCrystalLevelCost[self.crystalNewLevel] or {}

	self.nextData = ResCrystalLevelCost[self.crystalNewLevel + 1]

	self.textNextCapacity:setText(levelData.show_level or 0)

	self.showLevel, self.star, self.maxStar, self.nextLevelData = ClientUtils.GetCrystalNewLevelState()

	self.textNewLv:setText(self.showLevel)

	for index, cell in ipairs(self.panelActiveStars) do
		cell:setVisible(index <= self.star)

		if index <= self.star then
			self.aniActivityStars[index]:startAniLoop("LoopCrystalLvUp")
		end
	end

	self.aniCapacity:startAniLoop("LoopCrystalShow")

	if self.nextLevelData then
		self.costItem = self.nextLevelData.res_id[1]

		local costNum = self.nextLevelData.res_num[1]
		local itemPath = BaseObject.getItemIconPath(self.costItem)

		if itemPath then
			self.iconUpgrade:setImage(itemPath[1], itemPath[2])
		end

		self.textNumUpgrade:setText(costNum)

		if CurAvatar:crystalCanLevelUp() then
			self.textNumUpgrade:setFontColor(ResColor.WHITE)
		else
			self.textNumUpgrade:setFontColor(ResColor.RED)
		end
	end

	self.nowCapacity = CurAvatar:getCrystalNowCapacity()
	self.nextCapacity = CurAvatar:getNextCrystalCapacity()

	self.textNowCapacity:setText(self.nowCapacity)
	self.textNextCapacity:setText(self.nextCapacity)

	local maxLevel = CurAvatar:getCrystalNewLevelMax()

	if maxLevel <= self.crystalNewLevel and not CurAvatar:overProficientMaxLimit() then
		self.btnUpgrade:setVisible(false)
		self.btnMaxLevel:setVisible(true)
		self.textMaxTips:setVisible(true)
		self.textMaxTips:setText(string.format(Lang.get(56681), maxLevel))
		self.panelNowCapactity:setVisible(false)
		self.panelAfterCapactity:setVisible(false)
		self.panelArrow:setVisible(false)
	else
		self.btnMaxLevel:setVisible(false)
		self.btnUpgrade:setVisible(true)
		self.textMaxTips:setVisible(false)
		self.panelNowCapactity:setVisible(true)
		self.panelAfterCapactity:setVisible(true)
		self.panelArrow:setVisible(true)

		if not self.nextLevelData then
			self.btnUpgrade:setVisible(false)
			self.aniCapacity:setVisible(false)
		end
	end
end

function RearHouseCrystalDetailDlg:onClickClose()
	self:setVisible(false)
end

function RearHouseCrystalDetailDlg:onClickTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(276)
end

function RearHouseCrystalDetailDlg:onUpgradeClick()
	if self.inLevelUp then
		MsgManager.notice(Lang.get(56956))
	end

	if CurAvatar:crystalCanLevelUp() then
		RPC.crystalMsgLevelUp()

		self.inLevelUp = true

		self.btnUpgrade:setVisible(false)
	elseif self.costItem then
		BaseObject.ShowObjectTips(self.costItem, 1, self, {
			CloseSrcWindow = 1,
			AutoOpenGuide = 1
		})
	end
end

function RearHouseCrystalDetailDlg:onAchieveClick()
	local rearHouseCrystalAchieveDlg = UIManager.getUI("rearHouseCrystalAchieveDlg", true)

	rearHouseCrystalAchieveDlg:bindWindow(self)
end

function RearHouseCrystalDetailDlg:onMaxLevelClick(data)
	UIManager.getUI("handBookTeamOverviewDlg", true)
end

function RearHouseCrystalDetailDlg:onClickLevelAward()
	local heroCrystalAchieveDlg = UIManager.getUI("heroCrystalAchieveDlg", true)

	heroCrystalAchieveDlg:bindWindow(self)
end

function RearHouseCrystalDetailDlg:onStarChanged()
	local showLevel, star, maxStar, nextLevelData = ClientUtils.GetCrystalNewLevelState()

	if showLevel ~= self.showLevel or star ~= self.star then
		if self.coLevelUpAnim then
			coroutine.stop(self.coLevelUpAnim)
		end

		self.coLevelUpAnim = coroutine.start(self.coLevelUpAnimFunc, self, showLevel, star)
	end
end

function RearHouseCrystalDetailDlg:coLevelUpAnimFunc(showLevel, star)
	if showLevel ~= self.showLevel then
		self.panelActiveStars[MAX_STAR]:setVisible(true)
		self.aniActivityStars[MAX_STAR]:startAni("LightCrystalLvUp")
		self.aniCapacity:startAni("LightCrystalShow")
		coroutine.wait(1.2)
		UIManager.getUI("rearHouseNewLvUpDlg", true):onShow(self.showLevel, showLevel, self.nowCapacity, self.nextCapacity)
	else
		self.panelActiveStars[star]:setVisible(true)
		self.aniActivityStars[star]:startAni("LightCrystalLvUp")
		self.aniCapacity:startAni("LightCrystalShow")
		coroutine.wait(0.25)
	end

	self:onRefreshData(true)

	self.coLevelUpAnim = nil
end

function RearHouseCrystalDetailDlg:tryAutoRefresh()
	if self.inLevelUp then
		return
	end

	self:onRefreshData()
end

function RearHouseCrystalDetailDlg:onRefreshCostNum()
	if self.nextLevelData then
		if CurAvatar:crystalCanLevelUp() then
			self.textNumUpgrade:setFontColor(ResColor.WHITE)
		else
			self.textNumUpgrade:setFontColor(ResColor.RED)
		end
	end
end

function RearHouseCrystalDetailDlg:destroy()
	RearHouseCrystalDetailDlg.super.destroy(self)

	if self.coLevelUpAnim then
		coroutine.stop(self.coLevelUpAnim)
	end
end

return RearHouseCrystalDetailDlg
