-- 剧情结束
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9033 = oo.class(SkillBase)
function Skill9033:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill9033:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8145
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 8499
	local count99 = SkillApi:BuffCount(self, caster, target,3,4,9037)
	-- 8197
	if SkillJudger:Equal(self, caster, target, true,count99,0) then
	else
		return
	end
	-- 9033
	self:StartPlay(SkillEffect[9033], caster, self.card, data, "new_player_fight")
end
