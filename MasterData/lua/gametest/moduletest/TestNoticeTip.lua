--[[
-- added by wsh @ 2017-01-12
--]]

local function Run()
	UIManager:GetInstance():OpenTwoButtonTip("标题", "测试内容1", "按钮1", "按钮2", function()   --ignoreCN
		print("点击了按钮1")   --ignoreCN
	end,function()
		print("点击了按钮2")   --ignoreCN
	end)
	coroutine.start(function()
		local index = UIManager:GetInstance():WaitForTipResponse()
		print("等待响应结束：", index)   --ignoreCN
	end)
	coroutine.start(function()
		coroutine.waitforseconds(3)
		UIManager:GetInstance():OpenThreeButtonTip("标题", "测试内容2", "按钮1", "按钮2", "按钮3", function()   --ignoreCN
			print("点击了按钮1")   --ignoreCN
		end,function()
			print("点击了按钮2")   --ignoreCN
		end,function()
			print("点击了按钮3")   --ignoreCN
		end)
	end)
end

return {
	Run = Run
}