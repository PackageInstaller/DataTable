-- chunkname: @IQIGame\\UI\\SoulHandbook\\SoulHandBookToggle.lua

local SoulHandBookToggle = {}

function SoulHandBookToggle.New(view)
	local obj = Clone(SoulHandBookToggle)

	obj:Init(view)

	return obj
end

function SoulHandBookToggle:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.toggle = self.View:GetComponent("Toggle")

	self:AddEventListener()
end

function SoulHandBookToggle:AddEventListener()
	return
end

function SoulHandBookToggle:RemoveEventListener()
	return
end

function SoulHandBookToggle:SetDate(type, num, maxNum)
	self.getWayType = type

	UGUIUtil.SetText(self.TextTogUp, SoulHandBookUIApi:GetString("GetWayType", self.getWayType))
	UGUIUtil.SetText(self.TextTogDown, SoulHandBookUIApi:GetString("GetWayType", self.getWayType))
	UGUIUtil.SetText(self.TextTogNum, SoulHandBookUIApi:GetString("TextTogNum", num, maxNum))
	UGUIUtil.SetText(self.TextTogDownNum, SoulHandBookUIApi:GetString("TextTogNum", num, maxNum))

	self.Progress:GetComponent("Image").fillAmount = num / maxNum

	self:SetRedPoint(false)
end

function SoulHandBookToggle:SetRedPoint(isRed)
	self.RedPoint:SetActive(isRed)
end

function SoulHandBookToggle:Dispose()
	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.GameObject.DestroyImmediate(self.View)

	self.View = nil
end

return SoulHandBookToggle
