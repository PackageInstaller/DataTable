-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/view/HolyStripeCopyChallengeView.lua

module("logic.extensions.holystripecopy.view.HolyStripeCopyChallengeView", package.seeall)

local HolyStripeCopyChallengeView = class("HolyStripeCopyChallengeView", ViewComponent)

function HolyStripeCopyChallengeView:buildUI()
	HolyStripeCopyChallengeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goldBarCon = self:getGo("goldBarCon")
	self._goTable = self:getGo("level/tableview")
	self._goCell = self:getGo("level/cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTitle = self:getTxt("txtTitle")
	self._btnTip = self:getGo("btnTip")
	self._btnGetPlayTime = self:getGo("playTime/bg")
	self._txtPlayTimeNum = self:getTxt("playTime/txtNum")
	self._right = self:getGo("right")
	self._showRewardList = goutil.findChild(self._right, "showRewardList")
	self._itemCell = goutil.findChild(self._showRewardList, "cell")
	self._itemTable = goutil.findChild(self._showRewardList, "tableview")
	self._itemTableView = ScrollerList.create(self._itemTable, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	self._petcom = goutil.findChild(self._right, "petcom")
	self._formPetList = {}

	for i = 1, 3 do
		self._formPetList[i] = goutil.findChild(self._right, "formPetList/pet_" .. i .. "/node")
	end

	self._btnCheckForm = goutil.findChild(self._right, "btnCheckForm")
	self._goTeam = goutil.findChild(self._right, "team")
	self._iconCostTeam = goutil.findChild(self._goTeam, "cost/icon")
	self._txtCostTeam = goutil.findChildTextComponent(self._goTeam, "cost/txt")
	self._btnTeam = goutil.findChild(self._goTeam, "btn")
	self._txtTimesTeam = goutil.findChildTextComponent(self._goTeam, "txt")
	self._goSolo = goutil.findChild(self._right, "solo")
	self._txtCostSolo = goutil.findChildTextComponent(self._goSolo, "cost/txt")
	self._btnSolo = goutil.findChild(self._goSolo, "btn")
	self._btnSweep = goutil.findChild(self._goSolo, "btn_sweep")
	self._iconCostSolo = goutil.findChild(self._goSolo, "cost/icon")
	self._txtTimesSolo = goutil.findChildTextComponent(self._goSolo, "txt")
	self._firstPass = goutil.findChild(self._right, "firstPass")
	self._itemFirstPass = goutil.findChild(self._firstPass, "item")
end

function HolyStripeCopyChallengeView:bindEvents()
	HolyStripeCopyChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnCheckForm, self._onClickCheckForm, self)
	GameUtil.addClickHandler(self._btnTeam, self._onClickTeam, self)
	GameUtil.addClickHandler(self._btnSolo, self._onClickSolo, self)
	GameUtil.addClickHandler(self._btnSweep, self._onClickSweep, self)
	GameUtil.addClickHandler(self._btnGetPlayTime, self._onClickBtnPlayTime, self)
end

function HolyStripeCopyChallengeView:unbindEvents()
	HolyStripeCopyChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCheckForm)
	GameUtil.rmClickHandler(self._btnTeam)
	GameUtil.rmClickHandler(self._btnSolo)
	GameUtil.rmClickHandler(self._btnSweep)
	GameUtil.rmClickHandler(self._btnGetPlayTime)
end

function HolyStripeCopyChallengeView:onEnter()
	HolyStripeCopyChallengeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HolyStripeCopyInfoUpdate, self._refreshViewByInfo, self)
	HolyStripeExploreController.instance:showPopup()

	local list = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Tili
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)

	self._curShowData = nil

	self:_refreshViewByCfg()
	self:_refreshViewByInfo()
	MaterialMgr.setIcon(self._iconCostSolo, MatType.Strength, 1)
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeCopyInfoUpdate, self._refreshViewByInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyStripeCopyFormtionGet, self._onHandleGetFormation, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onDailyRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	HolyStripeCopyModel.instance:ShowCI()
end

function HolyStripeCopyChallengeView:onExit()
	HolyStripeCopyChallengeView.super.onExit(self)
	self._tableView:dispose()
	self._itemTableView:dispose()

	if self.loader then
		self.loader = RoleObjectPool.instance:removeRole(self.loader)
	end

	self._tabCfg = nil
	self._stageCfgs = nil

	for i = 1, 3 do
		MaterialMgr.resetAll(self._formPetList[i])
	end

	MaterialMgr.resetAll(self._itemFirstPass)
	MaterialMgr.resetAll(self._iconCostSolo)
	MaterialMgr.resetAll(self._iconCostTeam)
	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeCopyInfoUpdate, self._refreshViewByInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyStripeCopyFormtionGet, self._onHandleGetFormation, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._onDailyRefresh, self)
end

function HolyStripeCopyChallengeView:_onClickTip()
	local ruleKey = HolyStripeCopyConfig.instance:getCommonValue("RULE")

	UIStateManager.instance:open(ViewName.RulesView, ruleKey)
end

function HolyStripeCopyChallengeView:_onClickLevelTab(data)
	if data.stageId - 1 > self._curMaxLevel then
		FloatWordMgr.instance:show(lang("请先通关上一层的单人模式"))

		return
	end

	self:_switchData(data)
end

function HolyStripeCopyChallengeView:_onClickCheckForm()
	HolyStripeCopyController.instance:getLastForm(true, true)
end

function HolyStripeCopyChallengeView:_onClickTeam()
	FormTeamController.instance:enterFormTeamView(self._curShowData.groupId)
end

function HolyStripeCopyChallengeView:_onClickSolo()
	HolyStripeCopyController.instance:getLastForm(false)
end

function HolyStripeCopyChallengeView:_onClickSweep()
	MopupModel.instance:clickOpenHolyStripeCopySweep(self._tabCfg.tabId, self._curShowData.stageId)
end

function HolyStripeCopyChallengeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickLevelTab, self, data))

	cell.txt.text = langPara("第 %s 层", data.stageId)

	goutil.setActive(cell.markLock, data.stageId - 1 > self._curMaxLevel)

	if self._curShowData == data then
		cell.change:SetState(1)
	end
end

function HolyStripeCopyChallengeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell

	GameUtil.rmClickHandler(cell.go)

	cell.txt = goutil.findChildTextComponent(cell.go, "txt")
	cell.txt.text = ""
	cell.markLock = goutil.findChild(cell.go, "markLock")
	cell.change = cell.go:GetComponent("UIChangeGroup")

	cell.change:SetState(0)
	goutil.setActive(cell.markLock, false)

	return cell
end

function HolyStripeCopyChallengeView:_refreshViewByCfg()
	local tabId = checkint(self:getFirstParam())

	self._tabCfg = HolyStripeCopyConfig.instance:getTabCfgByTabId(tabId)
	self._stageCfgs = HolyStripeCopyConfig.instance:getStageCfgsByTabId(tabId)
end

function HolyStripeCopyChallengeView:_refreshViewByInfo()
	if self._tabCfg and self._stageCfgs then
		local isOpen = GameUtil.checkTimeStr(self._tabCfg.openTime)

		if isOpen then
			self._txtTitle.text = self._tabCfg.name
			self._curMaxLevel = HolyStripeCopyModel.instance:getMaxLevel(self._tabCfg.tabId)

			if not self._stageCfgs[self._curMaxLevel + 1] then
				local showData = self._stageCfgs[self._curMaxLevel]

				self:_switchData(showData)

				local playTime = HolyStripeCopyModel.instance:getLeftTeamTime()

				self._txtPlayTimeNum.text = playTime <= 0 and langPara("次数：<color=#ff0000ff>%s</color>/%s", playTime, HolyStripeCopyModel.instance:getLimitTeamTime()) or langPara("次数：%s/%s", playTime, HolyStripeCopyModel.instance:getLimitTeamTime())

				self._tableView:reloadData(self._stageCfgs)
				self._tableView:MoveCellToCenter(self._curMaxLevel)
			end
		else
			local text = "当前副本未开放"

			TipsFacade.instance:openTipWindowNoX("提示", text, function()
				UIStateManager.instance:popByName(self._viewPresentor.viewName)
			end)
		end
	else
		printError("灵纹副本传参或配置错误")
	end
end

function HolyStripeCopyChallengeView:_switchData(data)
	if self._curShowData ~= data then
		self._curShowData = data

		local showRewardList = string.split(data.singlePrize, "#")

		self._itemTableView:reloadData(showRewardList)

		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(data.showSkin)

		if skinCfg then
			if self.loader then
				self.loader = RoleObjectPool.instance:removeRole(self.loader)
			end

			if not data.skinScale then
				local petScale = 1

				if not data.skinPos then
					local petPos = {
						0,
						0
					}

					GameUtil.setAnchoredPos(self._petcom, checknumber(petPos[1]), checknumber(petPos[2]))

					self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinCfg.skinId, self._petcom, petScale)
				end
			end
		end

		self._creepCfgs = HolyStripeCopyConfig.instance:getCreepCfgsByPlanId(data.teamPlanId)

		for i = 1, 3 do
			MaterialMgr.resetAll(self._formPetList[i])

			local cfg = self._creepCfgs[i]

			if cfg then
				local petMatStr = langPara("%s:%s:%s:0", MatType.Pet, cfg.showPet, cfg.showPetLv)
				local proxy = MaterialMgr.setCellByCfg(petMatStr, self._formPetList[i])

				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					self:_onClickFormPet()
				end)
			end
		end

		self._txtCostSolo.text = data.singleStrengthCost

		if data.stageId - 1 == self._curMaxLevel then
			goutil.setActive(self._firstPass, true)
			goutil.setActive(self._btnSolo, true)
			goutil.setActive(self._btnSweep, false)
		else
			goutil.setActive(self._firstPass, false)
			goutil.setActive(self._btnSolo, false)
			goutil.setActive(self._btnSweep, true)
		end

		goutil.setActive(self._firstPass, data.stageId - 1 == self._curMaxLevel)
		goutil.setActive(self._firstPass, data.stageId - 1 == self._curMaxLevel)
		MaterialMgr.setCellByCfg(data.firstPassPrize, self._itemFirstPass)
		self._tableView:refresh()
		MaterialMgr.resetAll(self._iconCostTeam)

		local teamCfg = FormTeamConfig.instance:getTeamCfgByGroupId(self._curShowData.groupId)

		self._txtCostTeam.text = data.groupStrengthCost

		local teamcost = teamCfg and teamCfg.cost

		if not string.nilorempty(teamcost) then
			local costType, costId, costNum = MaterialMgr.getMatParams(teamcost)

			MaterialMgr.setIcon(self._iconCostTeam, costType, costId)
		end
	end
end

function HolyStripeCopyChallengeView:_updateItemCell(view, goCell, data)
	local cell = self:_clearItemCell(goCell)

	MaterialMgr.setCellByCfg(data, cell.node)
end

function HolyStripeCopyChallengeView:_clearItemCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.node = goutil.findChild(cell.go, "node")

	MaterialMgr.resetAll(cell.node)

	return cell
end

function HolyStripeCopyChallengeView:_onClickFormPet()
	UIStateManager.instance:push(ViewName.HolyStripeCopyCheckView, self._creepCfgs)
end

function HolyStripeCopyChallengeView:_onDailyRefresh()
	HolyStripeCopyController.instance:getInfo()
end

function HolyStripeCopyChallengeView:_onHandleGetFormation(isTeam, isPreSetForm)
	if isTeam then
		local mo = HolyStripeCopyModel.instance:getTeamCustomFmtMo()

		mo:initParams(nil, isPreSetForm)
		CustomFmtController.instance:showMissionFormationView(mo)
	else
		local mo = HolyStripeCopyModel.instance:getSoloCustomFmtMo()

		mo:initParams(self._tabCfg.tabId, self._curShowData.stageId)
		CustomFmtController.instance:showMissionView(mo)
	end
end

function HolyStripeCopyChallengeView:_onClickClose()
	UIStateManager.instance:push(ViewName.HolyStripeCopyView)
	self:close()
end

function HolyStripeCopyChallengeView:_onViewClose(view)
	if view.viewName == ViewName.MopupMainView then
		HolyStripeExploreController.instance:showPopup()
	end
end

function HolyStripeCopyChallengeView:_onClickBtnPlayTime()
	local ruleKey = HolyStripeCopyConfig.instance:getCommonValue("PLAY_TIME_RULE")

	UIStateManager.instance:open(ViewName.RulesView, ruleKey)
end

return HolyStripeCopyChallengeView
