-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6200021 = oo.class(BuffBase)
function Buffer6200021:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 加buff时
function Buffer6200021:OnAddBuff(caster, target, buffer)
	-- 8061
	if SkillJudger:CasterIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 8258
	if SkillJudger:IsCtrlBuff(self, self.caster, target, true,2) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8263
	if SkillJudger:IsCallSkill(self, self.caster, target, false) then
	else
		return
	end
	-- 6200021
	self:AddBuffCount(BufferEffect[6200021], self.caster, self.card, nil, 6200019,1,20)
end
