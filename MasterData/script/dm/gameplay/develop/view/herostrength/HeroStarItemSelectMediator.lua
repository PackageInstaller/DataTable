-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStarItemSelectMediator.lua

HeroStarItemSelectMediator = class("HeroStarItemSelectMediator", DmPopupViewMediator, _M)

HeroStarItemSelectMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.rNode.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickR"
	},
	["main.srNode.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickSR"
	},
	["main.ssrNode.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickSSR"
	},
	["main.spNode.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickSP"
	},
	["main.ownNode.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickOwn"
	},
	["main.stiveNode.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickStive"
	}
}

function HeroStarItemSelectMediator:initialize()
	super.initialize(self)
end

function HeroStarItemSelectMediator:dispose()
	super.dispose(self)
end

function HeroStarItemSelectMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)

	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onOkClicked, self)
		},
		title = Strings:get("Equip_UI75"),
		title1 = Strings:get("Equip_UI85"),
		bgSize = {
			width = 757,
			height = 473
		}
	})
	self._sureWidget = self:bindWidget("main.okBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickSure, self)
		}
	})
	self._quickWidget = self:bindWidget("main.cancelBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onOkClicked, self)
		}
	})
end

function HeroStarItemSelectMediator:enterWithData()
	self:initData()
	self:initView()
	self:refreshView()
end

function HeroStarItemSelectMediator:initData()
	self._selectData = {}

	local value = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kHeroQuickSelectKey)

	if value ~= "" then
		local valueTemp = string.split(value, "&")

		for i = 1, #valueTemp do
			local keys = string.split(valueTemp[i], "_")

			self._selectData[keys[1]] = keys[2]
		end
	end
end

function HeroStarItemSelectMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._rNode = self._main:getChildByFullName("rNode")
	self._srNode = self._main:getChildByFullName("srNode")
	self._ssrNode = self._main:getChildByFullName("ssrNode")
	self._spNode = self._main:getChildByFullName("spNode")
	self._ownNode = self._main:getChildByFullName("ownNode")
	self._stiveNode = self._main:getChildByFullName("stiveNode")
end

function HeroStarItemSelectMediator:refreshView()
	self:resetSelectView(self._rNode, self._selectData["12"])
	self:resetSelectView(self._srNode, self._selectData["13"])
	self:resetSelectView(self._ssrNode, self._selectData["14"])
	self:resetSelectView(self._spNode, self._selectData["15"])
	self:resetSelectView(self._ownNode, self._selectData.canUseOwn)
	self:resetSelectView(self._stiveNode, self._selectData.canUseStive)
end

function HeroStarItemSelectMediator:resetSelectView(node, state)
	local show = state == "1"

	node:getChildByFullName("btnImage"):setVisible(show)
end

function HeroStarItemSelectMediator:onClickR()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("heroshow_UI37")
	}))

	do return end

	self._selectData["12"] = self._selectData["12"] == "0" and "1" or "0"

	self:resetSelectView(self._rNode, self._selectData["12"])
end

function HeroStarItemSelectMediator:onClickSR()
	self._selectData["13"] = self._selectData["13"] == "0" and "1" or "0"

	self:resetSelectView(self._srNode, self._selectData["13"])
end

function HeroStarItemSelectMediator:onClickSSR()
	self._selectData["14"] = self._selectData["14"] == "0" and "1" or "0"

	self:resetSelectView(self._ssrNode, self._selectData["14"])
end

function HeroStarItemSelectMediator:onClickSP()
	self._selectData["15"] = (self._selectData["15"] == nil or self._selectData["15"] == "0") and "1" or "0"

	self:resetSelectView(self._spNode, self._selectData["15"])
end

function HeroStarItemSelectMediator:onClickOwn()
	self._selectData.canUseOwn = self._selectData.canUseOwn == "0" and "1" or "0"

	self:resetSelectView(self._ownNode, self._selectData.canUseOwn)
end

function HeroStarItemSelectMediator:onClickStive()
	self._selectData.canUseStive = self._selectData.canUseStive == "0" and "1" or "0"

	self:resetSelectView(self._stiveNode, self._selectData.canUseStive)
end

function HeroStarItemSelectMediator:onClickSure()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Equip_UI74")
	}))

	local str = ""

	for key, value in pairs(self._selectData) do
		str = str == "" and key .. "_" .. value or str .. "&" .. key .. "_" .. value
	end

	cc.UserDefault:getInstance():setStringForKey(UserDefaultKey.kHeroQuickSelectKey, str)
	self._heroSystem:resetHeroQuickSelect()
	self:close()
end

function HeroStarItemSelectMediator:onOkClicked()
	self:close()
end
