-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeDecryptView.lua

module("logic.extensions.luyngarde.view.LuyngardeDecryptView", package.seeall)

local LuyngardeDecryptView = class("LuyngardeDecryptView", ViewComponent)

function LuyngardeDecryptView:ctor()
	LuyngardeDecryptView.super.ctor(self)
end

function LuyngardeDecryptView:unbindEvents()
	LuyngardeDecryptView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnHelpList)
	GameUtil.rmClickHandler(self._btnTip)

	for _, cell in ipairs(self._cellList) do
		GameUtil.rmClickHandler(cell.btnSureSelectStar)
		GameUtil.rmClickHandler(cell.btnEnter)
		GameUtil.rmClickHandler(cell.btnReset)
		GameUtil.rmClickHandler(cell.btnSeekHelp)
		GameUtil.rmClickHandler(cell.markSeekHelp)
	end
end

function LuyngardeDecryptView:bindEvents()
	LuyngardeDecryptView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnHelpList, self._onClickBtnHelpList, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickbtnTip, self)

	for i, cell in ipairs(self._cellList) do
		GameUtil.addClickHandler(cell.btnSureSelectStar, GameUtil.handler(self._onClickSure, self, i))
		GameUtil.addClickHandler(cell.btnEnter, GameUtil.handler(self._onClickEnter, self, i))
		GameUtil.addClickHandler(cell.btnReset, GameUtil.handler(self._onClickReset, self, i))
		GameUtil.addClickHandler(cell.btnSeekHelp, GameUtil.handler(self._onClickSeekHelp, self, i))
		GameUtil.addClickHandler(cell.markSeekHelp, GameUtil.handler(self._onClickSeekHelpAgain, self, i))
	end
end

function LuyngardeDecryptView:buildUI()
	LuyngardeDecryptView.super.buildUI(self)

	self._btnHelpList = self:getGo("btnHelpList")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._goldBarCon = self:getGo("goldBarCon")
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

				cell.tableviewDesc:reloadData(LuyngardeConfig.instance:getChapter3ExploreStarShowCfgs(self._activityId, exploreCfg.typeId))
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
		cell.iconPrize_1 = goutil.findChild(cell.showInfo, "prize/icon_1")
		cell.markGain_1 = goutil.findChild(cell.showInfo, "prize/markGain_1")
		cell.iconPrize_2 = goutil.findChild(cell.showInfo, "prize/icon_2")
		cell.markGain_2 = goutil.findChild(cell.showInfo, "prize/markGain_2")
		cell.btnReset = goutil.findChild(cell.showInfo, "btnReset")
		cell.pass = goutil.findChild(cell.showInfo, "pass")
		cell.btnSeekHelp = goutil.findChild(cell.showInfo, "btnSeekHelp")
		cell.markSeekHelp = goutil.findChild(cell.showInfo, "markSeekHelp")
		cell.txtTitle = goutil.findChildTextComponent(cell.go, "title/txt")
		self._cellList[i] = cell
	end
end

function LuyngardeDecryptView:onExit()
	LuyngardeDecryptView.super.onExit(self)

	for _, cell in ipairs(self._cellList) do
		cell.tableviewDesc:dispose()
		MaterialMgr.resetAll(cell.iconPrize_1)
		MaterialMgr.resetAll(cell.iconPrize_2)

		if cell.role then
			cell.role = RoleObjectPool.instance:removeRole(cell.role)
			cell.role = nil
		end
	end
end

function LuyngardeDecryptView:onEnter()
	LuyngardeDecryptView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.LuyngardeGetChapter3Info, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.LuyngardeChapter3SelectStar, self._handleSelectStar, self)
	self.addGEvent(self, GlobalNotify.LuyngardeChapter3SeekHelp, self._handleSeekHelp, self)
	self.addGEvent(self, GlobalNotify.LuyngardeChapter3ResetStar, self._handleResetStar, self)
	self:_updateUIByCfg()
	LuyngardeController.instance:getChapter3Info(self._activityId)
end

function LuyngardeDecryptView:_updateUIByCfg()
	self._actCfg = LuyngardeConfig.instance:getActCfg(self._activityId)
	self._exploreCfgs = LuyngardeConfig.instance:getChapter3ExploreCfgs(self._activityId)
	self._resetCfgs = LuyngardeConfig.instance:getChapter3ExploreResetCfgs(self._activityId)
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

	if not GameUtil.isEmptyString(showItemStr) then
		local objList = {
			{
				showAdd = true,
				id = showItemStr
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	end
end

function LuyngardeDecryptView:_updateList()
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
			local exploreStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarCfg(self._activityId, cfgId)
			local showStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)
			local prizeStrArr = string.split(exploreStarCfg.prize, "#")

			MaterialMgr.resetAll(cell.iconPrize_1)
			MaterialMgr.resetAll(cell.iconPrize_2)
			MaterialMgr.setCellByCfg(prizeStrArr[1], cell.iconPrize_1)
			MaterialMgr.setCellByCfg(prizeStrArr[2], cell.iconPrize_2)

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
				goutil.setActive(cell.markGain_1, true)
				goutil.setActive(cell.markGain_2, true)
				goutil.setActive(cell.btnEnter, false)
				goutil.setActive(cell.btnReset, false)
				goutil.setActive(cell.btnSeekHelp, false)
				goutil.setActive(cell.markSeekHelp, false)
			else
				goutil.setActive(cell.pass, false)
				goutil.setActive(cell.markGain_1, false)
				goutil.setActive(cell.markGain_2, false)
				goutil.setActive(cell.btnEnter, true)
				goutil.setActive(cell.btnReset, isCanReset)
				goutil.setActive(cell.btnSeekHelp, not seekHelped)
				goutil.setActive(cell.markSeekHelp, seekHelped)
			end
		else
			cell.curSelectStar = 1

			cell.tableviewDesc:reloadData(LuyngardeConfig.instance:getChapter3ExploreStarShowCfgs(self._activityId, exploreCfg.typeId))
			goutil.setActive(cell.selectStar, true)
			goutil.setActive(cell.showInfo, false)
		end
	end
end

function LuyngardeDecryptView:_handleGetInfo(msg)
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

function LuyngardeDecryptView:_handleSelectStar(msg)
	local info = GameUtil.pbToTable(msg)
	local posInfo = info.position
	local saveInfo = self._infoMap[posInfo.positionId]

	saveInfo.posInfo = posInfo

	self:_updateList()
end

function LuyngardeDecryptView:_handleResetStar(msg)
	local info = GameUtil.pbToTable(msg)
	local posInfo = info.position
	local saveInfo = self._infoMap[posInfo.positionId]

	saveInfo.posInfo = posInfo
	saveInfo.timeInfo.times = saveInfo.timeInfo.times + 1

	self:_updateList()
end

function LuyngardeDecryptView:_handleSeekHelp(msg)
	local info = GameUtil.pbToTable(msg)
	local saveInfo = self._infoMap[info.position.positionId]

	if saveInfo then
		saveInfo.posInfo = info.position
	end

	self:_updateList()

	if saveInfo then
		local exploreCfg = self._exploreCfgs[saveInfo.posInfo.positionId]
		local exploreStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarCfg(self._activityId, saveInfo.posInfo.id)
		local showStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)
		local params = {
			activityId = self._activityId,
			otherUserId = checknumber(RoleModel.instance:getUserId()),
			positionId = saveInfo.posInfo.positionId,
			helpId = saveInfo.posInfo.helpId,
			star = showStarCfg.showStrar,
			typeId = exploreCfg.title,
			helpScore = exploreStarCfg.helpScore
		}

		UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.Luyngarde, params)
	end
end

function LuyngardeDecryptView:_onClickBtnHelpList()
	UIStateManager.instance:push(ViewName.LuyngardeHelpCenterView, self._activityId)
end

function LuyngardeDecryptView:_onClickSure(id)
	local cell = self._cellList[id]

	if cell then
		LuyngardeController.instance:chapter3SelectStar(self._activityId, id, cell.curSelectStar)
	end
end

function LuyngardeDecryptView:_onClickEnter(id)
	local saveInfo = self._infoMap[id]

	if saveInfo then
		local cfgId = saveInfo.posInfo.id
		local exploreStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarCfg(self._activityId, cfgId)

		LuyngardeController.instance:openChapter3MissionView(self._activityId, exploreStarCfg.creepsMasterId, id)
	end
end

function LuyngardeDecryptView:_onClickReset(id)
	local saveInfo = self._infoMap[id]

	if saveInfo then
		UIStateManager.instance:push(ViewName.LuyngardeChapter3ResetView, self._activityId, saveInfo)
	end
end

function LuyngardeDecryptView:_onClickSeekHelp(id)
	LuyngardeController.instance:chapter3SeekHelp(self._activityId, id)
end

function LuyngardeDecryptView:_onClickSeekHelpAgain(id)
	local saveInfo = self._infoMap[id]

	if saveInfo then
		local exploreCfg = self._exploreCfgs[saveInfo.posInfo.positionId]
		local exploreStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarCfg(self._activityId, saveInfo.posInfo.id)
		local showStarCfg = LuyngardeConfig.instance:getChapter3ExploreStarShowCfgByStar(self._activityId, exploreStarCfg.typeId, exploreStarCfg.star)
		local params = {
			activityId = self._activityId,
			otherUserId = checknumber(RoleModel.instance:getUserId()),
			positionId = saveInfo.posInfo.positionId,
			helpId = saveInfo.posInfo.helpId,
			star = showStarCfg.showStrar,
			typeId = exploreCfg.title,
			helpScore = exploreStarCfg.helpScore
		}

		UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.Luyngarde, params)
	end
end

function LuyngardeDecryptView:_onClickbtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return LuyngardeDecryptView
