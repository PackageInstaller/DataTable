-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTower3v3FmtRightView.lua

module("logic.extensions.formation.view.MangTower3v3FmtRightView", package.seeall)

local MangTower3v3FmtRightView = class("MangTower3v3FmtRightView", FormationRightView)

function MangTower3v3FmtRightView:onEnter()
	MangTower3v3FmtRightView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.CurFormTabChange, self._OnFormationChanged, self)
end

function MangTower3v3FmtRightView:onExit()
	MangTower3v3FmtRightView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CurFormTabChange, self._OnFormationChanged, self)
end

function MangTower3v3FmtRightView:_getCurFormation()
	local tab = MangTowerModel.instance:getSelectFmtTab()

	return MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_3V3, tab)
end

function MangTower3v3FmtRightView:_onForbidDragTips(petData)
	if petData then
		local tabIdx = MangTowerController.instance:isInOtherTab(petData.raceId)

		if tabIdx then
			FloatWordMgr.instance:show(langPara("%s队伍中已使用该精灵", tabIdx))

			return
		end
	end

	local var_4_0 = petData ~= nil and self:_getCurFormation():HasPet(petData.petId) or false
	local inTeam = true

	goto label_4_0

	::label_4_0::

	local hasUp = FormationNewModel.instance:checkHasInTeamByRaceId(petData.raceId)

	if not inTeam and hasUp then
		FloatWordMgr.instance:show(lang("阵上已经拥有相同的精灵了，不能重复上阵哦！"))
	end

	local canNotUpYuan = self:getYuanLimit(petData)

	if canNotUpYuan then
		FloatWordMgr.instance:show(lang("已达到上阵限制，源属性精灵最多上阵两只"))

		return
	end
end

function MangTower3v3FmtRightView:updateForbit(data)
	local inTeam = self:getInTeam(data)
	local hasUp = self:getHasUp(data)
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)

	data:setPetForbit(not inTeam and ((data and MangTowerController.instance:isInOtherTab(data.raceId) or nil) and true or canNotUp or hasOne or canNotUp))
end

return MangTower3v3FmtRightView
