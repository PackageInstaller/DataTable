-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020072 = oo.class(BuffBase)
function Buffer1100020072:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100020072:OnCreate(caster, target)
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 1100020072
	self:AddHp(BufferEffect[1100020072], self.caster, target or self.owner, nil,-math.min(700000,math.floor(0.03*c116,1)))
end
