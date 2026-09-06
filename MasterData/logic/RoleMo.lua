-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/role/model/RoleMo.lua

module("logic.extensions.role.model.RoleMo", package.seeall)

local RoleMo = class("RoleMo")

function RoleMo:ctor()
	self:onReset()
end

function RoleMo:onReset()
	self.currentTimeMillis = ""
	self.zoneOffSetMillis = 0
	self.vipExp = 0
	self.userName = ""
	self.everMaxZdl = 0
	self.gender = 0
	self.userId = ""
	self.activeTime = ""
	self.settings = {}
	self.settings.screen = 0
	self.settings.settingSwitch = 0
	self.settings.musicVol = 0
	self.settings.soundEffectVol = 0
	self.onlineTime = 0
	self.curStrength = 0
	self.nextHpLeftTime = 0
	self.lastLogoutTime = 0
	self.zoneId = 0
	self.zoneName = ""
	self.consumeMoney = 0
	self.areaId = 0
	self.areaName = ""
	self.areaOpenTime = ""
	self.playerType = 0
	self.cardStates = {}
	self.headIconId = 0
	self.headFrameId = 0
	self.regressActId = -1
	self.hasFixedOutDateClothes = false
	self.hasJoinFamily = false
	self.regressInfo = nil
	self.guideMode = 0
end

function RoleMo:init(msg)
	self:onReset()

	local tb = GameUtil.pbToTable(msg, self)

	table.merge(self, tb)

	self.areaOpenTimeSec = math.floor(checknumber(self.areaOpenTime) / 1000)
	self.activeTimeSec = math.floor(checknumber(self.activeTime) / 1000)
	self.guideMode = msg:HasField("guideMode") and msg.guideMode or 0
end

return RoleMo
