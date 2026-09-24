-- chunkname: @modules/logic/autochess/main/flow/AutoChessSkillWork.lua

module("modules.logic.autochess.main.flow.AutoChessSkillWork", package.seeall)

local AutoChessSkillWork = class("AutoChessSkillWork", AutoChessBaseWork)

function AutoChessSkillWork:ctor(fromId, reasonId)
	self.delayFuncMap = {}
	self.fromId = tonumber(fromId)
	self.reasonId = tonumber(reasonId)
end

function AutoChessSkillWork:onStart()
	local mgr = AutoChessEntityMgr.instance
	local skillEntity = mgr:tryGetEntity(self.fromId)

	if not skillEntity then
		self:finishWork()

		return
	end

	local animTime = 0
	local effectTime = 0
	local skillCo = AutoChessConfig.instance:getLeaderSkillCfg(self.reasonId)

	if skillCo then
		if not string.nilorempty(skillCo.skillaction) then
			animTime = skillEntity:skillAnim(skillCo.skillaction)
		end

		if skillCo.useeffect ~= 0 then
			effectTime = skillEntity:playEffect(skillCo.useeffect)
		end
	end

	local delayTime = math.max(animTime, effectTime)

	self:delayCall(self.finishWork, delayTime)
end

function AutoChessSkillWork:onDestroy()
	self:clearTask()

	self.delayFuncMap = nil
end

return AutoChessSkillWork
