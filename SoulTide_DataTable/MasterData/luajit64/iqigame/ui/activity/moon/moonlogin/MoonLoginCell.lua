-- chunkname: @IQIGame\\UI\\Activity\\Moon\\MoonLogin\\MoonLoginCell.lua

local MoonLoginCell = {
	stateParents = {},
	bgPool = {},
	effectIds = {}
}

function MoonLoginCell.New(go)
	local o = Clone(MoonLoginCell)

	o:Initialize(go)

	return o
end

function MoonLoginCell:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.goSelf = go
	self.tfDay = self.goDay:GetComponent("Text")
	self.imgIcon = self.goIcon:GetComponent("Image")
	self.btnGet = self.goBgParent:GetComponent("Button")

	function self.onClickBtnGetDelegate()
		self:OnClickBtnGet()
	end

	for i = 1, 3 do
		local transState = self.goStateParent.transform:Find("Tag_0" .. i)

		transState:Find("Text_01"):GetComponent("Text").text = ActivityUIApi:GetString("moonLogin_stateDesc", i)
		self.stateParents[i] = transState
	end

	for i = 1, 3 do
		local go = self.goBgParent.transform:Find("Bg_" .. i).gameObject

		self.bgPool[i] = go
	end

	self.itemCell = ItemCell.PackageOrReuseView(self, self.goSlot)
	self.allSpecialDay = {}
end

function MoonLoginCell:Refresh(taskData, index, curIndex)
	self.taskData = taskData
	self.cfgTaskData = CfgMainQuestTable[taskData.cid]
	self.index = index
	self.curIndex = curIndex
	self.specialDay = -1

	for i, v in pairs(self.allSpecialDay) do
		if self.index == v then
			self.specialDay = v

			break
		end
	end

	self:StopFxEffect()

	if self.taskData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
		self.state = 1
	elseif self.taskData.CurrentNum >= self.taskData.TargetNum then
		self.state = 2

		self:PlayFxEffect(9001179, self.stateParents[2].gameObject)
	else
		self.state = 3
	end

	if self.index == self.specialDay and self.state == 2 then
		self:PlayFxEffect(9001178, self.goSelf)
	end

	self:RefreshMisc()
	self:AddListener()
end

function MoonLoginCell:OnHide()
	self:StopFxEffect()
	self:RemoveListener()
end

function MoonLoginCell:OnDestroy()
	self.itemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goSelf, self)

	self.goSelf = nil
end

function MoonLoginCell:AddListener()
	self:RemoveListener()
	self.btnGet.onClick:AddListener(self.onClickBtnGetDelegate)
end

function MoonLoginCell:RemoveListener()
	self.btnGet.onClick:RemoveListener(self.onClickBtnGetDelegate)
end

function MoonLoginCell:OnClickBtnGet()
	if self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and self.taskData.CurrentNum >= self.taskData.TargetNum then
		TaskModule.SendCommitTaskMsg(self.taskData.cid)
	elseif self.index == self.specialDay and self.state ~= 2 then
		local cfgItemData = CfgItemTable[self.cfgTaskData.Reward[1]]

		if cfgItemData.Type == Constant.ItemType.Equip then
			UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
				forShow = true,
				data = {
					cfgItemData
				}
			})
		elseif cfgItemData.Type == Constant.ItemType.AutoEffect and cfgItemData.SubType == Constant.ItemSubType.ItemGift then
			UIModule.Open(Constant.UIControllerName.SoulLockUI, Constant.UILayer.UI, SoulModule.GetSoulData(cfgItemData.EffectTypeParam[1][1]))
		end
	end
end

function MoonLoginCell:RefreshMisc()
	self.tfDay.text = ActivityUIApi:GetString("moonLogin_dayDesc", self.index, self.state, self.index == self.specialDay)

	self.goSignChecked:SetActive(self.state == 1)
	self.stateParents[1].gameObject:SetActive(self.state == 1)
	self.stateParents[2].gameObject:SetActive(self.state == 2)
	self.stateParents[3].gameObject:SetActive(self.state == 3 and self.index == self.curIndex + 1)

	if self.cfgTaskData.Flag ~= nil and self.cfgTaskData.Flag ~= "" then
		self.goIcon:SetActive(true)
		self.goSlot:SetActive(false)

		local path = UIGlobalApi.ImagePath .. "/" .. self.cfgTaskData.Flag

		AssetUtil.LoadImage(self, path, self.imgIcon)
	else
		self.goIcon:SetActive(false)
		self.goSlot:SetActive(true)
		self.itemCell:SetItemByCID(self.cfgTaskData.Reward[1], self.cfgTaskData.Reward[2])
	end

	self.bgPool[1]:SetActive(self.state == 1)
	self.bgPool[2]:SetActive(self.state == 2 or self.state == 3 and self.index ~= self.specialDay)
	self.bgPool[3]:SetActive(self.state ~= 1 and self.index == self.specialDay)
end

function MoonLoginCell:PlayFxEffect(id, goParent)
	self.effectIds[id] = GameEntry.Effect:PlayUIMountPointEffect(id, 50000, 0, goParent, 0)
end

function MoonLoginCell:StopFxEffect()
	for i, v in pairs(self.effectIds) do
		GameEntry.Effect:StopEffect(v)
	end

	self.effectIds = {}
end

return MoonLoginCell
