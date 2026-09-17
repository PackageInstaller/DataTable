local TempWidget = class("TempWidget")
local NodeEx = require("view.Sprite.NodeEx")
local var_0_2 = config._DEBUG and 0 or 1

TempWidget.Click = NodeEx.Click
TempWidget.Press = NodeEx.Press

function TempWidget:CreateTempImg(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = ccui.ImageView:create(arg_1_1, arg_1_3 or var_0_2)

	NodeEx:extend(var_1_0)

	if arg_1_2 then
		arg_1_2:addChild(var_1_0)
	end

	function var_1_0.loadTextureEx(arg_2_0, arg_2_1, arg_2_2)
		var_1_0:loadTexture(arg_2_1, arg_2_2 or var_0_2)
	end

	return var_1_0
end

function TempWidget:CreateTempSprite(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3 or var_0_2
	local var_3_1

	if (arg_3_3 or var_0_2) == ccui.TextureResType.localType then
		var_3_1 = cc.Sprite:create(arg_3_1)
	elseif var_3_0 == ccui.TextureResType.plistType then
		var_3_1 = cc.Sprite:createWithSpriteFrameName(arg_3_1)
	end

	NodeEx:extend(var_3_1)

	if arg_3_2 then
		arg_3_2:addChild(var_3_1)
	end

	return var_3_1
end

function TempWidget:CreateTempLabel(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = cc.Label:createWithTTF(arg_4_1, arg_4_2, arg_4_3)

	NodeEx:extend(var_4_0)

	if arg_4_4 then
		arg_4_4:addChild(var_4_0)
	end

	return var_4_0
end

function TempWidget:CreateTempBtn(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = ccui.Button:create()

	NodeEx:extend(var_5_0)

	if arg_5_1 then
		var_5_0:loadTextureNormal(arg_5_1, arg_5_3 or var_0_2)
	end

	if arg_5_2 then
		arg_5_2:addChild(var_5_0)
	end

	return var_5_0
end

function TempWidget:CreateTempLayout(arg_6_1)
	local var_6_0 = ccui.Layout:create()

	NodeEx:extend(var_6_0)

	if arg_6_1 then
		arg_6_1:addChild(var_6_0)
	end

	var_6_0:setBackGroundImageScale9Enabled(true)
	var_6_0:setBackGroundImageCapInsets(cc.rect(var_6_0:getContentSize().width / 2 - 1, var_6_0:getContentSize().height / 2 - 1, 2, 2))

	return var_6_0
end

function TempWidget:CreateTempListView(arg_7_1)
	local var_7_0 = ccui.ListView:create()

	NodeEx:extend(var_7_0)

	if arg_7_1 then
		arg_7_1:addChild(var_7_0)
	end

	var_7_0:setDirection(ccui.ListViewDirection.vertical)
	var_7_0:setBackGroundImageScale9Enabled(true)
	var_7_0:setBackGroundImageCapInsets(cc.rect(var_7_0:getContentSize().width / 2 - 1, var_7_0:getContentSize().height / 2 - 1, 2, 2))

	return var_7_0
end

function TempWidget:CreateTempScrollView(arg_8_1)
	local var_8_0 = ccui.ScrollView:create()

	NodeEx:extend(var_8_0)

	if arg_8_1 then
		arg_8_1:addChild(var_8_0)
	end

	var_8_0:setDirection(ccui.ScrollViewDir.horizontal)
	var_8_0:setBackGroundImageScale9Enabled(true)
	var_8_0:setBackGroundImageCapInsets(cc.rect(var_8_0:getContentSize().width / 2 - 1, var_8_0:getContentSize().height / 2 - 1, 2, 2))

	return var_8_0
end

return TempWidget
