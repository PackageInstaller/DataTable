-- 排壓盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2905 = oo.class(BuffBase)
function Buffer2905:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer2905:OnBefourHurt(caster, target)
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
	-- 102300201
	self:AddTempAttr(BufferEffect[102300201], self.caster, self.caster, nil, "crit",-0.3)
end
-- 创建时
function Buffer2905:OnCreate(caster, target)
	-- 2905
	self:AddReduceShield(BufferEffect[2905], self.caster, target or self.owner, nil,0.4,1,0.2)
	-- 8462
	local c62 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3228)
	-- 322801
	self:AddAttr(BufferEffect[322801], self.caster, target or self.owner, nil,"speed",c62*5)
	-- 8462
	local c62 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3228)
	-- 322811
	self:AddAttr(BufferEffect[322811], self.caster, target or self.owner, nil,"resist",0.05*c62)
end
