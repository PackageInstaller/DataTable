-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\MainStagePreviewDepositPanel.lua

local strClassName = "MainStagePreviewDepositPanel"
local MainStagePreviewDepositPanel = Class(strClassName, UIControls.Panel)

function MainStagePreviewDepositPanel:ctor()
	self:initUI()
end

function MainStagePreviewDepositPanel:initUI()
	self.btnPreviewAward = UIControls.Button(self, self.mPath .. "/PreviewAwardBtn")

	self.btnPreviewAward:addEventClick(self.onBtnPreviewAwardClick)

	self.panelNewAward = UIControls.Panel(self, self.mPath .. "/NewAwardPanel")

	self.panelNewAward:setVisible(false)

	self.txtNewAward = UIControls.Label(self, self.mPath .. "/NewAwardPanel/NewAwardText")
end

function MainStagePreviewDepositPanel:setNextRandAwardInfo(nextRandAwardInfo)
	self.panelNewAward:setVisible(true)

	local stageStr = string.format("%s-%s", nextRandAwardInfo.resData.chapter, nextRandAwardInfo.resData.level)

	self.txtNewAward:setText(string.format(Lang.get(45492), stageStr))

	local addRandItemId = nextRandAwardInfo.addRandItemId

	for i, itemId in ipairs(addRandItemId) do
		local fakeItem = BaseObject.GetObject(itemId)
		local itemGrid = UIControls.ItemGridChild(self, self.mPath .. "/NewAwardPanel/AwardPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)

		itemGrid.mDisableWays = true

		itemGrid:setObj(fakeItem)
	end
end

function MainStagePreviewDepositPanel:onBtnPreviewAwardClick()
	self.mWindow:changeNewAwardPreivewPanelShow(true)
end

return MainStagePreviewDepositPanel
