local RadioButtonGroup = class("RadioButtonGroup", function()
	return cc.Node:create()
end)
local Utility = require("common.Utility")

function RadioButtonGroup:create(...)
	local var_2_0 = RadioButtonGroup.new()

	var_2_0:init(...)

	return var_2_0
end

function RadioButtonGroup:init(arg_3_1)
	self.initParams = arg_3_1 or {}
	self.btns = {}
	self.length = 0
	self.maxWidth = 640
	self.maxHeight = 1000
	self.listView = ccui.ListView:create()

	self.listView:setContentSize(cc.size(640, 40))
	self.listView:setDirection(self.initParams.direction or ccui.ListViewDirection.horizontal)
	self.listView:setGravity(5)
	self.listView:setItemsMargin(self.initParams.space or 5)
	self:addChild(self.listView)
end

function RadioButtonGroup:setTouchEnabled(arg_4_1)
	self.listView:setTouchEnabled(arg_4_1)
end

function RadioButtonGroup:doLayout()
	if self.length == 0 then
		return
	end

	local var_5_0 = self.btns[1]:getContentSize()
	local var_5_1 = 0
	local var_5_2 = 0

	if (self.initParams.direction or ccui.ListViewDirection.horizontal) == ccui.ListViewDirection.horizontal then
		var_5_1 = self.length * var_5_0.width + math.max(0, self.length - 1) * self.listView:getItemsMargin()
		var_5_2 = var_5_0.height
	else
		var_5_1 = var_5_0.width
		var_5_2 = self.length * var_5_0.height + math.max(0, self.length - 1) * self.listView:getItemsMargin()
	end

	self.listView:setContentSize(cc.size(math.min(self.maxWidth, var_5_1), (math.min(self.maxHeight, var_5_2))))
	self.listView:doLayout()
end

function RadioButtonGroup:setInnerContentSize(arg_6_1)
	self.listView:setContentSize(arg_6_1)
	self.listView:doLayout()
end

function RadioButtonGroup:setMaxContentSize(arg_7_1)
	self.maxWidth = arg_7_1.width
	self.maxHeight = arg_7_1.height
end

function RadioButtonGroup:getInnerContentSize()
	return self.listView:getContentSize()
end

function RadioButtonGroup:getInnerContainer()
	return self.listView
end

function RadioButtonGroup:addButton(arg_10_1)
	self.listView:pushBackCustomItem(arg_10_1)

	self.btns[#self.btns + 1] = arg_10_1
	self.length = self.length + 1

	Utility:addClickEventListener(arg_10_1, handler(self, self.onSingleBtn), true)
end

function RadioButtonGroup:getButton(arg_11_1)
	if arg_11_1 < 0 or arg_11_1 > self.length then
		return
	end

	return self.btns[arg_11_1]
end

function RadioButtonGroup:removeButton(arg_12_1)
	local var_12_0 = Utility:indexOf(self.btns, arg_12_1)

	if var_12_0 < 0 then
		return
	end

	arg_12_1:removeFromParent()
	table.remove(self.btns, var_12_0)

	self.length = self.length - 1
end

function RadioButtonGroup:removeAllButton()
	self.listView:removeAllChildren()

	self.btns = {}
	self.length = 0
end

function RadioButtonGroup:registerClickEvent(arg_14_1)
	self.clickFunc = arg_14_1
end

function RadioButtonGroup:onSingleBtn(arg_15_1, arg_15_2)
	local var_15_0 = Utility:indexOf(self.btns, arg_15_1)

	if var_15_0 < 0 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(self.btns) do
		if iter_15_1 ~= arg_15_1 then
			iter_15_1:setTouchEnabled(true)
			iter_15_1:setBright(true)
		else
			iter_15_1:setTouchEnabled(false)
			iter_15_1:setBright(false)
		end
	end

	if self.clickFunc and arg_15_2 then
		self.clickFunc(var_15_0)
	end
end

function RadioButtonGroup:setSelectedButton(arg_16_1, arg_16_2)
	if arg_16_1 < 1 or arg_16_1 > self.length then
		return
	end

	self:onSingleBtn(self.btns[arg_16_1], arg_16_2)
end

function RadioButtonGroup:setClippingEnabled(arg_17_1)
	self.listView:setClippingEnabled(arg_17_1)
end

return RadioButtonGroup
