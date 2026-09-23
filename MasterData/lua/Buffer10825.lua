-- 源源不斷-等級6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10825 = oo.class(BuffBase)
function Buffer10825:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer10825:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4825
	if self:Rand(5000) then
		self:AddNp(BufferEffect[4825], self.caster, target or self.owner, nil,10)
	end
end
