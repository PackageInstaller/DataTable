local ToolLayer = class("ToolLayer", (require("view.Layer.BaseUILayer")))

ToolLayer._Name = "ToolLayer"

local TempWidget = require("view.Sprite.TempWidget")

ToolLayer.BUTTON_LIST = {
	{
		name = "角色偏移工具",
		callBack = function()
			if imgui and imgui.clear then
				imgui.clear()
			end

			package.loaded["role_pos_offset/start"] = nil

			require("role_pos_offset/start"):create()
		end
	},
	{
		name = "关闭角色偏移工具",
		callBack = function()
			if imgui and imgui.clear then
				imgui.clear()
			end
		end
	}
}

function ToolLayer:ctor()
	return
end

function ToolLayer:create()
	local var_4_0 = ToolLayer.new()

	if var_4_0:init() then
		var_4_0:setName(ToolLayer._Name)

		return var_4_0
	end
end

function ToolLayer:init()
	self:initLayer()

	return true
end

function ToolLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())
	var_6_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_6_0:setBackGroundColor(cc.c3b(255, 255, 255))
	var_6_0:setBackGroundColorOpacity(160)
	var_6_0:_addEvent(function()
		return
	end)

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempLayout(self._root)

	var_6_1:setContentSize(cc.size(80, 80))
	var_6_1:_setBack()
	var_6_1:_addEvent(function()
		var_6_1:runAction(cc.CallFunc:create(function()
			self:removeFromParent()
		end))
	end)
	var_6_1:align(cc.p(1, 1), self._root:property().right_top)
	var_6_1:setLocalZOrder(99)
	TempWidget:CreateTempLabel("关闭", FONT_NAME, 30, var_6_1):center()

	local var_6_2 = TempWidget:CreateTempListView(var_6_0)

	var_6_2:setDirection(ccui.ListViewDirection.vertical)
	var_6_2:setContentSize(cc.size(var_6_0:size().w, var_6_0:size().h - 100))

	self.listView = var_6_2

	self:updateListView()
end

function ToolLayer:onEnter()
	RoleOffsetLayer.super.onEnter(self)
end

function ToolLayer:onExit()
	RoleOffsetLayer.super.onExit(self)
end

function ToolLayer:updateListView()
	self.listView:removeAllItems()

	local var_12_0 = ToolLayer.BUTTON_LIST
	local var_12_1 = cc.size(250, 30)
	local var_12_2 = (self.listView:size().w - 2 * var_12_1.width) / (2 + 1)

	for iter_12_0 = 1, math.ceil(#ToolLayer.BUTTON_LIST / 2) do
		local var_12_3 = TempWidget:CreateTempLayout()

		var_12_3:setContentSize(cc.size(self.listView:size().w, 50))

		for iter_12_1 = 1, 2 do
			local var_12_4 = iter_12_0 * 2 - (2 - iter_12_1)

			if ToolLayer.BUTTON_LIST[iter_12_0 * 2 - (2 - iter_12_1)] then
				local var_12_5 = TempWidget:CreateTempLayout(var_12_3)

				var_12_5:setContentSize(var_12_1)
				var_12_5:_setBack()
				var_12_5:align(cc.p(0, 0), var_12_2 + (iter_12_1 - 1) * (var_12_2 + var_12_1.width), 0)
				var_12_5:_addEvent(function()
					if var_12_0[var_12_4].callBack then
						var_12_0[var_12_4].callBack()
					end

					var_12_5:runAction(cc.CallFunc:create(function()
						self:removeFromParent()
					end))
				end)
				TempWidget:CreateTempLabel(ToolLayer.BUTTON_LIST[iter_12_0 * 2 - (2 - iter_12_1)].name, FONT_NAME, 30, var_12_5):center()
			end
		end

		self.listView:pushBackCustomItem(var_12_3)
	end
end

return ToolLayer
