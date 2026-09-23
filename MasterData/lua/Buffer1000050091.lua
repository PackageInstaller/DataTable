-- 共鳴：弱化Ⅰ
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050091 = oo.class(BuffBase)
function Buffer1000050091:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000050091:OnCreate(caster, target)
	-- 1000050091
	self:AddAttrPercent(BufferEffect[1000050091], self.caster, target or self.owner, nil,"bedamage",0.08*self.nCount)
end
