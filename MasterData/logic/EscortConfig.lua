-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/config/EscortConfig.lua

module("logic.extensions.escort.config.EscortConfig", package.seeall)

local EscortConfig = class("EscortConfig", BaseConfig)

function EscortConfig:onInit()
	EscortConfig.super.onInit(self)

	self.boxWuziInfo = nil
	self.boxUpdataInfo = nil
	self.boxRewardInfo = nil
	self.baxBaseInfo = nil
	self.robotFormatInfo = nil
end

function EscortConfig:getNames()
	return {
		"convoy_box",
		"convoy_box_upgrade_cost",
		"convoy_param",
		"convoy_creeps"
	}
end

function EscortConfig:handleConfig(name, content)
	if name == "convoy_box" then
		self.boxWuziInfo = content
	elseif name == "convoy_box_upgrade_cost" then
		local num = 0
		local max = 0

		self.boxUpdataInfo = {}

		for _, cfg in pairs(content or {}) do
			if cfg and cfg.times then
				if max < cfg.times then
					max = cfg.times
				end

				if not string.nilorempty(cfg.consume) then
					self.boxUpdataInfo[cfg.times] = string.split(cfg.consume, ":")
				elseif num < cfg.times then
					num = cfg.times
				end
			end
		end

		self.baxBaseInfo = self.baxBaseInfo or {}
		self.baxBaseInfo.freeUpdataCount = num
		self.baxBaseInfo.maxUpdataCount = max
	elseif name == "convoy_reward" then
		self.boxRewardInfo = content
	elseif name == "convoy_param" then
		self.baxBaseInfo = self.baxBaseInfo or {}

		local openTimes = {
			{
				endHour = 13,
				startHour = 12,
				startMin = 0,
				endMin = 0
			},
			{
				endHour = 19,
				startHour = 18,
				startMin = 0,
				endMin = 0
			}
		}

		if content.openTime and not string.nilorempty(content.openTime.paramVal) then
			local list = string.split(content.openTime.paramVal, ",")

			if list and #list > 0 then
				openTimes = {}

				for i = 1, #list do
					local strs = string.split(list[i], "-")

					if strs and #strs == 2 then
						local a = string.split(strs[1], ":")
						local b = string.split(strs[2], ":")

						table.insert(openTimes, {
							startHour = tonumber(a[1]),
							startMin = tonumber(a[2]),
							endHour = tonumber(b[1]),
							endMin = tonumber(b[2])
						})
					end
				end
			end

			self.baxBaseInfo.openTimeArr = list
		end

		self.baxBaseInfo.openTimes = openTimes
		self.baxBaseInfo.maxConvoyTimes = content.maxConvoyTimes and not string.nilorempty(content.maxConvoyTimes.paramVal) and tonumber(content.maxConvoyTimes.paramVal) or 2
		self.baxBaseInfo.maxFreeChallengeTimes = content.maxFreeChallengeTimes and not string.nilorempty(content.maxFreeChallengeTimes.paramVal) and tonumber(content.maxFreeChallengeTimes.paramVal) or 2
		self.baxBaseInfo.maxBeChallengedTimes = content.maxBeChallengedTimes and not string.nilorempty(content.maxBeChallengedTimes.paramVal) and tonumber(content.maxBeChallengedTimes.paramVal) or 2
		self.baxBaseInfo.convoyPeriod = content.convoyPeriod and not string.nilorempty(content.convoyPeriod.paramVal) and tonumber(content.convoyPeriod.paramVal) * 60 or 1800
		self.baxBaseInfo.convoyLines = content.convoyLine and not string.nilorempty(content.convoyLine.paramVal) and string.split(content.convoyLine.paramVal, ",") or {
			"1011001",
			"1181011",
			"1151003",
			"1161004"
		}
		self.baxBaseInfo.convoyItem = content.convoyItem and not string.nilorempty(content.convoyItem.paramVal) and content.convoyItem.paramVal or "4:701"
		self.baxBaseInfo.robberyItem = content.robberyItem and not string.nilorempty(content.robberyItem.paramVal) and content.robberyItem.paramVal or "4:702"
		self.baxBaseInfo.wuziStr = content.materialItem and not string.nilorempty(content.materialItem.paramVal) and content.materialItem.paramVal or "4:700"
		self.baxBaseInfo.convoySlowDown = content.convoySlowDown and not string.nilorempty(content.convoySlowDown.paramVal) and tonumber(content.convoySlowDown.paramVal) or 3000
		self.baxBaseInfo.npcWhereMapIcon = string.split((content.npcWhereMapIcon and not string.nilorempty(content.npcWhereMapIcon.paramVal) or nil) and content.npcWhereMapIcon.paramVal, ",")
		self.baxBaseInfo.notOpenView = {}

		if content.notOpenView and not string.nilorempty(content.notOpenView.paramVal) then
			self.baxBaseInfo.notOpenView = string.splitToNumber(content.notOpenView.paramVal, ",")
		end
	elseif name == "convoy_creeps" then
		self.robotFormatInfo = content
	end
end

function EscortConfig:GetBoxWuziInfo(index)
	if self.boxWuziInfo == nil then
		return nil
	end

	if index == nil or index < 1 then
		return self.boxWuziInfo
	end

	local cfg = self.boxWuziInfo[index]

	if cfg == nil then
		cfg = self.boxWuziInfo[#self.boxWuziInfo]
	end

	return cfg
end

function EscortConfig:GetBoxUpdataInfo(index)
	if self.boxUpdataInfo == nil then
		return nil
	end

	if index == nil or index <= 0 then
		return self.boxUpdataInfo
	end

	local free = self.baxBaseInfo.freeUpdataCount
	local max = self.baxBaseInfo.maxUpdataCount

	if index <= free then
		return nil
	end

	if max <= index then
		return self.boxUpdataInfo[max]
	end

	return self.boxUpdataInfo[index]
end

function EscortConfig:GetBoxRewardInfo(index)
	return
end

function EscortConfig:GetBaxBaseInfo()
	return self.baxBaseInfo
end

function EscortConfig:GetPlayerSpeedRatio()
	if self.baxBaseInfo == nil or self.baxBaseInfo.convoySlowDown == nil or self.baxBaseInfo.convoySlowDown <= 0 then
		return -0.5
	end

	return self.baxBaseInfo.convoySlowDown / 10000 - 1
end

function EscortConfig:GetRobotFormatInfo(robotId)
	if self.robotFormatInfo then
		return self.robotFormatInfo[robotId]
	end
end

EscortConfig.instance = EscortConfig.New()

return EscortConfig
