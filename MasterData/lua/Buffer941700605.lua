-- 減傷
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer941700605 = oo.class(BuffBase)
function Buffer941700605:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer941700605:OnActionOver2(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 941700605
	self:OwnerAddBuffCount(BufferEffect[941700605], self.caster, self.card, nil, 941700601,-1,6)
end
