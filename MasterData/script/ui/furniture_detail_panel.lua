local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.insert
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.UILoader
local var_0_6 = string.format
local var_0_7 = gameenum.common_type
local var_0_8 = gameconfig.furniture_config
local var_0_9 = gameconfig.furniture_case_config

gamecore.UILoader:define("furniture_detail_panel", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self._now_furniture_data = arg_2_1
		self._config_data = var_0_8.find_object_by_cid(self._now_furniture_data.cid)

		self:set_lock_interactable_state(true)
		self:__init_panel()
		self:setVisible(true)
	end

	function arg_1_0:__onUpdate()
		self._reusable_cell:update()
	end

	function arg_1_0:update_lock_data()
		self._now_furniture_data.lock = not self._now_furniture_data.lock

		self:__set_lock_state()
	end

	function arg_1_0:update_cell()
		local var_5_0 = self._furniture_case_list

		self._reusable_cell:set_data(self._furniture_case_list)

		function self._reusable_cell:_set_func(arg_6_1)
			self.put_dorm:SetActive(false)
			self.lock:SetActive(false)

			self.bg.image.raycastTarget = false
			self.bg.icon.image.sprite = self:loadSprite((var_0_7:get_ship_icon(var_0_7.furniture_s_img, var_5_0[arg_6_1 + 1].icon)))

			if self:__get_cur_furniture_data(var_5_0[arg_6_1 + 1].cid) then
				self.frame.image.sprite = self:loadSprite(var_0_7.common_icon.room_furniture_frame.blue)
				self.bg.image.sprite = self:loadSprite(var_0_6(var_0_7.furniture_bg, var_5_0[arg_6_1 + 1].star))
				self.bg.icon.image.material = nil
			else
				self.frame.image.sprite = self:loadSprite(var_0_7.common_icon.room_furniture_frame.gray)
				self.bg.image.sprite = self:loadSprite(var_0_6(var_0_7.furniture_bg, 1))
				self.bg.icon.image.material = self:loadMaterial(var_0_7.common_icon.furniture_gray_material)
			end

			self.name_mask.name_txt.text.text = var_5_0[arg_6_1 + 1].title

			local var_6_0 = self.name_mask:GetComponent(typeof(TextScroller))

			var_6_0:SetText(var_5_0[arg_6_1 + 1].title)

			var_6_0.deltaLength = var_0_7.dormitory_const.text_interval
			var_6_0.scrollSpeed = var_0_7.dormitory_const.scroll_speed
		end
	end

	function arg_1_0:set_panel_state(arg_7_1)
		self._control.base_panel:SetActive(arg_7_1)
		self._control.fur_bg:SetActive(arg_7_1)
		self._control.detail_panel:SetActive(arg_7_1)
		self._control.single_detail:SetActive(not arg_7_1)
	end

	function arg_1_0:set_lock_interactable_state(arg_8_1)
		self._control.detail_panel.lock.button.interactable = arg_8_1
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_furniture_list()
		end

		self:set_panel_state(true)
		self:__init_furniture_detail()
		self:__set_lock_state()
		self:__set_case_data()
		self:__init_furniture_case_data()
		self:__set_furniture_collect_data()
		self:update_cell()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.base_panel.title.text.text = var_0_3:getNowLang("furnituredetailtitle")
		self._control.detail_panel.type_des.text.text = var_0_3:getNowLang("furnituredetailtype")
		self._control.detail_panel.area_des.text.text = var_0_3:getNowLang("furnituredetailarea")
	end

	function arg_1_0:__init_furniture_list()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.single_detail.scrollview.viewport.content.endlessScrollView, self._control.single_detail.scrollview.viewport.content, "single_furniture", "furniture_detail_panel")

		self._reusable_cell:init()
	end

	function arg_1_0:__init_furniture_case_data()
		if self._config_data.case_id == 0 then
			return
		end

		self._furniture_case_config = var_0_9.find_object_by_id(self._config_data.case_id)
		self._control.single_detail.title.text.text = self._furniture_case_config.title
		self._control.single_detail.furniture_des.text.text = self._furniture_case_config.desc
		self._furniture_case_list = {}

		for iter_12_0, iter_12_1 in pairs(self._furniture_case_config.furniture_cids) do
			var_0_2(self._furniture_case_list, (var_0_8.find_object_by_cid(iter_12_1)))
		end
	end

	function arg_1_0:__init_furniture_detail()
		self._control.fur_bg.image.sprite = self:loadSprite(var_0_6(var_0_7.furniture_bg, self._config_data.star))
		self._control.fur_bg.icon.image.sprite = self:loadSprite((var_0_7:get_ship_icon(var_0_7.furniture_s_img, self._config_data.icon)))
		self._control.detail_panel.title.text.text = self._config_data.title
		self._control.detail_panel.type_name.text.text = var_0_3:getNowLang("furnituretype" .. self._config_data.type)
		self._control.detail_panel.area_num.text.text = var_0_6(var_0_3:getNowLang("furnituresizetip"), self._config_data.width * self._config_data.height)
		self._control.detail_panel.furniture_des.text.text = self._config_data.desc
	end

	function arg_1_0:__set_lock_state()
		self._control.detail_panel.lock.image.sprite = self:loadSprite((self._now_furniture_data.lock or nil) and (var_0_7.dorm_furniture_lock_blue or var_0_7.dorm_furniture_lock_gray))
	end

	function arg_1_0:__set_case_data()
		if self._config_data.case_id == 0 then
			self._control.base_panel.add_bg.image.sprite = nil
			self._control.base_panel.add_bg.button.interactable = false
		else
			self._control.base_panel.add_bg.image.sprite = self:loadSprite(var_0_6(var_0_7.dorm_case_bg, self._config_data.case_id))
			self._control.base_panel.add_bg.button.interactable = true
		end
	end

	function arg_1_0:__set_furniture_collect_data()
		if #self._config_data.collection_id == 0 then
			self._control.detail_panel.btn_parent:SetActive(false)

			return
		end

		self._control.detail_panel.btn_parent:SetActive(true)

		for iter_16_0 = 1, self._control.detail_panel.btn_parent.transform.childCount do
			UnityEngine.Object.Destroy(self._control.detail_panel.btn_parent.transform:GetChild(iter_16_0 - 1).gameObject)
		end
	end

	function arg_1_0.__get_cur_furniture_data(arg_17_0, arg_17_1)
		local var_17_0 = false

		for iter_17_0, iter_17_1 in pairs((var_0_1:get_dormitory_furniture())) do
			if iter_17_1.cid == arg_17_1 then
				var_17_0 = true
			end
		end

		return var_17_0
	end

	function arg_1_0:__set_cur_panel_bg_state(arg_18_1)
		self._control.bg:SetActive(arg_18_1)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_19_0)
	local var_19_0 = var_0_4:class("furniture_detail_panel")

	var_19_0._is_already_init = nil
	var_19_0._furniture_detail_data = {}
	var_19_0._reusable_cell = nil
	var_19_0._now_furniture_data = nil
	var_19_0._config_data = nil
	var_19_0._furniture_case_config = nil
	var_19_0._furniture_case_list = {}

	return var_19_0
end

return var_0_0
