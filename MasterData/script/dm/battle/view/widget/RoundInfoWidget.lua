-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/RoundInfoWidget.lua

RoundInfoWidget = class("RoundInfoWidget", BattleWidget, _M)

function RoundInfoWidget:initialize(view)
	super.initialize(self, view)
	self:_setupRoundInfo(view)
end

function RoundInfoWidget:_setupRoundInfo(view)
	local roundLabel = view:getChildByFullName("round_lab")

	roundLabel:setString(Strings:get("BATTLE_ROUND_LABEL", {
		value = 1
	}))

	self._roundLabel = roundLabel
end

function RoundInfoWidget:setCurrentRoundNum(num, max)
	self._max = max or self._max

	self._roundLabel:setString(Strings:get("BATTLE_ROUND_LABEL", {
		value = num
	}))
end
