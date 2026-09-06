-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkaya/view/OriginKayaLevelView.lua

module("logic.extensions.originkaya.view.OriginKayaLevelView", package.seeall)

local OriginKayaLevelView = class("OriginKayaLevelView", ViewComponent)

function OriginKayaLevelView:ctor()
	OriginKayaLevelView.super.ctor(self)

	self._nodePosList = {
		{
			x = 0,
			y = -30
		},
		{
			x = 0,
			y = 20
		}
	}
	self._cycleCount = #self._nodePosList
end

function OriginKayaLevelView:unbindEvents()
	OriginKayaLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnReset)
end

function OriginKayaLevelView:bindEvents()
	OriginKayaLevelView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function OriginKayaLevelView:buildUI()
	OriginKayaLevelView.super.buildUI(self)

	self._stageTableview = self:getGo("stageTableview")
	self._stageTablecell = self:getGo("stageTablecell")
	self._stageTableList = ScrollerList.create(self._stageTableview, self._stageTablecell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._resultTableview = self:getGo("resultTableview")
	self._resultTablecell = self:getGo("resultTableview/resultTablecell")
	self._resultTableList = ScrollerList.create(self._resultTableview, self._resultTablecell, GameUtil.handler(self._updateResultCell, self), GameUtil.handler(self._clearResultCell, self))
	self._floorTableCell = self:getGo("floorTableCell")
	self._floorTableView = self:getGo("floorTableView")
	self._floorTableList = ScrollerList.create(self._floorTableView, self._floorTableCell, GameUtil.handler(self._updateFloorCell, self), GameUtil.handler(self._clearFloorCell, self))
	self._seedTableview = self:getGo("seedInfo/seedTableview")
	self._seedTablecell = self:getGo("seedInfo/seedTableview/seedTablecell")
	self._seedTableList = ScrollerList.create(self._seedTableview, self._seedTablecell, GameUtil.handler(self._updateSeedCell, self), GameUtil.handler(self._clearSeedCell, self))
	self._seedViewport = self:getGo("seedInfo/seedTableview/viewport")
	self._seedContent = self:getGo("seedInfo/seedTableview/viewport/content")

	local points = {}

	table.insert(points, {
		x = -52,
		y = -147
	})
	table.insert(points, {
		x = 216,
		y = 0
	})
	table.insert(points, {
		x = 718,
		y = -190
	})
	self._seedTableList:setBeizierOffset(true, points, 27, "node")

	self._prizeCon = self:getGo("prizeCon")
	self._btnReset = self:getGo("btnReset")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._seedCard = self:getGo("seedInfo/seedCard")
	self._txtSeedDesc = self:getTxt("seedInfo/seedCard/txtDesc")
	self._customInput = UICustomInput.Get(self._seedCard)
end

function OriginKayaLevelView:onExit()
	OriginKayaLevelView.super.onExit(self)
	MaterialMgr.resetAll(self._prizeCon)
end

function OriginKayaLevelView:onEnter()
	OriginKayaLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginKayaInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	GameUtil.SetActive(self._seedCard, false)
	self:_initData()
	self:_refreshView()
end

function OriginKayaLevelView:_initData()
	self._curFloor = 1

	local floorCfgs = OriginKayaConfig.instance:getFloorCfgs(self._activityId)

	for i, v in ipairs(floorCfgs) do
		if OriginKayaModel.instance:isPassFloor(self._activityId, v.floorId) == true then
			self._curFloor = v.floorId + 1
		end
	end

	if self._curFloor > #floorCfgs then
		self._curFloor = #floorCfgs
	end
end

function OriginKayaLevelView:_refreshView()
	local stageCfgs = OriginKayaConfig.instance:getStageCfgs(self._activityId, self._curFloor)

	self._curStageId = OriginKayaModel.instance:getPassStage(self._activityId, self._curFloor) + 1

	if self._curStageId > #stageCfgs then
		self._curStageId = #stageCfgs
	end

	local floorCfgs = OriginKayaConfig.instance:getFloorCfgs(self._activityId)

	self._floorTableList:reloadData(floorCfgs)
	self._stageTableList:reloadData(stageCfgs)

	local curFloorCfg = floorCfgs[self._curFloor]

	self._seedTableList:reloadData(curFloorCfg.needUseSeed)

	local curAttrCountMap = {}

	for i, v in ipairs(curFloorCfg.needUseSeed) do
		local activeSeedInfo = OriginKayaModel.instance:getSeedInfo(self._activityId, self._curFloor, v)

		if activeSeedInfo then
			curAttrCountMap[activeSeedInfo.attr] = curAttrCountMap[activeSeedInfo.attr] or 0
			curAttrCountMap[activeSeedInfo.attr] = curAttrCountMap[activeSeedInfo.attr] + 1
		end
	end

	local attributeList = {}

	for i, v in ipairs(curFloorCfg.attributeId) do
		table.insert(attributeList, {
			id = v,
			num = curFloorCfg.attributeNum[i],
			curCount = checknumber(curAttrCountMap[i])
		})
	end

	self._resultTableList:reloadData(attributeList)
	MaterialMgr.resetAll(self._prizeCon)
	MaterialMgr.setCellByCfg(curFloorCfg.prize, self._prizeCon)
end

function OriginKayaLevelView:_updateFloorCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txt")
	local txtNameGray = goutil.findChildTextComponent(go, "btnClick/txtGray")
	local btnClick = goutil.findChild(go, "btnClick")
	local curGo = goutil.findChild(go, "cur")
	local passGo = goutil.findChild(go, "passGo")

	GameUtil.SetActive(curGo, data.floorId == self._curFloor)
	GameUtil.SetActive(passGo, OriginKayaModel.instance:isPassFloor(self._activityId, data.floorId))

	if not OriginKayaModel.instance:isPassFloor(self._activityId, data.floorId) and data.floorId ~= self._curFloor then
		GameUtil.SetGray(btnClick, true)
		GameUtil.SetActive(txtName, false)
		GameUtil.SetActive(txtNameGray, true)
	else
		GameUtil.SetGray(btnClick, false)
		GameUtil.SetActive(txtName, true)
		GameUtil.SetActive(txtNameGray, false)
	end

	txtName.text = langPara("%s", GameUtil.toRomanNumber(data.floorId))
	txtNameGray.text = langPara("%s", GameUtil.toRomanNumber(data.floorId))

	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickFloor(data.floorId)
	end)
end

function OriginKayaLevelView:_clearFloorCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "btnClick")

	GameUtil.rmClickHandler(btnClick)
end

function OriginKayaLevelView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "node")
	local node = goutil.findChild(go, "node")
	local bg = goutil.findChild(node, "bg1")
	local txtNameGray = goutil.findChildTextComponent(node, "bg1/txtNameGray")
	local txtName = goutil.findChildTextComponent(node, "txtName")
	local passGo = goutil.findChild(node, "passGo")
	local index = data.stageId % self._cycleCount

	if index == 0 then
		index = self._cycleCount
	end

	txtName.text = langPara("第%d关", data.stageId)
	txtNameGray.text = langPara("第%d关", data.stageId)

	GameUtil.setAnchoredPos(node, self._nodePosList[index].x, self._nodePosList[index].y)
	GameUtil.SetActive(passGo, OriginKayaModel.instance:getPassStage(self._activityId, self._curFloor) >= data.stageId)

	if data.stageId > self._curStageId then
		GameUtil.SetGray(bg, true)
		GameUtil.SetActive(txtName, false)
		GameUtil.SetActive(txtNameGray, true)
	else
		GameUtil.SetGray(bg, false)
		GameUtil.SetActive(txtName, true)
		GameUtil.SetActive(txtNameGray, false)
	end

	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickStage(data.stageId)
	end)
end

function OriginKayaLevelView:_clearStageCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "node")

	GameUtil.rmClickHandler(btnClick)
end

function OriginKayaLevelView:_updateSeedCell(view, cell, data, tag)
	local go = cell.gameObject
	local node = goutil.findChild(go, "node")
	local btn = goutil.findChild(node, "btn")
	local stageInfo = goutil.findChild(node, "stageInfo")
	local txt = goutil.findChildTextComponent(stageInfo, "txt")
	local imgChange = goutil.findChildComponent(node, "img", ComponentType.UIImageSpriteChange)
	local seedInfo = OriginKayaModel.instance:getSeedInfo(self._activityId, self._curFloor, data)

	if seedInfo then
		imgChange:SetState(seedInfo.attr)
	else
		imgChange:SetState(0)
	end

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickSeed(go, data)
	end)

	local activeStage = 0

	if seedInfo then
		activeStage = seedInfo.stageId
	end

	GameUtil.SetActive(stageInfo, checknumber(activeStage) > 0)

	txt.text = checknumber(activeStage) > 0 and checknumber(activeStage) or ""
end

function OriginKayaLevelView:_clearSeedCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function OriginKayaLevelView:_updateResultCell(view, cell, data, tag)
	local go = cell.gameObject
	local txt = goutil.findChildTextComponent(go, "txt")
	local imgChange = goutil.findChildComponent(go, "img", ComponentType.UIImageSpriteChange)
	local imgTextChange = goutil.findChildComponent(go, "txt", ComponentType.UITextColorChange)

	imgChange:SetState(data.id)

	if data.curCount >= data.num then
		imgTextChange:SetState(0)
	else
		imgTextChange:SetState(1)
	end

	txt.text = langPara("%d<color=#FFFFFF>/%d</color>", data.curCount, data.num)
end

function OriginKayaLevelView:_clearResultCell(cell)
	return
end

function OriginKayaLevelView:_onClickFloor(floorId)
	if OriginKayaController.instance:isPassAllFloor(self._activityId) == true then
		self._curFloor = floorId

		local stageCfgs = OriginKayaConfig.instance:getStageCfgs(self._activityId, self._curFloor)

		self._curStageId = OriginKayaModel.instance:getPassStage(self._activityId, self._curFloor) + 1

		if self._curStageId > #stageCfgs then
			self._curStageId = #stageCfgs
		end

		self:_refreshView()
	else
		FloatWordMgr.instance:show(lang("未通关全部关卡"))
	end
end

function OriginKayaLevelView:_onClickStage(stageId)
	if OriginKayaModel.instance:getPassStage(self._activityId, self._curFloor) == self._curStageId then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	if stageId == self._curStageId then
		OriginKayaController.instance:openMissionView(self._activityId, self._curFloor, self._curStageId)
	end
end

function OriginKayaLevelView:_onClickSeed(cellGo, seedId)
	local nodeGo = goutil.findChild(cellGo, "node")
	local nodePos = GameUtil.getAnchoredPos(nodeGo)
	local cellPos = GameUtil.getAnchoredPos(cellGo)
	local contentPos = GameUtil.getAnchoredPos(self._seedContent)
	local viewportPos = GameUtil.getAnchoredPos(self._seedViewport)
	local tablePos = GameUtil.getAnchoredPos(self._seedTableview)
	local tableHeight, tableWidth = GameUtil.getHeight(self._seedTableview), GameUtil.getWidth(self._seedTableview)
	local contentWidth, contentHeight = GameUtil.getWidth(self._seedContent), GameUtil.getHeight(self._seedContent)
	local targetPosX = nodePos.x + cellPos.x + contentWidth / 2 + contentPos.x + viewportPos.x - tableWidth / 2 + tablePos.x
	local targetPosY = nodePos.y + cellPos.y - contentHeight / 2 + contentPos.y + viewportPos.y + tableHeight / 2 + tablePos.y
	local offsetX, offsetY = 5, 100

	GameUtil.setAnchoredPos(self._seedCard, targetPosX + offsetX, targetPosY + offsetY)
	GameUtil.SetActive(self._seedCard, true)

	local seedCfg = OriginKayaConfig.instance:getSeedCfg(self._activityId, seedId)

	self._txtSeedDesc.text = seedCfg.desc
end

function OriginKayaLevelView:_onClickReset()
	if OriginKayaModel.instance:getPassStage(self._activityId, self._curFloor) > 0 then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否重置当前层的所有关卡"), function()
			OriginKayaAgent.instance:sendPM_OriginKayaResetReq(self._activityId, self._curFloor)
		end)
	else
		FloatWordMgr.instance:show(lang("无可重置关卡"))
	end
end

function OriginKayaLevelView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._seedCard, false)
	end
end

return OriginKayaLevelView
