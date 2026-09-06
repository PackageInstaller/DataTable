-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareMissionFmtView.lua

module("logic.extensions.sharetask.view.ShareMissionFmtView", package.seeall)

local ShareMissionFmtView = class("ShareMissionFmtView", MissionFmtView)

function ShareMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function ShareMissionFmtView:_getCreepCos()
	local battleInfo = ShareTaskModel.instance:GetBattleBossInfo()

	if battleInfo == nil or checknumber(battleInfo.bossId) < 1 then
		return {}
	end

	local bossInfo
	local cfg = ShareTaskConfig.instance:GetBossBaseCfg((battleInfo.isMyBoss and ShareTaskModel.instance:GetMyShareBossInfo() or ShareTaskModel.instance:GetOtherShareBossInfo()).bossTypeId)

	if cfg == nil then
		return {}
	end

	local enemyCfgs = ShareTaskConfig.instance:GetBossTeamPosCfgs(cfg.creepsMasterId)

	return enemyCfgs or {}
end

function ShareMissionFmtView:_setFmtParams(heroSkillId, speed, zdlRadix)
	self:_setHeroSkill(heroSkillId)
	self:_updateDomainSkill()
	self:_updatePsychicedSkill()

	self._speed.text = speed
	self._power = zdlRadix
	self._powerTxt.text = "？？？"

	MissionModel.instance:setRightPower(zdlRadix)
	MissionModel.instance:setRightSpeed(speed)
	GlobalDispatcher:dispatch(GlobalNotify.FormationSpeedUpdate)

	local petPoses = {}

	for k, v in pairs(self._existPetPoses) do
		table.insert(petPoses, k)
	end

	MissionModel.instance:setPetPoses(petPoses)
end

function ShareMissionFmtView:_onClickPower()
	FloatWordMgr.instance:show("全员战斗力：？？？")
end

return ShareMissionFmtView
