-- 受到修復弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1040307 = oo.class(BuffBase)
function Buffer1040307:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1040307:OnCreate(caster, target)
	-- 5707
	self:AddAttr(BufferEffect[5707], self.caster, target or self.owner, nil,"becure",-2)
end
