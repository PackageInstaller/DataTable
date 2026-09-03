-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceShoutMediator.lua

PetRaceShoutMediator = class("PetRaceShoutMediator", DmPopupViewMediator)

PetRaceShoutMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {
	["Panel_base.Node_choose.Button_choose4"] = "onClickButtonChoose4",
	["Panel_base.Node_choose.Button_choose2"] = "onClickButtonChoose2",
	["Panel_base.Node_choose.Button_choose1"] = "onClickButtonChoose1",
	["Panel_base.Node_choose.Button_choose3"] = "onClickButtonChoose3"
}

function PetRaceShoutMediator:initialize()
	super.initialize(self)
end

function PetRaceShoutMediator:dispose()
	super.dispose(self)
end

function PetRaceShoutMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("Panel_base.Button_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickOK, self)
		}
	})
end

function PetRaceShoutMediator:enterWithData(data)
	self:setupView()
	self:setTextField()
end

function PetRaceShoutMediator:setTextField()
	self._editBox = self:getView():getChildByFullName("Panel_base.TextField_input")

	local talkLimit = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "KOF_TalkLimit", "content")

	self._editBox:setMaxLength(talkLimit)

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.CHAT)

	self._editBox:getContentLabel():enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._editBox:setText(Strings:get("Tips_WordNumber_Limit", {
		number = talkLimit
	}))
	self._editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			self._editBox:setText("")
			self:hideAllButtonChoose()
		elseif eventName == "ended" then
			-- block empty
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			-- block empty
		elseif eventName == "ForbiddenWord" then
			self:getEventDispatcher():dispatchEvent(ShowTipEvent({
				tip = Strings:get("Common_Tip1")
			}))
		elseif eventName == "Exceed" then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_WordNumber_Limit", {
					number = talkLimit
				})
			}))
		end
	end)
end

function PetRaceShoutMediator:setupView()
	local bgNode = self:getView():getChildByFullName("Panel_base.tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onBackClicked, self)
		},
		title = Strings:get("Petrace_Text_38"),
		title1 = Strings:get("UITitle_EN_Hanhua"),
		bgSize = {
			width = 840,
			height = 500
		}
	})

	self._mainPanel = self:getView():getChildByFullName("Panel_base")
end

function PetRaceShoutMediator:onClickOK()
	local response = {}

	response.content = self._editBox:getText()
	response.isSelf = true

	local talkLimit = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "KOF_TalkLimit", "content")
	local str = Strings:get("Tips_WordNumber_Limit", {
		number = talkLimit
	})

	if response.content and #response.content > 0 and response.content ~= str then
		self:dispatch(Event:new(EVT_PETRACE_SHOUT_PUSH, {
			response = response
		}))
		self._petRaceSystem:shout({
			content = response.content
		}, true)
	end

	self:close()
end

function PetRaceShoutMediator:onClickButtonChoose1()
	self:hideAllButtonChoose(1)
end

function PetRaceShoutMediator:onClickButtonChoose2()
	self:hideAllButtonChoose(2)
end

function PetRaceShoutMediator:onClickButtonChoose3()
	self:hideAllButtonChoose(3)
end

function PetRaceShoutMediator:onClickButtonChoose4()
	self:hideAllButtonChoose(4)
end

function PetRaceShoutMediator:hideAllButtonChoose(showIndex)
	for index = 1, 4 do
		local buttonName = "Panel_base.Node_choose.Button_choose" .. tostring(index)
		local button = self:getView():getChildByFullName(buttonName)
		local des = button:getChildByFullName("Text_des")
		local image_stateY = button:getChildByFullName("Image_stateY")
		local image_stateN = button:getChildByFullName("Image_stateN")

		image_stateY:setVisible(true)

		if showIndex and showIndex == index then
			image_stateN:setVisible(true)

			local str = des:getString()

			self._editBox:setText(str)
		else
			image_stateN:setVisible(false)
		end
	end
end

function PetRaceShoutMediator:onBackClicked(sender, eventType)
	self:close()
end
