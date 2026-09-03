-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/EscapeInfoWidget.lua

EscapeInfoWidget = class("EscapeInfoWidget", BattleWidget, _M)

function EscapeInfoWidget:initialize(view)
	super.initialize(self, view)
	self:_setupView(view)
end

function EscapeInfoWidget:_setupView(view)
	self._label = view:getChildByFullName("label"):posite(10)
end

function EscapeInfoWidget:shine()
	self._label:setString(Strings:get("BATTLE_ESCAPE_LABEL"))

	local view = self:getView()

	view:setVisible(true)
	view:stopAllActions()
	view:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeIn:create(0.5), cc.DelayTime:create(0.5), cc.FadeOut:create(0.5))))
end
