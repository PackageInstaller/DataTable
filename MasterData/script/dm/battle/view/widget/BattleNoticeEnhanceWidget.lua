-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleNoticeEnhanceWidget.lua

BattleNoticeEnhanceWidget = class("BattleNoticeEnhanceWidget", BattleWidget, _M)

function BattleNoticeEnhanceWidget:initialize(view)
	super.initialize(self, view)
	self:_setupView()
end

function BattleNoticeEnhanceWidget:dispose()
	super.dispose(self)
end

function BattleNoticeEnhanceWidget:_setupView()
	local text = Strings:get("ClassArena_UI86", {
		fontSize = 20,
		Time = 111,
		NUM = 222,
		fontName = TTF_FONT_FZYH_R
	})
	local richText = ccui.RichText:createWithXML(text, {})

	richText:addTo(self._view)

	self._tips = richText

	self._tips:setVisible(false)
end

function BattleNoticeEnhanceWidget:active(arg1, arg2)
	self.arg1 = arg1
	self.arg2 = arg2

	self:show()
	self:showDetail()
end

function BattleNoticeEnhanceWidget:showDetail()
	self._tips:setVisible(true)
	self._tips:setString(Strings:get("ClassArena_UI86", {
		fontSize = 20,
		Time = self.arg1,
		NUM = self.arg2,
		fontName = TTF_FONT_FZYH_R
	}))
end

function BattleNoticeEnhanceWidget:hide()
	self:getView():setVisible(false)
end

function BattleNoticeEnhanceWidget:show()
	self:getView():setVisible(true)
end
