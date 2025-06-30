-- chunkname: @IQIGame\\UI\\Guide\\GuideTalkMsgCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(npcID, cvID, posx, posy, siblingIndex)
	if npcID and npcID > 0 then
		self.NpcParent:SetActive(true)

		local path = UIGlobalApi.GetImagePath(CfgNPCTable[npcID].Picture)

		AssetUtil.LoadImage(self, path, self.HeadIcon:GetComponent("Image"))
	else
		self.NpcParent:SetActive(false)
	end

	if cvID and cvID > 0 then
		self.SpeakParent:SetActive(true)

		local text = string.gsub(CfgHeroSoundTable[cvID].Text, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName and PlayerModule.PlayerInfo.baseInfo.pName or "xxx")

		UGUIUtil.SetText(self.TalkText, text)
	else
		self.SpeakParent:SetActive(false)
	end

	if posx == nil then
		posx = 0
	end

	if posy == nil then
		posy = 0
	end

	self.View.transform.anchoredPosition = Vector3.New(posx, posy, 0)

	if siblingIndex == nil then
		siblingIndex = 0
	end

	self.NpcParent.transform:SetSiblingIndex(siblingIndex)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:TriggerSelf()
	return
end

return m
