-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardLottery2025View.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardLottery2025View", package.seeall)

local YearCardLottery2025View = class("YearCardLottery2025View", YearCardLotteryView)

function YearCardLottery2025View:buildUI()
	YearCardLottery2025View.super.buildUI(self)

	self.skinId = YearCardConfig.instance:getYearcardCommonValue("SkinId_2025", true)
	self._aniPath = "feixisi02_dengchang"
	self._mainEffPath = "20241220/mianbanfw_fx/fx_ui_zhizunnianfei_shengping_fw.prefab"
	self._gouGo = self:getGo("skipani/btnSkipAni/gou")
	self._btnSkipAni = self:getBtn("skipani/btnSkipAni")
	self._skipAni = false

	self:_updateSkipState()
end

function YearCardLottery2025View:unbindEvents()
	YearCardLottery2025View.super.unbindEvents(self)
	self._btnSkipAni:RemoveClickListener()
end

function YearCardLottery2025View:bindEvents()
	YearCardLottery2025View.super.bindEvents(self)
	self._btnSkipAni:AddClickListener(self._onClickbtnSkipAni, self)
end

function YearCardLottery2025View:onExit()
	YearCardLottery2025View.super.onExit(self)
	removetimer(self._showSecondEffect, self)
	removetimer(self._showRewardCI, self)
end

function YearCardLottery2025View:initActiveId()
	self._actId = YearCardModel.instance:getCurAnnuityId()
end

function YearCardLottery2025View:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.skinId)
	end
end

function YearCardLottery2025View:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "yearcardlotteryview2025")
end

function YearCardLottery2025View:_onClickbtnSkipAni()
	self._skipAni = not self._skipAni

	self:_updateSkipState()
end

function YearCardLottery2025View:_updateSkipState()
	goutil.setActive(self._gouGo, self._skipAni)
end

function YearCardLottery2025View:_playRotateEffs()
	if not self._skipAni then
		YearCardLottery2025View.super._playRotateEffs(self)
	else
		local info = YearCardLotteryModel.instance:getMsgInfo(self._actId)
		local effId = checknumber(info.gainPrizeId)

		self:_createEff("20211231/qiandao/fx_ui_xuyuan_jiangli.prefab", self._prizeList[effId].eff, "prizeEff" .. effId, false)
		settimer(0.6, self._showSecondEffect, self, false)
	end
end

function YearCardLottery2025View:_showSecondEffect()
	removetimer(self._showSecondEffect, self)

	local info = YearCardLotteryModel.instance:getMsgInfo(self._actId)
	local effId = checknumber(info.gainPrizeId)
	local key = "prizeEff" .. effId

	self:_createEff("20211231/qiandao/fx_ui_xuyuan_jiangli.prefab", self._prizeList[effId].eff, key, false)
	settimer(0.6, self._showRewardCI, self, false)
end

function YearCardLottery2025View:_showRewardCI()
	removetimer(self._showRewardCI, self)
	YearCardLotteryModel.instance:showCI(self._actId)
	self:_refreshView()

	self._isLotterying = false
end

return YearCardLottery2025View
