-- 莫拉鲁塔技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603000303 = oo.class(SkillBase)
function Skill603000303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603000303:DoSkill(caster, target, data)
	-- 11006
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11006], caster, target, data, 0.167,6)
end
-- 攻击结束
function Skill603000303:OnAttackOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8736
	local count736 = SkillApi:GetCount(self, caster, target,2,603000101)
	-- 8948
	if SkillJudger:Less(self, caster, target, true,count736,4) then
	else
		return
	end
	-- 603000303
	self:HitAddBuffCount(SkillEffect[603000303], caster, target, data, 10000,603000101,1,4)
end
-- 攻击结束2
function Skill603000303:OnAttackOver2(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 603000313
	self:HitAddBuff(SkillEffect[603000313], caster, target, data, 10000,603000303,2)
end
