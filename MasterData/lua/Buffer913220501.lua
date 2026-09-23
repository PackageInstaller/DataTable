-- 堅壘形態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913220501 = oo.class(BuffBase)
function Buffer913220501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913220501:OnCreate(caster, target)
	-- 913220501
	self:AddAttr(BufferEffect[913220501], self.caster, self.card, nil, "speed",20)
end
