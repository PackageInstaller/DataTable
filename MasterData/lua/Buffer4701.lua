-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4701 = oo.class(BuffBase)
function Buffer4701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4701:OnCreate(caster, target)
	-- 4701
	self:AddAttr(BufferEffect[4701], self.caster, target or self.owner, nil,"becure",0.1)
end
