local var_0_0 = {}
local var_0_1 = lx.UserData
local var_0_2 = gameenum.error_type
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.prompt
local var_0_6 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:UnlockShipStoryResp(arg_2_1)
		if arg_2_1.result == 0 then
			self:__unlock_chara_story_success()
		end
	end

	function arg_1_0:ReadStoryResp(arg_3_1)
		if arg_3_1.result == 0 then
			self:__read_story_success()

			local var_3_0 = var_0_3:getInstance("cinema_story_node")

			if var_3_0 then
				var_3_0:reset_story_node()
				var_3_0:show((var_0_6:get_now_story()))
				var_3_0._control.scrollview_2:SetActive(true)
				var_3_0._control.scrollview_1:SetActive(false)
			end
		end
	end

	function arg_1_0.UnlockStoryResp(arg_4_0, arg_4_1)
		return
	end

	function arg_1_0:SaveCustomCoverResp(arg_5_1)
		if arg_5_1 and arg_5_1.result == 0 then
			local var_5_0 = ""

			for iter_5_0, iter_5_1 in pairs(self._selected_pic) do
				var_5_0 = var_5_0 .. tostring(iter_5_1)
			end

			var_0_1:setKeyData("CustomCover", var_5_0)
			var_0_5:show(var_0_4:getNowLang("cg_set"))
		end
	end

	function arg_1_0.__unlock_chara_story_success(arg_6_0)
		return
	end

	function arg_1_0.__read_story_success(arg_7_0)
		return
	end

	function arg_1_0:TokenUnlockStoryResp(arg_8_1)
		if arg_8_1 and arg_8_1.result == 0 then
			local var_8_0 = var_0_3:getInstance("cinema_review")

			if var_8_0 then
				if self._init_story_id then
					var_0_6:req_UnlockStoryReq(self._init_story_id)
				end

				var_8_0:setVisible(false)

				local var_8_1 = var_0_3:getInstance("cinema_story_node")
				local var_8_2 = var_0_3:getInstance("story_btn_info")

				if var_8_2 then
					var_8_2:setVisible(false)
				end

				if var_8_1 then
					if self._now_story then
						var_8_1:reset_story_node()
						var_8_1:show(self._now_story)

						if self._now_small_story_panel then
							var_8_1._control.scrollview_1:SetActive(false)
							var_8_1._control.scrollview_2:SetActive(true)
						end
					elseif self._now_story_info and next(self._now_story_info) then
						var_8_1:reset_story_node()
						var_8_1:show(self._now_story_info.id)
					end
				else
					local var_8_3 = var_0_3:createInstance("cinema_story_node")

					if self._now_story then
						var_8_3:reset_story_node()
						var_8_3:show(self._now_story)
					elseif self._now_story_info and next(self._now_story_info) then
						var_8_3:reset_story_node()
						var_8_3:show(self._now_story_info.id)
					end
				end
			elseif var_0_3:createInstance("cinema_story_node") then
				local var_8_4 = var_0_3:createInstance("cinema_story_node")

				if self._now_story then
					var_8_4:reset_story_node()
					var_8_4:show(self._now_story)

					local var_8_5 = var_0_3:getInstance("story_btn_info")

					if var_8_5 then
						var_8_5:setVisible(false)
					end
				elseif self._now_story_info and next(self._now_story_info) then
					var_8_4:reset_story_node()
					var_8_4:show(self._now_story_info.id)
				end
			end
		else
			var_0_5:show(var_0_2:get_err_msg(arg_8_1.result))
		end
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
