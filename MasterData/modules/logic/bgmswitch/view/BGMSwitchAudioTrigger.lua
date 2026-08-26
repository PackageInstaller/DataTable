-- chunkname: @modules/logic/bgmswitch/view/BGMSwitchAudioTrigger.lua

module("modules.logic.bgmswitch.view.BGMSwitchAudioTrigger", package.seeall)

local BGMSwitchAudioTrigger = class("BGMSwitchAudioTrigger")
local WhiteNoiseMode = {
	[BGMSwitchEnum.Gear.On2] = true,
	[BGMSwitchEnum.Gear.On3] = true
}

function BGMSwitchAudioTrigger.switchGearTo(beforeGear, afterGear)
	local count = math.abs(afterGear - beforeGear)

	BGMSwitchAudioTrigger._play_ui_replay_tunetable()

	if count > 1 then
		TaskDispatcher.runRepeat(BGMSwitchAudioTrigger._play_ui_replay_tunetable, nil, 0.2, count - 1)
	end

	if beforeGear == BGMSwitchEnum.Gear.OFF then
		TaskDispatcher.runDelay(BGMSwitchAudioTrigger._play_ui_replay_boot, nil, count * 0.2)
	end

	if afterGear == BGMSwitchEnum.Gear.OFF then
		TaskDispatcher.runDelay(BGMSwitchAudioTrigger._play_ui_replay_shutdown, nil, count * 0.2)
	end

	if not WhiteNoiseMode[beforeGear] and WhiteNoiseMode[afterGear] then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_whitenoise_loop)
	elseif WhiteNoiseMode[beforeGear] and not WhiteNoiseMode[afterGear] then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_replay_whitenoise_loop)
	end
end

function BGMSwitchAudioTrigger._play_ui_replay_tunetable()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tunetable)
end

function BGMSwitchAudioTrigger._play_ui_replay_boot()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_boot)
end

function BGMSwitchAudioTrigger._play_ui_replay_shutdown()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_shutdown)
end

function BGMSwitchAudioTrigger.play_ui_replay_open()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_open)

	local gear = BGMSwitchModel.instance:getMechineGear()

	if WhiteNoiseMode[gear] then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_whitenoise_loop)
	end
end

function BGMSwitchAudioTrigger.play_ui_replay_close()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_close)

	local gear = BGMSwitchModel.instance:getMechineGear()

	if WhiteNoiseMode[gear] then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_replay_whitenoise_loop)
	end
end

function BGMSwitchAudioTrigger.play_ui_replay_tinyopen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tinyopen)
end

function BGMSwitchAudioTrigger.play_ui_replay_tinyclose()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tinyclose)
end

function BGMSwitchAudioTrigger.play_ui_replay_buttonsilp()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttonsilp)
end

function BGMSwitchAudioTrigger.play_ui_replay_buttoncut()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttoncut)
end

function BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_tapswitch)
end

function BGMSwitchAudioTrigger.play_ui_replay_buttonegg()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttonegg)
end

function BGMSwitchAudioTrigger.play_ui_replay_flap()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_flap)
end

function BGMSwitchAudioTrigger.play_ui_replay_heart(favorite)
	if favorite then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_hearton)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_heartoff)
	end
end

function BGMSwitchAudioTrigger.play_ui_rolesgo()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesgo)
end

function BGMSwitchAudioTrigger.play_ui_achieve_weiqicard_switch()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_switch)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
end

function BGMSwitchAudioTrigger.play_ui_checkpoint_resources_cardpass()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_resources_cardpass)
end

return BGMSwitchAudioTrigger
