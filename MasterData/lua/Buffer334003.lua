-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334003 = oo.class(BuffBase)
function Buffer334003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer334003:OnCreate(caster, target)
	-- 334003
	self:AddAttr(BufferEffect[334003], self.caster, target or self.owner, nil,"becure",0.20)
end
