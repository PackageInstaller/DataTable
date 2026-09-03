-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/SetSexPopMediator.lua

SetSexPopMediator = class("SetSexPopMediator", DmPopupViewMediator)

local kBtnHandlers = {
	["main.btn_ok.button"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickChoose"
	}
}

function SetSexPopMediator:initialize()
	super.initialize(self)
end

function SetSexPopMediator:dispose()
	super.dispose(self)
end

function SetSexPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._boyCheckBox = self._main:getChildByName("boy")
	self._girlCheckBox = self._main:getChildByName("girl")

	local function boyTouchCallfunc()
		self:onClickCheckBox(1)
	end

	local function girlTouchCallfunc()
		self:onClickCheckBox(2)
	end

	mapButtonHandlerClick(nil, self._main:getChildByName("boyTouch"), {
		ignoreClickAudio = true,
		func = boyTouchCallfunc
	})
	mapButtonHandlerClick(nil, self._main:getChildByName("girlTouch"), {
		ignoreClickAudio = true,
		func = girlTouchCallfunc
	})
	self:bindWidget("main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Tip_SetSex"),
		title1 = Strings:get("UITitle_EN_Xiugaixingbie"),
		bgSize = {
			width = 690,
			height = 408
		},
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	})
	self:bindWidget("main.btn_ok", OneLevelViceButton, {})
end

function SetSexPopMediator:enterWithData(data)
	self._playerGender = data.gender
	self._playerSelectGender = data.gender

	self:enableCheckbox()
end

function SetSexPopMediator:enableCheckbox()
	self._boyCheckBox:setSelected(self._playerSelectGender == 1)
	self._girlCheckBox:setSelected(self._playerSelectGender == 2)
end

function SetSexPopMediator:onClickCheckBox(selectTag)
	self._playerSelectGender = selectTag

	self:enableCheckbox()
end

function SetSexPopMediator:onClickClose(sender, eventType)
	self:close()
end

function SetSexPopMediator:onClickChoose()
	if self._playerGender ~= self._playerSelectGender then
		self:close({
			playerGender = self._playerSelectGender
		})
	else
		self:close()
	end
end
