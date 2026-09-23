-- 强势反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4102305 = oo.class(SkillBase)
function Skill4102305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4102305:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8498
	local count98 = SkillApi:BuffCount(self, caster, target,3,4,10230)
	-- 8194
	if SkillJudger:Greater(self, caster, target, true,count98,0) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 102300310
	self:OwnerAddBuffCount(SkillEffect[102300310], caster, self.card, data, 102300310,1,5)
end
-- 入场时
function Skill4102305:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4102316
	self:CallSkillEx(SkillEffect[4102316], caster, self.card, data, 102300201)
end
