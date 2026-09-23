-- 靈魂之歌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200700314 = oo.class(BuffBase)
function Buffer200700314:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200700314:OnCreate(caster, target)
	-- 200700313
	self:AddAttr(BufferEffect[200700313], self.caster, target or self.owner, nil,"cure",0.4)
	-- 4608
	self:AddAttr(BufferEffect[4608], self.caster, target or self.owner, nil,"resist",0.4)
end
