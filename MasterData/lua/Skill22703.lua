-- 庇护III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22703 = oo.class(SkillBase)
function Skill22703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill22703:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8223
	if SkillJudger:IsDamageType(self, caster, target, true,2) then
	else
		return
	end
	-- 22703
	self:AddTempAttr(SkillEffect[22703], caster, target, data, "bedamage",-0.2)
end
-- 行动开始
function Skill22703:OnActionBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 227010
	self:ShowTips(SkillEffect[227010], caster, self.card, data, 2,"光幕",true,227010)
end
