-- 當角色身上有【增傷】詞條時，增加暴擊率+30%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040091 = oo.class(BuffBase)
function Buffer1000040091:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000040091:OnBefourHurt(caster, target)
	-- 1000040091
	local targets = SkillFilter:All(self, self.caster, target or self.owner, nil)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[1000040091], self.caster, target, nil, "damage",0.2)
	end
end
