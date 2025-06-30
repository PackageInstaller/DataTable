-- chunkname: @IQIGame\\UI\\Map\\Common\\ArrowInstruction.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickJumpBtn()
		self:OnClickJumpBtn()
	end

	self.parentRectTransform = self.View.transform.parent:GetComponent("RectTransform")

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickJumpBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickJumpBtn)
end

function m:Follow()
	if MapModule.TargetMapItem == nil then
		return
	end

	local screenRatio = 750 / UnityEngine.Screen.height
	local screenWidth = UnityEngine.Screen.width * screenRatio
	local screenHeight = 750
	local heroPos = MapModule.TargetMapItem.transform.position
	local screenPos = GameEntry.UICamera:WorldToScreenPoint(heroPos) * screenRatio

	screenPos.y = screenPos.y - 50
	screenPos.x = screenPos.x - 100

	local minHeroX = 0
	local maxHeroX = screenWidth
	local minHeroY = 0
	local maxHeroY = screenHeight
	local outSideScreen = minHeroX > screenPos.x or maxHeroX < screenPos.x or minHeroY > screenPos.y or maxHeroY < screenPos.y

	self:SetState(outSideScreen)

	if outSideScreen then
		local pointerX = screenPos.x
		local pointerY = screenPos.y
		local minPointerX = 0
		local maxPointerX = screenWidth - 200
		local minPointerY = 0
		local maxPointerY = screenHeight - 200

		if pointerX < minPointerX then
			pointerX = minPointerX
		elseif maxPointerX < pointerX then
			pointerX = maxPointerX
		end

		if pointerY < minPointerY then
			pointerY = minPointerY
		elseif maxPointerY < pointerY then
			pointerY = maxPointerY
		end

		local pointerPos = Vector2(pointerX, pointerY)

		self.View.transform.anchoredPosition = pointerPos

		local fromStartToEnd = Vector3(screenPos.x, -screenPos.y, 0) - Vector3(pointerPos.x, -pointerPos.y, 0)
		local q = Quaternion.identity

		q:SetFromToRotation(Vector3.Normalize(fromStartToEnd), Vector3.up)

		self.View.transform:Find("arrowImg").transform.rotation = q
	end
end

function m:SetData()
	return
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	self:Follow()
end

function m:SetState(state)
	LuaUtility.SetGameObjectShow(self.View, state)
end

function m:OnClickJumpBtn()
	if MapModule.TargetMapItem then
		EventDispatcher.Dispatch(EventID.ClickMarkItemMoveMapEvent, MapModule.TargetMapItem.transform.position, true)
	end
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
