-- 攻擊傷害-8%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4201102 = oo.class(BuffBase)
function Buffer4201102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4201102:OnCreate(caster, target)
	-- 4201102
	self:AddAttr(BufferEffect[4201102], self.caster, target or self.owner, nil,"damage",-0.06)
end
