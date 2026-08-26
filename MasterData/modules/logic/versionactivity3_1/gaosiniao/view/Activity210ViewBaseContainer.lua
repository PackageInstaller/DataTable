-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/Activity210ViewBaseContainer.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.Activity210ViewBaseContainer", package.seeall)

local Activity210ViewBaseContainer = class("Activity210ViewBaseContainer", TaskViewBaseContainer)
local kPrefix = "Activity210|"

function Activity210ViewBaseContainer:getPrefsKeyPrefix()
	return kPrefix .. tostring(self:actId())
end

function Activity210ViewBaseContainer:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function Activity210ViewBaseContainer:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

return Activity210ViewBaseContainer
