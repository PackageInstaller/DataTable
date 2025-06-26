-- chunkname: @IQIGame\\UI\\Formation\\MonsterInfo\\MonsterCell.lua

local MonsterCell = {}

function MonsterCell.New(gameObject, mainUIController)
	local obj = Clone(MonsterCell)

	obj:Init(gameObject, mainUIController)

	return obj
end

function MonsterCell:Init(gameObject, mainUIController)
	self.gameObject = gameObject
	self.MainUIController = mainUIController

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitDelegates()
	self:AddListeners()
	self.gameObject:SetActive(true)
end

function MonsterCell:InitDelegates()
	function self.DelegateOnClick()
		self:OnClick()
	end
end

function MonsterCell:AddListeners()
	self.gameObject:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function MonsterCell:RemoveListeners()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
end

function MonsterCell:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function MonsterCell:Refresh(monsterCid, index)
	self.gameObject:SetActive(true)

	self.monsterCid = monsterCid

	local monsterCfg = CfgMonsterTable[monsterCid]

	AssetUtil.LoadImage(self, BattleApi:GetMonsterHeadIconPath(monsterCfg.HeadIcon), self.monsterHeadIcon:GetComponent("Image"))
	self.elementImg:SetActive(true)

	if monsterCfg.Elements > 0 then
		AssetUtil.LoadImage(self, string.format(BaseLangApi:GetResUrl(17001), monsterCfg.Elements), self.elementImg:GetComponent("Image"))
	else
		self.elementImg:SetActive(false)
	end

	if monsterCfg.MonsterType == 2 then
		self.normalTypeImg.gameObject:SetActive(true)
		self.eliteTypeImg.gameObject:SetActive(false)
	elseif monsterCfg.MonsterType == 4 then
		self.normalTypeImg.gameObject:SetActive(true)
		self.eliteTypeImg.gameObject:SetActive(true)
	else
		self.normalTypeImg.gameObject:SetActive(false)
		self.eliteTypeImg.gameObject:SetActive(false)
	end

	self.Tag.gameObject:SetActive(true)

	if not self.MainUIController.MainUIController.selectedMonster and index == 1 then
		self:OnClick()
	else
		self:SetSelect(false)
	end
end

function MonsterCell:OnClick()
	if self.MainUIController.MainUIController.selectedMonster then
		self.MainUIController.MainUIController.selectedMonster:SetSelect(false)
	end

	self.MainUIController.MainUIController.selectedMonster = self

	self:SetSelect(true)
	EventDispatcher.Dispatch(EventID.FormationSelectMonsterChangeEvent, self.monsterCid)
end

function MonsterCell:SetSelect(isSelect)
	self.Select.gameObject:SetActive(isSelect)
end

return MonsterCell
