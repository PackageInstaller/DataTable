-- chunkname: @IQIGame\\UI\\Battle\\BattleGuideTemplate\\BattleGuideMould1.lua

local BattleGuideTemplateBase = require("IQIGame/UI/Battle/BattleGuideTemplate/BattleGuideTemplateBase")
local BattleGuideMould1 = Clone(BattleGuideTemplateBase)

function BattleGuideMould1:__Init()
	LuaCodeInterface.BindOutlet(self.view, self)
end

function BattleGuideMould1:__Show()
	local mouldCfg = CfgBattleGuideModuleTable[self.guideData.moduleId]
	local path = BattleUIApi:GetGuideUIImagePath(mouldCfg.ShowImage[1])

	AssetUtil.LoadImage(self, path, self.icon:GetComponent("Image"), function()
		self.icon:GetComponent("Image"):SetNativeSize()
	end)
end

function BattleGuideMould1:__Hide()
	return
end

function BattleGuideMould1:__Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)
end

return BattleGuideMould1
