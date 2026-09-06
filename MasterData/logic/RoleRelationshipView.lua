-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/view/RoleRelationshipView.lua

module("logic.extensions.rolerelationship.view.RoleRelationshipView", package.seeall)

local RoleRelationshipView = class("RoleRelationshipView", ViewComponent)

function RoleRelationshipView:ctor()
	RoleRelationshipView.super.ctor(self)
end

function RoleRelationshipView:buildUI()
	RoleRelationshipView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._txtTipsCon = goutil.findChildTextComponent(self.mainGO, "tipsCon/txt")
	self._bg = goutil.findChild(self.mainGO, "bg")
	self._btnJumpOne = goutil.findChild(self.mainGO, "jumpCol/btnJumpOne")
	self._btnJumpTwo = goutil.findChild(self.mainGO, "jumpCol/btnJumpTwo")
	self._roleScrollerview = goutil.findChild(self.mainGO, "scrollerview")
	self._roleCol = goutil.findChild(self.mainGO, "scrollerview/Viewport/Content/roleCol")
	self._roleCell = goutil.findChild(self.mainGO, "scrollerview/Viewport/Content/roleCol/roleCell")
	self._roleList = {}

	GameUtil.SetActive(self._roleCell, false)

	local lineCol = goutil.findChild(self.mainGO, "scrollerview/Viewport/Content/lineCol")
	local lineGo = goutil.findChild(self.mainGO, "scrollerview/Viewport/Content/lineCol/lineGo")

	self._lineList = LineList.create(lineCol, lineGo)

	local dotLineCol = goutil.findChild(self.mainGO, "scrollerview/Viewport/Content/dotLineCol")
	local dotLineGo = goutil.findChild(self.mainGO, "scrollerview/Viewport/Content/dotLineCol/dotLineGo")

	self._dotLineList = LineList.create(dotLineCol, dotLineGo)
	self._boxCol = goutil.findChild(self.mainGO, "scrollerview/Viewport/Content/boxCol")
	self._boxCell = goutil.findChild(self.mainGO, "scrollerview/Viewport/Content/boxCol/boxCell")
	self._boxList = {}

	GameUtil.SetActive(self._boxCell, false)

	self._bubble = goutil.findChild(self.mainGO, "scoreprogressview/bubble")
	self._btnbubTip = goutil.findChild(self.mainGO, "scoreprogressview/total/btnTip")
	self._closeBub = goutil.findChild(self.mainGO, "scoreprogressview/bubble/btnClose")
	self._txtBub = goutil.findChildTextComponent(self.mainGO, "scoreprogressview/bubble/txtDesc")
	self._progressNum = goutil.findChildTextComponent(self.mainGO, "scoreprogressview/total/txtNum")
	self._proScrollerGo = goutil.findChild(self.mainGO, "scoreprogressview/scrollerview")

	local cellGo = goutil.findChild(self.mainGO, "scoreprogressview/scrollercell")
	local updateCellHandler = GameUtil.handler(self._updateProgressCell, self)
	local clearCellHandler = GameUtil.handler(self._clearProgressCell, self)
	local exParams = {
		isHorizontal = false
	}

	self._progressList = ProgressList.create(self._proScrollerGo, cellGo, updateCellHandler, clearCellHandler, exParams)
	self._proEffList = {}
	self._floatingWin = goutil.findChild(self.mainGO, "floatingWin")
	self._winScrollerview = goutil.findChild(self.mainGO, "floatingWin/win/winScrollerview")
	self._winScrollercell = goutil.findChild(self.mainGO, "floatingWin/win/winScrollercell")

	local updateCellCallBack = GameUtil.handler(self._updateWinCell, self)
	local clearCellCallBack = GameUtil.handler(self._clearWinCell, self)

	self._winScrollList = ScrollerList.create(self._winScrollerview, self._winScrollercell, updateCellCallBack, clearCellCallBack)
	self._customInput = UICustomInput.Get(self._floatingWin)
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._btnAddGoldCon = goutil.findChild(self.mainGO, "goldBarCon/btnAdd")
	self._txtGoldNum = goutil.findChildTextComponent(self.mainGO, "goldBarCon/txtNum")

	GameUtil.SetActive(self._floatingWin, false)

	self._bgEff = nil
	self._roleEff = nil
end

function RoleRelationshipView:bindEvents()
	RoleRelationshipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnAddGoldCon, self._onClickBtnAddGoldCon, self)
	GameUtil.addClickHandler(self._btnJumpOne, self._onClickBtnJumpOne, self)
	GameUtil.addClickHandler(self._btnJumpTwo, self._onClickBtnJumpTwo, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function RoleRelationshipView:unbindEvents()
	RoleRelationshipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAddGoldCon)
	GameUtil.rmClickHandler(self._btnJumpOne)
	GameUtil.rmClickHandler(self._btnJumpTwo)
	self._customInput:RemoveListener()
end

function RoleRelationshipView:destroyUI()
	RoleRelationshipView.super.destroyUI(self)
end

function RoleRelationshipView:onEnter()
	RoleRelationshipView.super.onEnter(self)

	local params = self:getOpenParam()

	if params then
		self._activityId = params[1] and checknumber(params[1]) or self._activityId
	end

	if self._activityId == nil then
		local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.RoleShip)

		if actCfg then
			self._activityId = actCfg.activityId
		end
	end

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.RoleShip, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._rsCfg = RoleRelationshipConfig.instance:getRsCfg(self._activityId)
	self._rsRoleCfg = RoleRelationshipConfig.instance:getRsRoleCfg(self._activityId)
	self._rsShipCfg = RoleRelationshipConfig.instance:getRsShipCfg(self._activityId)
	self._rsProPrizeCfg = RoleRelationshipConfig.instance:getRsProPrizeCfg(self._activityId)
	self._rsBoxCfg = RoleRelationshipConfig.instance:getRsBoxCfg(self._activityId)
	self._rsBoxShipCfg = RoleRelationshipConfig.instance:getRsBoxShipCfg(self._activityId)
	self._selectRoleIds = self._selectRoleIds or {}
	self._selectShipIds = self._selectShipIds or {}

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.RoleShipUpdateMapInfo, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleShipUpdateProgress, self._onUpdateProgressPrize, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleShipUpdateTaskInfo, self._onUpdateGoldBarCon, self)
	RoleRelationshipController.instance:onSendRRMGetMapInfoReq(self._activityId)

	local key = "RoleRelationshipViewFirstEnterNeedSendTaskInfo" .. self._activityId

	local function handler(value)
		if value ~= true then
			RoleRelationshipController.instance:onSendRRMGetTaskInfoReq(self._activityId)
			GameUtil.saveUserData(key, true)
		end
	end

	GameUtil.getUserData(key, handler)
end

function RoleRelationshipView:onExit()
	RoleRelationshipView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RoleShipUpdateMapInfo, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.RoleShipUpdateProgress, self._onUpdateProgressPrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.RoleShipUpdateTaskInfo, self._onUpdateGoldBarCon, self)
	self:_onClearGoldBarCon()
	self:_onClearRoleCell()
	UIEffectManager.instance:stopEffect(self._bgEff)
	UIEffectManager.instance:stopEffect(self._roleEff)

	self._bgEff = nil
	self._roleEff = nil
end

function RoleRelationshipView:_onSetUI()
	self:_onSetGoldBarCon()

	if self._bg then
		local isNeedEff = not string.nilorempty(self._rsCfg.bgEff)

		if self._bg then
			UIEffectManager.instance:stopEffect(self._bgEff)

			local effPath = self._rsCfg.bgEff .. ".prefab"

			local function func(_, eff)
				eff:setParent(self._bg.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1)
			end

			self._bgEff = UIEffectManager.instance:playEffect(self, effPath, self._bg, 0, 0, true, false, nil, func)
		end

		GameUtil.SetActive(self._btnJumpOne, not string.nilorempty(self._rsCfg.jumpStrOne))
		GameUtil.SetActive(self._btnJumpTwo, not string.nilorempty(self._rsCfg.jumpStrTwo))
	end
end

function RoleRelationshipView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function RoleRelationshipView:_onUpdateData()
	self:_onUpdatelineDataMo()
	self:_onUpdateRoleShipDataMo()
end

function RoleRelationshipView:_onUpdateUI()
	self:_onUpdateGoldBarCon()
	self:_onUpdateShipLineUI()
	self:_onUpdateRoleCell()
	self:_onUpdateProgressPrize()
	self:_onUpdateBoxCell()
end

function RoleRelationshipView:_onUpdatelineDataMo()
	self._lineDataMo = {}

	for shipId, rsShipData in ipairs(self._rsShipCfg) do
		local mo = {}

		mo.isShipLineHasConnect = RoleRelationshipController.instance:isShipLineHasConnect(shipId)
		self._lineDataMo[shipId] = mo
	end
end

function RoleRelationshipView:_isShipLineHasConnect(shipId)
	return self._lineDataMo[shipId].isShipLineHasConnect
end

function RoleRelationshipView:_onUpdateRoleShipDataMo()
	self._rsDataMo = {}

	for roleId, rsRoleData in ipairs(self._rsRoleCfg) do
		local mo = {}

		mo.roleState = RoleRelationshipController.instance:getRoleState(roleId)
		mo.isCanGetImpPrize = RoleRelationshipController.instance:isHasImpressPrizeCanGet(roleId)
		mo.shipMap = {}

		local tab = {}
		local fitShipIds = {}

		for _, shipData in ipairs(self._rsShipCfg) do
			if table.indexof(shipData.shipLine, rsRoleData.roleId) ~= false then
				table.insert(fitShipIds, shipData.shipId)
			end
		end

		for _, shipId in ipairs(fitShipIds) do
			local shipData = self._rsShipCfg[shipId]
			local t = {}

			t.nearRoleId = RoleRelationshipController.instance:getNearRoleIdByShipLine(roleId, shipData.shipLine)
			t.shipId = shipId

			table.insert(tab, t)
		end

		mo.shipMap = tab
		self._rsDataMo[roleId] = mo
	end

	if self._rsDataMo[1].roleState == 1 then
		self._rsDataMo[1].roleState = 2
	end
end

function RoleRelationshipView:_getRoleState(roleId)
	return self._rsDataMo[roleId].roleState
end

function RoleRelationshipView:_isRoleUnlocked(roleId)
	local roleStae = self:_getRoleState(roleId)

	return roleStae ~= 1
end

function RoleRelationshipView:_isCanGetImpPrize(roleId)
	return self._rsDataMo[roleId].isCanGetImpPrize
end

function RoleRelationshipView:_isCanUnlockLine(roleId)
	local isRoleUnlocked = self:_isRoleUnlocked(roleId)

	if not isRoleUnlocked then
		return false
	end

	local shipMap = self:_getShipMap(roleId)

	for _, v in ipairs(shipMap) do
		local isShipLineHasConnect = self:_isShipLineHasConnect(v.shipId)

		if not isShipLineHasConnect then
			return true
		end
	end
end

function RoleRelationshipView:_getShipMap(roleId)
	return self._rsDataMo[roleId].shipMap
end

function RoleRelationshipView:_getShipIdByNearRoleId(centreRoleId, nearRoleId)
	local shipId
	local shipMap = self:_getShipMap(centreRoleId)

	for _, v in ipairs(shipMap) do
		if v.nearRoleId == nearRoleId then
			shipId = v.shipId

			break
		end
	end

	return shipId
end

function RoleRelationshipView:_setRoleSelected(roleIdList, isSelected)
	self._selectRoleIds = {}

	for _, roleId in ipairs(roleIdList) do
		self._selectRoleIds[roleId] = isSelected
	end
end

function RoleRelationshipView:_isRoleSelected(roleId)
	return self._selectRoleIds[roleId]
end

function RoleRelationshipView:_setLineSelected(shipIdList, isSelected)
	self._selectShipIds = {}

	for _, shipId in ipairs(shipIdList) do
		self._selectShipIds[shipId] = isSelected
	end
end

function RoleRelationshipView:_isLineSelected(shipId)
	return self._selectShipIds[shipId]
end

function RoleRelationshipView:_onUpdateRoleCell()
	for roleId, data in ipairs(self._rsRoleCfg) do
		local cell = self._roleList[roleId]

		if cell == nil then
			cell = {}
			self._roleList[roleId] = cell

			local mainGo = goutil.cloneAndSetParent(self._roleCell, self._roleCol.transform, "roleCell_" .. roleId)

			cell._mainGo = mainGo
			cell._icon = goutil.findChild(mainGo, "img/icon")
			cell._select = goutil.findChild(mainGo, "select")
			cell._centerSelect = goutil.findChild(mainGo, "centerSelect")
			cell._redPoint = goutil.findChild(mainGo, "redPoint")
			cell._txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")

			local handler = GameUtil.handler(self._onClickBtnRoleCell, self, data)

			GameUtil.addClickHandler(cell._mainGo, handler)
		end

		GameUtil.SetActive(cell._mainGo, true)
		GameUtil.setLocalPos(cell._mainGo, data.headPos[1] or 0, data.headPos[2] or 0, 0)

		local isNeedSetHead = not string.nilorempty(data.headPath) and cell._icon

		if isNeedSetHead then
			local spriteType = uGuiUtil.SpriteType.BigBg
			local spriteName = string.format("ui/icon/character/%s.png", data.headPath)

			local function handler()
				return
			end

			uGuiUtil.setSpriteToImage(cell._icon, spriteType, spriteName, handler)
		end

		local isNeedTitle = not string.nilorempty(data.title) and cell._txtTitle ~= nil

		GameUtil.SetActive(cell._txtTitle, isNeedTitle)

		if isNeedTitle then
			cell._txtTitle.text = data.title
		end

		local isCanGetImpPrize = self:_isCanGetImpPrize(roleId)
		local isRoleUnlocked = self:_isRoleUnlocked(roleId)

		GameUtil.SetActive(cell._redPoint, isCanGetImpPrize and isRoleUnlocked)
		GameUtil.SetGray(cell._mainGo, not isRoleUnlocked)

		local isSelected = self:_isRoleSelected(roleId)

		GameUtil.SetActive(cell._select, isSelected)

		if isSelected then
			GameUtil.SetGray(cell._mainGo, false)
		end

		GameUtil.SetActive(cell._centerSelect, self._centerRoleId == roleId)
	end
end

function RoleRelationshipView:_onClearRoleCell()
	for _, cell in ipairs(self._roleList) do
		uGuiUtil.clearImage(cell._icon)
	end
end

function RoleRelationshipView:_onClickBtnRoleCell(data)
	local curRoleId = data.roleId

	if self._isInExplorationMode then
		local isRoleSelected = self:_isRoleSelected(curRoleId)
		local isSameSelectRoleId = self._centerRoleId == curRoleId

		if isSameSelectRoleId or not isRoleSelected then
			self:_setExplorationMode(false)
			self:_setSelectState(0)
			self:_onUpdateRoleCell()
			self:_onUpdateShipLineUI()

			return
		end

		local canUnlockTimes = RoleRelationshipModel.instance:getCanUnlockTimes()

		if canUnlockTimes == 0 then
			FloatWordMgr.instance:show("可探索次数不足~")

			return
		end

		local shipId = self:_getShipIdByNearRoleId(self._centerRoleId, curRoleId)
		local isShipLineHasConnect = self:_isShipLineHasConnect(shipId)

		if not isShipLineHasConnect then
			local go = self._roleList[curRoleId]._mainGo

			UIEffectManager.instance:stopEffect(self._roleEff)

			if go and not string.nilorempty(self._rsCfg.roleEff) then
				local effPath = self._rsCfg.roleEff .. ".prefab"

				local function func(_, eff)
					eff:setScrollRectClipping(self._roleScrollerview:GetComponent(ComponentType.ScrollRect))
					eff:setParent(go.transform)
					eff:setLocalPos(0, 0, 0)
					eff:setScale(1, 1, 1)
				end

				self._roleEff = UIEffectManager.instance:playEffect(self, effPath, go, 0, 0, false, false, nil, func, nil)
			end

			local activityId = self._activityId
			local lineId = shipId

			RoleRelationshipController.instance:onSendRRMUnlockLineReq(activityId, lineId)
		end

		self:_setExplorationMode(false)
		self:_setSelectState(0)
		self:_onUpdateRoleCell()
		self:_onUpdateShipLineUI()
	else
		local isRoleUnlocked = self:_isRoleUnlocked(curRoleId)

		if isRoleUnlocked then
			self:_setSelectState(curRoleId)
			self:_showFloatWin(curRoleId)
			self:_onUpdateRoleCell()

			return
		else
			FloatWordMgr.instance:show("请先点击亮起的头像，探索精灵间的关系噢~")
		end
	end

	if data.reportBehavior > 0 then
		SurveyController.instance:reportBehavior(data.reportBehavior)
	end
end

function RoleRelationshipView:_setSelectState(roleId)
	self._centerRoleId = roleId or 0
end

function RoleRelationshipView:_setExplorationMode(isRun)
	local shipMap = self:_getShipMap(self._centerRoleId)

	self._isInExplorationMode = isRun

	local selectRoleIds = {}
	local selectLineIds = {}

	for _, v in ipairs(shipMap) do
		local isShipLineHasConnect = self:_isShipLineHasConnect(v.shipId)

		if not isShipLineHasConnect then
			table.insert(selectRoleIds, v.nearRoleId)
			table.insert(selectLineIds, v.shipId)
		end
	end

	self:_setRoleSelected(selectRoleIds, isRun)
	self:_setLineSelected(selectLineIds, isRun)
end

function RoleRelationshipView:_onUpdateShipLineUI()
	for shipId, rsShipData in ipairs(self._rsShipCfg) do
		local isShipLineHasConnect = self:_isShipLineHasConnect(shipId)
		local isLineSelected = self:_isLineSelected(shipId)

		self:_setLine(self._lineList, shipId, isShipLineHasConnect)
		self:_setLine(self._dotLineList, shipId, isLineSelected)

		if isShipLineHasConnect then
			local lineGo = self._lineList:getLineGo(shipId)

			if lineGo then
				local txtShipTab = goutil.findChildTextComponent(lineGo, "txtShipTab")

				if txtShipTab then
					txtShipTab.text = rsShipData.txtShipTab or ""

					Framework.TransformUtil.SetEuler(txtShipTab.gameObject.transform, 0, 0, 0)
				end

				local arrowGo = goutil.findChild(lineGo, "imgArrow")

				GameUtil.SetActive(arrowGo, rsShipData.showArrow)
			end
		end
	end

	if self._rsBoxShipCfg then
		for shipId, rsBoxShipData in ipairs(self._rsBoxShipCfg) do
			local lineKey = "boxLine_" .. shipId

			self._lineList:showLine(rsBoxShipData.startPos, rsBoxShipData.endPos, lineKey)

			local lineGo = self._lineList:getLineGo(lineKey)

			if lineGo then
				local txtShipTab = goutil.findChildTextComponent(lineGo, "txtShipTab")

				if txtShipTab then
					txtShipTab.text = rsBoxShipData.txtShipTab or ""

					Framework.TransformUtil.SetEuler(txtShipTab.gameObject.transform, 0, 0, 0)
				end

				local arrowGo = goutil.findChild(lineGo, "imgArrow")

				GameUtil.SetActive(arrowGo, rsBoxShipData.showArrow)
			end
		end
	end
end

function RoleRelationshipView:_setLine(lineList, shipId, isShow)
	if isShow then
		local rsShipData = self._rsShipCfg[shipId]
		local roleIdA, roleIdB = rsShipData.shipLine[1], rsShipData.shipLine[2]
		local posA, posB = self._rsRoleCfg[roleIdA].headPos, self._rsRoleCfg[roleIdB].headPos

		lineList:showLine(posA, posB, shipId)
	else
		lineList:hideLine(shipId)
	end
end

function RoleRelationshipView:_showFloatWin(roleId)
	local cell = self._roleList[roleId]

	if cell._mainGo then
		goutil.addChildToParent(self._floatingWin, cell._mainGo.transform)
		GameUtil.setLocalPos(self._floatingWin, 0, 0, 0)
	end

	self:_updateWinScrollerList()
	GameUtil.SetActive(self._floatingWin, true)
end

function RoleRelationshipView:_hideFloatWin()
	GameUtil.SetActive(self._floatingWin, false)
end

function RoleRelationshipView:_updateWinScrollerList()
	local dataList = {}
	local isCanUnlockLine = self:_isCanUnlockLine(self._centerRoleId)

	if isCanUnlockLine then
		local data = {
			isNeedRed = false,
			txtName = "探索关系",
			changeStyle = 0,
			handler = GameUtil.handler(self._onClickBtnExplore, self)
		}

		table.insert(dataList, data)
	end

	local arcPlanId = self._rsRoleCfg[self._centerRoleId].arcPlanId
	local rsRoleArcCfg = RoleRelationshipConfig.instance:getRsRoleArcCfg(arcPlanId)

	for _, arcData in ipairs(rsRoleArcCfg) do
		local data = {
			txtName = "查看印象",
			changeStyle = 1,
			isNeedRed = RoleRelationshipController.instance:isHasImpressPrizeCanGetByArc(self._centerRoleId, arcPlanId, arcData.arcId),
			handler = GameUtil.handler(self._onClickBtnArchive, self, arcPlanId, arcData.arcId)
		}

		table.insert(dataList, data)
	end

	self._winScrollList:reloadData(dataList)
end

function RoleRelationshipView:_updateWinCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local groupChange = mainGo:GetComponent(ComponentType.UIChangeGroup)
	local isNeedSetName = txtName and not string.nilorempty(data.txtName)

	if isNeedSetName then
		txtName.text = data.txtName
	end

	GameUtil.SetActive(redPoint, data.isNeedRed)
	groupChange:SetState(data.changeStyle)

	if data.handler then
		GameUtil.addClickHandler(mainGo, data.handler)
	end
end

function RoleRelationshipView:_clearWinCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function RoleRelationshipView:_onClickBtnExplore()
	self:_setExplorationMode(true)
	self:_hideFloatWin()
	self:_onUpdateRoleCell()
	self:_onUpdateShipLineUI()
end

function RoleRelationshipView:_onClickBtnArchive(arcPlanId, arcId)
	UIStateManager.instance:push(ViewName.RoleRelationshipArchiveView, self._centerRoleId, arcPlanId, arcId)
	self:_setSelectState(0)
	self:_hideFloatWin()
	self:_onUpdateRoleCell()
end

function RoleRelationshipView:_onClickBtnFWinClose()
	self:_setSelectState(0)
	self:_hideFloatWin()
	self:_onUpdateRoleCell()
end

function RoleRelationshipView:_onCustomInputCallback(hover)
	if not hover then
		self:_onClickBtnFWinClose()
	end
end

function RoleRelationshipView:_onUpdateBoxCell()
	if not self._rsBoxCfg then
		return
	end

	for boxId, data in ipairs(self._rsBoxCfg) do
		local cell = self._boxList[boxId]

		if cell == nil then
			cell = {}
			self._boxList[boxId] = cell

			local mainGo = goutil.cloneAndSetParent(self._boxCell, self._boxCol.transform, "boxCell_" .. boxId)

			cell._mainGo = mainGo
			cell._txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
			cell._typeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
		end

		GameUtil.SetActive(cell._mainGo, true)
		GameUtil.setLocalPos(cell._mainGo, data.headPos[1] or 0, data.headPos[2] or 0, 0)
		GameUtil.setWidth(cell._mainGo, data.boxSize[1] or 250)
		GameUtil.setHeight(cell._mainGo, data.boxSize[2] or 100)

		local isNeedTitle = not string.nilorempty(data.title) and cell._txtTitle ~= nil

		GameUtil.SetActive(cell._txtTitle, isNeedTitle)

		if isNeedTitle then
			cell._txtTitle.text = data.title
		end

		if cell._typeGroup and checknumber(data.showType) > 0 then
			cell._typeGroup:SetState(data.showType - 1)
		end
	end
end

function RoleRelationshipView:_onUpdateProgressPrize()
	local dataList = {}

	for proPrizeId, data in ipairs(self._rsProPrizeCfg) do
		data.id = proPrizeId
		data.needTimes = data.needTimes
		data.prize = MaterialMgr.filterClothsArr(data.prize)[1]
		data.isHasGain = RoleRelationshipController.instance:isHasGainPrize(proPrizeId)
		data.isCanGet = RoleRelationshipController.instance:isCanGainPrize(proPrizeId)

		table.insert(dataList, data)
	end

	self._progressList:reloadDataList(dataList)
	self._progressList:updateCell()

	local proList = {}

	for _, data in ipairs(self._rsProPrizeCfg) do
		table.insert(proList, data.needTimes)
	end

	local unlockTimes = RoleRelationshipModel.instance:getUnlockTimes()

	self._progressList:updateProgressByList(proList, unlockTimes)

	local index = 0

	for idx, data in ipairs(dataList) do
		if data.isCanGet then
			index = idx

			break
		end
	end

	if index > 0 then
		self._progressList:rollToIdx(index)
	else
		self._progressList:rollToIdxNewest(proList, unlockTimes)
	end

	if self._progressNum then
		local unlockTimes = RoleRelationshipModel.instance:getUnlockTimes()

		self._progressNum.text = string.format("%d条关系线", unlockTimes)
	end
end

function RoleRelationshipView:_updateProgressCell(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local effGo = goutil.findChild(mainGo, "item/effGo")
	local received = goutil.findChild(mainGo, "item/received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")

	if not string.nilorempty(data.prize) then
		MaterialMgr.setCellByCfg(data.prize, item, urlOrGo, luaCls, isOne)
	end

	if txtNum then
		txtNum.text = data.needTimes
	end

	GameUtil.SetActive(received, data.isHasGain)
	GameUtil.SetActive(btnGet, data.isCanGet)
	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickBtnLotteryProgressCell, self, data.isCanGet, data.id))
	UIEffectManager.instance:stopEffect(self._proEffList[mainGo])

	if data.isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._proScrollerGo:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._proEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effGo, 0, 0, true, false, nil, func, nil)
	end
end

function RoleRelationshipView:_clearProgressCell(go, data, idx)
	local mainGo = go

	MaterialMgr.resetAll(goutil.findChild(mainGo, "item/itemcell"))
	GameUtil.rmClickHandler(goutil.findChild(mainGo, "btnGet"))
	UIEffectManager.instance:stopEffect(self._proEffList[mainGo])
end

function RoleRelationshipView:_onClickBtnLotteryProgressCell(isCanGet, proPrizeId)
	if isCanGet == true then
		local activityId = self._activityId
		local prizeId = proPrizeId

		RoleRelationshipController.instance:onSendRRMGainProgressPrizeReq(activityId, prizeId)
	end
end

function RoleRelationshipView:_onSetGoldBarCon()
	return
end

function RoleRelationshipView:_onClearGoldBarCon()
	return
end

function RoleRelationshipView:_onUpdateGoldBarCon()
	if self._txtGoldNum then
		local canUnlockTimes = RoleRelationshipModel.instance:getCanUnlockTimes()

		self._txtGoldNum.text = string.format("剩余探索次数：%d次", canUnlockTimes)
	end

	if self._txtTipsCon then
		local remainingTimes = RoleRelationshipController.instance:getRemainingTimes()

		self._txtTipsCon.text = string.format("还剩%d条关系线未解锁", remainingTimes)
	end
end

function RoleRelationshipView:_onClickBtnAddGoldCon()
	UIStateManager.instance:push(ViewName.RoleRelationshipTaskView)
end

function RoleRelationshipView:_onClickBtnJumpOne()
	local jumpStr = self._rsCfg.jumpStrOne

	GotoMgr.gotoByString(jumpStr)
end

function RoleRelationshipView:_onClickBtnJumpTwo()
	local jumpStr = self._rsCfg.jumpStrTwo

	GotoMgr.gotoByString(jumpStr)
end

return RoleRelationshipView
