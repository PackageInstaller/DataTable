-- chunkname: @IQIGame\\UI\\BattleBuffTips\\BattleBuffTipItem.lua

local m = {}
local BuffCell = require("IQIGame.UI.Common.BuffCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.BuffCell = BuffCell.New(self.BuffCellGO)
end

function m:SetData(buffPOD, hostTroopType)
	self.BuffPOD = buffPOD

	local cfgBuffData = CfgBuffTable[buffPOD.CID]

	self.BuffCell:Refresh(cfgBuffData, false, nil, nil, hostTroopType)
	self.BuffCell:RefreshLayers(buffPOD.Stack)

	self.CDText:GetComponent("Text").text = BattleBuffTipsUIApi:GetString("CDText", buffPOD.Count)
	self.DescText:GetComponent("Text").text = BattleBuffTipsUIApi:GetString("DescText", cfgBuffData.Name, self:ReplaceParam(cfgBuffData.Describe, buffPOD.SkillParams))
end

function m:ReplaceParam(text, params)
	if params == nil then
		return text
	end

	for i = 1, #params do
		local param = params[i]
		local placeholder = "{" .. i .. "}"
		local startIndex, endIndex = string.find(text, placeholder)

		if startIndex ~= nil then
			local replaceStr
			local type = string.sub(text, endIndex + 1, endIndex + 1)

			if type == "d" then
				replaceStr = tostring(math.floor(param))
			elseif type == "p" then
				replaceStr = math.round(param * 10000) / 100 .. "%%"
			end

			if replaceStr ~= nil then
				placeholder = placeholder .. type
				text = string.gsub(text, placeholder, replaceStr, 1)
			end
		end
	end

	return text
end

function m:Dispose()
	self.BuffCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
