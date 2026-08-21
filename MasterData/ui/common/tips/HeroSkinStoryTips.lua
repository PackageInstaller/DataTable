-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\HeroSkinStoryTips.lua

local strClassName = "HeroSkinStoryTips"
local HeroSkinStoryTips = Class(strClassName, UIControls.Tips)

function HeroSkinStoryTips:ctor()
	self:initUI()
end

function HeroSkinStoryTips:initUI()
	self.grid = UIControls.SkinCardChild(self, "BgPanel/HeroSkinPanel", "System/Common/Grid/GridSkinCard")
	self.textName = UIControls.Label(self, "BgPanel/TxtStoryPanel/TextTitle")
	self.textStory = UIControls.Label(self, "BgPanel/TxtStoryPanel/Viewport/Content/Text")
end

function HeroSkinStoryTips:_setObj(grid)
	self.skinData = grid.skinStoryData

	self.grid:setVisible(true)

	self.grid.isShowPreviewTips = false
	self.grid.mEnableTips = false

	self.grid:setSkin(self.skinData)
	self.textName:setText(self.skinData.name or "")
	self.textStory:setText(self.skinData.desc or "")
end

return HeroSkinStoryTips
