-- 夜幕
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer950100702 = oo.class(BuffBase)
function Buffer950100702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer950100702:OnCreate(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8416
	local c16 = SkillApi:LiveCount(self, self.caster, target or self.owner,3)
	-- 950100702
	self:AddTempAttr(BufferEffect[950100702], self.caster, self.card, nil, "damage",0.1*c16)
end
