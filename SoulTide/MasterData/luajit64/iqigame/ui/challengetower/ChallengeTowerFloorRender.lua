-- chunkname: @IQIGame\\UI\\ChallengeTower\\ChallengeTowerFloorRender.lua

local ChallengeTowerFloorRender = {}

function ChallengeTowerFloorRender.__New(itemCellView)
	local itemCell = Clone(ChallengeTowerFloorRender)

	itemCell:Init(itemCellView)

	return itemCell
end

function ChallengeTowerFloorRender:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	function self.delegateBtnSelf()
		self:OnClickBtnSelf()
	end

	function self.delegateBtnSelect()
		self:OnBtnSelect()
	end

	self:AddListener()
end

function ChallengeTowerFloorRender:AddListener()
	self.BtnInfo:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
	self.BtnSelect:GetComponent("Button").onClick:AddListener(self.delegateBtnSelect)
end

function ChallengeTowerFloorRender:RemoveListener()
	self.BtnInfo:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
	self.BtnSelect:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelect)
end

function ChallengeTowerFloorRender:SetData(data, maxChangeLayer, selectLayer)
	self.cfgTowerFloor = data
	self.maxChangeLayer = maxChangeLayer
	self.selectLayer = selectLayer

	if self.cfgTowerFloor then
		self:UpdateView()
	end
end

function ChallengeTowerFloorRender:UpdateView()
	local cfgMonsterTeam = CfgMonsterTeamTable[self.cfgTowerFloor.MonsterTeam]
	local monsterID

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local id = cfgMonsterTeam.TeamUnit[i]

		if cfgMonsterTeam.Type == 2 then
			if id > 0 then
				local cfgMonster = CfgMonsterTable[id]

				if cfgMonster.IsBoss then
					monsterID = id

					break
				end
			end
		elseif id > 0 then
			monsterID = id

			break
		end
	end

	local cfgMonster = CfgMonsterTable[monsterID]
	local path = UIGlobalApi.GetImagePath(cfgMonster.HeadIcon)

	AssetUtil.LoadImage(self, path, self.imgIcon:GetComponent("Image"))

	for i = 1, 4 do
		local top = self.cfgTowerFloor.MonsterType == i

		self["Type" .. i]:SetActive(top)
	end

	local isMaxLayer = self.cfgTowerFloor.Floor == self.maxChangeLayer
	local isSelectLayer = self.cfgTowerFloor.Floor == self.selectLayer

	self:SetCurrentFloorState(isMaxLayer)
	self:Select(isSelectLayer)
	UGUIUtil.SetText(self.textName, self.cfgTowerFloor.Name)
end

function ChallengeTowerFloorRender:SetCurrentFloorState(top)
	if top then
		self.imgBgSelect:SetActive(true)
		self.imgBg1:SetActive(false)
		self.imgBg2:SetActive(false)
		self["Type" .. self.cfgTowerFloor.MonsterType].transform:GetChild(0).gameObject:SetActive(false)
		self["Type" .. self.cfgTowerFloor.MonsterType].transform:GetChild(1).gameObject:SetActive(true)
	else
		self.imgBgSelect:SetActive(false)

		if self.cfgTowerFloor.MonsterType == 4 then
			self.imgBg1:SetActive(false)
			self.imgBg2:SetActive(true)
		else
			self.imgBg1:SetActive(true)
			self.imgBg2:SetActive(false)
		end

		self["Type" .. self.cfgTowerFloor.MonsterType].transform:GetChild(0).gameObject:SetActive(true)
		self["Type" .. self.cfgTowerFloor.MonsterType].transform:GetChild(1).gameObject:SetActive(false)
	end
end

function ChallengeTowerFloorRender:Select(top)
	if top then
		if self.cfgTowerFloor.Floor == self.maxChangeLayer then
			self.SelectTag:SetActive(false)
			self:SetCurrentFloorState(true)
		else
			self.SelectTag:SetActive(true)
			self:SetCurrentFloorState(false)
		end
	else
		self.SelectTag:SetActive(false)
		self:SetCurrentFloorState(false)
	end
end

function ChallengeTowerFloorRender:OnClickBtnSelf()
	UIModule.Open(Constant.UIControllerName.TowerMonsterInfoTipsUI, Constant.UILayer.UI, self.cfgTowerFloor)
end

function ChallengeTowerFloorRender:OnBtnSelect()
	if self.selectCallBack then
		self.selectCallBack(self.cfgTowerFloor)
	end
end

function ChallengeTowerFloorRender:Dispose()
	AssetUtil.UnloadAsset(self)

	self.selectCallBack = nil

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.Object.Destroy(self.goView)

	self.goView = nil
end

return ChallengeTowerFloorRender
