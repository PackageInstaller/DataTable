local var_0_0 = {}
local var_0_1 = gamecore.prompt
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.error_type
local var_0_4 = gameconfig.item_config
local var_0_5 = table.insert
local var_0_6 = gameconfig.chat_head_config
local var_0_8 = gameenum.common_type
local var_0_9 = table.remove
local var_0_10 = gameconfig.chat_head_config
local var_0_11 = gameconfig.equip_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:GetMailResp(arg_2_1)
		if arg_2_1.result == 0 then
			self:__get_mail_reward_success(arg_2_1)
		else
			var_0_1:show(var_0_3:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0.DeleteMailResp(arg_3_0, arg_3_1)
		if arg_3_1.result == 0 then
			-- block empty
		else
			var_0_1:show(var_0_3:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0:GetAllMailResp(arg_4_1)
		if arg_4_1.result == 0 then
			self:__show_all_award(arg_4_1)
		else
			var_0_1:show(var_0_3:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.__show_ship_detail_info(arg_5_0, arg_5_1)
		var_0_2:createInstance("new_ship_or_equip"):show(true, {
			type = arg_5_1.type,
			count = arg_5_1.count,
			id = arg_5_1.id,
			is_new = arg_5_1.is_new
		}, var_0_8.enter_get_ship_type.mail_ship_award, function()
			if arg_5_0._ship_info and next(arg_5_0._ship_info) then
				arg_5_0:__show_special_ship_detail()
			elseif arg_5_0._ship_skin and next(arg_5_0._ship_skin) then
				arg_5_0:__show_special_ship_skin_detail()
			else
				arg_5_0:__show_special_equip_info_detail()
			end
		end)
	end

	function arg_1_0:__show_ship_skin_info(arg_7_1)
		if self._ship_skin and next(self._ship_skin) then
			var_0_2:createInstance("reward_tip"):show_by_enter_type(arg_7_1.id, var_0_8.enter_get_ship_type.mail_skin_award, function()
				self:__show_special_ship_skin_detail()
			end)
		elseif self._equip_info and next(self._equip_info) then
			if #self._equip_info == 1 then
				self:__show_special_equip_info_detail()
			elseif #self._equip_info > 1 then
				self:__show_special_equip_info_detail()
			end
		end
	end

	function arg_1_0:__show_equip_info(arg_9_1)
		local var_9_0 = {
			type = arg_9_1.type,
			count = arg_9_1.count,
			id = var_0_11.find_object_by_cid(arg_9_1.id).cid,
			is_new = arg_9_1.is_new
		}
		local var_9_1 = var_0_2:createInstance("new_ship_or_equip")

		if self._equip_info and next(self._equip_info) then
			if #self._equip_info > 1 then
				var_9_1:show(true, var_9_0, var_0_8.enter_get_ship_type.spoils_shop, function()
					self:__show_special_equip_info_detail()
				end)
			elseif #self._equip_info == 1 then
				var_9_1:show(true, var_9_0, var_0_8.enter_get_ship_type.spoils_shop, function()
					self:__show_special_avatar_detail()
				end)
			end
		elseif self._avatar and next(self._avatar) then
			self:__show_special_avatar_detail()
		end
	end

	function arg_1_0.__show_avatar_info(arg_12_0, arg_12_1)
		var_0_2:createInstance("reward_tip"):show_by_enter_type(var_0_10.find_object_by_cid(arg_12_1.id).icon, var_0_8.enter_get_ship_type.mail_new_head_award, function()
			if arg_12_0._avatar and next(arg_12_0._avatar) then
				arg_12_0:__show_special_avatar_detail()
			elseif arg_12_0._picture_book and next(arg_12_0._picture_book) then
				arg_12_0:__show_special_picture_book_info_detail()
			end
		end)
	end

	function arg_1_0:__show_picture_book_info_info(arg_14_1)
		if self._picture_book and next(self._picture_book) then
			var_0_2:createInstance("reward_tip"):show_by_enter_type(nil, var_0_8.enter_icon_detail_type.picture_panel, function()
				self:__show_special_picture_book_info_detail()
			end, arg_14_1.id)
		elseif self._now_item_info and next(self._now_item_info) then
			var_0_2:createInstance("acquire_image"):Show_Info(self._now_item_info)
		end
	end

	function arg_1_0:__show_special_ship_detail()
		if self._ship_info and next(self._ship_info) then
			for iter_16_0, iter_16_1 in pairs(self._ship_info) do
				if iter_16_1.type == var_0_8.reward_type.ship then
					self:__show_ship_detail_info(iter_16_1)
					var_0_9(self._ship_info, iter_16_0)

					return
				end
			end
		elseif self._ship_skin and next(self._ship_skin) then
			self:__show_special_ship_skin_detail()
		elseif self._equip_info and next(self._equip_info) then
			self:__show_special_equip_info_detail()
		elseif self._avatar and next(self._avatar) then
			self:__show_special_avatar_detail()
		elseif self._picture_book and next(self._picture_book) then
			self:__show_special_picture_book_info_detail()
		elseif self._now_item_info and next(self._now_item_info) then
			var_0_2:createInstance("acquire_image"):Show_Info(self._now_item_info)
		end
	end

	function arg_1_0:__show_special_ship_skin_detail()
		if self._ship_skin and next(self._ship_skin) then
			for iter_17_0, iter_17_1 in pairs(self._ship_skin) do
				if iter_17_1.type == var_0_8.reward_type.ship_skin then
					self:__show_ship_skin_info(iter_17_1)
					var_0_9(self._ship_skin, iter_17_0)

					return
				end
			end
		elseif self._equip_info and next(self._equip_info) then
			self:__show_special_equip_info_detail()
		elseif self._avatar and next(self._avatar) then
			self:__show_special_avatar_detail()
		elseif self._picture_book and next(self._picture_book) then
			self:__show_special_picture_book_info_detail()
		elseif self._now_item_info and next(self._now_item_info) then
			var_0_2:createInstance("acquire_image"):Show_Info(self._now_item_info)
		end
	end

	function arg_1_0:__show_special_equip_info_detail()
		if self._equip_info and next(self._equip_info) then
			for iter_18_0, iter_18_1 in pairs(self._equip_info) do
				if iter_18_1.type == var_0_8.reward_type.equipment then
					self:__show_equip_info(iter_18_1)
					var_0_9(self._equip_info, iter_18_0)

					return
				end
			end
		elseif self._avatar and next(self._avatar) then
			self:__show_special_avatar_detail()
		elseif self._picture_book and next(self._picture_book) then
			self:__show_special_picture_book_info_detail()
		elseif self._now_item_info and next(self._now_item_info) then
			var_0_2:createInstance("acquire_image"):Show_Info(self._now_item_info)
		end
	end

	function arg_1_0:__show_special_avatar_detail()
		if self._avatar and next(self._avatar) then
			for iter_19_0, iter_19_1 in pairs(self._avatar) do
				if iter_19_1.type == var_0_8.reward_type.head_icon then
					self:__show_avatar_info(iter_19_1)
					var_0_9(self._avatar, iter_19_0)

					return
				end
			end
		elseif self._picture_book and next(self._picture_book) then
			self:__show_special_picture_book_info_detail()
		elseif self._now_item_info and next(self._now_item_info) then
			var_0_2:createInstance("acquire_image"):Show_Info(self._now_item_info)
		end
	end

	function arg_1_0:__show_special_picture_book_info_detail()
		if self._picture_book and next(self._picture_book) then
			for iter_20_0, iter_20_1 in pairs(self._picture_book) do
				if iter_20_1.type == var_0_8.reward_type.cg then
					self:__show_picture_book_info_info(iter_20_1)
					var_0_9(self._picture_book, iter_20_0)

					return
				end
			end
		elseif self._now_item_info and next(self._now_item_info) then
			var_0_2:createInstance("acquire_image"):Show_Info(self._now_item_info)
		end
	end

	function arg_1_0.DeleteAllMailResp(arg_21_0, arg_21_1)
		if arg_21_1.result == 0 then
			-- block empty
		else
			var_0_1:show(var_0_3:get_err_msg(arg_21_1.result))
		end
	end

	function arg_1_0:__get_mail_reward_success(arg_22_1)
		self:__show_all_award(arg_22_1)
	end

	function arg_1_0:__show_all_award(arg_23_1)
		table.sort(arg_23_1.reward, function(arg_24_0, arg_24_1)
			return arg_24_0.id < arg_24_1.id
		end)

		local var_23_1 = var_0_2:getInstance("task")
		local var_23_2 = {}
		local var_23_3 = {}
		local var_23_4 = {}
		local var_23_6 = {}
		local var_23_7 = {}
		local var_23_9 = {}
		local var_23_10 = {}
		local var_23_11 = {}
		local var_23_12 = {}
		local var_23_13 = {}

		for iter_23_0, iter_23_1 in pairs((var_0_4.get_sequence())) do
			var_0_5(var_23_13, {
				is_new = false,
				count = 0,
				id = iter_23_1.cid,
				type = iter_23_1.type
			})
		end

		for iter_23_2, iter_23_3 in pairs(arg_23_1.reward) do
			if iter_23_3.type == 4 then
				var_0_5(var_23_2, iter_23_3)
			elseif iter_23_3.type == 1 then
				var_0_5(var_23_4, iter_23_3)
			elseif iter_23_3.type == 3 then
				var_0_5(var_23_3, iter_23_3)
			elseif iter_23_3.type == 5 then
				var_0_5(var_23_6, iter_23_3)
			elseif iter_23_3.type == 6 then
				var_0_5(var_23_7, iter_23_3)
			elseif iter_23_3.type == 8 then
				var_0_5(var_23_9, iter_23_3)

				arg_23_1.reward[iter_23_2] = nil
			elseif iter_23_3.type == 12 then
				var_0_5(var_23_10, iter_23_3)
			elseif iter_23_3.type == 13 then
				var_0_5(var_23_12, iter_23_3)
			elseif iter_23_3.type % 100 == 42 or iter_23_3.type % 100 == 43 then
				var_0_5(var_23_11, {
					is_new = false,
					type = 2,
					id = iter_23_3.id,
					count = iter_23_3.count
				})
			else
				for iter_23_4, iter_23_5 in pairs(var_23_13) do
					if iter_23_5.id == iter_23_3.id then
						iter_23_5.count = iter_23_5.count + iter_23_3.count
						iter_23_5.type = iter_23_3.type
					end
				end
			end
		end

		self._ship_info = var_23_2
		self._ship_skin = var_23_3
		self._equip_info = var_23_4
		self._avatar = var_23_9
		self._picture_book = var_23_10
		self._furniture_info = var_23_6
		self._cook_book_info = var_23_7
		self._abyss_ship_info = var_23_12

		local var_23_14 = {}

		for iter_23_6, iter_23_7 in pairs(var_23_13) do
			if iter_23_7.count > 0 then
				var_0_5(var_23_14, {
					is_new = false,
					id = iter_23_7.id,
					count = iter_23_7.count,
					type = iter_23_7.type
				})
			end
		end

		if var_23_6 and next(var_23_6) then
			for iter_23_8, iter_23_9 in ipairs(var_23_6) do
				var_0_5(var_23_14, iter_23_9)
			end
		end

		if var_23_7 and next(var_23_7) then
			for iter_23_10, iter_23_11 in ipairs(var_23_7) do
				var_0_5(var_23_14, iter_23_11)
			end
		end

		if var_23_12 and next(var_23_12) then
			for iter_23_12, iter_23_13 in ipairs(var_23_12) do
				var_0_5(var_23_14, iter_23_13)
			end
		end

		self._now_item_info = var_23_14

		local function var_23_15()
			if #var_23_14 >= 1 then
				var_0_2:createInstance("acquire_image"):Show_Info(var_23_14)
			end
		end

		local function var_23_16()
			if #var_23_9 == 1 then
				var_0_2:createInstance("reward_tip"):show_by_enter_type(var_0_6.find_object_by_cid(var_23_9[1].id).icon, var_0_8.enter_get_ship_type.task_award, var_23_15)
			else
				var_23_15()
			end
		end

		local function var_23_17()
			if #var_23_10 >= 1 then
				local var_27_0 = var_0_2:createInstance("reward_tip")

				if #var_23_9 >= 1 then
					var_27_0:show_by_enter_type(nil, var_0_8.enter_icon_detail_type.picture_panel, var_23_16, var_23_10[1].id)
				elseif #var_23_14 >= 1 then
					var_27_0:show_by_enter_type(nil, var_0_8.enter_icon_detail_type.picture_panel, var_23_15, var_23_10[1].id)
				end
			else
				var_23_16()
			end
		end

		if self._ship_info and next(self._ship_info) then
			local var_23_18 = var_0_2:createInstance("new_ship_or_equip")

			if #var_23_3 >= 1 then
				if #var_23_3 == 1 then
					var_23_18:show(true, self._ship_info[1], var_0_8.enter_get_ship_type.mail_ship_award, function()
						if #var_23_4 >= 1 then
							if #var_23_4 == 1 then
								if #var_23_9 >= 1 then
									var_0_2:createInstance("new_ship_or_equip"):show(true, var_23_4[1], var_0_8.enter_get_ship_type.mail_skin_award, var_23_16)
								end
							elseif #var_23_14 > 1 then
								self:__show_special_item_detail(var_23_4)
							end
						else
							var_23_16()
						end
					end)
				elseif #var_23_3 > 1 then
					self:__show_special_ship_detail()
				end
			elseif #var_23_4 >= 1 then
				if #var_23_4 == 1 then
					var_23_18:show(true, self._ship_info[1], var_0_8.enter_get_ship_type.mail_ship_award, var_23_17)
				elseif #var_23_4 > 1 then
					self:__show_special_ship_detail()
				end
			elseif #var_23_10 >= 1 then
				if #self._ship_info == 1 then
					var_23_18:show(true, self._ship_info[1], var_0_8.enter_get_ship_type.mail_ship_award, var_23_17)
				elseif #self._ship_info > 1 then
					self:__show_special_ship_detail()
				end
			elseif #var_23_9 >= 1 then
				if #self._ship_info == 1 then
					var_23_18:show(true, self._ship_info[1], var_0_8.enter_get_ship_type.mail_ship_award, var_23_16)
				elseif #self._ship_info > 1 then
					self:__show_special_ship_detail()
				end
			elseif #var_23_14 >= 1 then
				if #self._ship_info == 1 then
					var_23_18:show(true, self._ship_info[1], var_0_8.enter_get_ship_type.mail_ship_award, var_23_15)
				elseif #self._ship_info > 1 then
					self:__show_special_ship_detail()
				end
			end
		else
			var_23_17()
		end
	end

	function arg_1_0.LockMailResp(arg_29_0)
		return
	end
end

function var_0_0.extend_obj(arg_30_0)
	return
end

return var_0_0
