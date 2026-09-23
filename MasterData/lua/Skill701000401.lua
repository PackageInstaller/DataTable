-- 机神传送
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701000401 = oo.class(SkillBase)
function Skill701000401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill701000401:CanSummon()
	return self.card:CanSummon(10000025,1,{3,1},{progress=1001,type=3},nil,nil,true)
end
-- 执行技能
function Skill701000401:DoSkill(caster, target, data)
	-- 40009
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[40009], caster, self.card, data, 10000025,1,{3,1},{progress=1001,type=3},nil,nil,true)
end
-- 切换周目
function Skill701000401:OnChangeStage(caster, target, data)
	-- 20015
	self:AddProgress(SkillEffect[20015], caster, self.card, data, 600)
end
