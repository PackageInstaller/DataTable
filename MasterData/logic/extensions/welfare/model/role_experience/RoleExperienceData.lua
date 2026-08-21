-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/role_experience/RoleExperienceData.lua

module("logic.extensions.welfare.model.role_experience.RoleExperienceData", package.seeall)

local M = class("RoleExperienceData", ActivityWelfareData)

function M:IsDisappear()
	return self._dynConfig.unlocked > 0 and self._dynConfig.rewardInfo > 0
end

function M:getRedDotActive()
	return self:getIsOpen() and self._dynConfig.unlocked > 0 and self._dynConfig.rewardInfo == 0
end

return M
