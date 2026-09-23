-- 连锁阵线第二期buff2（通用偏爆发）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000015 = oo.class(SkillBase)
function Skill6000015:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill6000015:OnActionBegin(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4200207
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[4200207], caster, caster, data, 4200202,1)
	end
end
-- 行动结束
function Skill6000015:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 95007
	if self:Rand(5000) then
		self:AlterBufferByGroup(SkillEffect[95007], caster, self.card, data, 1,1)
	end
end
