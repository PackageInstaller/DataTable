-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/view/GodXiuerRightWrongView.lua

module("logic.extensions.godxiuerchallenge.view.GodXiuerRightWrongView", package.seeall)

local GodXiuerRightWrongView = class("GodXiuerRightWrongView", ViewComponent)

function GodXiuerRightWrongView:ctor()
	GodXiuerRightWrongView.super.ctor(self)
end

function GodXiuerRightWrongView:buildUI()
	GodXiuerRightWrongView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRight = self:getBtn("challenge1/btnRight")
	self._btnWrong = self:getBtn("challenge2/btnWrong")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._passRight = self:getGo("challenge1/pass")
	self._passWrong = self:getGo("challenge2/pass")
	self._goCell = self:getGo("levelList/level/levelcell")
	self._goTableview = self:getGo("levelList/level/tableview")
	self._scrollList = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._rightHeadList = {}
	self._wrongHeadList = {}

	for i = 1, 9 do
		local item = {}

		item.go = self:getGo(string.format("challenge1/btnRight/cell_%d", i))
		item.con = self:getGo(string.format("challenge1/btnRight/cell_%d/con", i))

		table.insert(self._rightHeadList, item)
	end

	for i = 1, 9 do
		local item = {}

		item.go = self:getGo(string.format("challenge2/btnWrong/cell_%d", i))
		item.con = self:getGo(string.format("challenge2/btnWrong/cell_%d/con", i))

		table.insert(self._wrongHeadList, item)
	end

	self._wrongBg = self:getGo("challenge2/btnWrong/bg")
	self._wrongEmptyGo = self:getGo("challenge2/emptyGo")
	self._itemGo = self:getGo("levelList/getItem/item")
	self._scoreGo = self:getGo("levelList/getItem/score")
	self._txtScore = self:getTxt("levelList/getItem/score/txtScore")
	self._effectRect = self:getGo("levelList/level/tableview"):GetComponent(goutil.Type_RectTransform)
	self._propNumTxt = self:getTxt("propNumTxt")
	self._propIcon = self:getGo("propNumTxt/icon")
	self._propTxt = self:getTxt("propNumTxt/txt")
end

function GodXiuerRightWrongView:bindEvents()
	GodXiuerRightWrongView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnRight:AddClickListener(self._onClickRight, self)
	self._btnWrong:AddClickListener(self._onClickWrong, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function GodXiuerRightWrongView:unbindEvents()
	GodXiuerRightWrongView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnWrong:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function GodXiuerRightWrongView:onEnter()
	GodXiuerRightWrongView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GodHyurWholePeopleChallengeInfoRes, self._onChallengeInfoRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateData, self)

	self._challengeId = self:getFirstParam()
	self._day = GodXiuerChallengeModel.instance:getCurWholePeopleDay(self._challengeId)
	self._cfgs = GoodOrEvilChallengeConfig.instance:getChallengeTypeInfoByType(self._challengeId, 2, self._day)
	self._curId = self._cfgs[1].id
	self._uiEffectList = {}

	self:_initGetItem()
	self:_updateLevels()
	self:_updateBtns()
	self:_resetHeadList()
	self:_iconShow()

	if not GodXiuerChallengeController.instance:isFinishWholePeopleChallenge(self._challengeId) then
		GodHyurChallengeAgent.instance:sendPM_GodHyurWholePeopleChallengeInfoReq(self._challengeId)
	else
		self:_showFinishChallengeTip()
	end
end

function GodXiuerRightWrongView:onExit()
	GodXiuerRightWrongView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodHyurWholePeopleChallengeInfoRes, self._onChallengeInfoRes, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._updateData, self)
	self._scrollList:dispose()
	self:_clearHeadIcon()
	self:_clearGetItem()
	table.clear(self._uiEffectList)

	self._day = 1
end

function GodXiuerRightWrongView:_onClickClose()
	self:close()
end

function GodXiuerRightWrongView:_onClickRight()
	if GodXiuerChallengeModel.instance:isCurLevelCanChallenge(self._challengeId, self._curId, GodXiuerChallengeModel.StageRight) then
		local id = self._curId
		local stage = GodXiuerChallengeModel.StageRight
		local form

		GodXiuerChallengeController.instance:openTrueOrFalseChallengeForm(self._challengeId, id, stage, form)
	else
		FloatWordMgr.instance:show(lang("godxiuer_10"))
	end
end

function GodXiuerRightWrongView:_onClickWrong()
	if not GodXiuerChallengeModel.instance:isWholePeopleLevelPass(self._challengeId, self._curId) then
		if GodXiuerChallengeModel.instance:isCurLevelCanChallenge(self._challengeId, self._curId, GodXiuerChallengeModel.StageWrong) then
			local id = self._curId
			local stage = GodXiuerChallengeModel.StageWrong
			local form = GodXiuerChallengeModel.instance:getWholePeopleWrongForm(self._challengeId)

			GodXiuerChallengeController.instance:openTrueOrFalseChallengeForm(self._challengeId, id, stage, form)
		else
			FloatWordMgr.instance:show(lang("godxiuer_11"))
		end
	else
		FloatWordMgr.instance:show(lang("godxiuer_10"))
	end
end

function GodXiuerRightWrongView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "godxiuerrightwrongview")
end

function GodXiuerRightWrongView:_onChallengeInfoRes()
	self._curId = GodXiuerChallengeModel.instance:getCurWholePeopleId(self._challengeId) or self._curId
	self._day = GodXiuerChallengeModel.instance:getCurWholePeopleDay(self._challengeId)
	self._cfgs = GoodOrEvilChallengeConfig.instance:getChallengeTypeInfoByType(self._challengeId, 2, self._day)

	self:_updateGetItem()
	self:_updateLevels()
	self:_updateBtns()
	self:_updateFmtHeadIcon()
end

function GodXiuerRightWrongView:_updateCell(view, cell, data, tag)
	local select = goutil.findChild(cell, "select")
	local pass = goutil.findChild(cell, "pass")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local effect = goutil.findChild(cell, "effect")

	txtLevel.text = data.tag

	local isCurLevel = GodXiuerChallengeModel.instance:isCurWholePeopleLevel(self._challengeId, data.id)
	local isPass = GodXiuerChallengeModel.instance:isWholePeopleLevelPass(self._challengeId, data.id)

	goutil.setActive(pass, isPass)
	goutil.setActive(select, isCurLevel)
	self:_removeEffect(cell)

	if isCurLevel and not isPass then
		self:_loadEffect(cell, effect)
	end
end

function GodXiuerRightWrongView:_clearCell(cell)
	self:_removeEffect(cell)
end

function GodXiuerRightWrongView:_updateLevels()
	self._scrollList:reloadData(self._cfgs)
end

function GodXiuerRightWrongView:_updateBtns()
	local stage, pass = GodXiuerChallengeModel.instance:getWholePeopleStageAndPass(self._challengeId)
	local isRight = stage == 1 and not pass
	local isWrong = stage == 1 and pass
	local isLastWrongPass = stage == 2 and pass

	if isRight then
		goutil.setActive(self._passRight, false)
		goutil.setActive(self._passWrong, false)
		goutil.setActive(self._wrongBg, false)
		goutil.setActive(self._wrongEmptyGo, true)
	elseif isWrong then
		goutil.setActive(self._passRight, true)
		goutil.setActive(self._passWrong, false)
		goutil.setActive(self._wrongBg, true)
		goutil.setActive(self._wrongEmptyGo, false)
	elseif isLastWrongPass then
		goutil.setActive(self._passRight, true)
		goutil.setActive(self._passWrong, true)
		goutil.setActive(self._wrongBg, true)
		goutil.setActive(self._wrongEmptyGo, false)
	end
end

function GodXiuerRightWrongView:_getCfg(id)
	for i, v in ipairs(self._cfgs) do
		if id == v.id then
			return v
		end
	end
end

function GodXiuerRightWrongView:_showFinishChallengeTip()
	if GodXiuerChallengeController.instance:isFinishWholePeopleChallenge(self._challengeId) then
		local function onCloseViewCallback()
			UIStateManager.instance:popByName(ViewName.GodXiuerRightWrongView)
		end

		UIStateManager.instance:push(ViewName.DivineEvolveTipView, onCloseViewCallback)
	end
end

function GodXiuerRightWrongView:_updateFmtHeadIcon()
	local cfg = self:_getCfg(self._curId)

	if not cfg then
		return
	end

	self:_resetHeadList()

	local cfgFmtList = GoodOrEvilChallengeConfig.instance:getChallengerueCreeps(cfg.creepsMasterId)

	for i, cfgEnemy in ipairs(cfgFmtList) do
		local item = self._rightHeadList[cfgEnemy.posId]

		if item and item.go then
			goutil.setActive(item.go, true)
			GameUtil.setLocalScale(item.con, 0.8, 0.8, 0.8)

			local proxy = MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, item.con)
		end
	end

	local isWrongCanChallenge = GodXiuerChallengeModel.instance:isCurLevelCanChallenge(self._challengeId, self._curId, GodXiuerChallengeModel.StageWrong)
	local isLevelPass = GodXiuerChallengeModel.instance:isWholePeopleLevelPass(self._challengeId, self._curId)

	if isWrongCanChallenge or isLevelPass then
		local form = GodXiuerChallengeModel.instance:getWholePeopleWrongForm(self._challengeId)
		local petIdList = form.pos

		for i, petId in ipairs(petIdList) do
			local mo = BagModel.instance:getBagPetById(petId)

			if mo then
				local raceId = mo:getDefineId()
				local item = self._wrongHeadList[i]

				if item and item.go then
					goutil.setActive(item.go, true)
					GameUtil.setLocalScale(item.con, 0.8, 0.8, 0.8)
					MaterialMgr.setCell(MatType.Pet, raceId, item.con)
				end
			end
		end
	end
end

function GodXiuerRightWrongView:_clearHeadIcon()
	for i, v in ipairs(self._rightHeadList) do
		MaterialMgr.resetAll(v.con)
	end

	for i, v in ipairs(self._wrongHeadList) do
		MaterialMgr.resetAll(v.con)
	end
end

function GodXiuerRightWrongView:_resetHeadList()
	for i, v in ipairs(self._rightHeadList) do
		goutil.setActive(v.go, false)
	end

	for i, v in ipairs(self._wrongHeadList) do
		goutil.setActive(v.go, false)
	end
end

function GodXiuerRightWrongView:_initGetItem()
	goutil.setActive(self._scoreGo, false)
	goutil.setActive(self._itemGo, false)
end

function GodXiuerRightWrongView:_updateGetItem()
	self:_clearGetItem()

	local cfg = self:_getCfg(self._curId)

	if not GodXiuerChallengeModel.instance:isEvolveChallenge(self._challengeId) then
		goutil.setActive(self._scoreGo, false)
		goutil.setActive(self._itemGo, true)

		if cfg and not string.nilorempty(cfg.prize) then
			MaterialMgr.setCellByCfg(cfg.prize, self._itemGo)
		end
	else
		goutil.setActive(self._scoreGo, true)
		goutil.setActive(self._itemGo, false)

		if cfg then
			self._txtScore.text = string.format("x%d", cfg.score)
		end
	end
end

function GodXiuerRightWrongView:_clearGetItem()
	MaterialMgr.resetAll(self._itemGo)
end

function GodXiuerRightWrongView:_loadEffect(cell, parentGo)
	local function loadedFunc(target, eff)
		if not goutil.isNil(self._effectRect) then
			eff:setClipping(self._effectRect)
		end
	end

	local uiEffect = UIEffectManager.instance:playEffect(self, GodXiuerRightWrongViewPresentor.Effect1, parentGo.transform, 0, 0, true, false, nil, loadedFunc)

	uiEffect:setParent(parentGo.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	uiEffect.hideEffWhileNotOnTop = false
	self._uiEffectList[cell] = uiEffect
end

function GodXiuerRightWrongView:_removeEffect(cell)
	if self._uiEffectList[cell] then
		UIEffectManager.instance:stopEffect(self._uiEffectList[cell])

		self._uiEffectList[cell] = nil
	end
end

function GodXiuerRightWrongView:_updateData()
	if not GodXiuerChallengeController.instance:isFinishWholePeopleChallenge(self._challengeId) then
		GodHyurChallengeAgent.instance:sendPM_GodHyurWholePeopleChallengeInfoReq(self._challengeId)
	else
		self:_showFinishChallengeTip()
	end
end

function GodXiuerRightWrongView:_iconShow()
	local isEvolveChallenge = GodXiuerChallengeModel.instance:isEvolveChallenge(self._challengeId)
	local curScore = GodXiuerChallengeModel.instance:getScore(self._challengeId)
	local cfg = GoodOrEvilChallengeConfig.instance:getCfgById(self._challengeId)

	if not isEvolveChallenge then
		MaterialMgr.updateItemByStr(self._propIcon, cfg.limitPrize)

		self._propNumTxt.text = "x" .. checknumber(curScore)
	end

	goutil.setActive(self._propNumTxt.gameObject, not isEvolveChallenge)
end

return GodXiuerRightWrongView
