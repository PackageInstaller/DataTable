-- chunkname: @IQIGame\\UI\\ActiveRookie\\RookieTask\\RookieTaskCell.lua

local RookieTaskCell = {
	itemCellPool = {}
}

function RookieTaskCell.New(go)
	local o = Clone(RookieTaskCell)

	o:Initialize(go)

	return o
end

function RookieTaskCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.imgBar = self.goBar:GetComponent("Image")
	self.tfName = self.goName:GetComponent("Text")
	self.tfProgress = self.goProgress:GetComponent("Text")
	self.btnGet = self.goBtnGet:GetComponent("Button")
	self.btnGo = self.goBtnGo:GetComponent("Button")

	function self.onClickBtnGetDelegate()
		self:OnClickBtnGet()
	end

	function self.onClickBtnGoDelegate()
		self:OnClickBtnGo()
	end

	for i = 1, 4 do
		local go = self.goSlotParent.transform:Find("CommonSlotUI_" .. i).gameObject

		self.itemCellPool[i] = ItemCell.PackageOrReuseView(self, go)
	end

	self.goBtnGet.transform:Find("Text"):GetComponent("Text").text = ActiveRookieUIApi:GetString("btnGetTxt")
	self.goBtnGo.transform:Find("Text"):GetComponent("Text").text = ActiveRookieUIApi:GetString("btnGoTxt")
	self.goSignGetted.transform:Find("Text"):GetComponent("Text").text = ActiveRookieUIApi:GetString("btnSignGettedTxt")
end

function RookieTaskCell:Refresh(data)
	self.data = data
	self.cfgTaskData = CfgMainQuestTable[data.cid]

	self:RefreshMisc()
	self:RefreshReward()
	self:AddListener()
end

function RookieTaskCell:AddListener()
	self:RemoveListener()
	self.btnGet.onClick:AddListener(self.onClickBtnGetDelegate)
	self.btnGo.onClick:AddListener(self.onClickBtnGoDelegate)
end

function RookieTaskCell:RemoveListener()
	self.btnGet.onClick:RemoveListener(self.onClickBtnGetDelegate)
	self.btnGo.onClick:RemoveListener(self.onClickBtnGoDelegate)
end

function RookieTaskCell:OnHide()
	self:RemoveListener()
end

function RookieTaskCell:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function RookieTaskCell:OnClickBtnGet()
	if self.data.CurrentNum >= self.data.TargetNum then
		TaskModule.SendCommitTaskMsg(self.data.cid)
	else
		NoticeModule.ShowNotice(21040077)
	end
end

function RookieTaskCell:OnClickBtnGo()
	JumpModule.Jump(self.cfgTaskData.Source)
end

function RookieTaskCell:RefreshMisc()
	self.tfName.text = ActiveRookieUIApi:GetString("taskName", self.cfgTaskData.Name)
	self.tfProgress.text = ActiveRookieUIApi:GetString("taskProgress", self.data.CurrentNum, self.data.TargetNum)

	self.goBarFull:SetActive(self.data.CurrentNum >= self.data.TargetNum)

	self.imgBar.fillAmount = self.data.CurrentNum / self.data.TargetNum

	self.goSignNormal:SetActive(false)
	self.goSignCanGet:SetActive(false)
	self.goBtnGet:SetActive(false)
	self.goBtnGo:SetActive(false)
	self.goSignGetted:SetActive(false)

	if self.data.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
		if self.data.CurrentNum >= self.data.TargetNum then
			self.goSignCanGet:SetActive(true)
			self.goBtnGet:SetActive(true)
		else
			self.goSignNormal:SetActive(true)
			self.goBtnGo:SetActive(self.cfgTaskData.Source ~= nil and self.cfgTaskData.Source ~= 0)
		end
	elseif self.data.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
		self.goSignNormal:SetActive(true)
		self.goSignGetted:SetActive(true)
	else
		self.goSignNormal:SetActive(true)
	end
end

function RookieTaskCell:RefreshReward()
	local ids = {}
	local counts = {}

	for i, v in ipairs(self.cfgTaskData.Reward) do
		if i % 2 ~= 0 then
			ids[#ids + 1] = v
			counts[#counts + 1] = self.cfgTaskData.Reward[i + 1]
		end
	end

	for i, v in ipairs(self.itemCellPool) do
		v.ViewGo:SetActive(i <= #ids)

		if i <= #ids then
			v:SetItemByCID(ids[i], counts[i])
		end
	end
end

return RookieTaskCell
