-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/WaveAnimWidget.lua

WaveAnimWidget = class("WaveAnimWidget", BattleWidget, _M)

function WaveAnimWidget:initialize(view)
	super.initialize(self, view)
	self:_setupView(view)
end

function WaveAnimWidget:_setupView(view)
	self._label = view:getChildByFullName("label")

	local anim = cc.MovieClip:create("dh_jieduanqiehuan")

	anim:setScale(1.2)
	anim:setPlaySpeed(0.65)

	if anim then
		anim:addTo(view:getParent())
		anim:addEndCallback(function(cid, mc)
			mc:stop()
			mc:setVisible(false)
		end)
		view:changeParent(anim:getChildByName("label"))
		anim:setVisible(false)
		view:setVisible(true)

		self._anim = anim
	end
end

function WaveAnimWidget:showNewWaveLabel(wave)
	if wave <= 1 then
		return
	end

	local str = Strings:get("BATTLE_WAVEANIM_LABEL", {
		value = wave
	})

	self._label:setString(str)

	if self._anim then
		self._anim:setVisible(true)
		self._anim:gotoAndPlay(1)
	end
end
