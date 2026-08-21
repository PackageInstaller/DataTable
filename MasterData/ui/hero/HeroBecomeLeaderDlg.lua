-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroBecomeLeaderDlg.lua

local strClassName = "HeroSelectListCell"
local HeroSelectListCell = Class(strClassName, UIControls.Child)

function HeroSelectListCell:ctor()
	self:initUI()
end

function HeroSelectListCell:initUI()
	self.imgCheck = UIControls.Image(self, "Bg")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function HeroSelectListCell:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function HeroSelectListCell:onBtnSelfClick()
	if self.hero and self.selectCallback then
		self.selectCallback(self)
	end
end

function HeroSelectListCell:setSelected(selected)
	self.selected = selected
end

function HeroSelectListCell:setHero(hero)
	self.hero = hero

	if not self.gridHero then
		self.gridHero = UIControls.HeroGridChild(self, "GridPanel", "System/StarUp/GridHeroStarUp", 0, 0, true)
	end

	self.imgCheck:setVisible(self.selected)
	self.gridHero:setObj(self.hero)
	self.gridHero:setHeroRealLv()
end

local HeroGrowBecomeLeaderDlg = require("UI/Hero/HeroGrowBecomeLeaderDlg")
local strClassName = "HeroBecomeLeaderDlg"
local HeroBecomeLeaderDlg = Class(strClassName, HeroGrowBecomeLeaderDlg)

function HeroBecomeLeaderDlg:initUI()
	HeroBecomeLeaderDlg.super.initUI(self)

	self.toggleEquip = UIControls.Toggle(self, "BgPanel/ToggleEquip")
	self.toggleStep = UIControls.Toggle(self, "BgPanel/ToggleRank")

	self.toggleEquip:addEventValueChanged(Slot(self.onEquipToggleChange, self))
	self.toggleStep:addEventValueChanged(Slot(self.onStepToggleChange, self))

	self.cells = {}
	self.scrollSelectList = UIControls.ScrollViewLoopH(self, "BgPanel/GridLeaderHeroList")

	self.scrollSelectList:addEventCellChanged(self.onSelectListChanged)

	self.aniBgSelect = UIControls.UIAni(self, "BgPanel/BgSelect")

	self.aniBgSelect:startAniLoop("BgSelect", true)
end

function HeroBecomeLeaderDlg:refreshSelectHeroGridList()
	for idx, hero in ipairs(self.selectHeroData) do
		if not self.cells[idx] then
			self.cells[idx] = HeroSelectListCell(self, "BgPanel/GridLeaderHeroList/Content", "System/Hero/GridLeaderHero", 0, 0, true)
		end

		self.cells[idx]:setSelected(self.priestHero and self.priestHero.gid == self.selectHeroData[idx].gid)
		self.cells[idx]:setHero(self.selectHeroData[idx])
		self.cells[idx]:setSelectCallback(Slot(self.onSelectHero, self))
	end
end

function HeroBecomeLeaderDlg:onSelectListChanged(sender, targetCell, newIdx)
	targetCell = targetCell or HeroSelectListCell(sender, "System/Hero/GridLeaderHero", newIdx)

	if not self.selectHeroData or #self.selectHeroData == 0 then
		return
	end

	if self.selectHeroData[newIdx] ~= nil then
		targetCell:setSelected(self.priestHero and self.priestHero.gid == self.selectHeroData[newIdx].gid)
		targetCell:setHero(self.selectHeroData[newIdx])
		targetCell:setSelectCallback(Slot(self.onSelectHero, self))
	end

	self.cells[newIdx] = targetCell
end

function HeroBecomeLeaderDlg:setRecHero(recHero)
	HeroBecomeLeaderDlg.super.setRecHero(self, recHero)
	self.toggleEquip:setOnVoidUnChange(false)
	self.toggleStep:setOnVoidUnChange(false)

	self.selectHeroData = {}

	for _, info in ipairs(CurAvatar.crystalData.priests) do
		table.insert(self.selectHeroData, CurAvatar.heroDic[info.hero])
	end

	if #self.selectHeroData ~= 5 then
		local exceptionMsg = ""

		for i, info in ipairs(CurAvatar.crystalData.priests) do
			exceptionMsg = exceptionMsg .. info.hero .. "   exists：" .. tostring(CurAvatar.heroDic[info.hero] ~= nil) .. "\n"
		end

		ClientUtils.trySendException(Lang.get(30332), exceptionMsg)
	end

	self:refreshSelectHeroGridList()

	self.selectPriest = true
end

function HeroBecomeLeaderDlg:onSelectHero(sender)
	if self.selectPriest then
		local prePriest = sender.hero

		if prePriest.gid == self.recHero.gid then
			MsgManager.clientNotice(305)

			return
		end

		if prePriest.realLevel <= self.recHero.realLevel then
			MsgManager.clientNotice(306)

			return
		end

		if prePriest.realLevel > self.recHero:getMaxStarLv() then
			MsgManager.clientNotice(307)

			return
		end

		HeroBecomeLeaderDlg.super.setPriestHero(self, prePriest)
	end

	self.aniBgSelect:stopAni("BgSelect")
	self:refreshSelectHeroGridList()
	self:refreshCanSwapStep()
	self:refreshArtifactCanSwap()
	self:refreshCostMaterial()
	self.toggleEquip:setOnVoidUnChange(self.canSwapEquip == 1)
	self.toggleStep:setOnVoidUnChange(self.defaultSwapStep == 1)
end

function HeroBecomeLeaderDlg:onEquipToggleChange()
	if self.toggleEquip:isOn() and self.canSwapEquip == 0 then
		self.toggleEquip:setOnVoidUnChange(false)
		MsgManager.clientNotice(314)

		return
	end

	self.openSwapEquip = self.toggleEquip:isOn() and 1 or 0

	self:refreshCostMaterial()
end

function HeroBecomeLeaderDlg:onStepToggleChange()
	if self.toggleStep:isOn() and self.canSwapStep == 0 then
		self.toggleStep:setOnVoidUnChange(false)

		if self.priestHero and self.recHero then
			if self.priestHero.step == self.recHero.step then
				MsgManager.clientNotice(311)

				return
			end

			if self.priestHero.career ~= self.recHero.career then
				MsgManager.clientNotice(308)

				return
			end

			if self.cantStepResetReason and #self.cantStepResetReason > 0 then
				local reason = self.cantStepResetReason[1]

				if reason == Const.HERO_CANT_RESET_STEP_REASON.CLOSE_STEP then
					MsgManager.clientNotice(309)
				else
					MsgManager.clientNotice(310)
				end

				return
			end
		end

		return
	end

	self.openSwapStep = self.toggleStep:isOn() and 1 or 0

	self:refreshCostMaterial()
end

return HeroBecomeLeaderDlg
