local device_manager = require("controller.device_manager")
local var_0_1 = "public/button/hyperlink_button.png"
local var_0_2 = "public/button/hyperlink_button.png"
local var_0_3 = "public/button/hyperlink_button.png"

return function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_1.href then
		return
	end

	local var_1_0 = ccui.Button:create(var_0_1, var_0_2, var_0_3, config._DEBUG and 0 or 1)

	var_1_0:setScale9Enabled(true)
	var_1_0:setCapInsets(cc.rect(0, 0, 10, 1))

	local var_1_2 = cc.Label:createWithTTF(arg_1_1.content, arg_1_3.fontName, arg_1_3.fontSize)

	var_1_2:setAnchorPoint(0.5, 0.5)
	var_1_2:setColor(cc.c3b(0, 187, 255))
	var_1_0:setContentSize(cc.size(var_1_2:getContentSize().width, var_1_2:getContentSize().height + 5))
	var_1_2:setPosition(cc.p(var_1_2:getContentSize().width / 2, var_1_2:getContentSize().height / 2 + 2.5))
	var_1_0:addChild(var_1_2)
	var_1_0:addTouchEventListener(function(arg_2_0, arg_2_1)
		if arg_2_1 == ccui.TouchEventType.began then
			arg_2_0:setScale(1.1)
			var_1_2:setScale(1)
		end

		if arg_2_1 == ccui.TouchEventType.canceled then
			arg_2_0:setScale(1)
			var_1_2:setScale(1)
		end

		if arg_2_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_2_0:setScale(1)
		var_1_2:setScale(1)
		device_manager.openURL(arg_1_1.href)
	end)

	return {
		var_1_0
	}
end
