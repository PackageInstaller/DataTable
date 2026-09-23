-- 堅壘形態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913220401 = oo.class(BuffBase)
function Buffer913220401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913220401:OnCreate(caster, target)
	-- 913220401
	self:AddAttrPercent(BufferEffect[913220401], self.caster, self.card, nil, "defense",0.15)
end
