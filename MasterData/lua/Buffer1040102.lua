-- 攻擊弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1040102 = oo.class(BuffBase)
function Buffer1040102:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1040102:OnCreate(caster, target)
	-- 1040102
	self:AddAttrPercent(BufferEffect[1040102], self.caster, target or self.owner, nil,"attack",-0.40)
end
