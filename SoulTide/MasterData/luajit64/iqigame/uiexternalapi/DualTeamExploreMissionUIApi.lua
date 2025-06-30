-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreMissionUIApi.lua

DualTeamExploreMissionUIApi = BaseLangApi:Extend()

function DualTeamExploreMissionUIApi:Init()
	self:RegisterApi("TitleText2", self.GetTitleText2)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("StateView1_StateText_L3", self.GetStateView1_StateText_L3)
	self:RegisterApi("StateView2_StateText_L3", self.GetStateView2_StateText_L3)
	self:RegisterApi("StateView3_StateText_L3", self.GetStateView3_StateText_L3)
	self:RegisterApi("StateView_TargetDescText_L3", self.GetStateView_TargetDescText_L3)
	self:RegisterApi("StateView_ProgressText_L3", self.GetStateView_ProgressText_L3)
	self:RegisterApi("StateView_RewardNumText", self.GetStateView_RewardNumText)
	self:RegisterApi("GetAllBtnText", self.GetGetAllBtnText)
end

function DualTeamExploreMissionUIApi:GetTitleText2()
	return self:GetCfgText(3410150)
end

function DualTeamExploreMissionUIApi:GetTitleText(openCount)
	if openCount == 1 then
		return self:GetCfgText(3410151)
	elseif openCount == 2 then
		return self:GetCfgText(2000074)
	elseif openCount == 3 then
		return self:GetCfgText(3410151)
	end

	return ""
end

function DualTeamExploreMissionUIApi:GetStateView1_StateText_L3()
	return self:GetCfgText(3410152)
end

function DualTeamExploreMissionUIApi:GetStateView2_StateText_L3()
	return self:GetCfgText(3410153)
end

function DualTeamExploreMissionUIApi:GetStateView3_StateText_L3()
	return self:GetCfgText(3410154)
end

function DualTeamExploreMissionUIApi:GetStateView_TargetDescText_L3(targetDesc, finishedCount, targetCount)
	return targetDesc
end

function DualTeamExploreMissionUIApi:GetStateView_ProgressText_L3(finishedCount, targetCount)
	return self:ShortNum(finishedCount, 2) .. "/" .. self:ShortNum(targetCount, 2)
end

function DualTeamExploreMissionUIApi:GetStateView_RewardNumText(num)
	return "x" .. num
end

function DualTeamExploreMissionUIApi:GetGetAllBtnText()
	return self:GetCfgText(3410155)
end

DualTeamExploreMissionUIApi:Init()
