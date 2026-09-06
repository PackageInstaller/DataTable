-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/SeniorFormationRightView.lua

module("logic.extensions.formation.view.SeniorFormationRightView", package.seeall)

local SeniorFormationRightView = class("SeniorFormationRightView", FormationRightView)

function SeniorFormationRightView:onEnter()
	SeniorFormationRightView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.CurFormTabChange, self._onFormTabChange, self)
end

function SeniorFormationRightView:onExit()
	SeniorFormationRightView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CurFormTabChange, self._onFormTabChange, self)
end

function SeniorFormationRightView:_onFormTabChange()
	return
end

function SeniorFormationRightView:_onForbidDragTips(petData)
	if petData then
		local tabIdx = SeniorArenaController.instance:isInOtherTab(petData.petId)

		if tabIdx then
			FloatWordMgr.instance:show(langPara("【%s】阵型中已使用该精灵", tabIdx))

			return
		end
	end

	local inTeam = self:getInTeam(petData)
	local hasUp = FormationNewModel.instance:checkHasInTeamByRaceId(petData.raceId)

	if not inTeam and hasUp then
		FloatWordMgr.instance:show(lang("阵上已经拥有相同的精灵了，不能重复上阵哦！"))

		return
	end

	local canNotUp, hasOne = self:getSummonLimit(petData)

	if canNotUp then
		local mo = self:getPetMoById(petData.summonMasterId)

		FloatWordMgr.instance:show(langPara("该精灵被召唤师%s契约绑定，不能单独上阵", (mo or nil) and mo.name))

		return
	end

	local canNotUpYuan = self:getYuanLimit(petData)

	if canNotUpYuan then
		FloatWordMgr.instance:show(lang("已达到上阵限制，源属性精灵最多上阵两只"))

		return
	end
end

function SeniorFormationRightView:updateForbit(data)
	local inTeam = self:getInTeam(data)
	local hasUp = FormationNewModel.instance:checkHasInTeamByRaceId(data.raceId)

	if data then
		local tabIdx = SeniorArenaController.instance:isInOtherTab(data.petId)

		if SeniorArenaController.instance:isInOtherTab(data.petId) then
			hasUp = true
		end
	end

	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)

	data:setPetForbit(not inTeam and (hasUp or canNotUp or hasOne or canNotUpWithYuan))
end

return SeniorFormationRightView
