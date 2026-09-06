-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/MississiMainView.lua

module("logic.extensions.timelimitedchallenge.view.mississi.MississiMainView", package.seeall)

local MississiMainView = class("MississiMainView", ViewComponent)

function MississiMainView:buildUI()
	MississiMainView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("topLeft/btnClose")
	self._btnRule = self:getGo("topLeft/btnRule")
	self._btnSkill = self:getGo("info/btnSkill")
	self._btnInfo = self:getGo("info/btnInfo")
	self._posRare = self:getGo("info/pointRare")
	self._btnStart = self:getGo("btnStart")
	self._btnTry = self:getGo("btnTry")
	self._btnShop = self:getGo("shop/btnShop")
	self._btnGainBuff = self:getGo("buff/btnGain")
	self._txtDescBuff = self:getTxt("buff/txtDesc")
	self._txtLevelBuff = self:getTxt("buff/txtLevel")
	self._tipLvMax = self:getGo("buff/tipLvMax")
	self._itemShop = self:getGo("shop/item")
	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._tipTry = self:getGo("tipTry")
	self._pointItem = self:getGo("tipTry/pointItem")
	self._goTableView = self:getGo("tableView")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._progressSlider = self:getSlider("tableView/ViewPort/Content/progressSlider")
	self._txtPassNum = self:getTxt("txtPassNum")
	self._btnShowMore = self:getGo("buff/btnShowMore")
end

function MississiMainView:bindEvents()
	MississiMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self.onClickRule, self)
	GameUtil.addClickHandler(self._btnSkill, self.onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self.onClickInfo, self)
	GameUtil.addClickHandler(self._btnStart, self.onClickStart, self)
	GameUtil.addClickHandler(self._btnTry, self.onClickTry, self)
	GameUtil.addClickHandler(self._btnShop, self.onClickShop, self)
	GameUtil.addClickHandler(self._btnGainBuff, self.onClickGainBuff, self)
	GameUtil.addClickHandler(self._tipTry, self.onClickTry, self)
	GameUtil.addClickHandler(self._btnShowMore, self.onClickShowMore, self)
end

function MississiMainView:unbindEvents()
	MississiMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnGainBuff)
	GameUtil.rmClickHandler(self._tipTry)
	GameUtil.rmClickHandler(self._btnShowMore)
end

function MississiMainView:onEnter()
	MississiMainView.super.onEnter(self)

	local actId = self:_getActivityId()

	if checknumber(actId) > 0 then
		MississiModel.instance:setActId(checknumber(actId))

		self._actId = MississiModel.instance:getActId()

		self:refreshViewByCfg()
		MississiController.instance:getInfo()
	else
		local text = "活动未开始"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
	end

	GlobalDispatcher:addListener(GlobalNotify.MississiInfoUpdate, self.updateViewByInfo, self)
end

function MississiMainView:_getActivityId()
	return self:getFirstParam() or MississiModel.instance:getActIdByCfg()
end

function MississiMainView:onExit()
	MississiMainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	removetimer(self._onTick, self)
	MaterialMgr.resetAll(self._posRare)
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.MississiInfoUpdate, self.updateViewByInfo, self)
end

function MississiMainView:refreshViewByCfg()
	self._actCfg = MississiConfig.instance:getActCfg(self._actId)
	self._challengeId = self._actCfg.challengeId
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	if not self._challengeCfg then
		printError("密密西限时挑战为空" .. self._challengeId)

		return
	end

	self._skinId = checkint(self._challengeCfg.raceId)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._skinId, self._con, 1)

	settimer(1, self._onTick, self, true)
	self:_onTick()
	self:refreshCollegePart()
	MaterialMgr.setCell(MatType.Rare, self._skinId, self._posRare)
end

function MississiMainView:refreshCollegePart()
	local collegeId = PetCollegeConfig.instance:raceId2ChallengeId(checknumber(self._skinId))

	if checknumber(collegeId) > 0 then
		local stageCfgs = PetCollegeConfig.instance:getStageCfg(collegeId)
		local passedStageId = PetCollegeModel.instance:getCurrPassStageId(collegeId)
		local prizeDic = {}

		for k, v in ipairs(stageCfgs) do
			if passedStageId < k then
				local matType, matId, matNum = unpack(string.splitToNumber(v.firstPassPrize, ":"))
				local key = matType .. ":" .. matId

				prizeDic[key] = checknumber(prizeDic[key]) + matNum
			end
		end

		local matStr = ""

		for k, v in pairs(prizeDic) do
			matStr = k .. ":" .. v
		end

		MaterialMgr.setCellByCfg(matStr, self._pointItem)
		self._tipTry:SetActive(not string.nilorempty(matStr))
	end
end

function MississiMainView:onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, self._challengeCfg.ruleKey)
end

function MississiMainView:onClickSkill()
	if self._skinId ~= 0 then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, self._skinId)
		end
	end
end

function MississiMainView:onClickInfo()
	if self._skinId ~= 0 then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:openPetinfoView(raceId)
		end
	end
end

function MississiMainView:onClickStart()
	UIStateManager.instance:push(ViewName.MississiChallengeView)
end

function MississiMainView:onClickTry()
	if self._skinId ~= 0 then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

		if cfg then
			local raceId = cfg.raceId

			FuncOpenController.instance:openFunc(149, raceId)
		end
	end
end

function MississiMainView:onClickShop()
	if not string.nilorempty(self._actCfg.itemGoTo) then
		GotoMgr.gotoByString(self._actCfg.itemGoTo)
	end
end

function MississiMainView:onClickGainBuff()
	if self._isBuffMax then
		FloatWordMgr.instance:show(lang("当前战斗鼓舞已满级"))

		return
	end

	if self._isGotBuff then
		FloatWordMgr.instance:show(lang("您已获得今日的战斗鼓舞，请明天再来"))

		return
	end

	MississiController.instance:gainBuff()
end

function MississiMainView:_onTick()
	if self._challengeId == nil or not TLChallengeController.instance:isInOpenTime(self._challengeId) then
		if self._txtLeftTime then
			self._txtLeftTime.text = ""
		end

		local text = "活动已经结束"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
		removetimer(self._onTick, self)
	else
		local leftTimeFormat = TLChallengeController.instance:getLeftTimeFormat(self._challengeId)

		if self._txtLeftTime then
			self._txtLeftTime.text = string.format("距离活动结束：%s", leftTimeFormat)
		end
	end
end

function MississiMainView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.txtNum.text = langPara("第<color=#69FFECFF>%s</color>关", data.stageId)

	MaterialMgr.setCellByCfg(data.prize, cell.item)
	goutil.setActive(cell.mark, data.stageId <= self._curPassStage)
end

function MississiMainView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(cell.go, "item/itemcell")
	cell.mark = goutil.findChild(cell.go, "item/received")
	cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
	cell.txtNum.text = ""

	MaterialMgr.resetAll(cell.item)

	return cell
end

function MississiMainView:updateViewByInfo()
	self:updatePrizePart()

	self._buffLevel, self._isBuffMax = MississiModel.instance:getShowBuffLevel(self._actId)

	goutil.setActive(self._tipLvMax, self._isBuffMax)
	goutil.setActive(self._btnGainBuff, not self._isBuffMax)

	local buffCfg = MississiConfig.instance:getBuffCfgByLevel(self._actId, self._buffLevel)

	if buffCfg then
		self._txtDescBuff.text = buffCfg.desc or ""
	end

	self._isGotBuff = MississiModel.instance:getIsGotBuff(self._actId)
	self._txtLevelBuff.text = langPara("战斗鼓舞%s级", self._buffLevel)

	GameUtil.SetGray(self._btnGainBuff, self._isGotBuff)
end

function MississiMainView:updatePrizePart()
	self._curPassStage = MississiModel.instance:getCurPassStage(self._actId)

	local cfgs = MississiConfig.instance:getStageCfgs(self._actId)

	self._tableView:reloadData(cfgs)
	self._progressSlider:SetValue(checknumber(self._curPassStage) / #cfgs)

	self._txtPassNum.text = self._curPassStage > 0 and langPara("已通关第<color=#69FFECFF>%s</color>关", self._curPassStage) or ""
end

function MississiMainView:onClickShowMore()
	UIStateManager.instance:push(ViewName.MississiBuffView)
end

return MississiMainView
