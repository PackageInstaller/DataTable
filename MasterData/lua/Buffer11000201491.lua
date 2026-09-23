-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer11000201491 = oo.class(BuffBase)
function Buffer11000201491:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer11000201491:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8720
	local c116 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"hp")
	-- 11000201491
	if self:Rand(3000) then
		self:AddHp(BufferEffect[11000201491], self.caster, self.card, nil, -math.floor(c116*0.99,1))
	end
end
