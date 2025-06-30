-- chunkname: @IQIGame\\UIExternalApi\\SoulAwakeTaskUIApi.lua

SoulAwakeTaskUIApi = BaseLangApi:Extend()

function SoulAwakeTaskUIApi:Init()
	self:RegisterApi("goPrefabName", self.GetPrefabName)
	self:RegisterApi("goPrefabDesc", self.GetPrefabDesc)
	self:RegisterApi("goDesc1", self.GetDesc1)
	self:RegisterApi("goBtnGo", self.GetBtnGoTxt)
	self:RegisterApi("goBtnGiveUp", self.GetBtnGiveUpTxt)
	self:RegisterApi("goBtnUnlock", self.GetBtnUnlockTxt)
	self:RegisterApi("goBtnActivate", self.GetBtnActivateTxt)
	self:RegisterApi("closeUIDelayTime", self.GetCloseUIDelayTime)
	self:RegisterApi("goTaskName", self.GetTaskName)
	self:RegisterApi("goTaskDesc", self.GetTaskDesc)
	self:RegisterApi("goTaskTarget", self.GetTaskTarget)
	self:RegisterApi("goTaskWorkingDesc", self.GetTaskWorkingDesc)
	self:RegisterApi("goTaskEngDesc", self.GetTaskEngDesc)
	self:RegisterApi("goCellBgPath", self.GtCellBgPath)
end

function SoulAwakeTaskUIApi:GetCloseUIDelayTime()
	return 1.5
end

function SoulAwakeTaskUIApi:GtCellBgPath(index)
	local imgName

	if index == 1 then
		imgName = ""
	elseif index == 2 then
		imgName = ""
	elseif index == 3 then
		imgName = ""
	end

	return UIGlobalApi.GetImagePath("/Common/ComImage/" .. imgName)
end

function SoulAwakeTaskUIApi:GetBtnGoTxt()
	return self:GetCfgText(1321001)
end

function SoulAwakeTaskUIApi:GetBtnGiveUpTxt()
	return self:GetCfgText(1321002)
end

function SoulAwakeTaskUIApi:GetBtnUnlockTxt()
	return self:GetCfgText(1321003)
end

function SoulAwakeTaskUIApi:GetBtnActivateTxt()
	return self:GetCfgText(1321004)
end

function SoulAwakeTaskUIApi:GetTaskEngDesc()
	return self:Blank(self:GetCfgText(1321005), 1)
end

function SoulAwakeTaskUIApi:GetTaskWorkingDesc()
	return self:GetCfgText(1321006)
end

function SoulAwakeTaskUIApi:GetTaskTarget(curNum, targetNum, state)
	if state == 1 then
		if curNum == targetNum then
			return self.TextColor[208] .. self:FontSize(curNum, 30) .. self.TextColor[0] .. "/" .. targetNum
		else
			return self:FontSize(curNum, 30) .. "/" .. targetNum
		end
	elseif state == 3 then
		return self.TextColor[208] .. self:FontSize(curNum, 30) .. "/" .. targetNum .. self.TextColor[0]
	elseif state == 4 then
		return self:FontSize(curNum, 30) .. "/" .. targetNum
	end
end

function SoulAwakeTaskUIApi:GetTaskDesc(desc, state)
	return desc
end

function SoulAwakeTaskUIApi:GetTaskName(name, state)
	return name
end

function SoulAwakeTaskUIApi:GetPrefabName(name)
	return name
end

function SoulAwakeTaskUIApi:GetPrefabDesc(desc)
	return desc
end

function SoulAwakeTaskUIApi:GetDesc1()
	return self:GetCfgText(1321007)
end

SoulAwakeTaskUIApi:Init()
