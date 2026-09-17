RestartScene = class("RestartScene", function()
	return cc.Scene:create()
end)

function RestartScene.createScene(arg_2_0, arg_2_1)
	local var_2_0 = RestartScene.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function RestartScene:init(arg_3_1)
	self:tryToRestart(arg_3_1)
end

function RestartScene.tryToRestart(arg_4_0)
	local var_4_0

	var_4_0 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_4_0)
		arg_4_0:restart(needclean)
	end, 0.1, false)
end

function RestartScene.restart(arg_6_0, arg_6_1)
	if arg_6_1 then
		require("network.network"):closeOnLogout()
		require("network.net_dispatcher"):unregisterAllListeners()
		require("controller.spinecache_manager"):collectUnusedSpineCache()
		require("controller.l2d_manager"):releaseAllModelForce()

		local audio_manager = require("controller.audio_manager")

		audio_manager:stopAllSources()
		audio_manager:unloadAllAudio()
	end

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("RESTART_GAME"))
end
