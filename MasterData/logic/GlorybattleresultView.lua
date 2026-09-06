-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleresultView.lua

module("logic.extensions.glorybattle.view.GlorybattleresultView", package.seeall)

local GlorybattleresultView = class("GlorybattleresultView", ViewComponent)

function GlorybattleresultView:ctor()
	GlorybattleresultView.super.ctor(self)
end

function GlorybattleresultView:unbindEvents()
	GlorybattleresultView.super.unbindEvents(self)
	self._btnRule:RemoveClickListener()
	self._btnStatics:RemoveClickListener()
	self._btnCutepetIcon:RemoveClickListener()
end

function GlorybattleresultView:bindEvents()
	GlorybattleresultView.super.bindEvents(self)
	self._btnRule:AddClickListener(self._onClickbtnRule, self)
	self._btnStatics:AddClickListener(self._onClickbtnStatics, self)
	self._btnCutepetIcon:AddClickListener(self._onClickcutepetIcon, self)
end

function GlorybattleresultView:buildUI()
	GlorybattleresultView.super.buildUI(self)

	self._cutepetconGo = self:getGo("cutepetcon")
	self._tableviewwinGo = self:getGo("tableviewwin")
	self._tableviewstarGo = self:getGo("tableviewstar")
	self._tablecellstarGo = self:getGo("tablecellstar")
	self._tableviewhpGo = self:getGo("tableviewhp")
	self._tablecellhpGo = self:getGo("tablecellhp")
	self._tablecellwinGo = self:getGo("tablecellwin")
	self._tablecellpetGo = self:getGo("tablecellpet")
	self._tableviewpetGo = self:getGo("tableviewpet")
	self._txtScoreTitle = self:getTxt("txtScoreTitle")
	self._txtScore = self:getTxt("txtScore")
	self._scrollerListHp = ScrollerList.create(self._tableviewhpGo, self._tablecellhpGo, GameUtil.handler(self._updateHpCell, self), GameUtil.handler(self._clearHpCell, self))
	self._scrollerListWin = ScrollerList.create(self._tableviewwinGo, self._tablecellwinGo, GameUtil.handler(self._updateWinCell, self), GameUtil.handler(self._clearWinCell, self))
	self._scrollerListStar = ScrollerList.create(self._tableviewstarGo, self._tablecellstarGo, GameUtil.handler(self._updateStarCell, self), GameUtil.handler(self._clearStarCell, self))
	self._scrollerListPet = ScrollerList.create(self._tableviewpetGo, self._tablecellpetGo, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._btnRule = self:getBtn("btnRule")
	self._btnStatics = self:getBtn("btnStatics")
	self._icon1Go = self:getGo("icon1")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnCutepetIcon = self:getBtn("cutepetIcon")
	self._cutepetIconGo = self:getGo("cutepetIcon")
end

function GlorybattleresultView:onExit()
	GlorybattleresultView.super.onExit(self)
	self._scrollerListHp:dispose()
	self._scrollerListWin:dispose()
	self._scrollerListStar:dispose()
	self._scrollerListPet:dispose()
	uGuiUtil.clearImage(self._cutepetIconGo)

	if self._resultType == GlorybattleController.ResultType.Total then
		GlorybattleModel.instance:resetDatas()
	end

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	self:_stopEffectHp()
	self:_stopEffectWin()
end

function GlorybattleresultView:onEnter()
	GlorybattleresultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._resultType = params[2]
	self._openData = params[3]

	self:_updateUI()
	self:_playEffect()
end

function GlorybattleresultView:_updateHpCell(view, cell, data, tag)
	GameUtil.SetGray(cell.gameObject, data.isGray)

	if self._hpEffectIdx == cell.data then
		self:_playEffectHp(cell.gameObject)
	end
end

function GlorybattleresultView:_playEffectHp(go)
	self:_stopEffectHp()

	local effName = "20251024/pvp/fx_ui_diaoxin_pvp.prefab"

	self._effectHandlerHp = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._effectHandlerHp:setParent(go.transform)
	self._effectHandlerHp:setScale(1)
	self._effectHandlerHp:setLocalPos(13, -9, 0)
end

function GlorybattleresultView:_stopEffectHp()
	if self._effectHandlerHp then
		UIEffectManager.instance:stopEffect(self._effectHandlerHp)

		self._effectHandlerHp = nil
	end
end

function GlorybattleresultView:_clearHpCell(cell)
	return
end

function GlorybattleresultView:_updateWinCell(view, cell, data, tag)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	goutil.setActive(goIcon, not data.isGray)

	if self._winEffectIdx == cell.data then
		self:_playEffectWin(cell.gameObject)
	end
end

function GlorybattleresultView:_playEffectWin(go)
	self:_stopEffectWin()

	local effName = "20251024/pvp/fx_ui_jiangbei_pvp.prefab"

	self._effectHandlerWin = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._effectHandlerWin:setParent(go.transform)
	self._effectHandlerWin:setScale(1)
	self._effectHandlerWin:setLocalPos(21.2, -18.3, 0)
end

function GlorybattleresultView:_stopEffectWin()
	if self._effectHandlerWin then
		UIEffectManager.instance:stopEffect(self._effectHandlerWin)

		self._effectHandlerWin = nil
	end
end

function GlorybattleresultView:_clearWinCell(cell)
	return
end

function GlorybattleresultView:_updateStarCell(view, cell, data, tag)
	GameUtil.SetGray(cell.gameObject, data.isGray)
end

function GlorybattleresultView:_clearStarCell(cell)
	return
end

function GlorybattleresultView:_updatePetCell(view, cell, creepsId, tag)
	local pet = goutil.findChild(cell.gameObject, "pet")
	local mask = goutil.findChild(cell.gameObject, "mask")
	local petMo = GlorybattleModel.instance:getPetMo(self._activityId, creepsId)
	local petTryCreepsIds = self._openData.petTryCreepsIds
	local isTryPet = false

	if petTryCreepsIds then
		isTryPet = table.indexof(petTryCreepsIds, creepsId)
	end

	MaterialMgr.setCellByMo(petMo, pet.gameObject)
	GameUtil.SetActive(mask, isTryPet)
end

function GlorybattleresultView:_clearPetCell(cell)
	local pet = goutil.findChild(cell.gameObject, "pet")

	MaterialMgr.resetAll(pet.gameObject)
end

function GlorybattleresultView:_updateUI()
	local winNum = 0
	local decBloodNum = 0
	local cutePetLv = 0
	local genreId = 0
	local currencyStr = ""
	local creepsIds

	self._txtTitle.text = self._resultType == GlorybattleController.ResultType.Report and "结果" or self._openData.isWin and "胜利" or "失败"

	local titleStr = self._resultType == GlorybattleController.ResultType.Single and "收  益" or "对决积分"

	goutil.setActive(self._icon1Go, self._resultType == GlorybattleController.ResultType.Single)
	goutil.setActive(self._btnStatics.gameObject, self._resultType == GlorybattleController.ResultType.Single or self._resultType == GlorybattleController.ResultType.Total)
	goutil.setActive(self._btnRule.gameObject, self._resultType == GlorybattleController.ResultType.Single)

	if self._resultType == GlorybattleController.ResultType.Report then
		winNum = self._openData.winNum
		cutePetLv = self._openData.cutePetLevel
		genreId = self._openData.genreId
		currencyStr = GlorybattleConfig.instance:getScore(self._openData.winNum)
		creepsIds = self._openData.creepsId
		decBloodNum = self._openData.decBloodNum
	elseif self._resultType == GlorybattleController.ResultType.Single then
		local info = GlorybattleModel.instance:getInfo(self._activityId)

		winNum = info.challengeInfo.curRound - info.challengeInfo.decBloodNum
		cutePetLv = info.challengeInfo.cutePetInfo.level
		genreId = info.challengeInfo.genreId

		local value = info.challengeInfo.currency - self._openData.lastCurrency

		currencyStr = value < 0 and string.format("%s%s", self._openData.lastCurrency, value) or string.format("%s<color=#29FF60FF>+%s</color>", self._openData.lastCurrency, value)
		creepsIds = self._openData.creepsIds
		genreId = info.challengeInfo.genreId
		decBloodNum = info.challengeInfo.decBloodNum
	elseif self._resultType == GlorybattleController.ResultType.Total then
		cutePetLv = self._openData.cutePetLv
		winNum = self._openData.winNum
		decBloodNum = self._openData.decBloodNum
		creepsIds = self._openData.creepsIds

		local value = GlorybattleConfig.instance:getScore(self._openData.winNum)

		currencyStr = value < 0 and string.format("%s%s", self._openData.lastTotalScore, value) or string.format("%s<color=#29FF60FF>+%s</color>", self._openData.lastTotalScore, value)
		genreId = self._openData.genreId
	elseif self._resultType == GlorybattleController.ResultType.GiveUp then
		cutePetLv = self._openData.cutePetLv
		winNum = self._openData.winNum
		decBloodNum = self._openData.decBloodNum
		creepsIds = self._openData.creepsIds

		local value = self._openData.currTotalScore - self._openData.lastTotalScore

		currencyStr = value < 0 and string.format("%s<color=red>-%s</color>", self._openData.lastTotalScore, math.abs(value)) or string.format("%s<color=#29FF60FF>+%s</color>", self._openData.lastTotalScore, value)
		genreId = self._openData.genreId
	end

	local genreCfg = GlorybattleConfig.instance:getGenreCfg(self._activityId, genreId)
	local cutePetLvCfgs = GlorybattleConfig.instance:getCutePetCfgs(genreCfg.cutePetId)
	local maxStar = #cutePetLvCfgs
	local totalRound = GlorybattleConfig.instance:getCommonValue("END_NEED_WIN_TIMES", true)
	local bloodNum = GlorybattleConfig.instance:getCommonValue("ORIGIN_BLOOD", true)
	local winList = {}
	local hpList = {}
	local starList = {}

	for i = 1, totalRound do
		table.insert(winList, {
			winIdx = i,
			isGray = winNum < i
		})
	end

	for i = 1, bloodNum do
		table.insert(hpList, {
			hpIdx = i,
			isGray = i > bloodNum - decBloodNum
		})
	end

	for i = 1, maxStar do
		table.insert(starList, {
			starIdx = i,
			isGray = cutePetLv < i
		})
	end

	if self._resultType == GlorybattleController.ResultType.Single or self._resultType == GlorybattleController.ResultType.Total then
		if not self._openData.isWin then
			self._hpEffectIdx = bloodNum - decBloodNum + 1
		else
			self._winEffectIdx = winNum
		end
	end

	self._cutePetLv = cutePetLv
	self._genreId = genreId

	self._scrollerListHp:reloadData(hpList)
	self._scrollerListWin:reloadData(winList)
	self._scrollerListStar:reloadData(starList)
	self._scrollerListPet:reloadData(creepsIds)

	self._txtScore.text = currencyStr
	self._txtScoreTitle.text = titleStr

	self:_setCutePetImg(genreCfg.cutePetId)
end

function GlorybattleresultView:_onClickbtnRule()
	if self._resultType == GlorybattleController.ResultType.Single then
		local info = GlorybattleModel.instance:getInfo(self._activityId)
		local curRound = info.challengeInfo.curRound
		local baseGain = GlorybattleConfig.instance:getRoundGainNum(curRound)
		local content = string.format("收益说明：\n基础胜利收益：%s\n上阵上一场未上阵过的精灵时额外：%s", baseGain, (info.challengeInfo.curRound <= 1 or nil) and 0)

		CommonTipsMgr.instance:showTextTips(content, self._btnRule.gameObject)
	end
end

function GlorybattleresultView:_onClickbtnStatics()
	ViewMgr.instance:open(ViewName.BattleStatics)
end

function GlorybattleresultView:_setCutePetImg(cutePetId)
	local raceId = GlorybattleConfig.instance:getCutePetRaceId(cutePetId)
	local cfg = CutePetConfig.instance:getCutePetById(raceId)
	local url = GameUrl.getCutepetImgUrl(cfg.cardName)

	uGuiUtil.setSpriteToImage(self._cutepetIconGo, uGuiUtil.SpriteType.BigBg, url)
end

function GlorybattleresultView:_onClickcutepetIcon()
	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local genreCfg = GlorybattleConfig.instance:getGenreCfg(self._activityId, self._genreId)

	UIStateManager.instance:push(ViewName.GlorycutepetsimpletipView, genreCfg.cutePetId, self._cutePetLv)
end

function GlorybattleresultView:_playEffect()
	local effName = "20251024/pvp/fx_ui_jiemian2_pvp.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

return GlorybattleresultView
