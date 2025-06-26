-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandPlantTimeCell.lua

local HomeLandPlantTimeCell = {
	defaultShow = false
}

function HomeLandPlantTimeCell.New(view, defaultShow)
	local obj = Clone(HomeLandPlantTimeCell)

	obj:Init(view, defaultShow)

	return obj
end

function HomeLandPlantTimeCell:Init(view, defaultShow)
	self.View = view

	if defaultShow then
		self.defaultShow = defaultShow
	end

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateUpdatePlantEvent(buildingCid, lands)
		self:UpdatePlantEvent(buildingCid, lands)
	end

	self.timerCD = Timer.New(function()
		self:ShowPlantCD()
	end, 1, -1)

	self:AddListener()
end

function HomeLandPlantTimeCell:AddListener()
	EventDispatcher.AddEventListener(EventID.HomeLandUpdatePlantEvent, self.delegateUpdatePlantEvent)
end

function HomeLandPlantTimeCell:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdatePlantEvent, self.delegateUpdatePlantEvent)
end

function HomeLandPlantTimeCell:UpdatePlantEvent(buildingCid, lands)
	if buildingCid == Constant.HomelandBuildType.BuildPlant and self.decorateId then
		self:UpdateView(self.decorateId)
	end
end

function HomeLandPlantTimeCell:UpdateView(decorateId)
	self.timerCD:Stop()

	if LuaCodeInterface.GameObjIsDestroy(self.View) then
		return
	end

	self.decorateId = decorateId

	local buildingData = HomeLandLuaModule.GetBuildingDataByID(Constant.HomelandBuildType.BuildPlant)

	self.plantData = buildingData:GetPlantDataByDecorateCid(self.decorateId)

	if self.plantData == nil then
		self.View:SetActive(false)

		return
	end

	if self.plantData.landPOD.status ~= Constant.HomelandPlantType.landStatusIdle and self.plantData.landPOD.status ~= Constant.HomelandPlantType.landStatusMature then
		self:ShowPlantCD()
		self.timerCD:Start()
		self.View:SetActive(true)
	elseif self.plantData.landPOD.status == Constant.HomelandPlantType.landStatusMature then
		UGUIUtil.SetText(self.TextTime, HomeLandPlantUIApi:GetString("TextFinish3"))
		self.View:SetActive(self.defaultShow)
	else
		self.View:SetActive(false)
	end
end

function HomeLandPlantTimeCell:ShowPlantCD()
	local cd = self.plantData.landPOD.finishTime - PlayerModule.GetServerTime()

	if cd >= 0 then
		if not LuaCodeInterface.GameObjIsDestroy(self.TextTime) then
			UGUIUtil.SetText(self.TextTime, GetFormatTime(cd))
		end
	else
		self.timerCD:Stop()
		self.View:SetActive(self.defaultShow)
	end
end

function HomeLandPlantTimeCell:Dispose()
	if self.timerCD then
		self.timerCD:Stop()
	end

	self.timerCD = nil

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.GameObject.Destroy(self.View)

	self.View = nil
end

return HomeLandPlantTimeCell
