-- 普攻追擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010241 = oo.class(BuffBase)
function Buffer1100010241:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010241:OnCreate(caster, target)
	-- 8405
	local c5 = SkillApi:PercentHp(self, self.caster, target or self.owner,3)
	-- 1100010241
	self:AddAttr(BufferEffect[1100010241], self.caster, self.card, nil, "becure",math.floor((1-c5)*10)*0.04)
end
