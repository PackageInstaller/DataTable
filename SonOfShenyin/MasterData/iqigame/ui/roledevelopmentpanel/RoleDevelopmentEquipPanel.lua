-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\RoleDevelopmentEquipPanel.lua

local RoleDevelopmentPanelBase = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentPanelBase")
local EquipDetailsView = require("IQIGame.UI.Equip.MainView.EquipDetailsView")
local panel = Clone(RoleDevelopmentPanelBase)

function panel:__OnInit()
	self.equipDetailsView = EquipDetailsView.New(self.EquipView)
end

function panel:__OnAddListeners()
	return
end

function panel:__OnRemoveListeners()
	return
end

function panel:__OnShow()
	EquipModule.SetCurrentHeroCid(self.roleCid)
	self.equipDetailsView:Show()
end

function panel:__OnHide()
	self.equipDetailsView:Hide()
end

function panel:__OnRefresh()
	EquipModule.SetCurrentHeroCid(self.roleCid)
	self.equipDetailsView:Show()
end

function panel:__OnDispose()
	self.equipDetailsView:Dispose()
end

return panel
