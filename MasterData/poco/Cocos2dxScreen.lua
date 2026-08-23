local function var_0_0(arg_1_0, arg_1_1)
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
end

local var_0_1 = _G.cc or require("cc")
local var_0_2

xpcall(function()
	var_0_2 = _G.mime or require("mime")
end, function()
	var_0_2 = var_0_1.exports.mime
end)

local var_0_3 = var_0_0(".sdk.IScreen")
local var_0_4 = var_0_2 ~= nil and var_0_2.b64 or var_0_0(".support.base64").enc
local var_0_5 = {}

var_0_5.__index = var_0_5

setmetatable(var_0_5, var_0_3)

local var_0_6 = var_0_1.Director:getInstance()
local var_0_7 = var_0_6:getWinSize()
local var_0_8 = var_0_6:getOpenGLView():getFrameSize()

function var_0_5.getPortSize(arg_4_0)
	return {
		var_0_8.width,
		var_0_8.height
	}
end

function var_0_5.getScreen(arg_5_0, arg_5_1)
	local var_5_0 = "screenshot.png"
	local var_5_2 = var_0_6:getRunningScene()

	return function(arg_6_0)
		var_0_1.utils:captureScreen(function(arg_7_0, arg_7_1)
			if arg_7_0 then
				print("截图成功：" .. arg_7_1)

				local var_7_0 = io.open(arg_7_1, "rb")
				local var_7_1

				if not var_7_0 then
					print("截图文件不存在 2333")

					var_7_1 = {
						nil,
						"png"
					}
				end

				var_7_1[1] = var_0_4((var_7_0:read("*all")))

				arg_6_0(var_7_1)
				var_7_0:close()
				print("done!")
			else
				print("截图失败")
			end
		end, var_5_0)
	end
end

return var_0_5
