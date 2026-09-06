-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/config/MonthCardConfig.lua

module("logic.extensions.monthcard.config.MonthCardConfig", package.seeall)

local MonthCardConfig = class("MonthCardConfig", BaseConfig)

function MonthCardConfig:onInit()
	MonthCardConfig.super.onInit(self)

	self.monthCardCfg = nil
end

function MonthCardConfig:getNames()
	return {
		"month_card"
	}
end

function MonthCardConfig:handleConfig(name, content)
	if name == "month_card" then
		self.monthCardCfg = content
	end
end

function MonthCardConfig:getCfgByIndex(index)
	return self.monthCardCfg[index]
end

function MonthCardConfig:getCfgById(id)
	return self.monthCardCfg[id]
end

function MonthCardConfig:getAllCfgs()
	return self.monthCardCfg
end

function MonthCardConfig:getCardPrivilegeDescList(id)
	local cfg = self:getCfgById(id)

	return cfg.privilegeDesc
end

MonthCardConfig.instance = MonthCardConfig.New()

return MonthCardConfig
