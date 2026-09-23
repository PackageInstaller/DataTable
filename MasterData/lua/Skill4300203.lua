-- 影舞
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300203 = oo.class(SkillBase)
function Skill4300203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4300203:OnAttackOver(caster, target, data)
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
	-- 8481
	local count81 = SkillApi:BuffCount(self, caster, target,2,3,4300201)
	-- 8169
	if SkillJudger:Greater(self, caster, target, true,count81,0) then
	else
		return
	end
	-- 4300203
	self:LimitDamage(SkillEffect[4300203], caster, target, data, 1,0.4)
	-- 4300207
	self:ShowTips(SkillEffect[4300207], caster, self.card, data, 2,"机敏",true,4300207)
end
