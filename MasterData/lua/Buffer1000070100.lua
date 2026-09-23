-- 角色使用追擊後，自身可以增加【癲狂】效果：5%暴擊幾率（可疊加，最多5層）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070100 = oo.class(BuffBase)
function Buffer1000070100:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer1000070100:OnAfterHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8248
	if SkillJudger:IsBeatAgain(self, self.caster, target, true) then
	else
		return
	end
	-- 1000070100
	self:AddBuff(BufferEffect[1000070100], self.caster, self.card, nil, 1000070051)
end
