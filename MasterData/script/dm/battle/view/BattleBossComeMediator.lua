-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleBossComeMediator.lua

BattleBossComeMediator = class("BattleBossComeMediator", PopupViewMediator, _M)

function BattleBossComeMediator:initialize()
	super.initialize(self)
end

function BattleBossComeMediator:dispose()
	super.dispose(self)
end

function BattleBossComeMediator:onRegister()
	super.onRegister(self)
end

function BattleBossComeMediator:onTouchMaskLayer()
	return
end

function BattleBossComeMediator:enterWithData(data)
	AudioEngine:getInstance():playEffect("Se_Alert_Warning", false)

	local animNode = self:getView():getChildByFullName("main.anim")
	local anim = cc.MovieClip:create("dh_qiangdilaixi")

	anim:addTo(animNode, 1)
	anim:addCallbackAtFrame(60, function(cid, mc)
		mc:stop()
		self:close()
	end)
	anim:addEndCallback(function(cid, mc)
		mc:stop()
		self:close()
	end)
end
