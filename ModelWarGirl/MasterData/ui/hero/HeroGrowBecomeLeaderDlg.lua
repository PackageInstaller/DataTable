-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroGrowBecomeLeaderDlg.lua

local HeroSwapWearingPanel = require("UI/Hero/HeroSwapWearingPanel")
local ResHeroResetMisc = require("ClientData/ResHeroResetMisc")
local ResClientNotice = require("ClientData/ResClientNotice")
local strClassName = "HeroGrowBecomeLeaderDlg"
local HeroGrowBecomeLeaderDlg = Class(strClassName, UIControls.Window)

function HeroGrowBecomeLeaderDlg:ctor()
	self:initUI()
end

function HeroGrowBecomeLeaderDlg:initUI()
	self.priestWearingPanel = HeroSwapWearingPanel(self, "BgPanel/BtnEquipWearingPanel1")
	self.recWearingPanel = HeroSwapWearingPanel(self, "BgPanel/BtnEquipWearingPanel2")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnExchange = UIControls.Button(self, "BgPanel/BtnExchange")

	self.btnExchange:addEventClick(self.onBtnExchangeClick)

	self.exchangeCostCom = {}

	for i = 1, 2 do
		local exchangeIcon = UIControls.Image(self, "BgPanel/BtnExchange/Icon" .. i)
		local exchangeTextNum = UIControls.Label(self, "BgPanel/BtnExchange/TextNum" .. i)

		table.insert(self.exchangeCostCom, {
			icon = exchangeIcon,
			text = exchangeTextNum
		})
	end
end

function HeroGrowBecomeLeaderDlg:onBtnCloseClick()
	self:setVisible(false)
end

local function jumpToRearHouse(self)
	RPC.heroExchange(self.priestHero.gid, self.recHero.gid, self.openSwapEquip, self.canSwapArtifact, self.openSwapStep)

	if CurAvatar.rearHouseState.unlock_award == 0 then
		RPC.houseUnlockAwardGet()
	end

	GameFsm.translateState(Const.STATE_MAIN_REAR_HOUSE)
end

local function onlyExchange(self)
	RPC.heroExchange(self.priestHero.gid, self.recHero.gid, self.openSwapEquip, self.canSwapArtifact, self.openSwapStep)
end

function HeroGrowBecomeLeaderDlg:onBtnExchangeClick()
	if self.btnLock then
		return
	end

	if not self.priestHero then
		MsgManager.clientNotice(312)

		return
	end

	if not self.toggleStep then
		self.openSwapStep = self.defaultSwapStep
	end

	if self.lackMaterialId and self.lackMaterialId ~= 0 then
		local tempItem = BaseObject.GetObject(self.lackMaterialId)

		MsgManager.notice(string.format(Lang.get(30029), tempItem.name))

		return
	end

	if self.recHero:isCrystalSlot() then
		local msgContent = ResClientNotice[304].notice

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, Slot(jumpToRearHouse, self), Slot(onlyExchange, self), -1)
	else
		RPC.heroExchange(self.priestHero.gid, self.recHero.gid, self.openSwapEquip, self.canSwapArtifact, self.openSwapStep)
	end

	self.btnLock = true
end

function HeroGrowBecomeLeaderDlg:setExchangeHeros(priestHero, recHero)
	self:setPriestHero(priestHero)
	self:setRecHero(recHero)
	self:refreshCanSwapStep()
	self:refreshArtifactCanSwap()
	self:refreshCostMaterial()
end

function HeroGrowBecomeLeaderDlg:setPriestHero(priestHero)
	self.priestHero = priestHero

	self.priestWearingPanel:setHero(self.priestHero)
end

function HeroGrowBecomeLeaderDlg:setRecHero(recHero)
	self.recHero = recHero

	self.recWearingPanel:setHero(self.recHero)
end

function HeroGrowBecomeLeaderDlg:refreshCanSwapStep()
	if self.priestHero.step > self.recHero.step then
		self.cantStepResetReason = CurAvatar:canResetStep(self.priestHero)
	else
		self.cantStepResetReason = CurAvatar:canResetStep(self.recHero)
	end

	self.canSwapStep = 0
	self.openSwapStep = 0
	self.defaultSwapStep = 0

	if #self.cantStepResetReason == 0 and self.priestHero.step ~= self.recHero.step and self.priestHero.career == self.recHero.career then
		self.canSwapStep = 1

		if self.priestHero.step > self.recHero.step then
			self.openSwapStep = 1
			self.defaultSwapStep = 1
		end
	end
end

function HeroGrowBecomeLeaderDlg:refreshArtifactCanSwap()
	self.priestArtifact = self.priestHero:getArtifact()
	self.recArtifact = self.recHero:getArtifact()
	self.canSwapArtifact = 1
	self.openSwapEquip = 1
	self.canSwapEquip = 1

	self.priestWearingPanel.imgLockArtifact:setVisible(false)
	self.recWearingPanel.imgLockArtifact:setVisible(false)

	if self.priestArtifact or self.recArtifact then
		if self.priestArtifact and not self.priestArtifact:canBeWear(self.recHero) then
			self.priestWearingPanel.imgLockArtifact:setVisible(true)
			self.recWearingPanel.imgLockArtifact:setVisible(true)

			self.canSwapArtifact = 0
		end

		if self.recArtifact and not self.recArtifact:canBeWear(self.priestHero) then
			self.priestWearingPanel.imgLockArtifact:setVisible(true)
			self.recWearingPanel.imgLockArtifact:setVisible(true)

			self.canSwapArtifact = 0
		end
	else
		self.canSwapArtifact = 0
	end

	local priestHaveEquips = self.priestHero:getEquips() ~= nil and utils.getTableElemCount(self.priestHero:getEquips()) > 0
	local recHaveEquips = self.recHero:getEquips() ~= nil and utils.getTableElemCount(self.recHero:getEquips()) > 0

	if self.canSwapArtifact == 0 and not priestHaveEquips and not recHaveEquips then
		self.openSwapEquip = 0
		self.canSwapEquip = 0
	end
end

function HeroGrowBecomeLeaderDlg:refreshCostMaterial()
	if not self.priestHero or not self.recHero then
		return
	end

	self.costMaterialList = {}

	local costId = ResHeroResetMisc[1].consume[1].id
	local costNum = ResHeroResetMisc[1].consume[1].num

	if self.openSwapStep == 1 then
		costNum = costNum + ResHeroResetMisc[2].consume[1].num
	end

	table.insert(self.costMaterialList, {
		id = costId,
		num = costNum
	})

	for _, costCom in ipairs(self.exchangeCostCom) do
		costCom.icon:setVisible(false)
		costCom.text:setVisible(false)
	end

	self.lackMaterialId = 0

	for i, costInfo in ipairs(self.costMaterialList) do
		self.exchangeCostCom[i].icon:setVisible(true)
		self.exchangeCostCom[i].text:setVisible(true)

		local costId = costInfo.id
		local costNum = costInfo.num
		local haveNum = ClientUtils.getMoney(costId)

		self.exchangeCostCom[i].text:setText(ClientUtils.getNumShortStr(costNum))

		if haveNum < costNum then
			self.exchangeCostCom[i].text:setFontColor(ResColor.RED)

			self.lackMaterialId = costId
		else
			self.exchangeCostCom[i].text:setFontColor(ResColor.WHITE)
		end

		local moneyInfo = UIConst.MONEY_ID2INFO[costId]

		if moneyInfo then
			self.exchangeCostCom[i].icon:setImage(moneyInfo[1], moneyInfo[2])
		else
			local tempItem = BaseObject.GetObject(costId)
			local iconPath = tempItem:getIconPath()

			if iconPath then
				self.exchangeCostCom[i].icon:setImage(iconPath[1], iconPath[2])
			end
		end
	end
end

return HeroGrowBecomeLeaderDlg
