-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartbuffeventView.lua

module("logic.extensions.sixartdaoguan.view.SixartbuffeventView", package.seeall)

local SixartbuffeventView = class("SixartbuffeventView", ViewComponent)

function SixartbuffeventView:onExitFinished()
	SixartbuffeventView.super.onExitFinished(self)
	self:_recyleAllGrids()
end

function SixartbuffeventView:unbindEvents()
	SixartbuffeventView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()
	self._btnChange:RemoveClickListener()
end

function SixartbuffeventView:bindEvents()
	SixartbuffeventView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
end

function SixartbuffeventView:onExit()
	SixartbuffeventView.super.onExit(self)

	self._selectingDropBuff = nil
	self._curSelectIdx = nil

	self:_stopSelectEffect()
end

function SixartbuffeventView:buildUI()
	SixartbuffeventView.super.buildUI(self)

	self._btnGet = self:getBtn("btnGet")
	self._btnChange = self:getBtn("refreshcon/btnChange")
	self.txtCost = self:getTxt("refreshcon/txtCost")
	self.icon = self:getGo("refreshcon/txtCost/icon")
	self._mapRoot = self:getGo("cellRoot")
	self._cloneGrid = self:getGo("cellRoot/cell")

	self._cloneGrid:SetActive(false)

	self._gridPool = {}
	self._gridList = {}
	self._gridHeight = GameUtil.getHeight(self._cloneGrid)
	self._gridWidth = GameUtil.getWidth(self._cloneGrid)
	self._gridGap = 30
	self._txtRefreshTime = self:getTxt("refreshcon/txtRefreshTime")
	self._refreshconGo = self:getGo("refreshcon")

	local bgCanvas = self:getGo("Canvas")

	GameUtil.expandRectTransform(bgCanvas.transform)
end

function SixartbuffeventView:onEnter()
	SixartbuffeventView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SixArtDaoguanRerandomDropBuffRes, self._onSixArtDaoguanRerandomDropBuffRes, self)
	self.addGEvent(self, GlobalNotify.SixArtDaoguanSelectDropBuffRes, self._onSixArtDaoguanSelectDropBuffRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._isFromStageView = params[2]
	self._challengeId = SixartdaoguanController.ChallengeType.Defense

	if not self:_initData() then
		self:_closeViewAndDoNext()

		return
	end

	self._maxRefreshTime = SixartdaoguanConfig.instance:getMaxBuffRerandomCount(self._activityId)
	self._curSelectIdx = 1

	self:_updateUI()
end

function SixartbuffeventView:_updateCost()
	local isMaxTime = self._refreshTime >= self._maxRefreshTime

	goutil.setActive(self._refreshconGo, not isMaxTime)

	if isMaxTime then
		return
	end

	local cfg = SixartdaoguanConfig.instance:getBuffRerandomCfg(self._activityId, self._refreshTime + 1)
	local matType, matId, matNum = MaterialMgr.getMatParams(cfg.cost)

	self.txtCost.text = MaterialFacade.instance:getGoodCost(matType, matId, matNum)

	MaterialMgr.setIcon(self.icon, matType, matId)
end

function SixartbuffeventView:_updateUI()
	self:_setupBuffList()
	self:_updateCost()
	self:_updateRefreshLeftTime()
end

function SixartbuffeventView:_setupBuffList()
	self:_stopSelectEffect()
	self:_recyleAllGrids()
	self._btnGet.gameObject:SetActive(self._curSelectIdx > 0)

	for k, buffId in ipairs(self._selectingDropBuff) do
		local grid = self:_getOneGrid()
		local cfg = SixartdaoguanConfig.instance:getBuffCfg(self._activityId, buffId)
		local index = k

		grid.txtName.text = cfg.buffName
		grid.txtDesc.text = cfg.buffDesc

		grid.btn:RemoveClickListener()
		grid.bufIcon:SetImage(GameUrl.getExpEventUrl(cfg.iconPath))
		grid.buffLv:SetState(cfg.quality)
		grid.buffLvIcon:SetNativeSize()

		if self._curSelectIdx == index then
			self:_playSelectEffect(grid.go)
		end

		grid.btn:AddClickListener(function()
			self._curSelectIdx = index

			self:_setupBuffList()
		end, self)
		grid.viewClick:RemoveClickListener()
		grid.viewClick:AddClickListener(function()
			self._curSelectIdx = index

			self:_setupBuffList()
		end, self)
		GameUtil.setLocalPos(grid.go, (k - 1) * (self._gridWidth + self._gridGap), 0, 0)
		Framework.TransformUtil.SetLocalPos(grid.content, 0, 0, 0)

		local sizeDelta = grid.content.sizeDelta

		sizeDelta.y = grid.txtDesc.preferredHeight + 8
		grid.content.sizeDelta = sizeDelta

		local preferredHeight = grid.txtName.preferredWidth
		local widthDelta = math.max(0, preferredHeight - 120) * 0.5

		Framework.TransformUtil.SetAnchoredPos(grid.leftSide.transform, -68 - widthDelta, -40)
		Framework.TransformUtil.SetAnchoredPos(grid.rightSide.transform, 72 + widthDelta, -40)
	end

	local len = #self._selectingDropBuff

	GameUtil.setLocalPos(self._mapRoot, -(len * self._gridWidth + (len - 1) * self._gridGap) * 0.5, GameUtil.getLocalPos(self._mapRoot).y, 0)
end

function SixartbuffeventView:_playSelectEffect(go)
	self:_stopSelectEffect()

	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab", go.transform, true)

	eff:setParent(go.transform)
	eff:setLocalPos(118, 0, 0)
	eff:setScale(1)
	eff:setSortingOrder(220)

	self._selectEff = eff
end

function SixartbuffeventView:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end
end

function SixartbuffeventView:_onClickChange()
	local cfg = SixartdaoguanConfig.instance:getBuffRerandomCfg(self._activityId, self._refreshTime + 1)
	local matType, matId, matNum = MaterialMgr.getMatParams(cfg.cost)
	local cost = MaterialFacade.instance:getGoodCost(matType, matId, matNum)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = langPara("确定要花费%s%s换一批圣器吗？", cost, matName)

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		self.selectedId = 0

		self._btnGet.gameObject:SetActive(self._curSelectIdx > 0)
		self:_recyleAllGrids()
		self:_sendMsg()
	end)
end

function SixartbuffeventView:_onClickGet()
	local selectedId = self._selectingDropBuff[self._curSelectIdx]

	SixArtDaoguanAgent.instance:sendPM_SixArtDaoguanSelectDropBuffReq(self._activityId, self._challengeId, selectedId)
end

function SixartbuffeventView:_sendMsg()
	SixArtDaoguanAgent.instance:sendPM_SixArtDaoguanRerandomDropBuffReq(self._activityId, self._challengeId)
end

function SixartbuffeventView:_getOneGrid()
	local len = #self._gridPool
	local grid

	if len > 0 then
		grid = self._gridPool[len]
		self._gridPool[len] = nil
	else
		grid = {}

		local gridGo = goutil.cloneAndSetParent(self._cloneGrid, self._mapRoot.transform)

		grid.go = gridGo
		grid.txtName = goutil.findChildTextComponent(gridGo, "txtName")
		grid.txtDesc = goutil.findChildTextComponent(gridGo, "View/Viewport/Content/txtDesc")
		grid.btn = Framework.ButtonAdapter.GetFrom(gridGo, "btn")
		grid.bufIcon = Framework.ImageBigBG.GetFrom(gridGo, "BuffIcon")
		grid.buffLv = goutil.findChildComponent(gridGo, "level", "UIImageSpriteChange")
		grid.buffLvState = goutil.findChildComponent(gridGo, "icon", "UIImageSpriteChange")
		grid.buffLvIcon = grid.buffLv:GetComponent(typeof(UnityEngine.UI.Image))
		grid.scrollRect = goutil.findChildComponent(gridGo, "View", "ScrollRect")
		grid.content = goutil.findChild(gridGo, "View/Viewport/Content").transform
		grid.viewClick = Framework.UIClickTrigger.Get(grid.scrollRect.gameObject)
		grid.leftSide = goutil.findChild(grid.go, "LeftSide")
		grid.rightSide = goutil.findChild(grid.go, "RightSide")
	end

	grid.go:SetActive(true)
	table.insert(self._gridList, grid)

	return grid
end

function SixartbuffeventView:_recyleAllGrids()
	for i = 1, #self._gridList do
		local grid = self._gridList[i]

		grid.bufIcon:ClearImage()
		grid.go:SetActive(false)
		grid.viewClick:RemoveClickListener()
		table.insert(self._gridPool, grid)
	end

	self._gridList = {}
end

function SixartbuffeventView:_onSixArtDaoguanRerandomDropBuffRes(msg)
	self._selectingDropBuff = msg.selectingDropBuff
	self._refreshTime = msg.reRandomCount
	self._curSelectIdx = 1

	self:_updateUI()
end

function SixartbuffeventView:_onSixArtDaoguanSelectDropBuffRes()
	if not self:_initData() then
		self:_closeViewAndDoNext()

		return
	end

	self:_updateUI()
end

function SixartbuffeventView:_updateRefreshLeftTime()
	self._txtRefreshTime.text = string.format("刷新剩余次数：%s/%s", self._maxRefreshTime - self._refreshTime, self._maxRefreshTime)
end

function SixartbuffeventView:_closeViewAndDoNext()
	if not self._isFromStageView then
		BattleFacade.instance:endBattle()
	else
		self:close()
	end
end

function SixartbuffeventView:_initData()
	local info = SixartdaoguanModel.instance:getInfo(self._activityId)

	for i, v in ipairs(info.challenges) do
		if v.challengeId == self._challengeId then
			self._dropBuffInfo = v.dropBuffInfo

			break
		end
	end

	if not self._dropBuffInfo then
		return false
	end

	self._selectingDropBuff = self._dropBuffInfo.selectingDropBuff
	self._refreshTime = self._dropBuffInfo.reRandomCount

	if not self._selectingDropBuff or #self._selectingDropBuff <= 0 then
		return false
	end

	return true
end

return SixartbuffeventView
