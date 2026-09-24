local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.AuditServerManager

gamecore.UILoader:define("select_server", function(arg_1_0)
	function arg_1_0:getIP()
		return self._ip
	end

	function arg_1_0:getPort()
		return self._port
	end

	function arg_1_0:getOther()
		return self._other
	end

	function arg_1_0:getName()
		return self._name
	end

	function arg_1_0:show(arg_6_1, arg_6_2)
		self:setVisible(arg_6_1)

		if arg_6_1 then
			self._server_list = arg_6_2

			self:__load_server_list()
		end

		local var_6_0 = app:getSystem():getChannel()

		if var_6_0 == "xiaomi" or var_6_0 == "yyb" then
			self._control.select_big_server_item:SetActive(false)
		else
			self._control.select_big_server_item:SetActive(true)
		end

		if var_0_4:isAuditVersion() then
			self._control.select_big_server_item:SetActive(false)
		end
	end

	function arg_1_0:__load_server_list()
		local var_7_0 = self._server_list

		if not self._server_list or not next(self._server_list) then
			log.errorlog("no server")

			return
		end

		table.sort(self._server_list, function(arg_8_0, arg_8_1)
			return arg_8_0.id < arg_8_1.id
		end)

		local var_7_1 = var_0_2:getInstance("enter_game")

		self:destroyChildren("server_item")

		for iter_7_0, iter_7_1 in pairs(self._server_list) do
			local var_7_2 = self._server_list[iter_7_0].ip
			local var_7_3 = self._server_list[iter_7_0].port
			local var_7_4 = self._server_list[iter_7_0].other
			local var_7_5 = self._server_list[iter_7_0].name
			local var_7_6, var_7_7 = self:loadUIPrefab("server_item", self._control.scroll_view.Viewport.Content.transform)

			var_7_6:setVisible(true)
			self:__set_server_state(self._server_list[iter_7_0].state, var_7_7)

			var_7_7.status.text.text = var_0_1:getNowLang(var_0_3.server_state[self._server_list[iter_7_0].state].language)
			var_7_7.server_name.text.text = self._server_list[iter_7_0].name

			var_7_7.m_proleflag:SetActive(var_7_1:judge_server_history(self._server_list[iter_7_0].id))
			var_7_7.bar_bg.button.onClick:AddListener(function()
				var_7_1:select_server_control(true, var_7_0[iter_7_0])
				self:__select_server(var_7_2, var_7_3, var_7_4, var_7_5)
			end)
		end
	end

	function arg_1_0:__select_server(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
		self._ip = arg_10_1
		self._port = arg_10_2
		self._other = arg_10_3
		self._name = arg_10_4

		if arg_10_5 then
			return
		end

		self:setVisible(false)
	end

	function arg_1_0.__set_server_state(arg_11_0, arg_11_1, arg_11_2)
		for iter_11_0 = 1, arg_11_2.status_tip.transform.childCount do
			arg_11_2.status_tip.transform:GetChild(iter_11_0 - 1).gameObject:SetActive(false)
		end

		arg_11_2.status_tip.transform.transform:Find(var_0_3.server_state[arg_11_1].rect_name).gameObject:SetActive(true)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_2:class("select_server")

	var_12_0._ip = ""
	var_12_0._port = ""
	var_12_0._other = nil
	var_12_0._name = nil
	var_12_0._server_list = {}

	gamecore.extend_obj(var_12_0)

	return var_12_0
end

return var_0_0
