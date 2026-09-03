-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubDonationMediator.lua

ClubDonationMediator = class("ClubDonationMediator", DmPopupViewMediator, _M)

ClubDonationMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
ClubDonationMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function ClubDonationMediator:initialize()
	super.initialize(self)
end

function ClubDonationMediator:dispose()
	super.dispose(self)
end

function ClubDonationMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("mainpanel")
	self._bagSystem = self._developSystem:getBagSystem()
end

function ClubDonationMediator:enterWithData(data)
	if data then
		self._pointId = data.pointId or nil
	end

	if data then
		self._techId = data.techId or nil
	end

	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBDONATE_SUCC, self, self.refreshView)
	self:setUpView()
end

function ClubDonationMediator:setUpView()
	self._cellPanel = self:getView():getChildByName("pointcell")

	self._cellPanel:setVisible(false)
	self:refreshView()
end

function ClubDonationMediator:refreshView()
	self:refreshTopView()
	self:createDonationView()
end

function ClubDonationMediator:refreshTopView()
	self._pointData = self._clubSystem:getTechPoint(self._techId, self._pointId)

	if self._pointData then
		local bgNode = self._main:getChildByFullName("bg")
		local widget = self:bindWidget(bgNode, PopupNormalWidget, {
			bg = "bg_popup_dark.png",
			ignoreBtnBg = true,
			btnHandler = {
				clickAudio = "Se_Click_Close_1",
				func = bind1(self.onClickBack, self)
			},
			title = self._pointData:getName(),
			title1 = Strings:get("UITitle_EN_Jieshedengjitisheng"),
			bgSize = {
				width = 837.8,
				height = 592
			}
		})
		local levelLabel = self._main:getChildByName("level")
		local lineGradiantVecLevel = {
			{
				ratio = 0.6,
				color = cc.c4b(255, 255, 255, 255)
			},
			{
				ratio = 1,
				color = cc.c4b(129, 118, 113, 255)
			}
		}

		levelLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVecLevel, {
			x = 0,
			y = -1
		}))
		levelLabel:enableOutline(cc.c4b(0, 0, 0, 255), 1)

		local progressBar = self._main:getChildByName("progbackimg")
		local progrLoading = progressBar:getChildByFullName("loadingbar")
		local proLabel = progressBar:getChildByName("Text_pro")

		proLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVecLevel, {
			x = 0,
			y = -1
		}))
		proLabel:enableOutline(cc.c4b(0, 0, 0, 255), 1)

		local pointLevel = self._pointData:getLevel()

		if pointLevel < self._pointData:getMaxLevel() then
			levelLabel:setString("Lv." .. pointLevel)
		else
			levelLabel:setString(Strings:get("Club_Contribute_UI2"))
			proLabel:setVisible(false)
		end

		local percent = self._pointData:getExp() / self._pointData:getUpgradeExp() * 100
		local curExp = self._pointData:getExp()

		if pointLevel == self._pointData:getMaxLevel() then
			percent = 100
			curExp = self._pointData:getUpgradeExp()
		end

		progrLoading:setPercent(percent)
		proLabel:setString(curExp .. "/" .. self._pointData:getUpgradeExp())
	end

	local todayNum = self._main:getChildByName("todaynum")
	local curCount = self._clubSystem:getClub():getCurDonateCount()

	todayNum:setString(curCount .. "/" .. self._clubSystem:getMaxDonateCount())

	local lineGradiantVecNum = {
		{
			ratio = 0.6,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}

	todayNum:enablePattern(cc.LinearGradientPattern:create(lineGradiantVecNum, {
		x = 0,
		y = -1
	}))
	todayNum:enableOutline(cc.c4b(0, 0, 0, 255), 1)

	local lineGradiantVec2 = {
		{
			ratio = 0.6,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}

	todayNum:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	todayNum:enableOutline(cc.c4b(0, 0, 0, 255), 1)
end

local posMap = {
	{
		width = 276,
		basePosX = 275
	},
	{
		width = 340,
		basePosX = 583
	}
}

function ClubDonationMediator:createDonationView()
	local donationList = self._pointData:getDonationList()
	local newList = {}

	for i = 1, #donationList do
		local donationData = donationList[i]
		local vipLimit = donationData:getVipLimit()

		if self._clubSystem:isDonationPointUnlock(vipLimit) then
			newList[#newList + 1] = donationData
		end
	end

	for i = 1, #newList do
		local donationData = newList[i]
		local cellClone = self._cellPanel:clone()

		cellClone:setVisible(true)

		local bgImg = cellClone:getChildByName("bg")
		local ImageIcon = cellClone:getChildByName("Image_Icon")

		ImageIcon:loadTexture(donationData:getBoardIcon() .. ".png", ccui.TextureResType.plistType)

		local expLabel = cellClone:getChildByName("expnum")

		expLabel:setString(donationData:getClubExp())

		local lineGradiantVec2 = {
			{
				ratio = 0.6,
				color = cc.c4b(255, 255, 255, 255)
			},
			{
				ratio = 1,
				color = cc.c4b(129, 118, 113, 255)
			}
		}

		expLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
			x = 0,
			y = -1
		}))
		expLabel:enableOutline(cc.c4b(0, 0, 0, 255), 1)

		local rewardData = ConfigReader:getRecordById("Reward", donationData:getReward()).Content
		local num = 0

		for i = 1, #rewardData do
			local reward = rewardData[i]

			if reward.code == CurrencyIdKind.kClub then
				num = reward.amount
			end
		end

		local iconNumLabel = cellClone:getChildByName("iconnum")

		iconNumLabel:setString(num)
		iconNumLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
			x = 0,
			y = -1
		}))
		iconNumLabel:enableOutline(cc.c4b(0, 0, 0, 255), 1)

		local costIcon = cellClone:getChildByName("Button_donate"):getChildByName("costIcon")
		local icon = IconFactory:createPic({
			id = donationData:getType()
		}, {
			largeIcon = false
		})

		icon:setScale(1)
		icon:addTo(costIcon):center(costIcon:getContentSize())

		local cellTitle = cellClone:getChildByName("title")
		local exptext = cellClone:getChildByName("exptext")
		local clubIcon = cellClone:getChildByName("clubIcon")
		local imgBg = cellClone:getChildByName("imgBg")

		if donationData:getType() == CurrencyIdKind.kGold then
			cellTitle:setString(Strings:get("GoldDonationName"))
		elseif donationData:getType() == CurrencyIdKind.kDiamond then
			cellTitle:setString(Strings:get("DiamondDonationName"))
		end

		local demandNum = donationData:getDemand() .. " "
		local donateText = Strings:get("Club_Contribute_UI6")
		local donateBtn = cellClone:getChildByName("Button_donate")
		local text = donateBtn:getChildByName("titlelabel")

		text:setString(demandNum .. donateText)
		donateBtn:setTouchEnabled(true)

		local function callFunc(sender, eventType)
			self:onDonateClick(donationData)
		end

		mapButtonHandlerClick(nil, donateBtn, {
			ignoreClickAudio = true,
			func = callFunc
		})

		local engoughSta = self._bagSystem:checkCostEnough(donationData:getType(), donationData:getDemand(), {
			notShowTip = true
		})

		cellClone:setPosition(posMap[i].basePosX, 80)
		self._main:removeChildByTag(1000 + i, true)
		cellClone:setTag(1000 + i)
		cellClone:addTo(self._main)
		donateBtn:getChildByName("name1"):setString(Strings:get("UITitle_EN_Juanxian"))
	end
end

function ClubDonationMediator:onDonateClick(donationData)
	if self._clubSystem:getClub():getCurDonateCount() < 1 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Contribute_Tip1")
		}))

		return
	end

	local cost = donationData:getDemand()
	local costType = donationData:getType()

	if not self._bagSystem:checkCostEnough(costType, cost, {
		type = "tip"
	}) then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if costType == CurrencyIdKind.kGold then
		AudioEngine:getInstance():playEffect("Se_Alert_Sell", false)
	elseif costType == CurrencyIdKind.kDiamond then
		AudioEngine:getInstance():playEffect("Se_Alert_Recharge", false)
	else
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end

	self._clubSystem:requestClubDonate(self._techId, self._pointId, donationData:getId())
end

function ClubDonationMediator:onClickBack(sender, eventType)
	self:close()
end
