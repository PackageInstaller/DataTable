-- 急救-等級2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10710 = oo.class(BuffBase)
function Buffer10710:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动开始
function Buffer10710:OnActionBegin(caster, target)
	-- 8405
	local c5 = SkillApi:PercentHp(self, self.caster, target or self.owner,3)
	-- 4710
	self:AddTempAttr(BufferEffect[4710], self.caster, self.card, nil, "becure",math.floor((1-c5)*10)*0.04)
end
