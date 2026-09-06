-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardLottery2026View.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardLottery2026View", package.seeall)

local YearCardLottery2026View = class("YearCardLottery2026View", YearCardLotteryView)

YearCardLottery2026View.EntryType = {
	BagRule = 3,
	FormationRule = 2,
	Poster = 5,
	Skin = 4,
	StartAni = 1
}
YearCardLottery2026View.EntryTypeConfigs = {
	YearCardLottery2026View.EntryType.StartAni,
	YearCardLottery2026View.EntryType.FormationRule,
	YearCardLottery2026View.EntryType.BagRule,
	YearCardLottery2026View.EntryType.Skin,
	YearCardLottery2026View.EntryType.Poster
}

function YearCardLottery2026View:buildUI()
	YearCardLottery2026View.super.buildUI(self)

	self.skinId = YearCardConfig.instance:getYearcardCommonValue("SkinId_2026", true)
	self._aniPath = "heichuang01_dengchang"
	self._mainEffPath = "20251219/26nianfei/fx_ui_pifuchoujiang_fw.prefab"
	self._gouGo = self:getGo("skipani/btnSkipAni/gou")
	self._btnSkipAni = self:getBtn("skipani/btnSkipAni")
	self._skipAni = false

	self:_updateSkipState()
	self:_buildEntryCells()
end

function YearCardLottery2026View:_buildEntryCells()
	self._entryCells = {}
	self._conGo = self:getGo("entry/con")
	self._cellGo = self:getGo("entry/cell")
	self._layout = self._conGo:GetComponent(ComponentType.UILayoutSingleLine)

	goutil.setActive(self._cellGo, false)

	for i, v in ipairs(YearCardLottery2026View.EntryTypeConfigs) do
		local go = goutil.cloneAndSetParent(self._cellGo, self._conGo.transform)

		self._entryCells[v] = {
			go = go,
			btn = Framework.ButtonAdapter.GetFrom(go, "btn")
		}

		goutil.setActive(go, true)
	end

	self._layout:Layout()
end

function YearCardLottery2026View:unbindEvents()
	YearCardLottery2026View.super.unbindEvents(self)
	self._btnSkipAni:RemoveClickListener()

	for k, v in pairs(self._entryCells) do
		v.btn:RemoveClickListener()
	end
end

function YearCardLottery2026View:bindEvents()
	YearCardLottery2026View.super.bindEvents(self)
	self._btnSkipAni:AddClickListener(self._onClickbtnSkipAni, self)

	for k, v in pairs(self._entryCells) do
		v.btn:AddClickListener(function()
			self:_onClickEntry(k)
		end)
	end
end

function YearCardLottery2026View:onEnter()
	YearCardLottery2026View.super.onEnter(self)
	self:_updateEntrys()
end

function YearCardLottery2026View:onExit()
	YearCardLottery2026View.super.onExit(self)
	removetimer(self._showSecondEffect, self)
	removetimer(self._showRewardCI, self)
end

function YearCardLottery2026View:initActiveId()
	self._actId = YearCardConfig.instance:getNextActId()
end

function YearCardLottery2026View:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.skinId)
	end
end

function YearCardLottery2026View:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "yearcardlotteryview2026")
end

function YearCardLottery2026View:_onClickbtnSkipAni()
	self._skipAni = not self._skipAni

	self:_updateSkipState()
end

function YearCardLottery2026View:_updateSkipState()
	goutil.setActive(self._gouGo, self._skipAni)
end

function YearCardLottery2026View:_playRotateEffs()
	if not self._skipAni then
		YearCardLottery2026View.super._playRotateEffs(self)
	else
		local info = YearCardLotteryModel.instance:getMsgInfo(self._actId)
		local effId = checknumber(info.gainPrizeId)

		self:_createEff("20211231/qiandao/fx_ui_xuyuan_jiangli.prefab", self._prizeList[effId].eff, "prizeEff" .. effId, false)
		settimer(0.6, self._showSecondEffect, self, false)
	end
end

function YearCardLottery2026View:_showSecondEffect()
	removetimer(self._showSecondEffect, self)

	local info = YearCardLotteryModel.instance:getMsgInfo(self._actId)
	local effId = checknumber(info.gainPrizeId)
	local key = "prizeEff" .. effId

	self:_createEff("20211231/qiandao/fx_ui_xuyuan_jiangli.prefab", self._prizeList[effId].eff, key, false)
	settimer(0.6, self._showRewardCI, self, false)
end

function YearCardLottery2026View:_showRewardCI()
	removetimer(self._showRewardCI, self)
	YearCardLotteryModel.instance:showCI(self._actId)
	self:_refreshView()

	self._isLotterying = false
end

function YearCardLottery2026View:_updateEntrys()
	for k, v in pairs(self._entryCells) do
		local txtDesc = goutil.findChildTextComponent(v.go, "txtDesc")

		txtDesc.text = self:_getEntryDesc(k)
	end
end

function YearCardLottery2026View:_getEntryDesc(eType)
	if eType == YearCardLottery2026View.EntryType.StartAni then
		return "战斗界面新增入场动画&击杀特效"
	elseif eType == YearCardLottery2026View.EntryType.FormationRule then
		return "布阵界面专属头像框"
	elseif eType == YearCardLottery2026View.EntryType.BagRule then
		return "背包专属外框"
	elseif eType == YearCardLottery2026View.EntryType.Skin then
		return "高品质点触交互"
	elseif eType == YearCardLottery2026View.EntryType.Poster then
		return "自带动态海报"
	end
end

function YearCardLottery2026View:_onClickEntry(eType)
	if eType == YearCardLottery2026View.EntryType.StartAni then
		local skinId = 1803101
		local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if not string.nilorempty(petSkinCfg.showTime) then
			local time = GameUtil.string2time(petSkinCfg.showTime)

			if time > ServerTime.now() then
				FloatWordMgr.instance:show("敬请期待")

				return
			end
		end

		UIJumper.instance:saveCurStack()
		GotoMgr.gotoByString("ui#petcollegeview#61")
	elseif eType == YearCardLottery2026View.EntryType.FormationRule then
		local key = "yearcardlottery2026_2"

		TipsFacade.instance:openImageRuleViewByKey(key, "游戏规则")
	elseif eType == YearCardLottery2026View.EntryType.BagRule then
		local key = "yearcardlottery2026_1"

		TipsFacade.instance:openImageRuleViewByKey(key, "游戏规则")
	elseif eType == YearCardLottery2026View.EntryType.Skin then
		UIStateManager.instance:push(ViewName.Yearcardskininteraction2026View, 1803101)
	elseif eType == YearCardLottery2026View.EntryType.Poster then
		local skinId = 1803101
		local list = PetSkinConfig.instance:getPosterList(skinId)

		if list and #list > 0 then
			local posterList = {}

			for i, posterCfg in ipairs(list) do
				table.insert(posterList, posterCfg.posterId)
			end

			local posterCfg = PetskinController.instance:getPosterCfg(skinId)

			if posterCfg then
				UIStateManager.instance:push(ViewName.PetskinposterView, posterCfg.posterId, posterList, skinId)
			elseif #posterList > 0 then
				UIStateManager.instance:push(ViewName.PetskinposterView, posterList[1], posterList, skinId)
			end
		end
	end
end

return YearCardLottery2026View
