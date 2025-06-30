-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\DiySkillInfoView\\DiySkillContrastView.lua

local DiySkillDetailsView = require("IQIGame.UI.DiySkill.DetailsView.DiySkillDetailsView")
local DiySkillContrastView = {}

function DiySkillContrastView.New(view)
	local obj = Clone(DiySkillContrastView)

	obj:__Init(view)

	return obj
end

function DiySkillContrastView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.diySkillDetailsView = DiySkillDetailsView.New(self.SkillInfoScroll)

	self:__AddListeners()
end

function DiySkillContrastView:__AddListeners()
	return
end

function DiySkillContrastView:__RemoveListeners()
	return
end

function DiySkillContrastView:Dispose()
	self:__RemoveListeners()
	self.diySkillDetailsView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillContrastView:SetData(skillData)
	self.SkillData = skillData

	self.gameObject:SetActive(true)
	self.diySkillDetailsView:Show(skillData)
end

function DiySkillContrastView:Hide()
	self.gameObject:SetActive(false)

	self.SkillData = nil
end

return DiySkillContrastView
