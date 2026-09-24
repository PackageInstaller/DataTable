local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = gamecore.prompt
local var_0_5 = gamecore.Language
local var_0_6 = DG.Tweening.DOTween
local var_0_7 = lx.UserData

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_ship_empty_add_ship_btn()
		local var_2_0 = var_0_3:get_secretary_info().members
		local var_2_1 = var_0_1:getInstance("ship_clerk_prepare")

		var_2_1._control.bg_2:SetActive(true)
		var_2_1:setVisible(false)

		local var_2_2 = var_0_1:getInstance("select_member")
		local var_2_3 = self:autoKillDOTween(var_0_6.Sequence())

		local function var_2_4()
			var_2_1._control.bg_2:SetActive(false)
		end

		if var_2_2 then
			var_2_2:show_by_type(var_0_2.enter_select_member_type.secretary_info_ship, var_2_0)
		else
			var_0_1:createInstance("select_member"):show_by_type(var_0_2.enter_select_member_type.secretary_info_ship, var_2_0)
		end

		var_2_3:AppendInterval(0.1)
		var_2_3:AppendCallback(var_2_4)
		var_2_3:Play()
	end

	function arg_1_0:__onLongClick_ship_empty_add_ship_btn()
		if self._data and next(self._data) then
			local var_4_0 = var_0_1:getInstance("ship_clerk_prepare")

			var_0_7:setKeyData("is_secretary_info_id", self._data.id)

			if var_4_0 then
				var_4_0._control.select_bg:SetActive(false)
				var_4_0:_set_mian_secretary_list()
			end

			var_0_4:show(var_0_5:getNowLang("secretary_set"))
		end
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
