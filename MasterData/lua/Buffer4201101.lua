-- 攻擊傷害-4%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4201101 = oo.class(BuffBase)
function Buffer4201101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4201101:OnCreate(caster, target)
	-- 4201101
	self:AddAttr(BufferEffect[4201101], self.caster, target or self.owner, nil,"damage",-0.04)
end
