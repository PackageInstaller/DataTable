-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyMessage\\MessageTimeCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(day, dayOfPhase)
	local cfgData = MonsterAcademyModule.GetCfgGalGameDataByDayNum(day)
	local str = MonsterAcademyMessageUIApi:GetString("TextDayOfPhase", dayOfPhase)

	UGUIUtil.SetText(self.TimeTxt, MonsterAcademyMessageUIApi:GetString("TextGameTime", cfgData.Year, cfgData.Month, cfgData.Day, str))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
