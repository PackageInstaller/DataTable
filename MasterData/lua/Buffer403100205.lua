-- 超速模式
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer403100205 = oo.class(BuffBase)
function Buffer403100205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer403100205:OnCreate(caster, target)
	-- 403100205
	self:AddAttr(BufferEffect[403100205], self.caster, target or self.owner, nil,"speed",100)
	-- 403100207
	self:AddSp(BufferEffect[403100207], self.caster, self.card, nil, 20)
end
-- 攻击开始
function Buffer403100205:OnAttackBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 403100206
	self:AddAttr(BufferEffect[403100206], self.caster, self.card, nil, "crit_rate",2)
end
