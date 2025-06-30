-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\RoleDevelopmentStarRisePanel.lua

local RoleDevelopmentPanelBase = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentPanelBase")
local RoleStarRiseView = require("IQIGame.UI.RoleDevelopment.RoleTraining.RoleStarRiseView")
local panel = Clone(RoleDevelopmentPanelBase)

function panel:__OnInit()
	self.roleStarRiseView = RoleStarRiseView.New(self.RoleStarRisePanel, self)
end

function panel:__OnAddListeners()
	return
end

function panel:__OnRemoveListeners()
	return
end

function panel:__OnShow()
	self.roleStarRiseView:Show()
	self.roleStarRiseView:SetData(self.roleCid)
end

function panel:__OnHide()
	self.roleStarRiseView:Hide()
end

function panel:__OnDispose()
	self.roleStarRiseView:Dispose()
end

function panel:__OnRefresh()
	self.roleStarRiseView:SetData(self.roleCid)
end

return panel
