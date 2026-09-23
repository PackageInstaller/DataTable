-- 迅击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603500102 = oo.class(SkillBase)
function Skill603500102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603500102:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill603500102:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 603500101
	self:HitAddBuff(SkillEffect[603500101], caster, target, data, 3000,3007)
end
-- 回合开始时
function Skill603500102:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 603500601
	local r = self.card:Rand(2)+1
	if 1 == r then
		-- 603500401
		self:ChangeSkill(SkillEffect[603500401], caster, self.card, data, 2,603500201)
	elseif 2 == r then
		-- 603500501
		self:ChangeSkill(SkillEffect[603500501], caster, self.card, data, 2,603500401)
	end
end
