local var_0_0

function appEnterForeground()
	if var_0_0 == nil then
		return
	end

	require("controller.audio_manager"):resumeAllSources()

	local var_1_0 = cc.EventCustom:new("APPENTERFOREGROUND")

	var_1_0.backtime = os.time() - var_0_0

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_1_0)
end

function appEnterBackground()
	var_0_0 = os.time()

	require("controller.audio_manager"):pauseAllSources()
	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("APPENTERBACKGROUND")))
end
