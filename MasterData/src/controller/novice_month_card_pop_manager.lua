local NoviceMonthCardPopManager = class("NoviceMonthCardPopManager", (require("controller.base_manager")))

NoviceMonthCardPopManager.MULTITON_MSG = "NoviceMonthCardPopManager instancealready constructed!"

local var_0_1 = "activitypop13002820:"

function NoviceMonthCardPopManager:ctor()
	NoviceMonthCardPopManager.super.ctor(self)

	self._data = {
		day = 0
	}
end

function NoviceMonthCardPopManager:requestInfo(arg_2_1)
	return
end

function NoviceMonthCardPopManager:requestPopInfo()
	require("network.network"):rpc("check_autopop_sign", nil, function(arg_4_0)
		for iter_4_0, iter_4_1 in pairs(arg_4_0.list) do
			if string.find(iter_4_1, var_0_1) then
				self._data.day = tonumber((string.gsub(iter_4_1, var_0_1, "")))

				LayerManager:pushInLayer("NoviceMonthCardPopLayer")

				break
			end
		end
	end)
end

function NoviceMonthCardPopManager:requestReward()
	require("network.network"):rpc("get_activity_pop_drop", {
		id = 13002820
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			global_gain({
				gold = arg_6_0.gold,
				sp = arg_6_0.sp,
				items = arg_6_0.items,
				surecallback = function()
					if self.layer then
						LayerManager:removePopLayer(self.layer.__queueindex)
					end
				end,
				cancelcallback = function()
					if self.layer then
						LayerManager:removePopLayer(self.layer.__queueindex)
					end
				end
			})
		elseif arg_6_0.result == 2 then
			global_ShowBlockWords("今日已领取")
			LayerManager:removePopLayer(self.layer.__queueindex)
		elseif arg_6_0.result == 3 then
			global_ShowBlockWords("已过期")
			LayerManager:removePopLayer(self.layer.__queueindex)
		else
			LayerManager:removePopLayer(self.layer.__queueindex)
		end
	end)
end

function NoviceMonthCardPopManager:handlerInfo(arg_9_1)
	return
end

function NoviceMonthCardPopManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function NoviceMonthCardPopManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function NoviceMonthCardPopManager:popLayer(arg_12_1)
	if string.find(arg_12_1, var_0_1) then
		self._data.day = tonumber((string.gsub(arg_12_1, var_0_1, "")))

		LayerManager:pushInLayer("NoviceMonthCardPopLayer")
	end
end

function NoviceMonthCardPopManager:getDay()
	return self._data.day
end

return NoviceMonthCardPopManager
