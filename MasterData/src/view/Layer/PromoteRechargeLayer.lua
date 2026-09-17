local supermarket_limited_time_package_manager = require("controller.supermarket_limited_time_package_manager")

local function var_0_1(arg_1_0)
	if not arg_1_0 then
		return ""
	end

	if arg_1_0 > 86400 then
		return string.format(L_TIME_SINGLE.Day, math.floor(arg_1_0 / 3600 / 24))
	elseif arg_1_0 >= 3600 then
		return string.format(L_TIME_SINGLE.Hour, math.floor(arg_1_0 / 3600))
	elseif arg_1_0 >= 60 then
		return string.format(L_TIME_SINGLE.Minute, math.floor(arg_1_0 % 3600 / 60))
	else
		return string.format(L_TIME_SINGLE.Minute, 1)
	end
end

PromoteRechargeLayer = class("PromoteRechargeLayer", function()
	return ccui.Layout:create()
end)

function PromoteRechargeLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PromoteRechargeLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function PromoteRechargeLayer:init(arg_4_1)
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)

	local var_4_0 = ccui.Layout:create()

	var_4_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_4_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_4_0:setBackGroundColor(cc.c3b(10, 10, 10))
	var_4_0:setBackGroundColorOpacity(120)
	var_4_0:setTouchEnabled(true)
	var_4_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootlayer:addChild(var_4_0)
	var_4_0:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_4_1 = require("view.Layer.SupermarketLayer.SupermarketLimitedTimePackageLayer"):create(8998)

	self.rootlayer:addChild(var_4_1)

	local var_4_2 = cc.Label:createWithTTF("", FONT_DES, 32)

	var_4_0:addChild(var_4_2)
	var_4_2:setPosition(var_4_0:getContentSize().width / 2, var_4_1:getPositionY() + 340)
	supermarket_limited_time_package_manager:getSpecialPacksInfo(function(arg_6_0)
		if arg_6_0.result == 1 then
			hx_print("getSpecialPacksInfo")
			print_lua_table(arg_6_0)

			if tolua.isnull(self) then
				return
			end

			if not arg_6_0.result_info or not next(arg_6_0.result_info) then
				return
			end

			for iter_6_0, iter_6_1 in pairs(arg_6_0.result_info) do
				if iter_6_1.id == 8998 then
					var_4_2:setString("剩余时间:" .. var_0_1(iter_6_1.endtime - require("controller.time_check_manager"):getCurTime()))

					return
				end
			end
		end
	end)
end

return PromoteRechargeLayer
