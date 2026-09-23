-- 鱼雷攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980100101 = oo.class(SkillBase)
function Skill980100101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill980100101:DoSkill(caster, target, data)
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
