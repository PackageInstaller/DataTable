-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroStageView.lua

module("logic.extensions.miraclehero.view.MiracleHeroStageView", package.seeall)

local MiracleHeroStageView = class("MiracleHeroStageView", ViewComponent)

function MiracleHeroStageView:ctor()
	MiracleHeroStageView.super.ctor(self)
end

function MiracleHeroStageView:unbindEvents()
	MiracleHeroStageView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MiracleHeroStageView:bindEvents()
	MiracleHeroStageView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function MiracleHeroStageView:buildUI()
	MiracleHeroStageView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")

	local cellGo = self:getGo("tablecell")
	local tableviewGo = self:getGo("tableview")

	self._tableView = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._roleCon = self:getGo("roleCon")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
end

function MiracleHeroStageView:onExit()
	MiracleHeroStageView.super.onExit(self)

	if self.loader then
		self.loader = RoleObjectPool.instance:removeRole(self.loader)
	end

	self._tableView:dispose()

	self._lastUpdateId = nil
end

function MiracleHeroStageView:onEnter()
	MiracleHeroStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._challengeCfg = params[1]

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function MiracleHeroStageView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	if data then
		local isTimeMatch = self._timeNow >= GameUtil.string2time(data.openDateTime)
		local openDate = GameUtil.string2date(data.openDateTime)
		local isPass = self._curStage >= data.stageId
		local isCurStage = self._curStage + 1 == data.stageId

		goutil.setActive(cell.pass, isPass)

		if isTimeMatch then
			goutil.setActive(cell.txtTimeTips.gameObject, not isPass and not isCurStage)

			cell.txtTimeTips.text = lang("通关上一层解锁")
		else
			goutil.setActive(cell.txtTimeTips.gameObject, not isPass)

			cell.txtTimeTips.text = string.format("%d.%02d %02d:00后开启", openDate.month, openDate.day, openDate.hour)
		end

		cell.txtStage.text = string.format("第<size=62>%s</size>关", data.stageId)

		local arr = MaterialMgr.changeItemStrArr(data.prize)

		for i, itemCell in ipairs(cell.itemCellList) do
			local cfgStr = arr[i]
			local isEmpty = GameUtil.isEmptyString(cfgStr)

			if isEmpty then
				goutil.setActive(itemCell.go, false)
			else
				goutil.setActive(itemCell.go, true)

				local proxy = MaterialMgr.setCellByCfg(cfgStr, itemCell.icon)

				if proxy then
					proxy.binder:setEffStatus(false)
				end

				goutil.setActive(itemCell.gain, isPass)
			end
		end

		GameUtil.addClickHandler(cell.btnChallenge, GameUtil.handler(self._onClickChallenge, self, data))

		if self._lastUpdateId then
			if self._lastUpdateId > data.stageId then
				cell.go.transform:SetAsLastSibling()
			elseif self._lastUpdateId < data.stageId then
				cell.go.transform:SetAsFirstSibling()
			end
		else
			cell.go.transform:SetAsLastSibling()
		end

		self._lastUpdateId = data.stageId

		local isMoveLeft = data.stageId % 2 == 1
		local isLastId = data.stageId == #self._stageCfgs

		GameUtil.setAnchoredPos(cell.con, isMoveLeft and 65 or 0, 0)
		goutil.setActive(cell.planeLeft, isMoveLeft and not isLastId)
		goutil.setActive(cell.planeRight, not isMoveLeft and not isLastId)
		goutil.setActive(cell.bg, not isCurStage)
		goutil.setActive(cell.bgSelect, isCurStage)
		cell.txtTimeTipsChange:SetState(isCurStage and 1 or 0)
		cell.txtStageChange:SetState(isCurStage and 1 or 0)
	end
end

function MiracleHeroStageView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.con = goutil.findChild(cell.go, "con")
	cell.bg = goutil.findChild(cell.con, "bg")
	cell.bgSelect = goutil.findChild(cell.con, "bg_select")
	cell.planeLeft = goutil.findChild(cell.con, "plane_left")
	cell.planeRight = goutil.findChild(cell.con, "plane_right")
	cell.itemCellList = {}

	for i = 1, 3 do
		local itemCell = {}

		itemCell.go = goutil.findChild(cell.con, "sc/Viewport/Content/cell_" .. i)
		itemCell.icon = goutil.findChild(itemCell.go, "icon")
		itemCell.gain = goutil.findChild(itemCell.go, "gain")

		MaterialMgr.resetAll(itemCell.icon)
		goutil.setActive(itemCell.go, false)

		cell.itemCellList[i] = itemCell
	end

	cell.pass = goutil.findChild(cell.con, "pass")
	cell.txtStage = goutil.findChildTextComponent(cell.con, "txtStage")
	cell.txtTimeTips = goutil.findChildTextComponent(cell.con, "txtTimeTips")
	cell.btnChallenge = goutil.findChild(cell.con, "btnChallenge")

	GameUtil.rmClickHandler(cell.btnChallenge)

	cell.txtStageChange = goutil.findChildComponent(cell.con, "txtStage", "UITextColorChange")
	cell.txtTimeTipsChange = goutil.findChildComponent(cell.con, "txtTimeTips", "UITextColorChange")

	return cell
end

function MiracleHeroStageView:_updateUIByCfg()
	self._activityId = checknumber(self._challengeCfg.activityId)
	self._challengeId = self._challengeCfg.challengeId
	self._stageCfgs = MiracleHeroConfig.instance:getStageCfgs(self._activityId, self._challengeId)

	local curFaceId = checknumber(self._challengeCfg.faceId)

	if curFaceId > 0 then
		if not self._challengeCfg.lihuiPos then
			if not self._challengeCfg.lihuiScale then
				local lihuiScale = 1

				self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._roleCon, lihuiScale, nil, true, self._challengeCfg.lihuiPos[1], self._challengeCfg.lihuiPos[2])
			end
		end
	end

	self._txtTitle.text = self._challengeCfg.challengeName
end

function MiracleHeroStageView:_updateUIByInfo()
	self._curStage = MiracleHeroModel.instance:getCurChallengeStageId(self._activityId, self._challengeId)
	self._timeNow = ServerTime.now()

	self._tableView:reloadData(self._stageCfgs)
	self._tableView:MoveCellToCenter(self._curStage)
end

function MiracleHeroStageView:_onClickChallenge(data)
	if data then
		local isPass = self._curStage >= data.stageId

		if isPass then
			TipsFacade.instance:openCommonTips(lang("已通关"))

			return
		end

		local isTimeMatch = self._timeNow >= GameUtil.string2time(data.openDateTime)

		if not isTimeMatch then
			TipsFacade.instance:openCommonTips(lang("暂未开启哦~"))

			return
		end

		local isCurStage = self._curStage + 1 == data.stageId

		if not isCurStage then
			TipsFacade.instance:openCommonTips(lang("通关上一层解锁"))

			return
		end

		self:_jumpToFormationView(data)
	end
end

function MiracleHeroStageView:_jumpToFormationView(...)
	UIStateManager.instance:push(ViewName.MiracleHeroFormationView, ...)
end

return MiracleHeroStageView
