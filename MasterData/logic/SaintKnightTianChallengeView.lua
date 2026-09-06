-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/SaintKnightTianChallengeView.lua

module("logic.extensions.saintknighttian.view.SaintKnightTianChallengeView", package.seeall)

local SaintKnightTianChallengeView = class("SaintKnightTianChallengeView", ViewComponent)

function SaintKnightTianChallengeView:buildUI()
	SaintKnightTianChallengeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._buffPetPart = self:buildBuffUI("buffPet")
	self._buffNewAera = self:buildBuffUI("buffNewAera")

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtProgress = goutil.findChildTextComponent(playerRoot, "txtProgress")
	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("tablecell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SaintKnightTianChallengeView:buildBuffUI(uiName)
	local cell = {}

	cell.go = self:getGo(uiName)
	cell.btn = goutil.findChild(cell.go, "btn")
	cell.slider = self:getSlider(uiName .. "/slider")
	cell.txtTip = goutil.findChildTextComponent(cell.go, "txtTip")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")

	return cell
end

function SaintKnightTianChallengeView:bindEvents()
	SaintKnightTianChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._buffPetPart.btn, self._onClickBuffPet, self)
	GameUtil.addClickHandler(self._buffNewAera.btn, self._onClickBuffNewArea, self)
end

function SaintKnightTianChallengeView:unbindEvents()
	SaintKnightTianChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._buffPetPart.btn)
	GameUtil.rmClickHandler(self._buffNewAera.btn)
end

function SaintKnightTianChallengeView:onEnter()
	SaintKnightTianChallengeView.super.onEnter(self)
	self:setViewByCfg()
	SaintKnightTianController.instance:getInfo(self._challengeId)
	GlobalDispatcher:addListener(GlobalNotify.SKTianUpdateInfo, self.refreshViewByInfo, self)

	local userDataKey = ViewName.SaintKnightTianChallengeView .. self._challengeId
	local userData = GameUtil.getUserData(userDataKey)
	local copyId = 4290013

	if checkint(userData) <= 0 then
		GameUtil.saveUserData(userDataKey, 1)
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, copyId, StoryModel.StoryType.SCCopy)
	end

	SaintKnightTianModel.instance:setDailyOpen(ViewName.SaintKnightTianChallengeView)
end

function SaintKnightTianChallengeView:onExit()
	SaintKnightTianChallengeView.super.onExit(self)
	self._playerSliderMo:onExit()
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SKTianUpdateInfo, self.refreshViewByInfo, self)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	removetimer(self.refreshPrize, self)
end

function SaintKnightTianChallengeView:setViewByCfg()
	self._challengeId = SaintKnightTianModel.instance:getCurChallengeId()
	self._actCfg = SaintKnightTianConfig.instance:getActCfg(self._challengeId)
	self._areaBuffCfg = SaintKnightTianConfig.instance:getAreaBuffCfg(self._actCfg.buffPlanId)
	self._teamBuffCfgs = SaintKnightTianConfig.instance:getTeamBuffCfgs(self._actCfg.buffPlanId)
	self._prizeCfgs = SaintKnightTianConfig.instance:getPrizeCfgs(self._actCfg.prizePlanId)
	self._stageCfgs = SaintKnightTianConfig.instance:getStageCfgs(self._actCfg.challengePlanId)

	self:_initPlayerParams()
end

function SaintKnightTianChallengeView:refreshViewByInfo()
	self:refreshAreaBuff()
	self:refreshTeamBuff()
	self:refreshStageList()
	settimer(0.3, self.refreshPrize, self, false)
end

function SaintKnightTianChallengeView:refreshAreaBuff()
	local isWithBuff = SaintKnightTianModel.instance:getIsWithAreaBuff()

	if isWithBuff then
		local dayLeft = self._areaBuffCfg.days - GameUtil.getOpenAreaDaysForFive()

		self._buffNewAera.txtTip.text = langPara("剩余%s天", dayLeft)
		self._buffNewAera.txtDesc.text = self._areaBuffCfg.des

		self._buffNewAera.slider:SetValue(checknumber(dayLeft / self._areaBuffCfg.days))
	end

	goutil.setActive(self._buffNewAera.go, isWithBuff)
end

function SaintKnightTianChallengeView:refreshTeamBuff()
	local curCollectNum = SaintKnightTianModel.instance:getCurCollectNum()

	if self._teamBuffCfgs then
		self._buffPetPart.txtDesc.text = self._teamBuffCfgs and self._teamBuffCfgs.des or ""
		self._buffPetPart.txtTip.text = langPara("集齐%s只", curCollectNum)

		self._buffPetPart.slider:SetValue(checknumber(curCollectNum / checkint(table.nums(self._actCfg.teamCollectPetId))))
	end
end

function SaintKnightTianChallengeView:_initPlayerParams()
	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = self._prizeCfgs

	function playerParam.getPlayerProgress()
		return SaintKnightTianModel.instance:getCurPassStage()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.ID
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return SaintKnightTianModel.instance:getCurPassStage() >= rewardCfg.ID and not SaintKnightTianModel.instance:isPlayerRewardGeted(rewardCfg.ID)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return SaintKnightTianModel.instance:isPlayerRewardGeted(rewardCfg.ID)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		SaintKnightTianController.instance:getPrize(self._challengeId, rewardCfg.ID)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function SaintKnightTianChallengeView:refreshPrize()
	self._playerSliderMo:updatePlayerReward()

	self._txtProgress.text = langPara("%s/%s", SaintKnightTianModel.instance:getCurPassStage(), table.nums(self._prizeCfgs))

	self:_showEffect()
end

function SaintKnightTianChallengeView:refreshStageList()
	self._curPassStage = SaintKnightTianModel.instance:getCurPassStage()

	self._tableView:reloadData(self._stageCfgs)

	if self._curPassStage == #self._stageCfgs then
		self._tableView:MoveCellToCenter(self._curPassStage - 1)
	else
		self._tableView:MoveCellToCenter(self._curPassStage)
	end
end

function SaintKnightTianChallengeView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "saintknighttian2_rule")
end

function SaintKnightTianChallengeView:_onClickBuffPet()
	local tip = lang("saintknighttianteambufftip")

	TipsFacade.instance:openTipWindowNoX(lang("提示"), tip)
end

function SaintKnightTianChallengeView:_onClickBuffNewArea()
	local tip = lang("saintknighttianareabufftip")

	TipsFacade.instance:openTipWindowNoX(lang("提示"), tip)
end

function SaintKnightTianChallengeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.btn = goutil.findChild(cell.go, "root")
	cell.line = goutil.findChild(cell.btn, "line")
	cell.pass = goutil.findChild(cell.btn, "pass")
	cell.icon = goutil.findChild(cell.btn, "icon")
	cell.lock = goutil.findChild(cell.btn, "lock")
	cell.txtZdl = goutil.findChild(cell.btn, "zdl/imgRecZdl"):GetComponent(typeof(UIImgNumeralText))
	cell.txtName = goutil.findChildTextComponent(cell.btn, "txtName")

	goutil.setActive(cell.lock, true)
	goutil.setActive(cell.pass, false)
	GameUtil.setAnchoredPos(cell.btn, 0, 0)

	cell.txtName.text = ""

	GameUtil.rmClickHandler(cell.btn)
	MaterialMgr.resetAll(cell.icon)

	return cell
end

function SaintKnightTianChallengeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	MaterialMgr.setIcon(cell.icon, MatType.Pet, data.facePetId)

	if not data.pos then
		GameUtil.setAnchoredPos(cell.btn, data.pos[1], data.pos[2])

		cell.txtName.text = data.name

		cell.txtZdl:SetNum(data.fightingCapacity)
		goutil.setActive(cell.lock, data.stageId > self._curPassStage + 1)
		goutil.setActive(cell.pass, data.stageId <= self._curPassStage)
		GameUtil.setLocalRotation(cell.line, 0, 0, data.lineRotZ)
		GameUtil.setWidth(cell.line, data.lineWidth)
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickStage, self, data))
	end
end

function SaintKnightTianChallengeView:_onClickStage(data)
	if data.stageId > self._curPassStage + 1 then
		FloatWordMgr.instance:show(lang("请通关前面关卡"))
	elseif data.stageId == self._curPassStage + 1 then
		local mo = SaintKnightTianModel.instance:getCurFmtMo()

		mo:initParams(data)
		CustomFmtController.instance:showMissionView(mo)
	else
		FloatWordMgr.instance:show(lang("已通关"))
	end
end

function SaintKnightTianChallengeView:_showEffect()
	if self._mainEff then
		return
	end

	self._mainEff = UIEffectManager.instance:playEffect(self, "20220729/shengqixiaotian/fx_ui_shengqixiaotian_yx.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

return SaintKnightTianChallengeView
