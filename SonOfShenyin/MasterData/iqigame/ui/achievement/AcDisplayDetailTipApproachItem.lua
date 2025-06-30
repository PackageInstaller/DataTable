-- chunkname: @IQIGame\\UI\\Achievement\\AcDisplayDetailTipApproachItem.lua

local AcDisplayDetailTipApproachItem = {}

function AcDisplayDetailTipApproachItem.New(go, mainView)
	local o = Clone(AcDisplayDetailTipApproachItem)

	o:Initialize(go, mainView)

	return o
end

function AcDisplayDetailTipApproachItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AcDisplayDetailTipApproachItem:InitComponent()
	return
end

function AcDisplayDetailTipApproachItem:InitDelegate()
	return
end

function AcDisplayDetailTipApproachItem:AddListener()
	return
end

function AcDisplayDetailTipApproachItem:RemoveListener()
	return
end

function AcDisplayDetailTipApproachItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function AcDisplayDetailTipApproachItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AcDisplayDetailTipApproachItem:Refresh(Data)
	LuaUtility.SetText(self.approachText, CfgUtil.GetCfgFunctionDataWithID(Data).Name)
end

return AcDisplayDetailTipApproachItem
