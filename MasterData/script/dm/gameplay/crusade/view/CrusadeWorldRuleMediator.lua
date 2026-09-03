-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/view/CrusadeWorldRuleMediator.lua

CrusadeWorldRuleMediator = class("CrusadeWorldRuleMediator", DmAreaViewMediator, _M)

CrusadeWorldRuleMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")
CrusadeWorldRuleMediator:has("_crusade", {
	is = "r"
}):injectWith("Crusade")

function CrusadeWorldRuleMediator:initialize()
	super.initialize(self)
end

function CrusadeWorldRuleMediator:dispose()
	super.dispose(self)
end

function CrusadeWorldRuleMediator:onRegister()
	super.onRegister(self)
	self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickBack, self)
		}
	})
end

function CrusadeWorldRuleMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:getView():getChildByFullName("main.Text_desc"):setLineSpacing(25)
end

function CrusadeWorldRuleMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Crusade_Tips_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function CrusadeWorldRuleMediator:onClickBack(sender, eventType)
	self:dismiss()
end
