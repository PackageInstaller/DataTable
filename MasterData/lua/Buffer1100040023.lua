-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100040023 = oo.class(BuffBase)
function Buffer1100040023:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer1100040023:OnRoundBegin(caster, target)
	-- 6112
	self:ImmuneBuffID(BufferEffect[6112], self.caster, target or self.owner, nil,3003)
end
