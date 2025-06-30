-- chunkname: @IQIGame\\UIExternalApi\\HomeLandWorkRoomUIApi.lua

HomeLandWorkRoomUIApi = BaseLangApi:Extend()

function HomeLandWorkRoomUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("title2", self.GetTitle2)
	self:RegisterApi("time", self.GetTime)
	self:RegisterApi("progress", self.GetProgress)
	self:RegisterApi("eventTime", self.GetEventTime)
	self:RegisterApi("eventDesc", self.GetEventDesc)
	self:RegisterApi("workName", self.GetWorkName)
	self:RegisterApi("workDesc", self.GetWorkDesc)
	self:RegisterApi("rewardTitle", self.GetRewardTitle)
	self:RegisterApi("rewardTitle2", self.GetRewardTitle2)
end

function HomeLandWorkRoomUIApi:GetRewardTitle()
	return self:GetCfgText(1015199)
end

function HomeLandWorkRoomUIApi:GetRewardTitle2()
	return self:GetCfgText(1015204)
end

function HomeLandWorkRoomUIApi:GetWorkName(name)
	return name
end

function HomeLandWorkRoomUIApi:GetWorkDesc(desc)
	return desc
end

function HomeLandWorkRoomUIApi:GetEventTime(time)
	return time
end

function HomeLandWorkRoomUIApi:GetEventDesc(name, eventDesc, effect)
	return "<color=#3e9ada>" .. name .. "</color>" .. "" .. eventDesc .. "" .. effect
end

function HomeLandWorkRoomUIApi:GetTitle2()
	return self:GetCfgText(1015200)
end

function HomeLandWorkRoomUIApi:GetProgress(cur, total)
	return self:GetCfgText(1015201) .. ":" .. math.floor(cur / total * 100) .. "%"
end

function HomeLandWorkRoomUIApi:GetTitle()
	return self:GetCfgText(1015202)
end

function HomeLandWorkRoomUIApi:GetTime(time)
	return self:GetCfgText(1015203) .. "<color=#58ffd2>" .. tostring(time) .. "</color>"
end

HomeLandWorkRoomUIApi:Init()
