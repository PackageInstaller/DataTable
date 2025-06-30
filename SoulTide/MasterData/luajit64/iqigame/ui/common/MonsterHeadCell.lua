-- chunkname: @IQIGame\\UI\\Common\\MonsterHeadCell.lua

local MonsterHeadCell = {}

function MonsterHeadCell.__New(itemCellView)
	local itemCell = Clone(MonsterHeadCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function MonsterHeadCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.UITweeners = self.goView:GetComponentsInChildren(typeof(UITweener))
	self.btnComponent = self.goView:GetComponent("Button")

	function self.delegateOnClickSelf()
		self:OnclickBtnSelf()
	end

	self:AddListener()
end

function MonsterHeadCell:AddListener()
	self.btnComponent.onClick:AddListener(self.delegateOnClickSelf)
end

function MonsterHeadCell:RemoveListener()
	self.btnComponent.onClick:RemoveListener(self.delegateOnClickSelf)
end

function MonsterHeadCell:SetData(monsterID, positionType)
	self.monsterId = monsterID

	if positionType ~= nil then
		self.positionType = positionType
	else
		self.positionType = 0
	end

	if self.monsterId == nil then
		self:Clear()
	else
		self:Update()
	end
end

function MonsterHeadCell:Update()
	self.goView:SetActive(true)

	local cfgMonster = CfgMonsterTable[self.monsterId]
	local imgPath = UIGlobalApi.GetImagePath(cfgMonster.HeadIcon)

	AssetUtil.LoadImage(self, imgPath, self.MonsterHeadIcon:GetComponent("Image"))

	if self.positionType > 0 then
		self.Tag:SetActive(true)
		UGUIUtil.SetText(self.TextTag, MiscApi:GetString("PositionType", self.positionType))
	else
		self.Tag:SetActive(false)
	end
end

function MonsterHeadCell:Clear()
	self.goView:SetActive(false)

	self.monsterId = nil
end

function MonsterHeadCell:OnclickBtnSelf()
	if self.clickHandler then
		self.clickHandler(self.monsterId)
	end
end

function MonsterHeadCell:Dispose()
	self.clickHandler = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.Object.DestroyImmediate(self.goView)

	self.goView = nil
end

return MonsterHeadCell
