-- 神秘金字塔技能6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill934100601 = oo.class(SkillBase)
function Skill934100601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill934100601:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill934100601:OnActionOver(caster, target, data)
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
	-- 8445
	local count45 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 934100601
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[934100601], caster, target, data, -count45*0.5)
	end
end
