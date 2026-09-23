-- 汲取攻擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer8501 = oo.class(BuffBase)
function Buffer8501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer8501:OnCreate(caster, target)
	-- 8407
	local gj1 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"gj1")
	-- 8501
	self:AddAttr(BufferEffect[8501], self.caster, self.caster, nil, "attack",gj1*0.2)
end
