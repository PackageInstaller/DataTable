-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\DIYSkillPanel\\RoleDevelopmentDIYSkillPanel.lua

local RoleDevelopmentPanelBase = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentPanelBase")
local DiySkillInfoView = require("IQIGame.UI.RoleDevelopment.RoleTraining.DiySkillInfoView.DiySkillInfoView")
local DiySkillInfoViewNew = require("IQIGame.UI.RoleDevelopmentPanel.SubPanel.DiySkillInfoPanelNew")
local RoleDevelopmentDIYSkillPanel = Clone(RoleDevelopmentPanelBase)

function RoleDevelopmentDIYSkillPanel:__OnInit()
	self.diySkillInfoView = DiySkillInfoViewNew.New(self.DiySkillInfoPanel)
end

function RoleDevelopmentDIYSkillPanel:__OnDispose()
	self.diySkillInfoView:Dispose()
end

function RoleDevelopmentDIYSkillPanel:__OnHide()
	self.diySkillInfoView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function RoleDevelopmentDIYSkillPanel:__OnShow()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self.diySkillInfoView:Show()
	self.diySkillInfoView:SetData(self.roleCid, false)
end

function RoleDevelopmentDIYSkillPanel:Refresh(roleCid)
	self.roleCid = roleCid

	self.diySkillInfoView:SetData(self.roleCid, true)
end

return RoleDevelopmentDIYSkillPanel
