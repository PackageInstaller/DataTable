-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattlePvpSpeedUpWidget.lua

BattlePvpSpeedUpWidget = class("BattlePvpSpeedUpWidget", BattleWidget, _M)

function BattlePvpSpeedUpWidget:initialize(view)
	super.initialize(self, view)
	self:_setupView()
end

function BattlePvpSpeedUpWidget:dispose()
	super.dispose(self)
end

function BattlePvpSpeedUpWidget:_setupView()
	self._speedup = self:getView():getChildByName("speedup")

	self._speedup:setLocalZOrder(100)

	self._tips = self:getView():getChildByFullName("bg")
	self._speedupClick = self:getView():getChildByName("click")

	self._speedupClick:setTouchEnabled(true)
	self._speedupClick:addClickEventListener(function()
		self:showDetail()
	end)
	self._tips:setVisible(false)
end

function BattlePvpSpeedUpWidget:active(arg1, arg2)
	self._speedup:setEnabled(true)

	self.arg1 = arg1
	self.arg2 = arg2

	self:show()
	self:showDetail()
end

function BattlePvpSpeedUpWidget:showDetail()
	self._tips:setVisible(true)
	self._tips:getChildByName("content"):setString(Strings:get("RTPK_CombatSpeed", {
		num1 = self.arg1,
		num2 = self.arg2
	}))
	self._tips:stopAllActions()

	local delay = cc.DelayTime:create(2)
	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		self._tips:setVisible(false)
	end))

	self._tips:runAction(sequence)
end

function BattlePvpSpeedUpWidget:hide()
	self:getView():setVisible(false)
end

function BattlePvpSpeedUpWidget:show()
	self:getView():setVisible(true)
end
