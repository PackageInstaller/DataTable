local var_0_0 = {}
local var_0_2 = math.floor
local var_0_3 = string.sub
local var_0_4 = string.format
local var_0_5 = table.insert
local var_0_6 = gamecore.UILoader
local var_0_7 = gameenum.launch_common_type
local var_0_8 = lx.UserData
local var_0_12 = lan_rand
local var_0_13 = gamecore.UserDataManager
local var_0_14 = gameenum.common_type
local var_0_16 = DG.Tweening.DOTween
local var_0_17 = gamecore.AuditServerManager

gamecore.UILoader:define("launch", function(arg_1_0)
	function arg_1_0:showVersionInfo(arg_2_1)
		self._control.version.text = var_0_4("App %s  Res %s", app:getSystem():getAppVersion(), (app:getSystem():getDataVersion()))
	end

	function arg_1_0.__onUpdate(arg_3_0)
		return
	end

	function arg_1_0:set_hoolai_is_close()
		local var_4_0 = self:autoKillDOTween(var_0_16.Sequence())

		var_4_0:AppendInterval(60)
		var_4_0:AppendCallback(function()
			if not var_0_6:getInstance("enter_game") then
				HMSDKManager.Instance:Logout()
				HMSDKManager.Instance:InitLoginSDK()
				self:set_hoolai_is_close()
			end
		end)
	end

	function arg_1_0:show(arg_6_1, arg_6_2, arg_6_3)
		self._hoolai_login_success = false

		local var_6_0 = self:autoKillDOTween(var_0_16.Sequence())

		var_6_0:AppendInterval(arg_6_1)
		var_6_0:AppendCallback(function()
			if arg_6_2 then
				arg_6_2()
				var_6_0:Kill()

				var_6_0 = nil
			end
		end)
		var_6_0:Play()

		if arg_6_3 then
			self._control.background:SetActive(true)

			return
		end

		local var_6_2 = var_0_13:getDataByID("open_panorama", "0")

		if ((var_6_2 ~= "" or nil) and var_6_2) == "true" then
			local var_6_3 = typeof(MainCameraRotate)
			local var_6_4 = self._control.camera_parent.gyroscope_camera.gameObject:GetComponent(var_6_3)

			if not var_6_4 then
				var_6_4 = self._control.camera_parent.gyroscope_camera.gameObject:AddComponent(var_6_3)
				var_6_4.gyroscope_sphere = self._control.gyroscope_sphere.transform
			end

			var_6_4.vertRotateRateScale = 1
			var_6_4.horiRotateRateScale = 1
			var_6_4.reverse_X = true
			var_6_4.reverse_Y = true
			var_6_4.need_back = false
			var_6_4.need_reverse = true

			self._control.gyroscope_sphere.gameObject:SetActive(true)
			self._control.camera_parent.gameObject:SetActive(true)
		else
			local function var_6_5()
				self._control.background:SetActive(true)
			end

			local var_6_6 = self:autoKillDOTween(var_0_16.Sequence())

			var_6_6:AppendInterval(1.2)
			var_6_6:AppendCallback(var_6_5)
			var_6_6:Play()
		end

		local var_6_7 = tonumber(var_0_8:getKeyData("always_light"))

		UnityEngine.Screen.sleepTimeout = var_6_7 and tonumber(var_6_7)
	end

	function arg_1_0:update_login_background()
		local var_9_0 = self:__cut_string_for_cover((var_0_8:getKeyData("CustomCover")))
		local var_9_1 = var_0_12(1, 1 + #var_9_0)
		local var_9_2 = var_0_7.open_panorama
		local var_9_3 = var_0_13:getDataByID("open_panorama", "0")
		local var_9_4

		if var_9_3 ~= "" then
			var_9_2 = var_9_3
			var_9_4 = var_0_17:isAuditVersion()
		end

		if var_9_2 == "true" and not var_9_4 then
			local var_9_5 = typeof(MainCameraRotate)
			local var_9_6 = self._control.camera_parent.gyroscope_camera.gameObject:GetComponent(var_9_5)

			if not var_9_6 then
				var_9_6 = self._control.camera_parent.gyroscope_camera.gameObject:AddComponent(var_9_5)
				var_9_6.gyroscope_sphere = self._control.gyroscope_sphere.transform
			end

			var_9_6.vertRotateRateScale = 1
			var_9_6.horiRotateRateScale = 1
			var_9_6.reverse_X = true
			var_9_6.reverse_Y = true
			var_9_6.need_back = false
			var_9_6.need_reverse = true

			self._control.gyroscope_sphere.gameObject:SetActive(true)
			self._control.camera_parent.gameObject:SetActive(true)
		elseif not var_9_4 then
			if var_9_1 <= #var_9_0 then
				local var_9_7 = var_0_12(1, #var_9_0)

				self._control.background.image.sprite = self:loadSprite("data/ui/cg/" .. tostring(var_9_0[var_9_7]) .. "/" .. tostring(var_9_0[var_9_7]) .. ".png")

				self._control.background:SetActive(true)
			end

			if var_9_1 > #var_9_0 then
				local var_9_8 = var_0_12(1, 3)

				if var_9_8 == 1 then
					self._control.background.image.sprite = self:loadSprite(var_0_14.lauch_back_ground.lauch_back_1)

					self._control.background:SetActive(true)
				elseif var_9_8 == 2 then
					self._control.background.image.sprite = self:loadSprite(var_0_14.lauch_back_ground.lauch_back_2)

					self._control.background:SetActive(true)
				else
					self._control.background.image.sprite = self:loadSprite(var_0_14.lauch_back_ground.lauch_back_3)

					self._control.background:SetActive(true)
				end
			end
		else
			self._control.background.image.sprite = self:loadSprite(var_0_14.lauch_back_ground.lauch_back_4)

			self._control.background:SetActive(true)
		end
	end

	function arg_1_0.__cut_string_for_cover(arg_10_0, arg_10_1)
		local var_10_0 = {}

		for iter_10_0 = 1, var_0_2(#arg_10_1 / 5) do
			var_0_5(var_10_0, (tonumber(var_0_3(arg_10_1, 1, 5))))

			arg_10_1 = var_0_3(arg_10_1, 6)
		end

		return var_10_0
	end

	function arg_1_0:__onVisible(arg_11_1)
		if arg_11_1 then
			self:showVersionInfo()
		end
	end
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_6:class("launch")

	var_12_0:__registerControl("version", UnityEngine.UI.Text)

	return var_12_0
end

return var_0_0
