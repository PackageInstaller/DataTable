-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlaySettleAwardDlg.lua

local SeasonPlaySettleAwardDlg = Class("SeasonPlaySettleAwardDlg", UIControls.Window)
local FlyIconUtils = require("UI/Common/FlyIconUtils")

function SeasonPlaySettleAwardDlg:ctor(...)
	self:initUI()
end

function SeasonPlaySettleAwardDlg:initUI(...)
	self.txtTitle = UIControls.Label(self, "BgPanel/TextTitle")
end

function SeasonPlaySettleAwardDlg:setData(data)
	self.data = data

	self.txtTitle:setText(data.desc)

	local fakeItem = BaseObject.GetObject(data.itemId, data.count)

	if not self.awardItemCell then
		self.awardItemCell = UIControls.getGridAwardContainer(self, "BgPanel/AwardList")
	end

	self.awardItemCell:setVisible(true)
	self.awardItemCell:setObj(fakeItem)
	self.txtTitle:setText(data.desc)
end

function SeasonPlaySettleAwardDlg:setEndFlyObj(obj)
	self.endFlyObj = obj
end

function SeasonPlaySettleAwardDlg:onClose(...)
	CurAvatar:clearOpActSeasonBPPointAdd(self.data.opId, self.data.type)

	local ui = UIManager.tryGetUI("seasonPlayMainDlg")

	if ui and ui:getVisible() then
		ui:setSettleShow()
	end

	if self.data and self.endFlyObj then
		FlyIconUtils.setFlyUItoUI(self.awardItemCell, self.endFlyObj, self.data.itemId, self.data.count, nil)
	end

	SeasonPlaySettleAwardDlg.super.onClose(self)
end

return SeasonPlaySettleAwardDlg
