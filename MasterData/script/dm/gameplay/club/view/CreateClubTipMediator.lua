-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/CreateClubTipMediator.lua

CreateClubTipMediator = class("CreateClubTipMediator", DmPopupViewMediator, _M)

CreateClubTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CreateClubTipMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
CreateClubTipMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["main.iconchangebtn"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onChangeIconClicked"
	},
	["main.createbtn"] = {
		ignoreClickAudio = true,
		func = "onClickCreate"
	}
}
local defaultClubIconId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_DefaultIcon", "content")
local createPriceConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Create_Price", "content")
local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Name_Limited", "content")
local clubIconList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Icon", "content")
local levelNeed = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Club_Create_Level", "content")

function CreateClubTipMediator:initialize()
	super.initialize(self)
end

function CreateClubTipMediator:dispose()
	super.dispose(self)
end

function CreateClubTipMediator:userInject()
	return
end

function CreateClubTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local injector = self:getInjector()
	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "paihangbang_bg_di_4.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Club_Text10"),
		title1 = Strings:get("UITitle_EN_Chuangjianjieshe"),
		bgSize = {
			width = 837,
			height = 512
		}
	})
end

function CreateClubTipMediator:closeView(event)
	self:close()
end

function CreateClubTipMediator:enterWithData()
	self._iconId = defaultClubIconId
	self._bagSystem = self._developSystem:getBagSystem()
	self._main = self:getView():getChildByFullName("main")

	self:createTextFiled()
	self:createClubIcon()
	self:refreshCostPanel()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_CREATECLUB_SUCC, self, self.closeView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_REFRESHCLUBINFO_SUCC, self, self.closeView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHBYGOLDORDIMOND_SUCC, self, self.refreshCostPanel)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_CREATE_FAILED, self, self.refreshTextFiledName)
end

function CreateClubTipMediator:createTextFiled()
	self._textFiledBackImg = self._main:getChildByName("backimg")
	self._main.originPos = cc.p(self._main:getPosition())

	local pos = self._main:convertToWorldSpace(cc.p(0, 0))

	self._main.worldPositionY = pos.y
	self._inPutStr = ""
	self._editBox = self._textFiledBackImg:getChildByName("textfiled")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setPlaceHolder(Strings:get("Club_Text12"))
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
		self._editBox:setString("")
	end

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.NAME)

	self._editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			-- block empty
		elseif eventName == "ended" then
			local state, finalString = StringChecker.checkString(self._editBox:getText(), MaskWordType.NAME)

			if state == StringCheckResult.AllOfCharForbidden then
				self._inPutStr = ""

				self._editBox:setText("")
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Input_Tip2")
				}))
			end
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

function CreateClubTipMediator:createClubIcon()
	local iconPanel = self._main:getChildByFullName("iconpanel")

	iconPanel:removeAllChildren()

	local icon = IconFactory:createClubIcon({
		id = self._iconId
	}, {
		isWidget = true
	})

	IconFactory:bindClickAction(icon, function()
		AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)

		return self:onChangeClubIconClicked()
	end)
	icon:addTo(iconPanel):center(iconPanel:getContentSize())
end

function CreateClubTipMediator:refreshCostPanel()
	local createbtn = self._main:getChildByFullName("createbtn")
	local costIcon = createbtn:getChildByFullName("money_icon")

	costIcon:removeAllChildren()

	local createPriceMap = createPriceConfig[1]
	local iconImg = IconFactory:createPic({
		id = createPriceMap.id
	})

	iconImg:addTo(costIcon):center(costIcon:getContentSize())

	local costLabel = createbtn:getChildByFullName("money_text")

	costLabel:setString(createPriceMap.amount)

	self._dimondEngouh = self._bagSystem:getDiamond() >= createPriceMap.amount

	if self._dimondEngouh then
		local var_11_0 = GameStyle:getColor(1)

		if not var_11_0 then
			var_11_0 = GameStyle:getColor(6)

			local color = var_11_0

			costLabel:setColor(color)

			local width = iconImg:getContentSize().width + costLabel:getContentSize().width

			createbtn:getChildByName("Text_create"):setString(Strings:get("Club_TextChuangjian"))
			createbtn:getChildByName("name1"):setString(Strings:get("UITitle_EN_Chuangjian"))
		end
	end
end

function CreateClubTipMediator:refreshTextFiledName()
	self._inPutStr = self._editBox:getText()
end

function CreateClubTipMediator:onClickCreate(sender, eventType)
	if self._inPutStr == "" then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Club_Text166")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

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
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local condition = {
		STAGE = levelNeed.STAGE
	}
	local isOpen, lockTip, unLockLevel = self._systemKeeper:isUnlockByCondition(condition)

	if not isOpen then
		self:dispatch(ShowTipEvent({
			tip = lockTip
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._bagSystem:checkCostEnough(CurrencyIdKind.kDiamond, createPriceConfig[1].amount, {
		type = "tip"
	}) then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)
	self._clubSystem:createClub(self._inPutStr, self._iconId, function()
		local clubSystem = self._clubSystem
		local delegate, outSelf = {}, self

		function delegate:willClose(popupMediator, data)
			outSelf:close()
			outSelf:dispatch(Event:new(EVT_CLUB_CREATECLUB_SUCC))
		end

		local nameStr = self._clubSystem:getName()
		local data = {
			playSound = 1,
			enabled = true,
			richTextStr = Strings:get("Club_Text92", {
				clubname = nameStr,
				fontName = TTF_FONT_FZYH_R
			}),
			btnCancelDate = {},
			btnOkDate = {
				callBack = function()
					clubSystem:sendRecruitMsg()
				end
			}
		}
		local view = self:getInjector():getInstance("ClubWaringTipView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	end)
end

function CreateClubTipMediator:onCloseClicked(sender, eventType)
	self:close()
end

function CreateClubTipMediator:onChangeIconClicked(sender, eventType)
	self:onChangeClubIconClicked()
end

function CreateClubTipMediator:onChangeClubIconClicked(sender, eventType)
	local delegate, outSelf = {}, self

	function delegate:willClose(popupMediator, data)
		if type(data) == "table" then
			outSelf._iconId = clubIconList[data.index].id

			outSelf:createClubIcon()
		end
	end

	local view = self:getInjector():getInstance("ClubIconSelectTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}, delegate))
end
