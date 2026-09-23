-- 攻擊傷害-12%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4201103 = oo.class(BuffBase)
function Buffer4201103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4201103:OnCreate(caster, target)
	-- 4201103
	self:AddAttr(BufferEffect[4201103], self.caster, target or self.owner, nil,"damage",-0.10)
end
