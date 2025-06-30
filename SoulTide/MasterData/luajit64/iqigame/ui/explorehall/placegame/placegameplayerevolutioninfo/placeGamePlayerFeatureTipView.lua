-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGamePlayerEvolutionInfo\\placeGamePlayerFeatureTipView.lua

local m = {
	SourceTxt = "",
	goCellPool = {},
	goDescPool = {},
	DelegateOnClickDescBtnMap = {}
}

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

function m:SetData(placeGameSoulData)
	self.placeGameSoulData = placeGameSoulData

	self:UpdateView()
end

function m:UpdateView()
	if self.placeGameSoulData then
		for i, v in ipairs(self.goCellPool) do
			v:SetActive(i <= #self.placeGameSoulData:GetCfgPlaceGameSoulData().ADDSkillID)
		end

		local sourceTxt = ""

		self.layIndex = 1

		for i, skillCid in ipairs(self.placeGameSoulData:GetCfgPlaceGameSoulData().ADDSkillID) do
			local cfgSkillData = CfgSkillTable[skillCid]
			local needUnlockLv = self.placeGameSoulData:GetCfgPlaceGameSoulData().UnLockSkillStrengthenLevel[i]
			local cell = self:GetCell(i)
			local goDesc = self:GetDesc(i)

			UGUIUtil.SetText(cell.transform:Find("Content/Text_1").gameObject, cfgSkillData.Name)

			local isUnlock = true
			local signUnlock = cell.transform:Find("Content/Unlock").gameObject
			local signLock = cell.transform:Find("Content/Lock").gameObject
			local unlockText = cell.transform:Find("Content/Text_2").gameObject

			UGUIUtil.SetText(unlockText, PlaceGamePlayerUpdateUIApi:GetString("UnlockFeatureCondition", needUnlockLv))
			signUnlock:SetActive(isUnlock)
			signLock:SetActive(not isUnlock)
			unlockText:SetActive(not isUnlock)

			local srcDescText = PlaceGamePlayerEvolutionInfoUIApi:GetString("infoViewFeatureDesc", self.placeGameSoulData:GetFeatureEffectDesc(skillCid), isUnlock)

			sourceTxt = sourceTxt .. srcDescText

			local descBtn = goDesc:GetComponent("Button")

			if descBtn ~= nil then
				local function delegateOnClickDescBtn()
					self:OnClickDescBtn(srcDescText, goDesc)
				end

				self.DelegateOnClickDescBtnMap[goDesc:GetInstanceID()] = delegateOnClickDescBtn

				descBtn.onClick:AddListener(delegateOnClickDescBtn)
			end

			UGUIUtil.SetTextInChildren(goDesc, UIGlobalApi.GetTextWithoutKeywordTag(srcDescText))

			self.layIndex = self.layIndex + 1

			cell.transform:SetSiblingIndex(self.layIndex)

			self.layIndex = self.layIndex + 1

			goDesc.transform:SetSiblingIndex(self.layIndex)
		end

		self.SourceTxt = sourceTxt
	end
end

function m:GetCell(index)
	local ret = self.goCellPool[index]

	if ret == nil then
		if index == 1 then
			ret = self.goCell
		else
			ret = UnityEngine.Object.Instantiate(self.goCell)
		end

		self.goCellPool[index] = ret

		ret.transform:SetParent(self.goCell.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function m:GetDesc(index)
	local ret = self.goDescPool[index]

	if ret == nil then
		if index == 1 then
			ret = self.goDesc
		else
			ret = UnityEngine.Object.Instantiate(self.goDesc)
		end

		self.goDescPool[index] = ret

		ret.transform:SetParent(self.goDesc.transform.parent, false)
	end

	ret:SetActive(true)

	return ret
end

function m:Dispose()
	for i, v in pairs(self.goCellPool) do
		self.goCellPool[i] = nil
	end

	for i, goDesc in pairs(self.goDescPool) do
		local instanceId = goDesc:GetInstanceID()
		local delegateOnClickDescBtn = self.DelegateOnClickDescBtnMap[instanceId]

		if delegateOnClickDescBtn ~= nil then
			goDesc:GetComponent("Button").onClick:RemoveListener(delegateOnClickDescBtn)

			self.DelegateOnClickDescBtnMap[instanceId] = nil
		end

		self.goDescPool[i] = nil
	end

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
