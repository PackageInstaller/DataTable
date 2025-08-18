-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\StepUpChild.lua

local ResStepCost = require("ClientData/ResStepCost")
local ResColor = require("ClientData/ResColor")
local MaterialItemGridChild = require("UI/Common/Grid/MaterialItemGridChild")
local ResItem = require("ClientData/ResItem")
local ResClientNotice = require("ClientData/ResClientNotice")
local strClassName = "StepUpChild"
local StepUpChild = Class(strClassName, UIControls.Child)

function StepUpChild:ctor()
	self:initUI()
end

function StepUpChild:initUI()
	self.btnStepUpgrade = UIControls.Button(self, "BtnUpgrade")

	self.btnStepUpgrade:addEventClick(self.onBtnStepUpgradeClick)

	self.btnClean = UIControls.Button(self, "BtnClean")

	self.btnClean:addEventClick(self.onBtnCleanClick)

	self.imgUpgradeNew = UIControls.Image(self, "BtnUpgrade/IconNew")
	self.imgCleanNew = UIControls.Image(self, "BtnClean/IconNew")
	self.imgGoldIcon = UIControls.Image(self, "BtnUpgrade/TextNum/IconMoney")
	self.txtNeedGold = UIControls.Label(self, "BtnUpgrade/TextNum")
	self.txtTaste = UIControls.Label(self, "BtnUpgrade/Text")
	self.txtEng = UIControls.Label(self, "BtnUpgrade/TextEng")
	self.txtCleanTaste = UIControls.Label(self, "BtnClean/Text")
	self.txtCleanEng = UIControls.Label(self, "BtnClean/TextEng")
	self.txtCleanNum = UIControls.Label(self, "BtnClean/TextNum")
	self.imgCleanIcon = UIControls.Image(self, "BtnClean/TextNum/IconMoney")
	self.stepMaterialGridList = {}
end

function StepUpChild:setHero(hero, step, showBtn)
	self.hero = hero
	self.step = step

	self.btnStepUpgrade:setVisible(showBtn)
	self.btnClean:setVisible(false)
	self:refreshStepMaterialInfo()
	self:checkStageUpGold()

	if #self.lackInfo == 0 then
		self.imgUpgradeNew:setVisible(true)
		self.btnStepUpgrade:setObjGray(false)
		self.txtTaste:setFontColor(ResColor.WHITE)
		self.txtEng:setFontColor(ResColor.BLUE)
	else
		self.imgUpgradeNew:setVisible(false)
		self.btnStepUpgrade:setObjGray(true)
		self.txtTaste:setFontColor(ResColor.GREYLIGHT)
		self.txtEng:setFontColor(ResColor.GREYLIGHT)

		if showBtn then
			local enoughToSweep = CurAvatar and CurAvatar:checkHeroCanSweepTowerAndPowerEnough(self.hero)

			if CurAvatar and CurAvatar:checkHeroCanSweepTower(self.hero) or enoughToSweep then
				self.btnStepUpgrade:setVisible(false)
				self.btnClean:setVisible(true)

				if self.btnLock then
					self.btnLock = nil
				end

				local moneyInfo = ClientUtils.getMoneyIcon(Const.MONEY_ID_POWER)

				if moneyInfo then
					self.imgCleanIcon:setImage(moneyInfo[1], moneyInfo[2])
				end

				self.powerLimit = CurAvatar:getHeroStepUpNeedPower(hero)

				local realNeedPower = CurAvatar:getHeroStepUpNeedPower(hero, nil, true)

				self.txtCleanNum:setText(realNeedPower)

				if CurAvatar and enoughToSweep then
					self.imgCleanNew:setVisible(true)
					self.btnClean:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnCommonFir00Nml")
					self.txtCleanTaste:setFontColor(ResColor.GREYMIDDLE)
					self.txtCleanEng:setFontColor(ResColor.GREYMIDDLE)
					self.txtCleanNum:setFontColor(ResColor.GREYMIDDLE)
				elseif realNeedPower == 0 then
					self.btnClean:setVisible(false)
					self.btnStepUpgrade:setVisible(true)
				else
					self.imgCleanNew:setVisible(false)
					self.btnClean:setImage("Atlas/CommonAtlas/BtnAtlas2", "BtnCommonFir01Dis")
					self.txtCleanTaste:setFontColor(ResColor.GREYLIGHT)
					self.txtCleanEng:setFontColor(ResColor.GREYLIGHT)
					self.txtCleanNum:setFontColor(ResColor.GREYLIGHT)
				end
			else
				self.btnClean:setVisible(false)
			end
		else
			self.btnClean:setVisible(false)
		end
	end
end

function StepUpChild:checkStageUpGold()
	if CurAvatar:getMoneyByType(Const.MONEY_TYPE_GOLD) < self.stepCostInfo.gold then
		table.insert(self.lackInfo, ResItem[Const.MONEY_ID_GOLD].name)
		self.txtNeedGold:setFontColor(ResColor.RED)
	elseif #self.lackInfo > 0 then
		self.txtNeedGold:setFontColor(ResColor.GREYLIGHT)
	else
		self.txtNeedGold:setFontColor(ResColor.WHITE)
	end
end

function StepUpChild:refreshStepMaterialInfo()
	self.lackInfo = {}
	self.stepCostInfo = ResStepCost[self.hero.resData.step_up_id][self.step]

	for i, v in ipairs(self.stepCostInfo.materials) do
		if not self.stepMaterialGridList[i] then
			self.stepMaterialGridList[i] = MaterialItemGridChild(self, "MaterialList", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		end

		self.stepMaterialGridList[i].uiConfig = {
			AutoOpenGuide = 1
		}

		local enough = self.stepMaterialGridList[i]:setMaterial(v.id, v.num)

		self.stepMaterialGridList[i].imgAdd2:setVisible(not enough)

		if not enough then
			table.insert(self.lackInfo, Lang.get(30293))

			local addPanelIdx = CurAvatar:getMaterialTowerCanSweep(v.id) and 1 or 2

			self.stepMaterialGridList[i]:setAddPanel(addPanelIdx)
		end

		self.stepMaterialGridList[i].hero = self.hero
	end

	for i = #self.stepCostInfo.materials + 1, #self.stepMaterialGridList do
		self.stepMaterialGridList[i]:destroy()

		self.stepMaterialGridList[i] = nil
	end

	local moneyID = Const.MONEY_TYPE2ID[Const.MONEY_TYPE_GOLD] or 0
	local moneyInfo = UIConst.MONEY_ID2INFO[moneyID]

	if moneyInfo then
		self.imgGoldIcon:setImage(moneyInfo[1], moneyInfo[2])
	end

	self.txtNeedGold:setText(ClientUtils.getNumShortStr(self.stepCostInfo.gold))
end

function StepUpChild:onBtnStepUpgradeClick()
	local function confirmToStepUp()
		self.btnStepUpgrade:setVisible(false)
		RPC.heroStepUp(self.hero.gid)
	end

	if #self.lackInfo == 0 then
		if self.hero.step == Const.HERO_RESET_CLOSE_STEP - 1 then
			local msgContent = ResClientNotice[264].notice

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, confirmToStepUp, nil, -1)
		else
			self.btnStepUpgrade:setVisible(false)
			RPC.heroStepUp(self.hero.gid)
		end
	else
		MsgManager.notice(string.format(Lang.get(30029), self.lackInfo[1]))
	end
end

function StepUpChild:refreshBtnState()
	self:refreshStepMaterialInfo()
	self:checkStageUpGold()

	if #self.lackInfo == 0 then
		self.imgUpgradeNew:setVisible(true)
		self.btnStepUpgrade:setObjGray(false)
		self.txtTaste:setFontColor(ResColor.WHITE)
		self.txtEng:setFontColor(ResColor.BLUE)
	else
		self.imgUpgradeNew:setVisible(false)
		self.btnStepUpgrade:setObjGray(true)
		self.txtTaste:setFontColor(ResColor.GREYLIGHT)
		self.txtEng:setFontColor(ResColor.GREYLIGHT)
	end
end

function StepUpChild:onBtnCleanClick()
	if not self.btnLock then
		if self.powerLimit < 0 then
			MsgManager.clientNotice(293)
		elseif CurAvatar.realPowerNum >= self.powerLimit then
			local layerInfoList = CurAvatar:getStepTowerLayerByHero(self.hero)

			if layerInfoList then
				local sweepDatas = {}

				for _, layerInfo in ipairs(layerInfoList) do
					local sweepData = {}

					sweepData.layer = layerInfo[1]
					sweepData.level = layerInfo[2]
					sweepData.times = layerInfo[4]

					table.insert(sweepDatas, sweepData)

					self.btnLock = true
				end

				RPC.towerSweep(sweepDatas)
			end
		else
			MsgManager.clientNotice(292)
		end
	end
end

return StepUpChild
