-- 角色使用普攻後，自身可以增加5%暴擊幾率（可疊加，最多5層）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040130 = oo.class(BuffBase)
function Buffer1000040130:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000040130:OnCreate(caster, target)
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
	-- 1000040131
	if SkillJudger:HasBuff(self, self.caster, target, true,1,1000040010) then
	else
		return
	end
	-- 1000040130
	self:AddAttr(BufferEffect[1000040130], self.caster, self.card, nil, "crit_rate",0.6)
end
