-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingChapter3View.lua

module("logic.extensions.liyangking.view.LiYangKingChapter3View", package.seeall)

local LiYangKingChapter3View = class("LiYangKingChapter3View", ViewComponent)
local prize_bg_height_list = {
	160,
	220,
	300
}

function LiYangKingChapter3View:ctor()
	LiYangKingChapter3View.super.ctor(self)
end

function LiYangKingChapter3View:unbindEvents()
	LiYangKingChapter3View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnHelpList)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._goldBar)

	for _, cell in ipairs(self._cellList) do
		GameUtil.rmClickHandler(cell.btnSureSelectStar)
		GameUtil.rmClickHandler(cell.btnEnter)
		GameUtil.rmClickHandler(cell.btnReset)
		GameUtil.rmClickHandler(cell.btnSeekHelp)
		GameUtil.rmClickHandler(cell.markSeekHelp)
	end
end

function LiYangKingChapter3View:bindEvents()
	LiYangKingChapter3View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnHelpList, self._onClickBtnHelpList, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickbtnTip, self)
	GameUtil.addClickHandler(self._goldBar, self._onClickBtnGoldBar, self)

	for i, cell in ipairs(self._cellList) do
		GameUtil.addClickHandler(cell.btnSureSelectStar, GameUtil.handler(self._onClickSure, self, i))
		GameUtil.addClickHandler(cell.btnEnter, GameUtil.handler(self._onClickEnter, self, i))
		GameUtil.addClickHandler(cell.btnReset, GameUtil.handler(self._onClickReset, self, i))
		GameUtil.addClickHandler(cell.btnSeekHelp, GameUtil.handler(self._onClickSeekHelp, self, i))
		GameUtil.addClickHandler(cell.markSeekHelp, GameUtil.handler(self._onClickSeekHelpAgain, self, i))
	end
end

function LiYangKingChapter3View:buildUI()
	LiYangKingChapter3View.super.buildUI(self)

	self._btnHelpList = self:getGo("btnHelpList")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._goldBar = self:getGo("goldBar")
	self._txtNumGoldBar = self:getTxt("goldBar/txtNum")
	self._itemGoldBar = self:getGo("goldBar/item")
	self._txtPowerTip = self:getTxt("goldBar/txtTip")
	self._cellList = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("con/cell_" .. i)
		cell.curSelectStar = 1
		cell.selectStar = goutil.findChild(cell.go, "selectStar")

		local selectStarCell = goutil.findChild(cell.selectStar, "tablecell")
		local selectStarTableview = goutil.findChild(cell.selectStar, "tableview")

		cell.tableviewDesc = ScrollerList.create(selectStarTableview, selectStarCell, function(view, cellGo, data)
			local select = goutil.findChild(cellGo.gameObject, "select")

			goutil.setActive(select, data.star == cell.curSelectStar)

			for k = 1, 5 do
				local star = goutil.findChild(cellGo.gameObject, "stars/" .. k)

				goutil.setActive(star, k <= data.showStrar)
			end

			local title = goutil.findChildTextComponent(cellGo.gameObject, "title")

			title.text = data.zdlRecommend

			GameUtil.addClickHandler(cellGo.gameObject, function()
				cell.curSelectStar = data.star

				local exploreCfg = self._exploreCfgs[i]

				cell.tableviewDesc:reloadData(LiYangKingConfig.instance:getChapter3ExploreStarShowCfgs(self._activityId, exploreCfg.typeId))
			end)
		end, function(cellGo)
			GameUtil.rmClickHandler(cellGo.gameObject)
		end)
		cell.btnSureSelectStar = goutil.findChild(cell.selectStar, "btnSure")
		cell.showInfo = goutil.findChild(cell.go, "showInfo")
		cell.roleCon = goutil.findChild(cell.showInfo, "role")
		cell.btnEnter = goutil.findChild(cell.showInfo, "btnEnter")
		cell.stars = {}

		for k = 1, 5 do
			cell.stars[k] = goutil.findChild(cell.showInfo, "info/stars/" .. k)
		end

		cell.titleShowInfo = goutil.findChildTextComponent(cell.showInfo, "info/title")
		cell.iconPrize_1 = goutil.findChild(cell.showInfo, "prize/reward/icon_1")
		cell.markGain_1 = goutil.findChild(cell.showInfo, "prize/reward/icon_1/markGain_1")
		cell.iconPrize_2 = goutil.findChild(cell.showInfo, "prize/reward/icon_2")
		cell.markGain_2 = goutil.findChild(cell.showInfo, "prize/reward/icon_2/markGain_2")
		cell.iconPrize_3 = goutil.findChild(cell.showInfo, "prize/reward/icon_3")
		cell.markGain_3 = goutil.findChild(cell.showInfo, "prize/reward/icon_3/markGain_3")
		cell.prizeBgGo = goutil.findChild(cell.showInfo, "prize/bg")
		cell.btnReset = goutil.findChild(cell.showInfo, "btnReset")
		cell.pass = goutil.findChild(cell.showInfo, "pass")
		cell.btnSeekHelp = goutil.findChild(cell.showInfo, "btnSeekHelp")
		cell.markSeekHelp = goutil.findChild(cell.showInfo, "markSeekHelp")
		cell.txtTitle = goutil.findChildTextComponent(cell.go, "title/txt")
		self._cellList[i] = cell
	end
end

function LiYangKingChapter3View:onExit()
	LiYangKingChapter3View.super.onExit(self)

	for _, cell in ipairs(self._cellList) do
		cell.tableviewDesc:dispose()
		MaterialMgr.resetAll(cell.iconPrize_1)
		MaterialMgr.resetAll(cell.iconPrize_2)
		MaterialMgr.resetAll(cell.iconPrize_3)

		if cell.role then
			cell.role = RoleObjectPool.instance:removeRole(cell.role)
			cell.role = nil
		end
	end

	MaterialMgr.clearIcon(self._itemGoldBar)
end

function LiYangKingChapter3View:onEnter()
	LiYangKingChapter3View.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangClgInfoRes, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangClgSelectStarRes, self._handleSelectStar, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangClgSeekHelpRes, self._handleSeekHelp, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangClgResetStarRes, self._handleResetStar, self)
	self:_updateUIByCfg()

	local curChangeSetId = LiYangKingModel.instance:popChangeSetId()

	if curChangeSetId then
		MaterialController.instance:showChangeSetInTemp(curChangeSetId)
	end

	LiYangKingController.instance:sendPM_PrinceLiyangClgInfoReq(self._activityId)
end

function LiYangKingChapter3View:_updateUIByCfg()
	self._actCfg = LiYangKingConfig.instance:getActCfg(self._activityId)
	self._exploreCfgs = LiYangKingConfig.instance:getChapter3ExploreCfgs(self._activityId)
	self._resetCfgs = LiYangKingConfig.instance:getChapter3ExploreResetCfgs(self._activityId)
	self._resetCost = self._resetCfgs[1].cost

	local matType, matId, matNum = MaterialMgr.getMatParams(self._resetCost)

	self._energyDefineCfg = EnergyConfig.instance:getEnergyCfg(matId)
	self._infoMap = {}

	for _, cfg in ipairs(self._exploreCfgs) do
		local posId = cfg.posId
		local cell = self._cellList[posId]

		cell.txtTitle.text = cfg.title
		self._infoMap[posId] = {}
	end

	local showItemStr = ""
	local resetCfg = self._resetCfgs[1]

	if resetCfg then
		local matType, cfgId, matNum = MaterialMgr.getMatParams(resetCfg.cost)

		if GameUtil.isEmptyString(showItemStr) then
			showItemStr = matType .. ":" .. cfgId
		end
	end

	local hasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local dailyLimit = self._energyDefineCfg.dailyLimit
	local miniute = math.floor(self._energyDefineCfg.recoveryEfficiency / 60)

	MaterialMgr.setIcon(self._itemGoldBar, matType, matId)

	self._txtNumGoldBar.text = string.format("%d/%d", hasMatNum, dailyLimit)
	self._txtPowerTip.text = string.format("每%d分钟回复%d能量", miniute, self._energyDefineCfg.unit)
end

function LiYangKingChapter3View:_updateList()
	for i, info in ipairs(self._infoMap) do
		local exploreCfg = self._exploreCfgs[i]
		local cell = self._cellList[i]

		if info.posInfo then
			goutil.setActive(cell.selectStar, false)
			goutil.setActive(cell.showInfo, true)

			local seekHelped = info.posInfo.seekHelped
			local finished = info.posInfo.finished
			local times = info.timeInfo.times
			local isCanReset = self._resetCfgs[times + 1]
			local cfgId = info.posInfo.id
			local exploreStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarCfg(self._activityId, cfgId)
			local showStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)
			local prizeStrArr = string.split(exploreStarCfg.prize, "#")
			local height = prize_bg_height_list[#prizeStrArr]

			MaterialMgr.resetAll(cell.iconPrize_1)
			MaterialMgr.resetAll(cell.iconPrize_2)
			MaterialMgr.resetAll(cell.iconPrize_3)
			MaterialMgr.setCellByCfg(prizeStrArr[1], cell.iconPrize_1)
			MaterialMgr.setCellByCfg(prizeStrArr[2], cell.iconPrize_2)
			MaterialMgr.setCellByCfg(prizeStrArr[3], cell.iconPrize_3)
			GameUtil.SetActive(cell.iconPrize_1, prizeStrArr[1] ~= nil)
			GameUtil.SetActive(cell.iconPrize_2, prizeStrArr[2] ~= nil)
			GameUtil.SetActive(cell.iconPrize_3, prizeStrArr[3] ~= nil)
			GameUtil.setHeight(cell.prizeBgGo, height)

			for k, star in ipairs(cell.stars) do
				goutil.setActive(star, k <= showStarCfg.showStrar)
			end

			cell.titleShowInfo.text = showStarCfg.zdlRecommend

			if cell.role then
				cell.role = RoleObjectPool.instance:removeRole(cell.role)
				cell.role = nil
			end

			cell.role = RoleObjectPool.instance:addRoleToParent(cell.role, exploreStarCfg.showSkinId, cell.roleCon, nil, nil, false, nil, nil)

			if finished then
				goutil.setActive(cell.pass, true)
				goutil.setActive(cell.markGain_1, prizeStrArr[1] ~= nil)
				goutil.setActive(cell.markGain_2, prizeStrArr[2] ~= nil)
				goutil.setActive(cell.markGain_3, prizeStrArr[3] ~= nil)
				goutil.setActive(cell.btnEnter, false)
				goutil.setActive(cell.btnReset, false)
				goutil.setActive(cell.btnSeekHelp, false)
				goutil.setActive(cell.markSeekHelp, false)
			else
				goutil.setActive(cell.pass, false)
				goutil.setActive(cell.markGain_1, false)
				goutil.setActive(cell.markGain_2, false)
				goutil.setActive(cell.markGain_3, false)
				goutil.setActive(cell.btnEnter, true)
				goutil.setActive(cell.btnReset, isCanReset)
				goutil.setActive(cell.btnSeekHelp, not seekHelped)
				goutil.setActive(cell.markSeekHelp, seekHelped)
			end
		else
			cell.curSelectStar = 1

			cell.tableviewDesc:reloadData(LiYangKingConfig.instance:getChapter3ExploreStarShowCfgs(self._activityId, exploreCfg.typeId))
			goutil.setActive(cell.selectStar, true)
			goutil.setActive(cell.showInfo, false)
		end
	end
end

function LiYangKingChapter3View:_handleGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	if not info.positions then
		for i, posInfo in ipairs(info.positions) do
			local saveInfo = self._infoMap[posInfo.positionId]

			saveInfo.posInfo = posInfo
		end

		for i, timeInfo in ipairs(info.resetTimes) do
			local saveInfo = self._infoMap[timeInfo.positionId]

			saveInfo.timeInfo = timeInfo
		end

		self:_updateList()
	end
end

function LiYangKingChapter3View:_handleSelectStar(msg)
	local info = GameUtil.pbToTable(msg)
	local posInfo = info.position
	local saveInfo = self._infoMap[posInfo.positionId]

	saveInfo.posInfo = posInfo

	self:_updateList()
end

function LiYangKingChapter3View:_handleResetStar(msg)
	local info = GameUtil.pbToTable(msg)
	local posInfo = info.position
	local saveInfo = self._infoMap[posInfo.positionId]

	saveInfo.posInfo = posInfo
	saveInfo.timeInfo.times = saveInfo.timeInfo.times + 1

	self:_updateList()

	local matType, matId, matNum = MaterialMgr.getMatParams(self._resetCost)
	local hasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local dailyLimit = self._energyDefineCfg.dailyLimit

	self._txtNumGoldBar.text = string.format("%d/%d", hasMatNum, dailyLimit)
end

function LiYangKingChapter3View:_handleSeekHelp(msg)
	local info = GameUtil.pbToTable(msg)
	local saveInfo = self._infoMap[info.position.positionId]

	if saveInfo then
		saveInfo.posInfo = info.position
	end

	self:_updateList()

	if saveInfo then
		local exploreCfg = self._exploreCfgs[saveInfo.posInfo.positionId]
		local exploreStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarCfg(self._activityId, saveInfo.posInfo.id)
		local showStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)
		local params = {
			activityId = self._activityId,
			otherUserId = checknumber(RoleModel.instance:getUserId()),
			positionId = saveInfo.posInfo.positionId,
			helpId = saveInfo.posInfo.helpId,
			star = showStarCfg.showStrar,
			typeId = exploreCfg.title,
			helpScore = exploreStarCfg.helpScore
		}

		UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.LiYangKing, params)
	end
end

function LiYangKingChapter3View:_onClickBtnHelpList()
	UIStateManager.instance:push(ViewName.LiYangKingHelpCenterView, self._activityId)
end

function LiYangKingChapter3View:_onClickSure(id)
	local cell = self._cellList[id]

	if cell then
		LiYangKingController.instance:sendPM_PrinceLiyangClgSelectStarReq(self._activityId, id, cell.curSelectStar)
	end
end

function LiYangKingChapter3View:_onClickEnter(id)
	local saveInfo = self._infoMap[id]

	if saveInfo then
		local cfgId = saveInfo.posInfo.id
		local exploreStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarCfg(self._activityId, cfgId)

		LiYangKingController.instance:openChapter3MissionView(self._activityId, exploreStarCfg.creepsMasterId, id)
	end
end

function LiYangKingChapter3View:_onClickReset(id)
	local saveInfo = self._infoMap[id]

	if saveInfo then
		UIStateManager.instance:push(ViewName.LiYangKingChapter3ResetView, self._activityId, saveInfo)
	end
end

function LiYangKingChapter3View:_onClickSeekHelp(id)
	LiYangKingController.instance:sendPM_PrinceLiyangClgSeekHelpReq(self._activityId, id)
end

function LiYangKingChapter3View:_onClickSeekHelpAgain(id)
	local saveInfo = self._infoMap[id]

	if saveInfo then
		local exploreCfg = self._exploreCfgs[saveInfo.posInfo.positionId]
		local exploreStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarCfg(self._activityId, saveInfo.posInfo.id)
		local showStarCfg = LiYangKingConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)
		local params = {
			activityId = self._activityId,
			otherUserId = checknumber(RoleModel.instance:getUserId()),
			positionId = saveInfo.posInfo.positionId,
			helpId = saveInfo.posInfo.helpId,
			star = showStarCfg.showStrar,
			typeId = exploreCfg.title,
			helpScore = exploreStarCfg.helpScore
		}

		UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.LiYangKing, params)
	end
end

function LiYangKingChapter3View:_onClickbtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function LiYangKingChapter3View:_onClickBtnGoldBar()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._resetCost)

	CommonTipsMgr.instance:openMaterialTips(self._goldBar1, matType, matId)
end

return LiYangKingChapter3View
