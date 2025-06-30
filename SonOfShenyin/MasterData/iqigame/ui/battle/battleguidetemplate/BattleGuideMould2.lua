-- chunkname: @IQIGame\\UI\\Battle\\BattleGuideTemplate\\BattleGuideMould2.lua

local BattleGuideTemplateBase = require("IQIGame/UI/Battle/BattleGuideTemplate/BattleGuideTemplateBase")
local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local SubItem = {}

function SubItem.New(view)
	local obj = Clone(SubItem)

	obj:__Init(view)

	return obj
end

function SubItem:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
end

function SubItem:Show(img)
	self.view.gameObject:SetActive(true)

	local path = BattleUIApi:GetGuideUIImagePath(img)

	AssetUtil.LoadImage(self, path, self.icon:GetComponent("Image"))
end

function SubItem:Hide()
	self.view.gameObject:SetActive(false)
end

function SubItem:IsFree()
	return not self.view.gameObject.activeSelf
end

function SubItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local BattleGuideMould2 = Clone(BattleGuideTemplateBase)

BattleGuideMould2.subItemPool = nil

function BattleGuideMould2:__Init()
	LuaCodeInterface.BindOutlet(self.view, self)
	self.subItemTemplate.gameObject:SetActive(false)

	self.subItemPool = UIViewObjectPool.New(self.subItemTemplate, nil, function(_view)
		return SubItem.New(_view)
	end)
end

function BattleGuideMould2:__Show()
	self.subItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	local mouldCfg = CfgBattleGuideModuleTable[self.guideData.moduleId]

	self.content:GetComponent("Text").text = mouldCfg.ShowText[1]

	for i = 1, #mouldCfg.ShowImage do
		local iconItem = self.subItemPool:GetFree(function(_item)
			_item:IsFree()
		end)

		iconItem:Show(mouldCfg.ShowImage[i])
	end
end

function BattleGuideMould2:__Hide()
	return
end

function BattleGuideMould2:__Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)
end

return BattleGuideMould2
