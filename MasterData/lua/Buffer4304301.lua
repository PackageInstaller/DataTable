-- 強化劑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4304301 = oo.class(BuffBase)
function Buffer4304301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4304301:OnCreate(caster, target)
	-- 4901
	self:AddAttr(BufferEffect[4901], self.caster, target or self.owner, nil,"bedamage",-0.05)
	-- 4301
	self:AddAttr(BufferEffect[4301], self.caster, target or self.owner, nil,"crit_rate",0.05)
	-- 4401
	self:AddAttr(BufferEffect[4401], self.caster, target or self.owner, nil,"crit",0.05)
end
