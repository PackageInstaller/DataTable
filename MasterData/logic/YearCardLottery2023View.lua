-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardLottery2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardLottery2023View", package.seeall)

local YearCardLottery2023View = class("YearCardLottery2023View", YearCardLotteryView)

function YearCardLottery2023View:buildUI()
	YearCardLottery2023View.super.buildUI(self)

	self.skinId = 1601001
	self._aniPath = "aojiu01_dengchang"
	self._mainEffPath = "20221223/2023nianfei/fx_ui_2023nianfei_aojiu.prefab"
end

function YearCardLottery2023View:_onClickSkill()
	UIStateManager.instance:push(ViewName.PetcollegeView, 39)
end

return YearCardLottery2023View
