-- 外殼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932800803 = oo.class(BuffBase)
function Buffer932800803:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932800803:OnCreate(caster, target)
	-- 932800803
	if self:Rand(6000) then
		self:AddAttr(BufferEffect[932800803], self.caster, self.card, nil, "damage",-0.5)
	end
end
