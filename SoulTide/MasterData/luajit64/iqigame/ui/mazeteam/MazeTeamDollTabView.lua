-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamDollTabView.lua

local m = {}

function m.New(view, isMine)
	local obj = Clone(m)

	obj:Init(view, isMine)

	return obj
end

function m:Init(view, isMine)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnUpdateDollAttr(dollId, attrId, attrValue)
		self:OnUpdateDollAttr(dollId, attrId, attrValue)
	end

	function self.DelegateOnClientPosChange(dollId, position)
		self:OnClientPosChange(dollId, position)
	end

	self.SoulCell = SoulHeadCell.New(self.CommonSoulHeadUI)

	self.SoulCell:SetIsMine(isMine)
	UGUIUtil.SetText(self.DeadLabelText, MazeTeamUIApi:GetString("DeadLabelText"))
	self:AddEventListeners()

	self.GrayComponent = self.View:GetComponent("ImageGroupGrayComponent")
end

function m:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.MazeUpdateDollAttr, self.DelegateOnUpdateDollAttr)
	EventDispatcher.AddEventListener(EventID.MazeRpgMazeUIChangePosition, self.DelegateOnClientPosChange)
end

function m:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateDollAttr, self.DelegateOnUpdateDollAttr)
	EventDispatcher.RemoveEventListener(EventID.MazeRpgMazeUIChangePosition, self.DelegateOnClientPosChange)
end

function m:SetData(dollPOD, soulData)
	self.DollPOD = dollPOD
	self.SoulData = soulData

	self.View:SetActive(dollPOD ~= nil)

	if dollPOD == nil then
		return
	end

	self.SoulCell:RefreshView(soulData)
	AssetUtil.LoadImage(self, UIGlobalApi.GetSoulHeadQualityPath(false), self.QualityImage:GetComponent("Image"))
	self:SetHp(dollPOD.finalAttributes[Constant.Attribute.TYPE_HP])
	self:SetSP(dollPOD.finalAttributes[Constant.Attribute.TYPE_SKILL_ENERGY])
	self:RefreshPosition(dollPOD.position)
end

function m:RefreshPosition(position)
	if self.FrontView ~= nil then
		self.FrontView:SetActive(position == 1)
	end

	if self.BackView ~= nil then
		self.BackView:SetActive(position ~= 1)
	end
end

function m:OnUpdateDollAttr(dollId, attrId, attrValue)
	if self.DollPOD ~= nil and self.DollPOD.id == dollId then
		if attrId == Constant.Attribute.TYPE_HP then
			self:SetHp(attrValue)
		end

		if attrId == Constant.Attribute.TYPE_SKILL_ENERGY then
			self:SetSP(attrValue)
		end
	end
end

function m:SetHp(value)
	self.HpBar:GetComponent("Image").fillAmount = value / self.DollPOD.finalAttributes[Constant.Attribute.TYPE_HP_MAX]

	self.DeadView:SetActive(value == 0)
	self.GrayComponent:EnableGray(value == 0)
end

function m:SetSP(value)
	self.SpBar:GetComponent("Image").fillAmount = value / CfgDiscreteDataTable[6506027].Data[1]
end

function m:SetSelect(value)
	local scale

	if value then
		scale = Vector3.one * 0.9
	else
		scale = Vector3.one * 0.82
	end

	self.Root.transform.localScale = scale

	self.SoulCell:SetSelected(value)
end

function m:OnClientPosChange(dollId, position)
	if self.DollPOD ~= nil and self.DollPOD.id == dollId then
		self:RefreshPosition(position)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveEventListeners()
	self.SoulCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.GrayComponent = nil
	self.DollPOD = nil
	self.SoulData = nil
end

return m
