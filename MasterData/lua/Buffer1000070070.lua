-- 角色使用反擊後，自身可以提升5%暴擊傷害（可疊加，最多五層）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070070 = oo.class(BuffBase)
function Buffer1000070070:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1000070070:OnActionOver(caster, target)
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
	-- 8244
	if SkillJudger:IsBeatBack(self, self.caster, target, true) then
	else
		return
	end
	-- 1000070070
	self:AddAttr(BufferEffect[1000070070], self.caster, self.card, nil, "crit",0.2)
end
