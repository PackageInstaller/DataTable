-- chunkname: @IQIGame\\UI\\MonsterAcademyGame\\FruitGameController.lua

local FruitGameFallingObjectItem = require("IQIGame.UI.MonsterAcademyGame.FruitGameFallingObjectItem")
local m = {
	TotalScore = 0,
	moveSpeed = 0,
	limitRight = 0,
	IsGaming = false,
	limitLeft = 0,
	basketPositionY = 0,
	fallingObjectPool = {},
	aliveFallongObjects = {},
	initiallyPositions = {}
}

function m.New(viewRoot)
	local obj = Clone(m)

	obj:__Init(viewRoot)

	return obj
end

function m:__Init(viewRoot)
	self.ViewRoot = viewRoot

	LuaCodeInterface.BindOutlet(self.ViewRoot, self)

	self.basketPositionY = self.goBasket.transform.localPosition.y

	self.goFallingObject.gameObject:SetActive(false)
	self.goFruitsEffect.gameObject:SetActive(false)
	self.goBlastEffect.gameObject:SetActive(false)

	local childCnt = self.goInitiallyRoot.transform.childCount

	for i = 0, childCnt - 1 do
		local trans = self.goInitiallyRoot.transform:GetChild(i)

		table.insert(self.initiallyPositions, trans.localPosition)
	end

	self.basketColliderBox = self.goBasket.gameObject:GetComponent(typeof(UnityEngine.Collider2D))
	self.limitLeft = self.goLeftLimit.transform.localPosition.x
	self.limitRight = self.goRightLimit.transform.localPosition.x

	local leftMoveBtn = self.goLeftMoveBtn:GetComponent("LongButton")

	function leftMoveBtn.OnPointerUpAction(go)
		self:__OnLeftPointerUp(go)
	end

	function leftMoveBtn.OnPointerDownAction(go)
		self:__OnLeftPointerDown(go)
	end

	local rightMoveBtn = self.goRightMoveBtn:GetComponent("LongButton")

	function rightMoveBtn.OnPointerUpAction(go)
		self:__OnRightPointerUp(go)
	end

	function rightMoveBtn.OnPointerDownAction(go)
		self:__OnRightPointerDown(go)
	end

	self.dragCom = self.goBasket:GetComponent("UIDrag")

	function self.dragCom.onBeginDrag(pointerEventData)
		self:__OnBasketBeginDrag(pointerEventData)
	end

	function self.dragCom.onDrag(pointerEventData)
		self:__OnBasketDrag(pointerEventData)
	end

	function self.dragCom.onReachTargetSuccess(rect)
		self:__OnBasketEndDrag(rect)
	end
end

function m:__OnBasketBeginDrag(eventData)
	self:__OnMoveBasketByDrag()
end

function m:__OnBasketDrag(eventData)
	self:__OnMoveBasketByDrag()
end

function m:__OnBasketEndDrag(eventData)
	self:__OnMoveBasketByDrag()
end

function m:__OnMoveBasketByDrag()
	local pos = Clone(self.goBasket.transform.localPosition)

	pos.y = self.basketPositionY
	pos.x = math.max(self.limitLeft, pos.x)
	pos.x = math.min(self.limitRight, pos.x)
	self.goBasket.transform.localPosition = pos
end

function m:__OnLeftPointerUp(go)
	self.moveSpeed = 0
end

function m:__OnLeftPointerDown(go)
	self.moveSpeed = -10
end

function m:__OnRightPointerUp(go)
	self.moveSpeed = 0
end

function m:__OnRightPointerDown(go)
	self.moveSpeed = 10
end

function m:__OnMoveBasket()
	if self.moveSpeed == 0 then
		return
	end

	local pos = Clone(self.goBasket.transform.localPosition)

	pos.x = pos.x + self.moveSpeed
	pos.x = math.max(self.limitLeft, pos.x)
	pos.x = math.min(self.limitRight, pos.x)
	self.goBasket.transform.localPosition = pos
end

function m:InitGame(gameConfig, updateScoreHandler, successHandler)
	self.IsGaming = false
	self.gameCfg = gameConfig
	self.gameSuccessHandler = successHandler
	self.updateScoreHandler = updateScoreHandler

	self:__PrepareFallingObjectPool(self.gameCfg.FruitsGroup)

	local pos = Clone(self.goBasket.transform.localPosition)

	pos.x = 0
	self.goBasket.transform.localPosition = pos
end

function m:StartGame()
	self.TotalScore = 0
	self.IsGaming = true

	self:__StartFalling()
end

function m:EndGame()
	self.IsGaming = false

	self:__StopFalling()
	self:__CleanAllFallingObject()
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.IsGaming then
		return
	end

	self:__OnMoveBasket()

	for _key, fallingItem in pairs(self.aliveFallongObjects) do
		fallingItem:OnUpdate(elapseSeconds, realElapseSeconds)

		if fallingItem:ColliderBoundsIntersects(self.basketColliderBox) then
			local score = fallingItem.Cfg.Score

			if score > 0 then
				self:__PlayFruitsEffect()
			else
				self:__PlayBlastEffect()
			end

			self:__UpdateScore(score)
			self.updateScoreHandler(score, fallingItem.ViewRoot.transform.position)
			fallingItem:SetFree()
		end
	end

	for i = #self.aliveFallongObjects, 1, -1 do
		if self.aliveFallongObjects[i].IsFree then
			table.remove(self.aliveFallongObjects, i)
		end
	end
end

function m:__PlayFruitsEffect()
	GameEntry.Sound:PlaySound(10262, Constant.SoundGroup.UI)

	if self.goFruitsEffect.gameObject.activeSelf then
		return
	end

	self.goFruitsEffect.gameObject:SetActive(true)

	self.fruitsEffectTimer = Timer.New(function()
		self:__HideFruitsEffect()
	end, 0.5)

	self.fruitsEffectTimer:Start()
end

function m:__HideFruitsEffect()
	if self.fruitsEffectTimer ~= nil then
		self.fruitsEffectTimer:Stop()

		self.fruitsEffectTimer = nil
	end

	if self.goFruitsEffect then
		self.goFruitsEffect.gameObject:SetActive(false)
	end
end

function m:__PlayBlastEffect()
	GameEntry.Sound:PlaySound(10263, Constant.SoundGroup.UI)

	if self.goBlastEffect.gameObject.activeSelf then
		return
	end

	self.goBlastEffect.gameObject:SetActive(true)

	self.blastEffectTimer = Timer.New(function()
		self:__HideBlastEffect()
	end, 0.5)

	self.blastEffectTimer:Start()
end

function m:__HideBlastEffect()
	if self.blastEffectTimer ~= nil then
		self.blastEffectTimer:Stop()

		self.blastEffectTimer = nil
	end

	self.goBlastEffect.gameObject:SetActive(false)
end

function m:__UpdateScore(score)
	self.TotalScore = self.TotalScore + score
	self.TotalScore = math.max(0, self.TotalScore)

	if self.TotalScore >= self.gameCfg.SucScore then
		self.gameSuccessHandler()
	end
end

function m:__StartFalling()
	self:__CreateRandomFallingObjects(self.gameCfg.Grade[2])

	self.timer = Timer.New(function()
		self:__CreateRandomFallingObjects(self.gameCfg.Grade[2])
	end, self.gameCfg.Grade[1], -1)

	self.timer:Start()
end

function m:__StopFalling()
	if self.timer == nil then
		return
	end

	self.timer:Stop()

	self.timer = nil
end

function m:__CleanAllFallingObject()
	for _key, fallingItem in pairs(self.aliveFallongObjects) do
		fallingItem:SetFree()
	end

	self.aliveFallongObjects = {}
end

function m:__CreateRandomFallingObjects(count)
	local itemsDataTable = self:__GenerateRandomFallingObjectData(count)

	for _itemId, _pos in pairs(itemsDataTable) do
		local item = self:__GetFreeFallingObject(_itemId)

		item:OnActivation(_pos)
		table.insert(self.aliveFallongObjects, item)
	end
end

function m:__GenerateRandomFallingObjectData(count)
	local result = {}
	local _indexList = self.__RandomBlockList(#self.gameCfg.FruitsGroup, count)
	local _posList = self.__RandomBlockList(#self.initiallyPositions, count)

	for i = 1, count do
		local itemId = self.gameCfg.FruitsGroup[_indexList[i]]
		local pos = self.initiallyPositions[_posList[i]]

		result[itemId] = pos
	end

	return result
end

function m.__RandomBlockList(max, count)
	local list = {}
	local map = {}

	for i = 1, count do
		local r_num = math.random(i, max)
		local value = map[r_num] and map[r_num] or r_num

		table.insert(list, value)

		map[r_num] = map[i] or i
	end

	return list
end

function m:__PrepareFallingObjectPool(itemTables)
	for _key, _itemId in pairs(itemTables) do
		if self.fallingObjectPool[_itemId] == nil then
			self.fallingObjectPool[_itemId] = {}
		end

		for i = 1, 5 do
			local item = self:__CreateFallingObject(_itemId)

			table.insert(self.fallingObjectPool[_itemId], item)
		end
	end
end

function m:__CreateFallingObject(itemId)
	local obj = UnityEngine.Object.Instantiate(self.goFallingObject)

	obj.transform.gameObject:SetActive(true)
	obj.transform:SetParent(self.goFallingObject.transform.parent, false)

	local fallingObject = FruitGameFallingObjectItem.New(obj, itemId)

	fallingObject:SetFree()

	return fallingObject
end

function m:__GetFreeFallingObject(itemId)
	local itemTable = self.fallingObjectPool[itemId]

	for _index, item in pairs(itemTable) do
		if item.IsFree then
			return item
		end
	end

	local newItem = self:__CreateFallingObject(itemId)

	if self.fallingObjectPool[itemId] == nil then
		self.fallingObjectPool[itemId] = {}
	end

	table.insert(self.fallingObjectPool[itemId], newItem)

	return newItem
end

function m:OnDestroy()
	self.aliveFallongObjects = {}

	LuaCodeInterface.ClearOutlet(self.ViewRoot, self)

	for id, items in pairs(self.fallingObjectPool) do
		for i = 1, #items do
			items[i]:OnDestroy()
		end
	end

	self.fallingObjectPool = nil
end

return m
