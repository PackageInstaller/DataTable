-- 克拉肯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911200701 = oo.class(SkillBase)
function Skill911200701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill911200701:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 911200701
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuffCount(SkillEffect[911200701], caster, target, data, 911200701,1,10)
	end
end
