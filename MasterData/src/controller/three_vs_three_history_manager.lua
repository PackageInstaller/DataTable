local ThreeVsThreeHistoryManager = class("ThreeVsThreeHistoryManager", (require("controller.base_manager")))

ThreeVsThreeHistoryManager.MULTITON_MSG = "ThreeVsThreeHistoryManager instancealready constructed!"
ThreeVsThreeHistoryManager.LookNum = 10

local var_0_1 = tonumber

function ThreeVsThreeHistoryManager:ctor()
	ThreeVsThreeHistoryManager.super.ctor(self)

	self._seasonId = nil
	self._seasonIdTable = {}
	self._seasonInfo = {}
end

function ThreeVsThreeHistoryManager:requestInfo(arg_2_1)
	require("controller.arenatft_manager"):get_arenatft_historyRankConfig(function(arg_3_0)
		local var_3_0 = require("controller.time_check_manager"):getCurTime()

		if arg_3_0.list and next(arg_3_0.list) then
			self._seasonIdTable = {}

			for iter_3_0, iter_3_1 in pairs(arg_3_0.list) do
				if not self._seasonId then
					if global_get_time_by_date(iter_3_1.starttime) <= var_3_0 and var_3_0 < global_get_time_by_date(iter_3_1.finishtime) then
						self._seasonId = iter_3_1.seasonid
					end
				end

				table.insert(self._seasonIdTable, iter_3_1)

				self._seasonIdTable[#self._seasonIdTable].id = iter_3_1.seasonid
			end

			table.sort(self._seasonIdTable, function(arg_4_0, arg_4_1)
				return arg_4_0.id >= arg_4_1.id
			end)

			if not self._seasonId and self._seasonIdTable[1] then
				self._seasonId = self._seasonIdTable[1].id
			end
		end

		self:handlerInfo(arg_3_0)
	end)
end

function ThreeVsThreeHistoryManager:requestSeasonRankInfo(arg_5_1, arg_5_2)
	arg_5_1 = var_0_1(arg_5_1)

	if not arg_5_1 then
		return
	end

	require("network.network"):rpc("get_arenatft_ranklist", {
		start = 1,
		stop = ThreeVsThreeHistoryManager.LookNum,
		seasonid = arg_5_1
	}, function(arg_6_0)
		self._seasonId = arg_5_1
		self._seasonInfo = arg_6_0.data

		self:updateSeasonId()

		if arg_5_2 then
			arg_5_2(arg_6_0)
		end
	end)
end

function ThreeVsThreeHistoryManager:handlerInfo(arg_7_1)
	self:updateLayer()
	self:requestSeasonRankInfo(self._seasonId)
end

function ThreeVsThreeHistoryManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function ThreeVsThreeHistoryManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function ThreeVsThreeHistoryManager:updateSeasonId()
	if self.layer then
		self.layer:updateSeasonId()
	end
end

function ThreeVsThreeHistoryManager:getSeasonIdTable()
	return self._seasonIdTable
end

function ThreeVsThreeHistoryManager:getSeasonId()
	return self._seasonId
end

function ThreeVsThreeHistoryManager:setSeasonId(arg_13_1)
	arg_13_1 = var_0_1(arg_13_1)

	if arg_13_1 then
		self._seasonId = arg_13_1
	end
end

function ThreeVsThreeHistoryManager:getSeasonInfo()
	return self._seasonInfo
end

function ThreeVsThreeHistoryManager:getSeasonInfoByRank(arg_15_1)
	arg_15_1 = var_0_1(arg_15_1)

	if arg_15_1 then
		return self._seasonInfo[arg_15_1]
	end
end

return ThreeVsThreeHistoryManager
