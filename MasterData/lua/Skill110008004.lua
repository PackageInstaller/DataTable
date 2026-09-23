-- 自身受到群体攻击后，将承受伤害的30％反弹给攻击方
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008004 = oo.class(SkillBase)
function Skill110008004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill110008004:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8616
	local count616 = SkillApi:GetBeDamage(self, caster, target,3)
	-- 8816
	if SkillJudger:Greater(self, caster, target, true,count616,0) then
	else
		return
	end
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 110008004
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[110008004], caster, caster, data, 302301)
		-- 22912
		self:AddHp(SkillEffect[22912], caster, caster, data, math.floor(-count616*0.30))
	end
end
