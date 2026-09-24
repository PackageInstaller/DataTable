local var_0_0 = {}
local var_0_2 = gamecore.AccountPlatform
local var_0_3 = gamecore.UILoader
local var_0_4 = HMSDKManager.Instance
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = gamecore.SceneManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_region_android()
		self:setVisible(false)

		local var_2_0 = app:getSystem():getChannel()

		log.print_r(var_2_0, "channel@@@@@@11111@@@@@")
		log.print_r(var_0_2:getChannel(), "AccountPlatform:getChannel()")

		local var_2_1 = false

		if var_0_2:getChannel() == "hm_sdk_ios" and var_2_0 == "hm_ios" then
			var_2_1 = true
		elseif var_0_2:getChannel() == "hm_sdk_ios" then
			var_0_4:SignOutNowPlayer()
			var_0_2:login("android", true)

			local var_2_2 = var_0_3:getInstance("enter_game")

			if var_2_2 then
				var_2_2:select_server_control(true)
			end
		else
			local var_2_3 = var_0_3:getInstance("enter_game")

			if var_2_3 then
				var_2_3:select_server_control(true)
			end
		end

		if var_2_1 then
			var_0_3:createInstance("loading"):show(true)

			local var_2_4 = self:autoKillDOTween(var_0_5.Sequence())

			var_0_2:login("android", false)

			local var_2_5 = var_0_3:getInstance("enter_game")

			if var_2_5 then
				var_2_5:select_server_control(true)
			end

			var_2_4:AppendInterval(1.5)
			var_2_4:AppendCallback(function()
				var_0_6:restart()
			end)
			var_2_4:Play()
		end
	end

	function arg_1_0:__onClick_region_ios()
		self:setVisible(false)

		local var_4_0 = false

		log.print_r(var_0_2:getChannel(), "AccountPlatform:getChannel()")

		local var_4_1 = app:getSystem():getChannel()

		log.print_r(var_4_1, "channel@@@@@@222222@@@@@")

		if var_0_2:getChannel() == "hm_sdk_android" and var_4_1 == "hm_ios" then
			var_4_0 = true
		elseif var_0_2:getChannel() == "hm_sdk_android" then
			var_0_4:SignOutNowPlayer()
			var_0_2:login("ios", true)

			local var_4_2 = var_0_3:getInstance("enter_game")

			if var_4_2 then
				var_4_2:select_server_control(true)
			end
		else
			local var_4_3 = var_0_3:getInstance("enter_game")

			if var_4_3 then
				var_4_3:select_server_control(true)
			end
		end

		if var_4_0 then
			var_0_3:createInstance("loading"):show(true)

			local var_4_4 = self:autoKillDOTween(var_0_5.Sequence())

			var_0_2:login("ios", false)

			local var_4_5 = var_0_3:getInstance("enter_game")

			if var_4_5 then
				var_4_5:select_server_control(true)
			end

			var_4_4:AppendInterval(1.5)
			var_4_4:AppendCallback(function()
				var_0_6:restart()
			end)
			var_4_4:Play()
		end
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
