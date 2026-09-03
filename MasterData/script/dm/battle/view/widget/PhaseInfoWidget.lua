-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/PhaseInfoWidget.lua

PhaseInfoWidget = class("PhaseInfoWidget", BattleWidget, _M)

function PhaseInfoWidget:initialize(view)
	super.initialize(self, view)
	self:_setupView(view)
end

function PhaseInfoWidget:_setupView(view)
	self._label = view:getChildByFullName("label")

	local anim = cc.MovieClip:create("dhb_jieduanqiehuan")

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

function PhaseInfoWidget:showNewPhaseLabel(phase, energySpeed)
	local str = Strings:get("BATTLE_PHASE_LABEL", {
		value = phase
	}) .. " " .. Strings:get("BATTLE_ENERGYSPEED_LABEL", {
		value = math.floor(energySpeed * 100)
	})

	self._label:setString(str)

	if self._anim then
		self._anim:setVisible(true)
		self._anim:gotoAndPlay(1)
	end

	AudioEngine:getInstance():playEffect("Se_Alert_Speedup")
end
