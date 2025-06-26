-- chunkname: @IQIGame\\UI\\Common\\BaseChildrenPanel.lua

BaseChildrenPanel = class({})

function BaseChildrenPanel:Open()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:OnOpen()
end

function BaseChildrenPanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	self:OnClose()
end

function BaseChildrenPanel:OnOpen()
	return
end

function BaseChildrenPanel:OnClose()
	return
end

function BaseChildrenPanel:OnDestroy()
	return
end

function BaseChildrenPanel:GetIsShow()
	return self.gameObject.activeSelf
end

function BaseChildrenPanel:GetPanelIsShow()
	return self.gameObject.activeSelf
end
