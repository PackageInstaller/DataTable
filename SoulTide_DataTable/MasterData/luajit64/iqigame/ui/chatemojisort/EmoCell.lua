-- chunkname: @IQIGame\\UI\\ChatEmojiSort\\EmoCell.lua

local EmoCell = {}

function EmoCell.New(view, mainView)
	local obj = Clone(EmoCell)

	obj:Init(view, mainView)

	return obj
end

function EmoCell:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgIcon = self.goIcon:GetComponent("Image")
	self.tfName = self.goName:GetComponent("Text")
	self.tfNum = self.goNum:GetComponent("Text")
	self.tfNum2 = self.goNum2:GetComponent("Text")
	self.dragComp = self.goDrag:GetComponent("UIDrag")

	function self.dragComp.onBeginDrag(pointerEventData)
		self:OnBeginDrag(pointerEventData)
	end

	function self.dragComp.onDrag(pointerEventData)
		self:OnDrag(pointerEventData)
	end

	function self.dragComp.onReachTargetSuccess(rect)
		self:OnEndDrag(rect)
	end

	self.moveSpeed = ChatUIApi:GetString("Emo_Speed")
end

function EmoCell:Refresh(posIndex, cfgEmoGroupData)
	self.posIndex = posIndex
	self.cfgEmoGroupData = cfgEmoGroupData
	self.limitX = self.mainView.goEmoCell.transform.anchoredPosition.x

	self:RefreshMisc()
	self:SetUIDragEnable(true)
end

function EmoCell:OnHide()
	self:StopAutoMove()
end

function EmoCell:OnDestroy()
	self.mainView = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function EmoCell:OnBeginDrag(pointerEventData)
	self.lastY = self.View.transform.anchoredPosition.y

	self.goSign:SetActive(true)
	self.mainView:OnEmoCellBeginDrag(self)
end

function EmoCell:OnDrag(pointerEventData)
	self:CheckPosition()
	self.mainView:OnEmoCellDrag(self, self.View.transform.anchoredPosition.y - self.lastY)

	self.lastY = self.View.transform.anchoredPosition.y
end

function EmoCell:OnEndDrag(rect)
	self.mainView:OnEmoCellEndDrag(self)
end

function EmoCell:RefreshMisc()
	self.tfName.text = ChatUIApi:GetString("Emo_Name", self.cfgEmoGroupData.Name)

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgEmoGroupData.Icon), self.imgIcon)
	self:RefreshNum()
end

function EmoCell:RefreshNum()
	self.tfNum.text = ChatUIApi:GetString("Emo_Num", self.posIndex)
	self.tfNum2.text = self.tfNum.text

	self.goSign:SetActive(false)
end

function EmoCell:SetActive(vs)
	self.View:SetActive(vs)
end

function EmoCell:Move(deltaY)
	self.View.transform.anchoredPosition = Vector2.New(self.limitX, self.View.transform.anchoredPosition.y + deltaY)

	self:CheckPosition()
end

function EmoCell:CheckPosition()
	if self.View.transform.anchoredPosition.y > self.mainView.limitYTop then
		self.View.transform.anchoredPosition = Vector2.New(self.limitX, self.mainView.limitYTop)
	elseif self.View.transform.anchoredPosition.y < self.mainView.limitYBottom then
		self.View.transform.anchoredPosition = Vector2.New(self.limitX, self.mainView.limitYBottom)
	else
		self.View.transform.anchoredPosition = Vector2.New(self.limitX, self.View.transform.anchoredPosition.y)
	end
end

function EmoCell:GetY()
	return self.View.transform.anchoredPosition.y
end

function EmoCell:OnUpdate()
	if not self.enableAutoMove then
		return
	end

	if self.moveToUp then
		self:Move(math.min(self.targetPos - self:GetY(), self.moveSpeed))

		if self:GetY() >= self.targetPos then
			self:StopAutoMove()
		end
	else
		self:Move(math.max(self.targetPos - self:GetY(), -self.moveSpeed))

		if self:GetY() <= self.targetPos then
			self:StopAutoMove()
		end
	end
end

function EmoCell:StartAutoMove(targetPosIndex)
	self.posIndex = targetPosIndex
	self.targetPos = self.mainView.fixedPosYList[self.posIndex]

	if self.targetPos == self:GetY() then
		return
	end

	self.moveToUp = self.targetPos > self:GetY()
	self.enableAutoMove = true
end

function EmoCell:StopAutoMove()
	self.enableAutoMove = false
end

function EmoCell:SetUIDragEnable(enable)
	self.View:GetComponent("UIDrag").enabled = enable
end

return EmoCell
