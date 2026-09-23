-- 躁動樂章（變調）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200300309 = oo.class(BuffBase)
function Buffer200300309:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200300309:OnCreate(caster, target)
	-- 200300309
	self:AddAttr(BufferEffect[200300309], self.caster, self.card, nil, "damage",0.24)
end
