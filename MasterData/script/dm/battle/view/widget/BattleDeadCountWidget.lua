-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleDeadCountWidget.lua

BattleDeadCountWidget = class("BattleDeadCountWidget", BattleWidget, _M)

function BattleDeadCountWidget:initialize(view)
	super.initialize(self, view)
end

function BattleDeadCountWidget:setMaxNum(max)
	self._maxNum = max
	self._currentNum = 0

	local cntLabel = self:getView():getChildByFullName("bg.Text_1")

	cntLabel:setString(Strings:get("Battle_All_Kill", {
		num1 = 0,
		num2 = self._maxNum
	}))

	self._cntLabel = cntLabel
end

function BattleDeadCountWidget:increaseDead()
	self._currentNum = self._currentNum + 1

	self._cntLabel:setString(Strings:get("Battle_All_Kill", {
		num1 = self._currentNum,
		num2 = self._maxNum
	}))
end

function BattleDeadCountWidget:enabled(isEnable)
	self:getView():setVisible(isEnable)
end
