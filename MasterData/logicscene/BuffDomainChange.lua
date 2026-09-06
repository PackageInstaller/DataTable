-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffDomainChange.lua

module("logicscene.scene.battle.skills.buffs.BuffDomainChange", package.seeall)

local BuffDomainChange = class("BuffDomainChange", BuffBase)

function BuffDomainChange:ctor(buffCo, unit, skillId, skillLevel)
	BuffDomainChange.super.ctor(self, buffCo, unit)

	local domainSkillCo = BattleConfig.instance:getDomainSkillLevelCo(skillId, skillLevel)

	if domainSkillCo then
		self._domainSkillScene = GameUrl.getBattleStageUrl(domainSkillCo.scene)
	end

	self._skillId = skillId
	self._skillLevel = skillLevel
end

function BuffDomainChange:onBuffBegin()
	BuffDomainChange.super.onBuffBegin(self)

	if not BattleModel.instance:getBattleBgCoverDomain() then
		BattleStagesMgr.instance:loadStage(self._domainSkillScene, self._onDomainSceneLoaded, self)
	end

	BattleDoaminSkillMgr.instance:triggedDomainSkill(self._unit, self._skillId, self._skillLevel)
	GlobalDispatcher:dispatch(GlobalNotify.OnDomainSkillTrigged, self._unit)
end

function BuffDomainChange:onBuffEnd()
	local unit = self._unit

	BuffDomainChange.super.onBuffEnd(self)
	BattleDoaminSkillMgr.instance:removeDomainSkill(unit)
	GlobalDispatcher:dispatch(GlobalNotify.OnDomainSkillRemoved, unit)
end

function BuffDomainChange:_onDomainSceneLoaded()
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)

	if battleScene and battleScene.stage and battleScene.stage.changeStage then
		battleScene.stage:changeStage(self._domainSkillScene)
	end
end

function BuffDomainChange:getBuffId()
	return UnitCompBuffList.DomainChange
end

function BuffDomainChange:isCustomBuff()
	return true
end

return BuffDomainChange
