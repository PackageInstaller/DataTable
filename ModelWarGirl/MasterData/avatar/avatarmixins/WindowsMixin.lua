-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\WindowsMixin.lua

local ResQQBlueAchieveDayGift = require("ClientData/ResQQBlueAchieveDayGift")
local ResQQBlueAchieveForeverGift = require("ClientData/ResQQBlueAchieveForeverGift")
local WindowsMixin = {}

function WindowsMixin:initWindowsMixin(baseData, syncData)
	self.qqPrivilege = {}

	self:initQQPrivilege(baseData.necessary.misc.qq_blue)
end

function WindowsMixin:postinitWindowsMixin(baseData, syncData)
	return
end

function WindowsMixin:destroyWindowsMixin()
	return
end

function WindowsMixin:onNewDayWindows()
	self:onQQBlueDataNewDay()
end

function WindowsMixin:initQQPrivilege(qq_blue)
	self:onQQBlueDataNotify(qq_blue)
end

function WindowsMixin:onQQBlueDataNotify(update_data)
	self.qqPrivilege.foreverAward = ClientUtils.getBitsDictFromByteString(update_data.forever_bit)

	if ClientUtils.isTickToday(update_data.refresh_day) then
		self.qqPrivilege.dayAward = ClientUtils.getBitsDictFromByteString(update_data.day_bit)
	else
		self.qqPrivilege.dayAward = {}
	end

	self:checkQQBlueDataNew()

	local dlgs = UIManager.tryGetUI("qqPrivilegeDlg")

	if dlgs then
		dlgs:onDataRefresh()
	end
end

function WindowsMixin:onQQBlueDataNewDay()
	self.qqPrivilege.dayAward = {}

	self:checkQQBlueDataNew()

	local dlgs = UIManager.tryGetUI("qqPrivilegeDlg")

	if dlgs then
		dlgs:onDataRefresh()
	end
end

function WindowsMixin:onQQBlueInfoNotify(vip_valid_time, year_vip_valid_time, super_vip_valid_time, expand_vip_valid_time, blue_vip_level)
	self.qqBlueLevel = blue_vip_level
	self.vip_valid_time = vip_valid_time
	self.year_vip_valid_time = year_vip_valid_time
	self.super_vip_valid_time = super_vip_valid_time
	self.expand_vip_valid_time = expand_vip_valid_time

	self:checkQQBlueDataNew()

	local dlgs = UIManager.tryGetUI("qqPrivilegeDlg")

	if dlgs then
		dlgs:onDataRefresh()
	end
end

function WindowsMixin:getQQBlueStep()
	if ChannelUtil.isQQGame() then
		local now = ClientUtils.getServerTime()

		if now <= (self.expand_vip_valid_time or 0) then
			return 4
		elseif now <= (self.year_vip_valid_time or 0) then
			return 3
		elseif now <= (self.super_vip_valid_time or 0) then
			return 2
		elseif now <= (self.vip_valid_time or 0) then
			return 1
		end
	end

	return 0
end

function WindowsMixin:checkQQBlueDataNew()
	local onceNew = false
	local foreverNew = false
	local dayNew = false

	if self:getQQBlueStep() > 0 then
		for index, achInfo in ipairs(ResQQBlueAchieveForeverGift) do
			if self.qqPrivilege.foreverAward and self.qqPrivilege.foreverAward[achInfo.id] then
				-- block empty
			elseif self:isBattlePassedServerMode(achInfo.check_param or 0) then
				if index == 1 then
					onceNew = true
				else
					foreverNew = true

					break
				end
			end
		end

		for index, achInfo in ipairs(ResQQBlueAchieveDayGift) do
			if self.qqPrivilege.dayAward and self.qqPrivilege.dayAward[achInfo.id] then
				-- block empty
			elseif self:getQQBlueStep() >= (achInfo.blue_step or 0) then
				dayNew = true

				break
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_QQ_PRIVILEGE_ONCE, onceNew)
	RedDotManager.setKeyState(UIConst.RD_HINT_QQ_PRIVILEGE_ACHIEVE, foreverNew)
	RedDotManager.setKeyState(UIConst.RD_HINT_QQ_PRIVILEGE_DAY, dayNew)
end

return WindowsMixin
