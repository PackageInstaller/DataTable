local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.util_func
local var_0_6 = string.format
local var_0_7 = lx.ServerTime

gamecore.UILoader:define("farfight_item", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)

		self._is_visible = true
	end

	function arg_1_0:hide()
		self:setVisible(false)

		self._is_visible = false
	end

	function arg_1_0:toggle_lock(arg_4_1, arg_4_2, arg_4_3)
		self._is_unlock = not arg_4_1

		if not arg_4_2 or arg_4_1 then
			self._control.bg.lock.lock_bg.lock_title.text.text = var_0_6(var_0_2:getNowLang("openexplorecondition"), var_0_4:get_chinaese_count(arg_4_3))
			self._control.bg.lock.lock_bg.lock_txt.text.text = var_0_2:getNowLang("ui_notopen")
			self._control.bg.lock.canvasGroup.alpha = 1
			self._control.bg.lock.canvasGroup.blocksRaycasts = true

			return
		end

		self._item_data = arg_4_2

		self:__init_panel()

		self._control.bg.lock.canvasGroup.alpha = 0
		self._control.bg.lock.canvasGroup.blocksRaycasts = false
	end

	function arg_1_0:update()
		if not self._is_visible then
			return
		end

		if not self._is_unlock then
			return
		end

		local var_5_0, var_5_1 = var_0_1:check_expedition_state(self._item_data.id)

		if self._curr_expedition_state ~= var_5_0 then
			self._curr_expedition_state = var_5_0

			self:__toggle_farfight_state(var_5_0)
		end

		if var_5_0 == var_0_4.expedition_state.ongoing then
			local var_5_2 = var_5_1 - var_0_7:getUtcTime()

			if var_5_2 < 0 then
				var_5_2 = 0
			end

			self._control.bg.bg_btn.going_group.going_time_txt.text.text = var_0_5.secondsToTime(var_5_2)
		end
	end

	function arg_1_0:__init_panel()
		self._control.bg.bg_btn.title_txt.text.text = self._item_data.title

		local var_6_0 = 0
		local var_6_1 = 0
		local var_6_2 = 0
		local var_6_3 = 0

		for iter_6_0, iter_6_1 in ipairs(self._item_data.award) do
			if iter_6_1.id == var_0_4.ship_item_cid.oil then
				var_6_0 = iter_6_1.count
			elseif iter_6_1.id == var_0_4.ship_item_cid.bullet then
				var_6_1 = iter_6_1.count
			elseif iter_6_1.id == var_0_4.ship_item_cid.steel then
				var_6_2 = iter_6_1.count
			elseif iter_6_1.id == var_0_4.ship_item_cid.alum then
				var_6_3 = iter_6_1.count
			end
		end

		self._control.bg.bg_btn.prepare_group.need_time_title.text.text = var_0_2:getNowLang("pveexploretimelabel1")
		self._control.bg.bg_btn.prepare_group.fight_btn.text.text.text = var_0_2:getNowLang("pveexplorestartbtn")
		self._control.bg.bg_btn.oil_txt.text.text = tostring(var_6_0)
		self._control.bg.bg_btn.bullet_txt.text.text = tostring(var_6_1)
		self._control.bg.bg_btn.steel_txt.text.text = tostring(var_6_2)
		self._control.bg.bg_btn.alum_txt.text.text = tostring(var_6_3)
		self._control.bg.bg_btn.going_group.cancel_btn.text.text.text = var_0_2:getNowLang("pveexplrecanceltitle")
		self._control.bg.bg_btn.going_group.going_title_txt.text.text = var_0_2:getNowLang("pveexploreinprogress")
		self._control.bg.bg_btn.done_group.done_btn.text.text.text = var_0_2:getNowLang("ui_harvestreward")
		self._control.bg.bg_btn.done_group.done_title_txt.text.text = var_0_2:getNowLang("pveexploretimelabel3")
		self._control.bg.bg_btn.award_txt.text.text = var_0_2:getNowLang("ui_campaigntip1")
		self._control.bg.bg_btn.prepare_group.need_time_txt.text.text = var_0_5.secondsToTime(self._item_data.need_time)

		local var_6_4 = 0

		if #self._item_data.pruduct_goods > 0 then
			self._control.bg.bg_btn.award_good.good_icon.image.sprite = self:loadSprite(var_0_6(var_0_4.icon.item_icon, self._item_data.pruduct_goods[1] .. "_1"))
			var_6_4 = 1
		end

		self._control.bg.bg_btn.award_good.canvasGroup.alpha = var_6_4

		if var_0_1:check_expedition_state(self._item_data.id) == var_0_4.expedition_state.ongoing then
			self._control.bg.bg_btn.going_group.team_num_bg.team_num_txt.text.text = var_0_1:get_expedition_info(self._item_data.id).team
		end
	end

	function arg_1_0:__toggle_farfight_state(arg_7_1)
		self._control.bg.bg_btn.prepare_group.canvasGroup.alpha = 0
		self._control.bg.bg_btn.prepare_group.canvasGroup.blocksRaycasts = false
		self._control.bg.bg_btn.going_group.canvasGroup.alpha = 0
		self._control.bg.bg_btn.going_group.canvasGroup.blocksRaycasts = false
		self._control.bg.bg_btn.done_group.canvasGroup.alpha = 0
		self._control.bg.bg_btn.done_group.canvasGroup.blocksRaycasts = false

		self._control.bg.bg_btn.going_group.going_spine.skeletonGraphic.AnimationState:ClearTracks()

		if arg_7_1 == var_0_4.expedition_state.prepare then
			self._control.bg.bg_btn.prepare_group.canvasGroup.alpha = 1
			self._control.bg.bg_btn.prepare_group.canvasGroup.blocksRaycasts = true
		elseif arg_7_1 == var_0_4.expedition_state.ongoing then
			self._control.bg.bg_btn.going_group.going_spine.skeletonGraphic.AnimationState:SetAnimation(0, "Expedition", true)

			self._control.bg.bg_btn.going_group.canvasGroup.alpha = 1
			self._control.bg.bg_btn.going_group.canvasGroup.blocksRaycasts = true
		elseif arg_7_1 == var_0_4.expedition_state.done then
			self._control.bg.bg_btn.done_group.canvasGroup.alpha = 1
			self._control.bg.bg_btn.done_group.canvasGroup.blocksRaycasts = true
		end
	end

	function arg_1_0:_play_into_se(arg_8_1)
		self:playSE(arg_8_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_9_0)
	local var_9_0 = var_0_3:class("farfight_item")

	var_9_0._item_data = nil
	var_9_0._is_visible = false
	var_9_0._is_unlock = false
	var_9_0._on_going = false
	var_9_0._curr_expedition_state = var_0_4.expedition_state.prepare

	return var_9_0
end

return var_0_0
