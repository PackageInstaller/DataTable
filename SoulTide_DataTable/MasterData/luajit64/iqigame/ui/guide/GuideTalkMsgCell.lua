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

function m:SetData(npcID, cvID)
	if npcID and npcID > 0 then
		self.NpcHead:SetActive(true)

		local path = UIGlobalApi.GetImagePath(CfgNPCTable[npcID].NpcHeadImage)

		AssetUtil.LoadImage(self, path, self.HeadIcon:GetComponent("Image"))
	else
		self.NpcHead:SetActive(false)
	end

	if cvID and cvID > 0 then
		self.NpcSpeak:SetActive(true)

		local text = string.gsub(CfgCVTable[cvID].Text, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)

		UGUIUtil.SetText(self.TextTalk, text)
	else
		self.NpcSpeak:SetActive(false)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
