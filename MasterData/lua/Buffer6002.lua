-- 解析
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6002 = oo.class(BuffBase)
function Buffer6002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6002:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 6002
	self:AddNp(BufferEffect[6002], self.caster, target or self.owner, nil,2)
end
-- 创建时
function Buffer6002:OnCreate(caster, target)
	-- 4204
	self:AddAttr(BufferEffect[4204], self.caster, target or self.owner, nil,"speed",20)
end
