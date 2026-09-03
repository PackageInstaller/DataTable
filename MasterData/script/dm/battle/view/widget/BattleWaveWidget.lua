-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleWaveWidget.lua

BattleWaveWidget = class("BattleWaveWidget", BaseWidget)

function BattleWaveWidget:initialize(view)
	super.initialize(self, view)
	self:setupView()
end

function BattleWaveWidget:dispose()
	super.dispose(self)
end

function BattleWaveWidget:setupView()
	local view = self:getView()

	self._text1 = view:getChildByFullName("text1")
	self._text2 = view:getChildByFullName("text2")
	self._text = view:getChildByFullName("text")

	view:setVisible(false)
end

function BattleWaveWidget:setWave(waveIndex, totalWave)
	if totalWave <= 1 then
		return
	end

	self._view:setVisible(true)
	self._text:setString(tostring(waveIndex) .. "/" .. tostring(totalWave))
end
