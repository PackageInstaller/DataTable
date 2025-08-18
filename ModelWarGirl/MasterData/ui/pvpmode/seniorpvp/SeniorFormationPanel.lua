-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\SeniorPVP\\SeniorFormationPanel.lua

local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local strClassName = "SeniorFormationPanel"
local SeniorFormationPanel = Class(strClassName, UIControls.Panel)

function SeniorFormationPanel:ctor(...)
	self.formationChilds = {}

	for i = 1, 3 do
		local child = SeniorFormation(self, self.mPath, "System/AsynPVP/SeniorPVPTeamInfoCell")

		self.formationChilds[i] = child
	end
end

function SeniorFormationPanel:setFormation(formation, isMyFormaion)
	for i, child in ipairs(self.formationChilds) do
		child:setFormation(formation[i], i)
		child:setSideState(isMyFormaion == true)
	end
end

function SeniorFormationPanel:setHeros(heros, isMyFormaion, pets)
	for i, child in ipairs(self.formationChilds) do
		child:setHeros(heros[i], i)
		child:setPet(pets[i])
		child:setSideState(isMyFormaion == true)
	end
end

function SeniorFormationPanel:setFormationWithLocalData(formation, isMyFormaion)
	for i, child in ipairs(self.formationChilds) do
		child:setFormationWithLocalData(formation[i], i)
		child:setSideState(isMyFormaion == true)
	end
end

function SeniorFormationPanel:setCommonHideMode(...)
	for i, child in ipairs(self.formationChilds) do
		child:setCommonHideMode()
	end
end

function SeniorFormationPanel:setMyHideMode(modeData)
	for i, child in ipairs(self.formationChilds) do
		if modeData[i] == 0 then
			child:setMyHideMode(true)
		else
			child:setMyHideMode(false)
		end
	end
end

return SeniorFormationPanel
