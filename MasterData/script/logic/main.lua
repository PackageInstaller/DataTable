local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.LaunchManager
local var_0_4 = gamecore.NetworkManager
local var_0_6 = gameenum.common_type
local var_0_7 = gamecore.user
local var_0_8 = lx.UserData
local var_0_10 = UnityEngine
local var_0_11 = UnityEngine.Application
local var_0_12 = UnityEngine.RuntimePlatform
local var_0_13 = DeviceInfo
local var_0_15 = gamecore.AudioManager
local var_0_16 = XGPushManager
local var_0_18 = DG.Tweening.DOTween
local var_0_19

function var_0_0.start(arg_1_0)
	local var_1_0 = var_0_2:getInstance("status")

	var_1_0:setProgressTime(64)
	var_1_0:setProgressTargetFunc(function()
		var_1_0:newStatus(var_0_1:get("加载完毕，祝您游戏愉快。"))
		var_1_0:setProgressTime(0)
		var_1_0:setVisible(false)
		gamecore.AccountPlatform:initFinish(function()
			var_0_0:startLogin()
		end)
	end)
end

function var_0_0.startLogin(arg_4_0, arg_4_1)
	var_0_2:destroyStateUISet("game")

	if app:getSystem():getChannel() ~= "hm_android" then
		if app:getSystem():getChannel() ~= "hm_ios" then
			if app:getSystem():getChannel() ~= "taptap" then
				if app:getSystem():getChannel() == "hm_android_to_ios" then
					local var_4_0 = var_0_8:getKeyData("last_login_android_or_ios")

					if var_4_0 == "" then
						gamecore.AccountPlatform:login()
					elseif var_4_0 == "android" then
						gamecore.AccountPlatform:login("android")
					elseif var_4_0 == "ios" then
						gamecore.AccountPlatform:login("ios")
					end

					goto label_4_0
				end
			end
		end
	end

	gamecore.AccountPlatform:login()

	::label_4_0::
end

function var_0_0.logout(arg_5_0)
	gamecore.AccountPlatform:logout()
end

function var_0_0.onPlatformAuthSucceed(arg_6_0)
	var_0_2:createInstance("enter_game"):show(arg_6_0)
end

function var_0_0.onEnterGame()
	var_0_15:destroyCV()

	local var_7_0 = var_0_2:getInstance("enter_game")

	if var_7_0 then
		var_7_0:hide()
	end

	var_0_3:finish()
	var_0_2:destroyInstance("enter_game")
	var_0_2:destroyInstance("select_server")
end

function var_0_0.onEnterHome()
	if not app:isPC() then
		local var_8_0 = var_0_13.GetDeviceModel()
		local var_8_1 = var_0_13.GetDeviceID()
		local var_8_2 = tostring(var_0_10.Screen.width .. "x" .. var_0_10.Screen.height)
		local var_8_3 = "default "

		if var_0_11.platform == var_0_12.Android then
			var_8_3 = "Android "
		else
			local var_8_4

			if var_0_11.platform == var_0_12.IPhonePlayer then
				var_8_3 = "iOS "
				var_8_4 = {
					device = var_8_0,
					device_code = var_8_1,
					dpi = var_8_2
				}
			end
		end

		var_8_4.os = var_8_3 .. var_0_13.GetOperateSystemVer()
		var_8_4.propel_token = var_0_16.GetToken()

		var_0_7:req_TellDeviceReq(var_8_4)
	end

	local var_8_5 = var_0_7:get_guide_state()
	local var_8_6 = var_0_2:getInstance("home")

	if var_8_6 and var_8_6:isVisible() and var_8_5 then
		return
	end

	local var_8_7 = var_0_2:createInstance("home")

	var_8_7:show()

	if var_8_5 then
		if var_0_2:getInstance("guide_panel") then
			return
		end

		local var_8_8 = var_0_7:get_guide_info()

		if #var_8_8 == var_0_6.guide_const_num.interrupt_group_num then
			var_0_7:req_GuideStepReq({
				var_0_6.guide_const_id.nine_group.two,
				var_0_6.guide_const_id.ten_group.one
			})

			return
		end

		if #var_8_8 == var_0_6.guide_const_num.task_group_num and var_0_7:get_task_reward_num() == 0 then
			var_8_7:set_guide_task_state(true)
			var_0_7:req_GuideStepReq({
				var_0_6.guide_const_id.seven_group.two
			})

			return
		end

		var_0_2:createInstance("guide_panel"):show()
	end
end

function var_0_0.run_once(arg_9_0)
	if var_0_19 and var_0_10.Time.realtimeSinceStartup - var_0_19 > 2 then
		log.writelog_debug("[FreezeFix] detect onResume time jump, reset DOTween. dt=" .. tostring(var_0_10.Time.realtimeSinceStartup - var_0_19))
		var_0_18.PauseAll()
		var_0_18.PlayAll()
	end

	var_0_19 = var_0_10.Time.realtimeSinceStartup

	var_0_4:run_once(arg_9_0)
	gamecore.BattleManager:run_once(arg_9_0)
	gamecore.BattleRevampManager:run_once(arg_9_0)
	var_0_2:runOnce(arg_9_0)

	if var_0_10.Input.GetKeyDown(var_0_10.KeyCode.Escape) then
		local var_9_0 = var_0_2:createInstance("msgbox_image")

		if app:getSystem():getChannel() == "xiaomi" then
			XiaomiSDKBridge.Instance:Exit()
		elseif var_9_0 then
			var_9_0:Show_Info(var_0_1:getNowLang("exitgame"), exit_self_process, function()
				return
			end, var_0_1:getNowLang("settingquitgame"), nil, 0)
		end
	end
end

if tolua_xbask then
	function tolua_xbask.LateUpdate()
		return
	end

	function tolua_xbask.FixedUpdate()
		return
	end
end

return var_0_0
