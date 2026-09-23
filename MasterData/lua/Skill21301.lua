-- 防护I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill21301 = oo.class(SkillBase)
function Skill21301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill21301:OnBorn(caster, target, data)
	-- 21301
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
		-- 2201
		local targets = SkillFilter:All(self, caster, target, 1)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[2201], caster, target, data, 2101)
		end
		-- 213010
		self:ShowTips(SkillEffect[213010], caster, self.card, data, 2,"屏障",true,213010)
	end
end
