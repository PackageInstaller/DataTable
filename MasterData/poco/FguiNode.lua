local var_0_0 = _G.cc or require("cc")
local var_0_1 = (function(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1 = arg_1_0

	while true do
		if string.byte(arg_1_0, 1) ~= 46 then
			var_1_1 = string.sub(arg_1_0, 1)

			if var_1_0 and #var_1_0 > 0 then
				var_1_1 = table.concat(var_1_0, ".") .. "." .. var_1_1
			end

			break
		end

		if not var_1_0 then
			if not arg_1_1 then
				local var_1_3, var_1_4 = debug.getlocal(3, 1)

				arg_1_1 = var_1_4
			end

			var_1_0 = string.split(arg_1_1, ".")
		end

		table.remove(var_1_0, #var_1_0)
	end

	return require(var_1_1)
end)(".sdk.AbstractNode")
local var_0_2 = {}

var_0_2.__index = var_0_2

setmetatable(var_0_2, var_0_1)

function var_0_2.new(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {}

	setmetatable(var_2_0, var_0_2)

	var_2_0.node = arg_2_1
	var_2_0.screenWidth = arg_2_2
	var_2_0.screenHeight = arg_2_3

	return var_2_0
end

function var_0_2:getParent()
	local var_3_0 = self.node:getParent()

	if var_3_0 == nil then
		return nil
	end

	self:new(var_3_0, self.screenWidth, self.screenHeight)
end

function var_0_2:getChildren()
	local var_4_0 = {}

	if self.node.getChildren then
		for iter_4_0, iter_4_1 in ipairs(self.node:getChildren()) do
			table.insert(var_4_0, self:new(iter_4_1, self.screenWidth, self.screenHeight))
		end
	end

	return var_4_0
end

function var_0_2.getAvailableAttributeNames(arg_5_0)
	local var_5_0 = {
		"text",
		"touchable",
		"enabled",
		"rotation",
		"skew",
		"_instanceId",
		"getVisible"
	}

	for iter_5_0, iter_5_1 in ipairs(var_0_1.getAvailableAttributeNames(arg_5_0)) do
		table.insert(var_5_0, iter_5_1)
	end

	return var_5_0
end

function var_0_2:getAttr(arg_6_1)
	if arg_6_1 == "visible" then
		if not self.node:isVisible() then
			return false
		end

		local var_6_0 = self.node:getParent()

		while var_6_0 do
			if not var_6_0:isVisible() then
				return false
			end

			var_6_0 = var_6_0:getParent()
		end

		return true
	elseif arg_6_1 == "name" then
		local var_6_1 = self.node:getName()

		if var_6_1 == "" then
			var_6_1 = "未命名"
		end

		return var_6_1
	elseif arg_6_1 == "text" then
		if self.node.getText then
			return self.node:getText():match("^%s*(.-)%s*$")
		elseif self.node.getTitle then
			return self.node:getTitle():match("^%s*(.-)%s*$")
		end

		return nil
	elseif arg_6_1 == "type" then
		return (tolua.type(self.node):gsub("^fgui%.", ""))
	elseif arg_6_1 == "pos" then
		local var_6_2 = self.node:localToGlobal(var_0_0.p(0, 0))

		var_6_2.x = var_6_2.x / self.screenWidth
		var_6_2.y = var_6_2.y / self.screenHeight

		local var_6_3 = self.node:getSize()

		if var_6_3 ~= nil then
			var_6_3.width = var_6_3.width / self.screenWidth
			var_6_3.height = var_6_3.height / self.screenHeight
		end

		if not self.node:isPivotAsAnchor() then
			var_6_2.x = var_6_2.x + 0.5 * var_6_3.width
			var_6_2.y = var_6_2.y + 0.5 * var_6_3.height
		end

		var_6_2.x = math.min(1, math.max(0, var_6_2.x))
		var_6_2.y = math.min(1, math.max(0, var_6_2.y))

		return {
			var_6_2.x,
			var_6_2.y
		}
	elseif arg_6_1 == "size" then
		local var_6_4 = self.node:getSize()

		if var_6_4 ~= nil then
			var_6_4.width = var_6_4.width / self.screenWidth
			var_6_4.height = var_6_4.height / self.screenHeight

			return {
				var_6_4.width,
				var_6_4.height
			}
		end
	elseif arg_6_1 == "scale" then
		return {
			self.node:getScaleX(),
			self.node:getScaleY()
		}
	elseif arg_6_1 == "anchorPoint" then
		local var_6_5 = self.node:getPivot()

		return {
			0.5,
			0.5
		}
	elseif arg_6_1 == "zOrders" then
		return {
			global = self.node:getSortingOrder(),
			["local"] = self.node:getSortingOrder()
		}
	elseif arg_6_1 == "touchable" then
		if self.node.isTouchable then
			return self.node:isTouchable()
		end

		return nil
	elseif arg_6_1 == "enabled" then
		if self.node.isEnabled then
			return self.node:isEnabled()
		end

		return nil
	elseif arg_6_1 == "rotation" then
		if self.node.getRotation then
			return self.node:getRotation()
		end

		return 0
	elseif arg_6_1 == "skew" then
		if self.node.getSkewX and self.node.getSkewY then
			return {
				self.node:getSkewX(),
				self.node:getSkewY()
			}
		end

		return nil
	elseif arg_6_1 == "_instanceId" then
		if self.node.setText ~= nil then
			return tostring(self.node)
		end
	elseif arg_6_1 == "getVisible" then
		if not self.node:displayObject():isVisible() then
			return false
		end

		local var_6_6 = self.node:getParent()

		while var_6_6 do
			if not var_6_6:displayObject():isVisible() then
				return false
			end

			var_6_6 = var_6_6:getParent()
		end

		return true
	end

	return var_0_1.getAttr(self, arg_6_1)
end

function var_0_2:setAttr(arg_7_1, arg_7_2)
	if arg_7_1 == "text" and self.node.setText then
		self.node:setText(arg_7_2)

		return true
	end

	return var_0_1.setAttr(self, arg_7_1, arg_7_2)
end

return var_0_2
