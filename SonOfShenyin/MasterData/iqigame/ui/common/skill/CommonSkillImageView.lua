-- chunkname: @IQIGame\\UI\\Common\\Skill\\CommonSkillImageView.lua

CommonSkillImageView = {}

function CommonSkillImageView.New(view)
	local obj = Clone(CommonSkillImageView)

	obj:Init(view)

	return obj
end

function CommonSkillImageView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function CommonSkillImageView:SetData(skillCid)
	self.skillCfg = CfgSkillTable[skillCid]

	self:OnLoadSkillImage()
	self:OnLoadSkillEffect()
end

function CommonSkillImageView:OnLoadSkillImage()
	local path = UIGlobalApi.GetIconPath(self.skillCfg.Icon)

	AssetUtil.LoadImage(self, path, self.skillImage:GetComponent(typeof(UnityEngine.UI.Image)), nil, nil, nil, true)
end

function CommonSkillImageView:OnLoadSkillEffect()
	self:StopEffect()

	if self.skillCfg.DiyEffect[1] ~= 0 and self.skillCfg.DiyEffect[1] ~= nil then
		self.topEffectSerialId = GameEntry.Effect:PlayUIMountPointEffect(self.skillCfg.DiyEffect[1], 1510010, 0, self.View, 0)
	end

	if self.skillCfg.DiyEffect[2] ~= 0 and self.skillCfg.DiyEffect[2] ~= nil then
		self.bottomEffectSerialId = GameEntry.Effect:PlayUIMountPointEffect(self.skillCfg.DiyEffect[2], 1510011, 0, self.View, 0)
	end
end

function CommonSkillImageView:StopEffect()
	if self.topEffectSerialId then
		GameEntry.Effect:StopEffect(self.topEffectSerialId)

		self.topEffectSerialId = nil
	end

	if self.bottomEffectSerialId then
		GameEntry.Effect:StopEffect(self.bottomEffectSerialId)

		self.bottomEffectSerialId = nil
	end
end

function CommonSkillImageView:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function CommonSkillImageView:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function CommonSkillImageView:Dispose()
	self:StopEffect()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return CommonSkillImageView
