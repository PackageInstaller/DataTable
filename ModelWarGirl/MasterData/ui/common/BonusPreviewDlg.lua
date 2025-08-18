-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\BonusPreviewDlg.lua

local ResBonusPreview = require("ClientData/ResBonusPreview")
local strClassName = "BonusPreviewDlg"
local BonusPreviewDlg = Class(strClassName, UIControls.Window)

function BonusPreviewDlg:ctor()
	self:initUI()
end

function BonusPreviewDlg:initUI()
	self.desTxt = UIControls.Label(self, "BgPanel/TextDes")
	self.titleTxt = UIControls.Label(self, "BgPanel/TextTitle")
	self.cTextDesc = UIControls.Label(self, "BgPanel/BgQ/TextQ")
	self.gridMountPath = "BgPanel/AwardList/Content"
	self.itemGrids = {}
end

function BonusPreviewDlg:onShow(randData, hasGot)
	local preId = randData.bonus_preview_id
	local preData = ResBonusPreview[preId] or {}

	self.titleTxt:setText(preData.title or "")
	self.desTxt:setText(preData.desc or "")
	self.cTextDesc:setText(preData.c_desc or "")
	ClientUtils.CreateBonusGrid(self, self.itemGrids, "BgPanel/AwardList/Content", randData.id, true, nil, true)

	if hasGot then
		for index, grid in ipairs(self.itemGrids) do
			grid:setGet(true)
		end
	end
end

return BonusPreviewDlg
