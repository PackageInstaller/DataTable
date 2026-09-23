-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer331401 = oo.class(BuffBase)
function Buffer331401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer331401:OnCreate(caster, target)
	-- 331401
	self:AddAttr(BufferEffect[331401], self.caster, target or self.owner, nil,"becure",0.04)
end
