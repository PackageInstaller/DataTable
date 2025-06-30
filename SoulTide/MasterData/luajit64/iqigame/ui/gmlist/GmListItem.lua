-- chunkname: @IQIGame\\UI\\GmList\\GmListItem.lua

local GmListItem = {}

function GmListItem.New(go)
	local o = Clone(GmListItem)

	o:Initialize(go)

	return o
end

function GmListItem:Initialize(go)
	self.tfName = go.transform:Find("Text_01"):GetComponent("Text")
	self.tfCmd = go.transform:Find("Text_02"):GetComponent("Text")
	self.btnCmd = go.transform:Find("Button_02"):GetComponent("Button")

	function self.onClickBtnCmdDelegate()
		self:OnClickBtnCmd()
	end

	self.btnCmd.onClick:AddListener(self.onClickBtnCmdDelegate)
end

function GmListItem:Refresh(cfgData)
	self.cfgData = cfgData
	self.tfName.text = self.cfgData.Name
	self.tfCmd.text = self.cfgData.Cmd
end

function GmListItem:OnDestroy()
	self.btnCmd.onClick:RemoveListener(self.onClickBtnCmdDelegate)
end

function GmListItem:OnClickBtnCmd()
	GmListModule.SendCmd(self.cfgData.Cmd, self.cfgData.Type)
end

return GmListItem
