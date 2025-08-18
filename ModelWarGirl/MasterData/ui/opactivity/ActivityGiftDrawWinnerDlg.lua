-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityGiftDrawWinnerDlg.lua

local strClassName = "ActivityGiftDrawWinnerDlg"
local ActivityGiftDrawWinnerDlg = Class(strClassName, UIControls.Window)

function ActivityGiftDrawWinnerDlg:ctor()
	self:initUI()
end

function ActivityGiftDrawWinnerDlg:initUI()
	self.btnResult = UIControls.Button(self, "BgPanel/BtnResult")

	self.btnResult:addEventClick(self.onBtnResultClick)

	self.textDes = UIControls.Label(self, "BgPanel/BgDes/TextDes")
	self.grids = {}
end

function ActivityGiftDrawWinnerDlg:setData(data, curRound)
	local content = utils.format(Lang.get(88771), data.price_title, curRound - 1)

	self.textDes:setText(content)
	ClientUtils.CreateBonusGrid(self, self.grids, "BgPanel/AwardPanel", data.award_id, true, nil, true)
end

function ActivityGiftDrawWinnerDlg:onBtnResultClick()
	self:setVisible(false)
end

return ActivityGiftDrawWinnerDlg
