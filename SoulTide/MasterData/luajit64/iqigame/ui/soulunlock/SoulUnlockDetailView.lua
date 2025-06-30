-- chunkname: @IQIGame\\UI\\SoulUnlock\\SoulUnlockDetailView.lua

local SoulUnlockDetailView = {
	notFirstUnlock = false,
	type = 0
}

function SoulUnlockDetailView.New(go)
	local o = Clone(SoulUnlockDetailView)

	o:Initialize(go)

	return o
end

function SoulUnlockDetailView:Initialize(go)
	self.goView = go

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.tfSoulName = self.goSoulName:GetComponent("Text")
	self.tfSoulTitle = self.goSoulTitle:GetComponent("Text")
	self.tfSoulDesc = self.goSoulDesc:GetComponent("Text")
	self.tfCvName = self.goCvName:GetComponent("Text")
	self.tfSoulEnName = self.goEnName:GetComponent("Text")

	UGUIUtil.SetText(self.goTransToFragLabel, SoulUnlockUIApi:GetString("goTransToFragLabel"))
end

function SoulUnlockDetailView:RefreshView(soulData, type, notFirstUnlock)
	self.soulData = soulData
	self.type = type
	self.notFirstUnlock = notFirstUnlock

	self:RefreshMisc()
	self:SetVoiceVisible(false)
end

function SoulUnlockDetailView:OnHide()
	self:StopLastCV()
end

function SoulUnlockDetailView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function SoulUnlockDetailView:RefreshMisc()
	local cfgSoulData = self.soulData:GetCfgSoul()

	self.tfSoulName.text = SoulUnlockUIApi:GetString("goSoulName", cfgSoulData.Name)
	self.tfSoulEnName.text = SoulUnlockUIApi:GetString("goEnName", cfgSoulData.EnglishName)
	self.tfSoulTitle.text = SoulUnlockUIApi:GetString("goSoulTitle", cfgSoulData.SoulDescribe)

	local cfgCVData = CfgCVTable[cfgSoulData.UnlockCV]

	self.tfSoulDesc.text = SoulUnlockUIApi:GetString("goSoulDesc", cfgCVData.Text)
	self.tfCvName.text = SoulUnlockUIApi:GetString("goCvName", cfgSoulData.CVName)

	self.goBgBlur:SetActive(self.type == 1)
	self.goBgNormal:SetActive(self.type == 2)
	self.goIsNew:SetActive(not self.notFirstUnlock)
	self.goTransToFragView:SetActive(self.notFirstUnlock)

	if self.notFirstUnlock then
		local fragmentCfgData = CfgItemTable[cfgSoulData.TransItem[1]]
		local itemNum = cfgSoulData.TransItem[2]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(fragmentCfgData.Icon), self.goFragIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.goFragNumText, SoulUnlockUIApi:GetString("goFragNumText", itemNum))
	end
end

function SoulUnlockDetailView:SetVisible(v)
	self.goView:SetActive(v)

	if v then
		local animation = self.goView:GetComponent(typeof(UnityEngine.Animation))

		if animation ~= nil then
			animation:Play("FX_renoujiesuo01")
		end
	else
		self:OnHide()
	end
end

function SoulUnlockDetailView:SetVoiceVisible(v)
	if v == true then
		local soundID = CfgCVTable[self.soulData:GetCfgSoul().UnlockCV].SoundID

		if soundID ~= nil and soundID ~= 0 then
			self:StopLastCV()

			self.lastSound = GameEntry.Sound:PlaySound(soundID, Constant.SoundGroup.CHARACTER)
		end
	end
end

function SoulUnlockDetailView:StopLastCV()
	if self.lastSound ~= nil then
		GameEntry.Sound:StopSound(self.lastSound)

		self.lastSound = nil
	end
end

function SoulUnlockDetailView:ShowSoul(asset)
	if self.preSoul ~= nil then
		UnityEngine.Object.Destroy(self.preSoul)
	end

	local go = UnityEngine.Object.Instantiate(asset)

	go.transform:SetParent(self.goSoulRoot.transform, false)

	self.preSoul = go
end

return SoulUnlockDetailView
