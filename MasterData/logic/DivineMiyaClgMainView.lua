-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/view/DivineMiyaClgMainView.lua

module("logic.extensions.divinemiyaclg.view.DivineMiyaClgMainView", package.seeall)

local DivineMiyaClgMainView = class("DivineMiyaClgMainView", ViewComponent)

function DivineMiyaClgMainView:ctor()
	DivineMiyaClgMainView.super.ctor(self)
end

function DivineMiyaClgMainView:unbindEvents()
	DivineMiyaClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnShowMore)
end

function DivineMiyaClgMainView:bindEvents()
	DivineMiyaClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnShowMore, self._onClickShowMore, self)
end

function DivineMiyaClgMainView:buildUI()
	DivineMiyaClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("topLeft/btnClose")
	self._btnRule = self:getGo("topLeft/btnRule")
	self._btnShop = self:getGo("shop/btnShop")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._petCon = self:getGo("con")
	self._txtName = self:getTxt("info/txtName")
	self._shopCon = self:getGo("shop/shopCon")
	self._btnSkill = self:getGo("info/btnSkill")
	self._btnInfo = self:getGo("info/btnInfo")
	self._btnStart = self:getGo("btnStart")
	self._btnShowMore = self:getGo("buff/btnShowMore")
	self._sliderProgress = self:getSlider("tableView/ViewPort/Content/progressSlider")
	self._txtPassNum = self:getTxt("txtPassNum")
	self._pointRare = self:getGo("info/pointRare")
	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._txtTime = self:getTxt("time/txtTime")
	self._buffIcon = self:getGo("buff/icon")
	self._txtBuffLevel = self:getTxt("buff/buffLevel/txtBuffLevel")
	self._btnGainBuff = self:getGo("buff/btnGain")
	self._txtCurBuff = self:getTxt("buff/buffDesc/levelUpBuff/txtBuff")
	self._txtNextBuff = self:getTxt("buff/buffDesc/levelUpBuff/txtNextBuff")
	self._imgBuffLevelArrow = self:getGo("buff/buffLevel/imgArrow")
	self._txtNextLevel = self:getTxt("buff/buffLevel/txtNextLevel")
	self._levelUpBuff = self:getGo("buff/buffDesc/levelUpBuff")
	self._txtSingleBuff = self:getTxt("buff/buffDesc/txtSingleBuff")
	self._txtGainBuff = self:getTxt("buff/btnGain/Text")
end

function DivineMiyaClgMainView:onExit()
	DivineMiyaClgMainView.super.onExit(self)

	if self._isSignInBuffRegistered then
		SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)

		self._isSignInBuffRegistered = false
	end

	RoleObjectPool.instance:removeRole(self._roleObj)
	MaterialMgr.resetAll(self._shopCon)
	MaterialMgr.resetAll(self._pointRare)

	for i, v in pairs(self._cellEffs) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._cellEffs = {}
end

function DivineMiyaClgMainView:onEnter()
	DivineMiyaClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineMiYaClgGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_DivineMiYaClgGainProgressPrizeRes, self._refreshPrize, self)

	self._activityId = self:getFirstParam() or DivineMiyaClgModel.instance:getCurrActId()
	self._activityCfg = DivineMiyaClgConfig.instance:getActivityCfg(self._activityId)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)

	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._pointRare)
	MaterialMgr.setCellByCfg(self._activityCfg.shopShowPirze, self._shopCon)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._cellEffs = {}

	local cfgs = SignInBuffConfig.instance:getBuffCfgsByActId(self._activityId)

	self._isSignInBuffRegistered = cfgs ~= nil

	if self._isSignInBuffRegistered then
		SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
			self:_refreshBuff(param)
		end)
	end

	DivineMiYaClgAgent.instance:sendPM_DivineMiYaClgGetInfoReq(self._activityId)
end

function DivineMiyaClgMainView:_refreshView()
	self:_refreshPrize()
end

function DivineMiyaClgMainView:_refreshPrize()
	local progressCfg = DivineMiyaClgConfig.instance:getProgressPrizeCfgs(self._activityId)

	self._tableList:reloadData(progressCfg)

	local curStageId = DivineMiyaClgModel.instance:getMaxStagePassed(self._activityId)
	local curDataBitId = 0

	for i, v in ipairs(progressCfg) do
		if curStageId < v.progress then
			break
		else
			curDataBitId = v.dataBitId
		end
	end

	self._sliderProgress:SetValue(curDataBitId / #progressCfg)

	self._txtPassNum.text = langPara("已通关第<color=#69FFECFF>%d</color>关", curStageId)
end

function DivineMiyaClgMainView:_refreshBuff(param)
	local buffLevel = param.buffLevel
	local nextLevel = buffLevel + 1
	local buffCfgs = SignInBuffConfig.instance:getBuffCfgsByActId(self._activityId) or {}
	local curBuffCfg = param.buffCfg
	local nextBuffCfg = buffCfgs[nextLevel]
	local isShowNextBuffInfo = nextBuffCfg ~= nil and param.isCanGain

	GameUtil.SetActive(self._imgBuffLevelArrow, isShowNextBuffInfo)
	GameUtil.SetActive(self._txtNextLevel, isShowNextBuffInfo)
	GameUtil.SetActive(self._levelUpBuff, isShowNextBuffInfo)
	GameUtil.SetActive(self._txtSingleBuff, not isShowNextBuffInfo)

	if param.isCanGain then
		self._txtGainBuff.text = lang("领 取")

		GameUtil.SetGray(self._btnGainBuff, false)
	elseif param.isCurLvMax then
		self._txtGainBuff.text = lang("已达上限")

		GameUtil.SetGray(self._btnGainBuff, true)
	else
		self._txtGainBuff.text = param.info and lang("明日再来") or lang("领 取")

		GameUtil.SetGray(self._btnGainBuff, true)
	end

	self._txtBuffLevel.text = langPara("战斗鼓舞%d级", buffLevel)

	if isShowNextBuffInfo then
		self._txtNextLevel.text = langPara("%d级", nextBuffCfg.buffLevel)
		self._txtCurBuff.text = curBuffCfg and curBuffCfg.des or lang("无加成")
		self._txtNextBuff.text = nextBuffCfg.des
	else
		self._txtSingleBuff.text = curBuffCfg and curBuffCfg.des or lang("无加成")
	end

	local iconCfg = curBuffCfg or nextBuffCfg
	local icon = iconCfg and iconCfg.icon

	if string.nilorempty(icon) then
		uGuiUtil.clearImage(self._buffIcon)
	else
		uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getIconUrl(icon))
	end
end

function DivineMiyaClgMainView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "item/itemcell")
	local receiveGo = goutil.findChild(go, "item/received")
	local txtStageId = goutil.findChildTextComponent(go, "txtNum")
	local isGain = DivineMiyaClgModel.instance:getIsGanStagePrize(self._activityId, data.dataBitId)
	local isCanGain = data.progress <= DivineMiyaClgModel.instance:getMaxStagePassed(self._activityId) and not isGain
	local proxy = MaterialMgr.setCellByCfg(data.prize, con)

	if proxy then
		proxy.binder:setAutoTips(not isCanGain)
		proxy.binder:setCallBack(GameUtil.handler(self._onClickProgressPrize, self, data.dataBitId))
	end

	GameUtil.SetActive(receiveGo, isGain)

	txtStageId.text = langPara("第%d关", data.progress)

	UIEffectManager.instance:stopEffect(self._cellEffs[go])

	if isCanGain == true then
		local effGo = con
		local path = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(target, eff)
			eff:setScrollRectClipping(self._tableView:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._cellEffs[go] = UIEffectManager.instance:playEffect(self, path, effGo, 0, 0, true, false, nil, func)
	end
end

function DivineMiyaClgMainView:_clearPrizeCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "item/itemcell")

	MaterialMgr.resetAll(con)
	UIEffectManager.instance:stopEffect(self._cellEffs[go])
end

function DivineMiyaClgMainView:_onClickStart()
	UIStateManager.instance:push(ViewName.DivineMiyaClgLevelView, self._activityId)
end

function DivineMiyaClgMainView:_onClickShowMore()
	UIStateManager.instance:push(ViewName.DivineMiyaClgDailyBuffView, self._activityId)
end

function DivineMiyaClgMainView:_onClickRule()
	TipsFacade.instance:openRulesView("divine_miya_clg_rule")
end

function DivineMiyaClgMainView:_onClickRank()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[2])
end

function DivineMiyaClgMainView:_onClickShop()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[1])
end

function DivineMiyaClgMainView:_onClickPrize()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[3])
end

function DivineMiyaClgMainView:_onClickProgressPrize(pirzeId)
	local isGain = DivineMiyaClgModel.instance:getIsGanStagePrize(self._activityId, pirzeId)
	local prizeCfg = DivineMiyaClgConfig.instance:getProgressPrizeCfg(self._activityId, pirzeId)
	local isCanGain = prizeCfg.progress <= DivineMiyaClgModel.instance:getMaxStagePassed(self._activityId) and not isGain

	if isCanGain == true then
		DivineMiYaClgAgent.instance:sendPM_DivineMiYaClgGainProgressPrizeReq(self._activityId, pirzeId)
	elseif isGain == true then
		FloatWordMgr.instance:show(lang("已领取"))
	else
		FloatWordMgr.instance:show(lang("未满足条件"))
	end
end

function DivineMiyaClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function DivineMiyaClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

return DivineMiyaClgMainView
