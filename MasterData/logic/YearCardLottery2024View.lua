-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardLottery2024View.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardLottery2024View", package.seeall)

local YearCardLottery2024View = class("YearCardLottery2024View", YearCardLotteryView)

function YearCardLottery2024View:buildUI()
	YearCardLottery2024View.super.buildUI(self)

	self.skinId = 1800101
	self._aniPath = "fanerweisi01_dengchang"
	self._mainEffPath = "20231222/nianfei24nian/fx_ui_zhizunnianfei_fw.prefab"
end

function YearCardLottery2024View:initActiveId()
	self._actId = 8004
end

function YearCardLottery2024View:_onClickSkill()
	UIStateManager.instance:push(ViewName.PetcollegeView, 41)
end

function YearCardLottery2024View:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "yearcardlotteryview2024")
end

return YearCardLottery2024View
