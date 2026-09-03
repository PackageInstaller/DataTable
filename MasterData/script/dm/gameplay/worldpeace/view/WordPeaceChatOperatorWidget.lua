-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceChatOperatorWidget.lua

WordPeaceChatOperatorWidget = class("WordPeaceChatOperatorWidget", ChatOperatorWidget, _M)

function WordPeaceChatOperatorWidget:initialize(view)
	super.initialize(self, view)
end

function WordPeaceChatOperatorWidget:bindWidgets()
	mapButtonHandlerClick(self, "main_panel.btn_emoji", {
		clickAudio = "Se_Click_Common_2",
		func = "onClickEmoji"
	})
	bindWidget(self, "main_panel.btn_send", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickSend, self)
		}
	})
end
