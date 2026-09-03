-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/view/CrusadeSweepTipMediator.lua

CrusadeSweepTipMediator = class("CrusadeSweepTipMediator", DmPopupViewMediator, _M)

CrusadeSweepTipMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")

local kBtnHandlers = {}

function CrusadeSweepTipMediator:initialize()
	super.initialize(self)
end

function CrusadeSweepTipMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function CrusadeSweepTipMediator:onRemove()
	super.onRemove(self)
end

function CrusadeSweepTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._cancelBtn = self:bindWidget("main.btn_cancel", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Cancle",
			func = bind1(self.onCancelClicked, self)
		}
	})
	self._sureBtn = self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onOKClicked, self)
		}
	})

	local bgNode = self._main:getChildByFullName("bg")
	local tempNode = bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Crusade_UI19"),
		title1 = Strings:get("Crusade_UI19_EN")
	})
end

function CrusadeSweepTipMediator:userInject()
	return
end

function CrusadeSweepTipMediator:enterWithData(data)
	self._data = data

	self:setUi()
end

function CrusadeSweepTipMediator:setUi()
	local name1 = self._main:getChildByFullName("name1")
	local name2 = self._main:getChildByFullName("name2")

	name1:setString(self._data.name1)
	name2:setString(self._data.name2)
	GameStyle:setQualityText(name1, self._data.quality1, true)
	GameStyle:setQualityText(name2, self._data.quality2, true)
end

function CrusadeSweepTipMediator:onCancelClicked(sender, eventType)
	self:close()
end

function CrusadeSweepTipMediator:onOKClicked(sender, eventType)
	self._crusadeSystem:requestCrusadeWipe(function(data)
		if DisposableObject:isDisposed(self) then
			return
		end

		self._crusadeSystem:showCrusadeSweepResultView(data)
		self:close()
	end)
end

function CrusadeSweepTipMediator:onCloseClicked(sender, eventType)
	self:close()
end
