-- 缭乱幻想（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill201501301 = oo.class(SkillBase)
function Skill201501301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill201501301:DoSkill(caster, target, data)
	-- 11084
	self.order = self.order + 1
	local targets = SkillFilter:Different(self, caster, target, 4,6)
	for i,target in ipairs(targets) do
		-- 11085
		self:DamageLight(SkillEffect[11085], caster, target, data, 1,1)
		-- 11086
		self:AddOrder(SkillEffect[11086], caster, target, data, nil)
	end
end
-- 伤害后
function Skill201501301:OnAfterHurt(caster, target, data)
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
	-- 201501301
	self:HitAddBuff(SkillEffect[201501301], caster, target, data, 4000,3501)
end
