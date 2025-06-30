-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\RoleDevelopmentBaseSkillPanel.lua

local RoleDevelopmentPanelBase = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentPanelBase")
local baseSkillInfoPanel = require("IQIGame.UI.RoleDevelopmentPanel.SubPanel.BaseSkillInfoPanel")
local panel = Clone(RoleDevelopmentPanelBase)

function panel:__OnInit()
	self.baseSkillInfoPanel = baseSkillInfoPanel.New(self.BaseSkillInfoPanel)
end

function panel:__OnAddListeners()
	return
end

function panel:__OnRemoveListeners()
	return
end

function panel:__OnShow()
	self.baseSkillInfoPanel:Show()
	self.baseSkillInfoPanel:SetData(self.roleCid)
end

function panel:__OnHide()
	self.baseSkillInfoPanel:Hide()
end

function panel:__OnDispose()
	self.baseSkillInfoPanel:Dispose()
end

function panel:__OnRefresh()
	self.baseSkillInfoPanel:SetData(self.roleCid)
end

return panel
