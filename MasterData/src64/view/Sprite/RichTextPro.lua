RichTextPro = class("RichTextPro", function()
	return cc.Node:create()
end)

local RichLabel = require("view.Sprite.RichLabel")

function RichTextPro.create(arg_2_0)
	return (RichTextPro.new())
end

function RichTextPro.ctor(arg_3_0)
	arg_3_0.fontName = FONT_DES
	arg_3_0.fontSize = 22
	arg_3_0.fontColor = cc.c3b(242, 242, 242)
	arg_3_0.maxWidth = 600
	arg_3_0.lineSpace = 5
	arg_3_0.charSpace = 0
	arg_3_0.playAni = false
	arg_3_0.labelTable = {}
end

function RichTextPro.setColor(arg_4_0, arg_4_1)
	arg_4_0.fontColor = arg_4_1
end

function RichTextPro.setSize(arg_5_0, arg_5_1)
	arg_5_0.fontSize = arg_5_1
end

function RichTextPro.setFontName(arg_6_0, arg_6_1)
	arg_6_0.fontName = arg_6_1
end

function RichTextPro.setLineSpace(arg_7_0, arg_7_1)
	arg_7_0.lineSpace = arg_7_1
end

function RichTextPro:getTable()
	return self.labelTable
end

function RichTextPro:setText(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = 0
	local var_9_1, var_9_2, var_9_3 = self:htmlDecode(arg_9_1)
	local var_9_4 = 0
	local var_9_5 = 0
	local var_9_6 = {}

	for iter_9_0 = 1, #var_9_1 do
		var_9_1[iter_9_0] = string.gsub(var_9_1[iter_9_0], "</span>", "</div>")

		local var_9_7 = RichLabel.new({
			fontName = self.fontName,
			fontSize = self.fontSize,
			fontColor = self.fontColor,
			maxWidth = self.maxWidth,
			lineSpace = self.lineSpace,
			charSpace = self.charSpace,
			maxlinewidth = self.maxlinewidth
		})

		var_9_7:setString(var_9_1[iter_9_0], var_9_2[iter_9_0] or 0, arg_9_3)

		self.labelTable[#self.labelTable + 1] = var_9_7

		local var_9_8, var_9_9 = var_9_7:getSize()

		if var_9_5 < var_9_8 then
			var_9_5 = var_9_8
		end

		var_9_4 = var_9_4 + var_9_9

		var_9_7:setAnchorPoint(cc.p(0, 1))
		var_9_7:setPosition(cc.p(0, var_9_0))

		var_9_0 = var_9_0 - var_9_9

		if self.playAni and self.playAni == 1 then
			local var_9_10 = var_9_7:getCurLabels()

			for iter_9_1 = 1, #var_9_10 do
				table.insert(var_9_6, var_9_10[iter_9_1])
			end
		elseif self.playAni then
			var_9_7:playAnimation()
		end

		self:addChild(var_9_7)
	end

	if self.playAni and self.playAni == 1 then
		self:playWordOutAnimation(var_9_6, arg_9_2)
	end

	self.curwidth, self.curheight = var_9_5, var_9_4
	self.ContentHeight = -var_9_0
end

function RichTextPro:clearText()
	for iter_10_0, iter_10_1 in ipairs(self.labelTable) do
		iter_10_1:removeFromParent()
	end

	self.labelTable = {}
end

function RichTextPro.playWordOutAnimation(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1

	local function var_11_1(arg_12_0)
		if arg_12_0 > #var_11_0 then
			if arg_11_2 then
				arg_11_2()
			end

			return
		end

		local var_12_0 = var_11_0[arg_12_0]
		local var_12_1 = var_11_0[arg_12_0]:getString()
		local var_12_2 = var_12_1:len()
		local var_12_3 = 1

		var_11_0[arg_12_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.03), cc.CallFunc:create(function()
			var_12_0:setVisible(true)

			var_12_3 = var_12_3 + subStringGetByteCount(var_12_1, var_12_3)

			var_12_0:setString(var_12_1:sub(1, var_12_3 - 1))

			if var_12_3 > var_12_2 then
				var_12_0:stopAllActions()
				var_11_1(arg_12_0 + 1)
			end
		end))))
	end

	var_11_1(1)
end

function RichTextPro.setMaxWidth(arg_14_0, arg_14_1)
	arg_14_0.maxlinewidth = arg_14_1
end

function RichTextPro.setplayAni(arg_15_0, arg_15_1)
	arg_15_0.playAni = arg_15_1
end

function RichTextPro:getMaxWidth()
	return self.maxlinewidth
end

function RichTextPro:getContentSize()
	return self.curwidth, self.curheight
end

function RichTextPro:getContentHeight()
	return self.ContentHeight
end

function RichTextPro:htmlDecode(arg_19_1)
	arg_19_1 = string.gsub(arg_19_1, "rgb(0, 176, 240)", "rgb(0, 150, 250)")
	arg_19_1 = string.gsub(arg_19_1, "rgb(227, 108, 9)", "rgb(250, 150, 0)")
	arg_19_1 = string.gsub(arg_19_1, "target=(%.+)</a>", "' />")
	arg_19_1 = string.gsub(arg_19_1, "font%-family: ", "fontName=")
	arg_19_1 = string.gsub(arg_19_1, "<strong>", "<div fontname='fonts/newkj.ttf'>")
	arg_19_1 = string.gsub(arg_19_1, "</strong>", "</div>")

	local var_19_2

	arg_19_1, var_19_2 = string.gsub(arg_19_1, "font%-size: ", " fontSize=")
	arg_19_1 = string.gsub(arg_19_1, "color: ", "fontColor=")
	arg_19_1 = string.gsub(arg_19_1, "<p>", "<div>")
	arg_19_1 = string.gsub(arg_19_1, "span style=", "div ")
	arg_19_1 = string.gsub(arg_19_1, "px;", "")
	arg_19_1 = string.gsub(arg_19_1, "</br>", "")
	arg_19_1 = string.gsub(arg_19_1, "<br/>", "")
	arg_19_1 = string.gsub(arg_19_1, "</p>", "</div>")
	arg_19_1 = string.gsub(arg_19_1, "<p style=text%-indent: ", "<p retract=")
	arg_19_1 = string.gsub(arg_19_1, "<p ", "<div ")

	while string.find(arg_19_1, "img src=/") do
		local var_19_3, var_19_4 = string.find(arg_19_1, "img src=")
		local var_19_5, var_19_6 = string.find(arg_19_1, ".png")

		arg_19_1 = string.gsub(arg_19_1, ".png", ".png/")

		local var_19_7 = string.sub(arg_19_1, var_19_4 + 1, var_19_6)

		path_new = "'" .. var_19_7 .. "'"
		arg_19_1 = string.gsub(arg_19_1, var_19_7, path_new, 1)
	end

	while string.find(arg_19_1, "rgb") do
		arg_19_1 = self:transColor(arg_19_1)
	end

	local var_19_8 = 0
	local var_19_9 = {}
	local var_19_10 = {}
	local var_19_11 = {}

	while arg_19_1 and arg_19_1 ~= "" do
		local var_19_15, var_19_16, var_19_17, var_19_18 = self:divString(arg_19_1)

		arg_19_1 = var_19_16
		var_19_8 = var_19_8 + 1
		var_19_9[var_19_8] = var_19_15
		var_19_10[var_19_8] = var_19_17
		var_19_11[var_19_8] = var_19_18
	end

	return var_19_9, var_19_10, var_19_11
end

function RichTextPro.divString(arg_20_0, arg_20_1)
	local var_20_2, var_20_3 = string.find(arg_20_1, "</div>")

	if var_20_3 == nil then
		var_20_3 = #arg_20_1
	end

	local var_20_4 = string.sub(arg_20_1, 1, var_20_3)
	local var_20_5 = tonumber(string.match(var_20_4, "retract=(%d+)em")) or 0
	local var_20_6 = string.gsub(var_20_4, " retract=(%d+)em;>", ">")
	local var_20_7 = 0

	for iter_20_0 in string.gmatch(var_20_6, "fontSize=(%d+)") do
		if var_20_7 < tonumber(iter_20_0) then
			var_20_7 = tonumber(iter_20_0)
		end
	end

	return var_20_6, string.sub(arg_20_1, var_20_3 + 1), var_20_5, var_20_7
end

function RichTextPro.convertColor(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	for iter_21_0 = 1, #arg_21_1 do
		arg_21_1[iter_21_0] = string.format("%#x", arg_21_1[iter_21_0])
		arg_21_1[iter_21_0] = string.sub(arg_21_1[iter_21_0], 3)

		if arg_21_1[iter_21_0] == "" then
			arg_21_1[iter_21_0] = "00"
		elseif string.len(arg_21_1[iter_21_0]) == 1 then
			arg_21_1[iter_21_0] = "0" .. arg_21_1[iter_21_0]
		end
	end

	return "#" .. arg_21_1[1] .. arg_21_1[2] .. arg_21_1[3] .. " "
end

function RichTextPro:transColor(arg_22_1)
	local var_22_0, var_22_1 = string.find(arg_22_1, "rgb")
	local var_22_2

	if not var_22_1 then
		do return end

		var_22_2 = {}
	end

	var_22_2[1], var_22_2[2], var_22_2[3] = string.match(string.gsub(string.sub(arg_22_1, var_22_1 + 1, var_22_1 + 15), " ", ""), "(%d+),(%d+),(%d+)")
	arg_22_1 = string.sub(arg_22_1, 1, var_22_0 - 1) .. self:convertColor({}) .. string.sub(arg_22_1, string.find(arg_22_1, ")", var_22_0) + 1)

	return arg_22_1
end

return RichTextPro
