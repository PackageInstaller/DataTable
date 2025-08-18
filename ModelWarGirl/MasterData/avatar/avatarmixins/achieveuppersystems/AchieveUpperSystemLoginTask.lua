-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\AchieveUpperSystems\\AchieveUpperSystemLoginTask.lua

local AchieveUpperSystemBase = require("Avatar/AvatarMixins/AchieveUpperSystems/AchieveUpperSystemBase")
local ResAchieve = require("ClientData/ResAchieve")
local EventConst = require("EventConst")
local AchieveUpperSystemLoginTask = Class("AchieveUpperSystemLoginTask", AchieveUpperSystemBase)

function AchieveUpperSystemLoginTask:initUpperSystem(svrData)
	for achieveId, achieveInfo in pairs(ResAchieve) do
		if achieveInfo.trunk_flag and achieveInfo.trunk_flag == Const.ACHEVE_UPPER_SYSTEM_LOGINTASK then
			self.achieveDict[achieveId] = true

			table.insert(self.achieveList, achieveId)
		end
	end

	table.sort(self.achieveList, function(a, b)
		return a < b
	end)
	self:_refreshRedDotEvent()
end

function AchieveUpperSystemLoginTask:_refreshDlg(...)
	return
end

function AchieveUpperSystemLoginTask:_refreshRedDotEvent()
	local hasHint = false
	local isQualify, isGot

	for achieveId, _ in pairs(self.achieveDict) do
		isQualify = CurAvatar.achieveQualify[achieveId]
		isGot = CurAvatar.achieveAwardGot[achieveId]
		hasHint = isQualify and not isGot

		if hasHint then
			break
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_LOGIN_ACHIEVE, hasHint)
end

return AchieveUpperSystemLoginTask
