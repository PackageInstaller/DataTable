-- chunkname: @IQIGame\\UI\\Chapter\\BossChapter\\SkillItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(skillId)
	local skillCfg = CfgSkillTable[skillId]
	local path = UIGlobalApi.GetIconPath(skillCfg.Icon)

	self:LoadImg(path, self.SkillImg)
	UGUIUtil.SetText(self.SkillName, skillCfg.Name)
	UGUIUtil.SetText(self.SkillDesc, ChapterUIApi:GetSkillDescValue(skillCfg.EffectText))
end

function m:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"))
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
