-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkOverView\\AmusementParkOverCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnFunction()
		self:OnBtnFunction()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnFunction:GetComponent("Button").onClick:AddListener(self.DelegateBtnFunction)
end

function m:RemoveListener()
	self.BtnFunction:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnFunction)
end

function m:SetData(buildData)
	self.BuildData = buildData

	self:UpdateView()
end

function m:UpdateView()
	if self.BuildData then
		local unlock = self.BuildData:IsUnlock()

		self.Unlock:SetActive(unlock)
		self.Lock:SetActive(not unlock)
		UGUIUtil.SetText(self.TextName, self.BuildData:GetCfgData().Name)

		local players = self.BuildData:GetBuildPlayers()

		UGUIUtil.SetText(self.TextSort, AmusementParkOverViewUIApi:GetString("TextSort", #players))

		local path = UIGlobalApi.GetImagePath(self.BuildData:GetCfgData().Icon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
		AssetUtil.LoadImage(self, path, self.ImgLockIcon:GetComponent("Image"))

		local cfgFunctionData = self.BuildData:GetBuildFunctionData()

		self.BtnLockFunction:SetActive(cfgFunctionData ~= nil)
		self.BtnFunction:SetActive(cfgFunctionData ~= nil)
		self.TextFunctionMsg:SetActive(cfgFunctionData ~= nil)

		if cfgFunctionData then
			UGUIUtil.SetText(self.TextLockFunction, cfgFunctionData.FunctionName)
			UGUIUtil.SetText(self.TextUnlockFunction, cfgFunctionData.FunctionName)

			local absStr = self:GetAbstract(cfgFunctionData)

			UGUIUtil.SetText(self.TextFunctionMsg, absStr)
		end

		UGUIUtil.SetText(self.TextLv, AmusementParkOverViewUIApi:GetString("TextLv", self.BuildData.parkBuildPOD.level, self.BuildData:GetMaxLevel()))
	end
end

function m:GetAbstract(cfgFunctionData)
	local showInfo = AmusementParkModule.ParkGameShowInfoList[cfgFunctionData.Type]

	if cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_Player then
		local num = #AmusementParkModule.AmusementParkInfoPOD.amusementParkVoRolesHave

		return string.format(cfgFunctionData.Abstract, num)
	elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_Challenge then
		local num = 0
		local maxNum = #AmusementParkModule.AmusementParkEventMonster

		for i = 1, maxNum do
			local eventData = AmusementParkModule.AmusementParkEventMonster[i]

			if eventData:IsUnlock() then
				num = num + 1
			end
		end

		return string.format(cfgFunctionData.Abstract, num, maxNum)
	elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_ExBoss then
		local num = 0

		if showInfo then
			num = showInfo.score
		end

		if num == 0 then
			return AmusementParkOverViewUIApi:GetString("NotParticipating")
		end

		return string.format(cfgFunctionData.Abstract, num)
	elseif cfgFunctionData.Type >= AmusementParkConstant.BuildFunction.BuildFunction_DollMachine and cfgFunctionData.Type < AmusementParkConstant.BuildFunction.BuildFunction_OneStroke or cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_StackedBlocks then
		local level = 0
		local score = 0

		if showInfo then
			level = showInfo.level
			score = showInfo.score
		end

		if level == 0 then
			return AmusementParkOverViewUIApi:GetString("NotParticipating")
		end

		return string.format(cfgFunctionData.Abstract, level, score)
	elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_OneStroke then
		local level = 0
		local score = 0

		if showInfo then
			level = showInfo.score
			score = #AmusementParkOneConnectGameModule.oneConnectLevels
		else
			return AmusementParkOverViewUIApi:GetString("NotParticipating")
		end

		return string.format(cfgFunctionData.Abstract, level, score)
	elseif cfgFunctionData.Type == AmusementParkConstant.BuildFunction.BuildFunction_Answer then
		local num = 0
		local maxNum = 0

		if showInfo then
			num = showInfo.score
		end

		for i, v in pairsCfg(CfgAmusementParkAnswerControlTable) do
			if v.Group == AmusementParkModule.GlobalCid then
				maxNum = #v.QuestionBank
			end
		end

		return string.format(cfgFunctionData.Abstract, num, maxNum)
	end
end

function m:OnBtnFunction()
	if self.BuildData then
		AmusementParkModule.OpenBuildFunction(self.BuildData)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
