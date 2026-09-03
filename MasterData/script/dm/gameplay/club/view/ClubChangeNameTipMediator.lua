-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubChangeNameTipMediator.lua

ClubChangeNameTipMediator = class("ClubChangeNameTipMediator", DmPopupViewMediator, _M)

ClubChangeNameTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubChangeNameTipMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Name_Limited", "content")
local createPriceConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_ChangeName_Price", "content")
local kBtnHandlers = {
	["main.changebtn"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onClickChange"
	}
}

function ClubChangeNameTipMediator:initialize()
	super.initialize(self)
end

function ClubChangeNameTipMediator:dispose()
	super.dispose(self)
end

function ClubChangeNameTipMediator:userInject()
	return
end

function ClubChangeNameTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "paihangbang_bg_di_4.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Club_Text145"),
		title1 = Strings:get("UITitle_EN_Xiugaijiesheming"),
		bgSize = {
			width = 838,
			height = 512
		}
	})
end

function ClubChangeNameTipMediator:enterWithData()
	self._inPutStr = ""
	self._mainPanel = self:getView():getChildByFullName("main")
	self._changebtn = self._mainPanel:getChildByFullName("changebtn")

	local text = self._changebtn:getChildByName("text")

	self._bagSystem = self._developSystem:getBagSystem()
	self._mainPanel.originPos = cc.p(self._mainPanel:getPosition())

	local pos = self._mainPanel:convertToWorldSpace(cc.p(0, 0))

	self._mainPanel.worldPositionY = pos.y

	self:refreshCost()
	self:createTextFiled()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_REFRESHCLUBINFO_SUCC, self, self.closeView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_PUSHPOSITIONCHANGE_SUCC, self, self.closeView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHBYGOLDORDIMOND_SUCC, self, self.refreshCost)

	local Text_create = self._changebtn:getChildByFullName("Text_create")
	local Text_En_Name = self._changebtn:getChildByFullName("name1")

	Text_create:setString(Strings:get("Club_Text65"))
	Text_En_Name:setString(Strings:get("UITitle_EN_Xiugai"))
end

function ClubChangeNameTipMediator:closeView(event)
	self:close()
end

function ClubChangeNameTipMediator:refreshCost()
	local costIcon = self._changebtn:getChildByFullName("money_icon")

	costIcon:removeAllChildren()

	if self._bagSystem:getItemCount("IM_Name_Club") > 0 then
		local iconImg = IconFactory:createResourcePic({
			id = "IM_Name_Club"
		}, {})

		iconImg:addTo(costIcon):center(costIcon:getContentSize())

		local costLabel = self._changebtn:getChildByFullName("money_text")

		costLabel:setString("1")
		costLabel:setPositionX(50 + iconImg:getContentSize().width * 0.5)
	else
		local priceData = createPriceConfig[1]
		local iconImg = IconFactory:createPic({
			id = priceData.id
		})

		iconImg:addTo(costIcon):center(costIcon:getContentSize())

		local costLabel = self._changebtn:getChildByFullName("money_text")

		costLabel:setString(priceData.amount)

		self._dimondEngouh = self._bagSystem:getDiamond() >= priceData.amount

		if self._dimondEngouh then
			local var_7_0 = GameStyle:getColor(1)

			if not var_7_0 then
				var_7_0 = GameStyle:getColor(6)

				local color = var_7_0

				costLabel:setColor(color)

				local width = iconImg:getContentSize().width + costLabel:getContentSize().width
			end
		end
	end
end

function ClubChangeNameTipMediator:createTextFiled()
	self._editBox = self._mainPanel:getChildByName("textfiled")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setPlaceHolder("    " .. Strings:get("Club_Text12"))
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
		self._editBox:setString("")
	end

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.NAME)

	self._editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			-- block empty
		elseif eventName == "ended" then
			-- block empty
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			self._inPutStr = self._editBox:getText()
		elseif eventName == "ForbiddenWord" then
			self:getEventDispatcher():dispatchEvent(ShowTipEvent({
				tip = Strings:get("Common_Tip1")
			}))
		elseif eventName == "Exceed" then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_WordNumber_Limit", {
					number = sender:getMaxLength()
				})
			}))
		end
	end)
end

function ClubChangeNameTipMediator:onClickChange(sender, eventType)
	if self._inPutStr == "" then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text166")
		}))

		return
	end

	local strList = {
		"%s",
		"\\"
	}
	local findSpecialStr = false

	for i = 1, #strList do
		if string.find(self._inPutStr, strList[i]) ~= nil then
			findSpecialStr = true
		end
	end

	if findSpecialStr then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("ClubApplyFind_Text1")
		}))

		self._inPutStr = ""

		self._editBox:setText(self._inPutStr)

		return
	end

	if self._bagSystem:getItemCount("IM_Name_Club") <= 0 and not self._bagSystem:checkCostEnough(CurrencyIdKind.kDiamond, createPriceConfig[1].amount, {
		type = "tip"
	}) then
		return
	end

	self._clubSystem:changeClubName(self._inPutStr, function()
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text146")
		}))
		self:close()
	end)
end

function ClubChangeNameTipMediator:onCloseClicked(sender, eventType)
	self:close()
end
