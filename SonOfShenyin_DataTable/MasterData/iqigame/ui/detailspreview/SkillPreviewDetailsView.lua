-- chunkname: @IQIGame\\UI\\DetailsPreview\\SkillPreviewDetailsView.lua

local skillPreviewDetailView_info = require("IQIGame.UI.DetailsPreview.SkillPreviewDetailView_Info")
local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.SkillPreviewDetailInfoView = skillPreviewDetailView_info.New(self.DiySkillInfoPanel)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(skillCid)
	self.SkillPreviewDetailInfoView:SetData(skillCid)
	self.SkillPreviewDetailInfoView:Show()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.SkillPreviewDetailInfoView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
