-- chunkname: @IQIGame\\UIExternalApi\\ActivityNewDollMissionUIApi.lua

ActivityNewDollMissionUIApi = BaseLangApi:Extend()

function ActivityNewDollMissionUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("btnGetTxt", self.GetBtnGetTxt)
	self:RegisterApi("btnJumpTxt", self.GetBtnJumpTxt)
	self:RegisterApi("finishSign", self.GetFinishSign)
	self:RegisterApi("targetDesc", self.GetTargetDesc)
	self:RegisterApi("targetProgressDesc", self.GetTargetProgressDesc)
end

function ActivityNewDollMissionUIApi:GetTitle()
	return self:GetCfgText(1233202)
end

function ActivityNewDollMissionUIApi:GetTargetDesc(desc, curNum, targetNum)
	return desc
end

function ActivityNewDollMissionUIApi:GetTargetProgressDesc(curNum, targetNum)
	return curNum .. "/" .. targetNum
end

function ActivityNewDollMissionUIApi:GetBtnJumpTxt()
	return self:GetCfgText(1101009)
end

function ActivityNewDollMissionUIApi:GetBtnGetTxt()
	return self:GetCfgText(1217001)
end

function ActivityNewDollMissionUIApi:GetFinishSign()
	return self:GetCfgText(1107013)
end

ActivityNewDollMissionUIApi:Init()
