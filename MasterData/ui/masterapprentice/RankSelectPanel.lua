-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\RankSelectPanel.lua

local HandBookRankSelectMixin = require("UI.HandBook.HandBookRankSelectMixin")
local RankSelectPanel = Class("RankSelectPanel", UIControls.Child)

MixinClass(RankSelectPanel, HandBookRankSelectMixin)

function RankSelectPanel:ctor()
	self:initUI()
end

return RankSelectPanel
