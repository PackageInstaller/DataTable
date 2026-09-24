local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader

gamecore.UILoader:define("msgbox_marry", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self:__initial_func()

		self._control.main.main_text.luck_text.num_text.text.text = var_0_2:get("+5")
		self._control.main.main_text.repair_text.num_text.text.text = var_0_2:get("30%")
		self._control.main.main_text.love_text.num_text.text.text = var_0_2:get("100  >>>   200")
	end

	function arg_1_0:__initial_func()
		local var_4_0 = {
			{
				nodetext = "merriedinfotitle",
				node = self._control.main.title
			},
			{
				nodetext = "ui_cbtn1",
				node = self._control.main.confirmbtn.text
			},
			{
				nodetext = "merriedinfo1",
				node = self._control.main.main_text.luck_text
			},
			{
				nodetext = "merriedinfo2",
				node = self._control.main.main_text.repair_text
			},
			{
				nodetext = "merriedinfo3",
				node = self._control.main.main_text.love_text
			}
		}
		local var_4_1 = {}
		local var_4_2 = {
			init_language = function(self, arg_5_1)
				self.text.text = var_0_2:getNowLang(arg_5_1)
			end,
			init_active = function(self, arg_6_1)
				self.gameObject:SetActive(arg_6_1)
			end
		}

		for iter_4_0 = 1, #var_4_0 do
			var_4_2.init_language(var_4_0[iter_4_0].node, var_4_0[iter_4_0].nodetext)
		end

		for iter_4_1 = 1, #var_4_1 do
			var_4_2.init_active(var_4_1[iter_4_1].node, var_4_1[iter_4_1].state)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_3:class("msgbox_marry")

	gamecore.extend_obj(var_7_0)

	return var_7_0
end

return var_0_0
