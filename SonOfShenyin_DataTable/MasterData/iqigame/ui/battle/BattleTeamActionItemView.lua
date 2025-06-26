-- chunkname: @IQIGame\\UI\\Battle\\BattleTeamActionItemView.lua

local m = {
	battleUnitID = 0,
	isInteractable = true
}

function m.New(view, battleUnitID, battleActionOrderFollower)
	local obj = Clone(m)

	obj:__Init(view, battleUnitID, battleActionOrderFollower)

	return obj
end

function m:__Init(view, battleUnitID, battleActionOrderFollower)
	self.gameObject = view

	self.gameObject:SetActive(true)

	self.battleUnitID = battleUnitID
	self.battleActionOrderFollower = battleActionOrderFollower
	self.rectTransform = self.gameObject:GetComponent(typeof(UnityEngine.RectTransform))

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.isInteractable = true

	self:ShowIcon()

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)

	self.gameObject.name = battleUnitData.monsterConfigID

	self:__InitDelegate()
	self:__AddListener()
end

function m:__InitDelegate()
	function self.delegateOnClick()
		BattleTeamActionModule.SetManualMoverID(self.battleUnitID)
	end

	function self.delegateOnLongDown()
		if self.OnDragBeginEvent == nil then
			return
		end

		self.OnDragBeginEvent(self)
	end

	function self.delegateOnLongDownClick()
		if self.OnDragEvent ~= nil then
			self.OnDragEvent(self)
		end
	end

	function self.delegateOnLongDownEnd()
		if self.OnDragEndEvent == nil then
			return
		end

		self.OnDragEndEvent(self)
	end
end

function m:__AddListener()
	local longButton = self.gameObject:GetComponent(typeof(LongButton))

	longButton.delay = 0.3
	longButton.clickInterval = 0.03

	longButton.onClick:AddListener(self.delegateOnClick)
	longButton.onLongDown:AddListener(self.delegateOnLongDown)
	longButton.onLongDownClick:AddListener(self.delegateOnLongDownClick)

	longButton.onLongDownEnd = self.delegateOnLongDownEnd
end

function m:__RemoveListener()
	local longButton = self.gameObject:GetComponent(typeof(LongButton))

	longButton.onClick:RemoveListener(self.delegateOnClick)
	longButton.onLongDown:RemoveListener(self.delegateOnLongDown)
	longButton.onLongDownClick:RemoveListener(self.delegateOnLongDownClick)

	longButton.onLongDownEnd = nil
end

function m:SetInteractable(isInteractable)
	self.isInteractable = isInteractable
	self.gameObject.gameObject:GetComponent(typeof(UnityEngine.UI.Button)).interactable = isInteractable

	self.selectRoot.gameObject:SetActive(false)
	self.selectBottomRoot.gameObject:SetActive(false)
	self.disableRoot.gameObject:SetActive(not isInteractable)
end

function m:ChangeSelect(battleUnitID)
	local isSelect = self.battleUnitID == battleUnitID

	self.selectRoot.gameObject:SetActive(isSelect)
	self.selectBottomRoot.gameObject:SetActive(isSelect)
end

function m:SetOrder(order)
	self.order = order

	self.battleActionOrderFollower:SetOrder(order)
end

function m:SetPosition(position)
	self.gameObject.transform.position = position
end

function m:ShowIcon()
	local headIconPath = BattleModule.GetBattleUnitHeadIcon(self.battleUnitID)

	AssetUtil.LoadImage(self, headIconPath, self.headIcon:GetComponent(typeof(UnityEngine.UI.Image)))
end

function m:Dispose()
	self:__RemoveListener()

	self.rectTransform = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	UnityEngine.Object.Destroy(self.battleActionOrderFollower)
	UnityEngine.Object.Destroy(self.gameObject)

	self.gameObject = nil
end

return m
