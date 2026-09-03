-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/FleeInfoWidget.lua

FleeInfoWidget = class("FleeInfoWidget", BattleWidget, _M)

function FleeInfoWidget:initialize(view)
	super.initialize(self, view)
	self:_setupView(view)
end

function FleeInfoWidget:_setupView(view)
	self._label = view:getChildByFullName("label"):posite(10)

	view:setVisible(false)
end

function FleeInfoWidget:shine()
	local view = self:getView()

	view:setVisible(true)
	view:stopAllActions()
	view:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeIn:create(0.5), cc.DelayTime:create(0.5), cc.FadeOut:create(0.5))))
end

function FleeInfoWidget:init(info)
	self:shine()

	self._fleeNum = info.count
	self._unitTag = info.unitTag

	self:refreshFleeNum()
end

function FleeInfoWidget:reduceNum(cellId, flags)
	if cellId < 0 and flags then
		for k, v in pairs(flags) do
			if v == self._unitTag then
				self._fleeNum = self._fleeNum - 1

				self:refreshFleeNum()

				return
			end
		end
	end
end

function FleeInfoWidget:refreshFleeNum()
	self._label:setString(Strings:get("BATTLE_ESCAPE_COUNT", {
		num = self._fleeNum
	}))
end
