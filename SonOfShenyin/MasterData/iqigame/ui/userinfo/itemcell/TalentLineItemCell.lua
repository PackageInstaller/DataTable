-- chunkname: @IQIGame\\UI\\UserInfo\\ItemCell\\TalentLineItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.rectCom = self.View:GetComponent("RectTransform")
end

function m:SetData(talentId, ownObj, targetObj)
	self.talentId = talentId

	local ownRectCom = ownObj:GetComponent("RectTransform")
	local targetRectCom = targetObj:GetComponent("RectTransform")

	LuaUtility.SetAnchoredPositionWithRectTransform(self.rectCom, ownRectCom.anchoredPosition.x, ownRectCom.anchoredPosition.y)

	local newPos = Vector3.New(ownRectCom.position.x - targetRectCom.position.x, ownRectCom.position.y - targetRectCom.position.y)
	local distance = newPos:Magnitude()

	self.rectCom.sizeDelta = Vector2.New(distance * 7, self.rectCom.sizeDelta.y)
	self.rectCom.transform.rotation = LuaUtility.GetUIObjectAngle(ownRectCom, targetRectCom)
end

function m:SetState()
	local state = UserInfoModule.GetTalentIsActive(self.talentId)

	LuaUtility.SetGameObjectShow(self.off, not state)
	LuaUtility.SetGameObjectShow(self.on, state)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
