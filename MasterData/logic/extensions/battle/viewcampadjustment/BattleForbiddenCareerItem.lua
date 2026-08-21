-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleForbiddenCareerItem.lua

module("logic.extensions.battle.viewcampadjustment.BattleForbiddenCareerItem", package.seeall)

local M = class("BattleForbiddenCareerItem", UIReusableLuaBehavior)

function M:buildUI()
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "txtHint3")
end

function M:destroyUI()
	self._txtContent = false
end

function M:setForbiddenCareer(career)
	self._txtContent.text = string.format("禁用<color=#fd3d47>%s</color>", CharacterCOUtil.getCareerName(career))
end

function M:setForbiddenCamp(camp)
	self._txtContent.text = string.format("禁用<color=#fd3d47>%s</color>", CommEnum.CampType2Name[camp])
end

return M
