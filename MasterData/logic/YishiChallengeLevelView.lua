-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/view/YishiChallengeLevelView.lua

module("logic.extensions.yishichallenge.view.YishiChallengeLevelView", package.seeall)

local YishiChallengeLevelView = class("YishiChallengeLevelView", ViewComponent)

function YishiChallengeLevelView:ctor()
	YishiChallengeLevelView.super.ctor(self)
end

function YishiChallengeLevelView:unbindEvents()
	YishiChallengeLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChess:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function YishiChallengeLevelView:bindEvents()
	YishiChallengeLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._closeView, self)
	self._btnTip:AddClickListener(self._tipsOnClick, self)
	self._btnChess:AddClickListener(self._chessOnClick, self)
	self._btnChallenge:AddClickListener(self._enterOnClick, self)
end

function YishiChallengeLevelView:onExit()
	YishiChallengeLevelView.super.onExit(self)
	self:_resetAllIcon()
	self._levelScroll:dispose()
	MaterialMgr.resetAll(self._bubbleItem)
	YishiChallengeControll.instance:stopEffect()
	GlobalDispatcher:removeListener(GlobalNotify.YishiChallengeInfoReq, self._refreshTabList, self)
	GlobalDispatcher:removeListener(GlobalNotify.YishiChallengeStageUnlockReq, self._reqInfo, self)
end

function YishiChallengeLevelView:buildUI()
	YishiChallengeLevelView.super.buildUI(self)

	self._bubble = self:getGo("bubble")
	self._bubbleItem = self:getGo("bubble/item")
	self._btnChess = self:getBtn("fmtCol/fmtCell1/btnChess")
	self._btnChallenge = self:getBtn("fmtCol/btnChallenge")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._txtBubbleNum = self:getTxt("bubble/num")
	self._txtDesc = self:getTxt("tips/txtDesc")
	self._txtChess = self:getTxt("txtDesc")
	self._levelTab = self:getGo("level/tableview")
	self._levelCell = self:getGo("level/levelCell")
	self._levelScroll = ScrollerList.create(self._levelTab, self._levelCell, GameUtil.handler(self._updateLevelCell, self), GameUtil.handler(self._clearLevelCell, self))
	self._checkerBoardFmtList = {}

	for i = 1, 9 do
		local list = {}

		list.go = self:getGo("fmtCol/fmtCell1/fmtCol/fmtView/cell_" .. i)
		list.icon = goutil.findChild(list.go, "icon"):GetComponent("UIImageSpriteChange")
		list.mask = goutil.findChild(list.go, "mask")
		list.eff = goutil.findChild(list.go, "eff")
		list.index = i

		table.insert(self._checkerBoardFmtList, list)
	end

	self._enemyFmtList = {}

	for i = 1, 9 do
		local list = {}

		list.go = self:getGo("fmtCol/fmtCell2/fmtCol/fmtView/cell_" .. i)
		list.icon = goutil.findChild(list.go, "icon")
		list.bg = goutil.findChild(list.go, "bg")

		table.insert(self._enemyFmtList, list)
	end
end

function YishiChallengeLevelView:onEnter()
	YishiChallengeLevelView.super.onEnter(self)

	self._challengeId = YishiChallengeModel.instance:getChallengeId()
	self._chanllengeCfg = YishiChallengeConfig.instance:getChallengeCfgById(self._challengeId)
	self._cfg = YishiChallengeConfig.instance:getCfgById(self._challengeId)
	self._chanllengeList = {}
	self._lineEffList = {}

	self:_reqInfo()

	self._txtDesc.text = self._cfg.desc
	self._selectEff = {}

	YishiChallengeControll.instance:stopEffect()
	YishiChallengeControll.instance:createEffect(self, "fx_ui_yishitiaozhan_fw", self.mainGO, true)
	GlobalDispatcher:addListener(GlobalNotify.YishiChallengeInfoReq, self._refreshTabList, self)
	GlobalDispatcher:addListener(GlobalNotify.YishiChallengeStageUnlockReq, self._reqInfo, self)
end

function YishiChallengeLevelView:_closeView()
	self:close()
end

function YishiChallengeLevelView:_tipsOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "YishiChallengeRule_2")
end

function YishiChallengeLevelView:_chessOnClick()
	if not self._stagePass then
		FloatWordMgr.instance:show("未满足条件")

		return
	end

	if self._stageUnlock then
		FloatWordMgr.instance:show("关卡已通关")

		return
	end

	YiShiChallengeAgent.instance:sendPM_YiShiChallengeStageUnlockReq(self._challengeId)
end

function YishiChallengeLevelView:_enterOnClick()
	if self._stageUnlock then
		FloatWordMgr.instance:show("关卡已通关")

		return
	end

	if self._stagePass then
		FloatWordMgr.instance:show("已达到解开棋盘的要求")

		return
	end

	local openTime = self._chanllengeCfg[self._curStageId].openTime
	local timePeriod = GameUtil.getTimePeriod(openTime)

	if timePeriod ~= GameUtil.inTimePeriod then
		local openDate = GameUtil.string2date(openTime)

		FloatWordMgr.instance:show(langPara("%02d.%02d %d:%02d后开启", openDate.month, openDate.day, openDate.hour, openDate.min))

		return
	end

	YishiChallengeControll.instance:openYishiCustomFmt(self._challengeId, self._curStageId)
end

function YishiChallengeLevelView:_reqInfo()
	YiShiChallengeAgent.instance:sendPM_YiShiChallengeInfoReq(self._challengeId)
end

function YishiChallengeLevelView:_refreshTabList()
	self._curStageId = YishiChallengeModel.instance:getStageId()
	self._stageUnlock = YishiChallengeModel.instance:getStageUnlock()
	self._chanllengeList = {}

	for i, v in ipairs(self._chanllengeCfg) do
		v.isOnLfet = v.stageId % 2 == 0
		v.isOver = v.stageId < self._curStageId

		if self._curStageId == v.stageId and self._stageUnlock then
			v.isOver = true
		end

		table.insert(self._chanllengeList, v)
	end

	self._levelScroll:reloadData(self._chanllengeList)

	if self._curStageId > #self._chanllengeCfg then
		self._levelScroll:MoveCellToCenter(self._curStageId - 2)
	else
		self._levelScroll:MoveCellToCenter(self._curStageId - 1)
	end

	self:_updateFmtList(self._curStageId)

	local matType, id, num = MaterialMgr.getMatParams(self._chanllengeCfg[self._curStageId].prize)

	MaterialMgr.setIcon(self._bubbleItem, matType, id)

	self._stagePass = YishiChallengeModel.instance:getStagePass()
	self._txtChess.text = self._chanllengeCfg[self._curStageId].desc
	self._txtBubbleNum.text = "x" .. num

	goutil.setActive(self._btnChess.gameObject, self._stagePass)
	goutil.setActive(self._txtChess.gameObject, not self._stagePass and not self._stageUnlock)
end

function YishiChallengeLevelView:_updateLevelCell(view, cell, data)
	local root = goutil.findChild(cell, "root")
	local bg = goutil.findChild(cell, "root/bg"):GetComponent("UIImageSpriteChange")
	local colorLevel = goutil.findChild(cell, "root/txtLevel"):GetComponent("UITextColorChange")
	local txtLevel = goutil.findChildTextComponent(cell, "root/txtLevel")
	local xPos = data.pos[1]
	local yPos = data.pos[2]

	bg:SetState(data.isOver and 1 or 0)
	colorLevel:SetState(data.isOver and 1 or 0)
	UIEffectManager.instance:stopEffect(self._selectEff[cell])

	if self._curStageId == data.stageId then
		self._selectEff[cell] = YishiChallengeControll.instance:createEffect(self, "fx_ui_yishitiaozhan_xuanzhong", root, true)
	end

	txtLevel.text = string.format("第%s关", data.stageId)

	GameUtil.setAnchoredPos(root, xPos, yPos)
end

function YishiChallengeLevelView:_clearLevelCell(cell)
	return
end

function YishiChallengeLevelView:_updateFmtList(index)
	local cfg = self._chanllengeCfg[index]
	local chessboard = cfg.chessboard
	local creepsCfg = YishiChallengeConfig.instance:getChallengeCreepsCfgById(cfg.creepsMasterId)
	local survivals = YishiChallengeModel.instance:getSurvivals()
	local list = {}

	self:_resetAllIcon()

	for i, v in ipairs(chessboard) do
		list[i] = checknumber(chessboard[i]) > 0 and checknumber(chessboard[i]) or checknumber(survivals[i]) > 0 and checknumber(survivals[i]) or 0
	end

	local lineList = self:_jugdeHaveLine(list)

	self._lineEffList = {}

	for i, v in ipairs(lineList) do
		local info = self._checkerBoardFmtList[v.pos]

		if info.go then
			self._lineEffList[v.index] = YishiChallengeControll.instance:createEffect(self, "fx_ui_yishitiaozhan_lianxian", info.eff, true)

			self._lineEffList[v.index]:setLocalEulerAngle(0, 0, v.rotationZ)
		end
	end

	for i, v in ipairs(self._checkerBoardFmtList) do
		goutil.setActive(v.icon.gameObject, true)

		if checknumber(list[i]) > 0 then
			v.icon:SetState(list[i] - 1)
		else
			goutil.setActive(v.icon.gameObject, false)
		end
	end

	for k, v in pairs(creepsCfg) do
		local go = self._enemyFmtList[v.posId]

		goutil.setActive(go.bg, true)
		goutil.setActive(go.icon, true)
		MaterialMgr.setIcon(go.icon, MatType.PET_SKIN, v.raceId)
	end
end

function YishiChallengeLevelView:_resetAllIcon()
	for i, v in ipairs(self._checkerBoardFmtList) do
		MaterialMgr.resetAll(v.icon)
		GameUtil.setLocalRotation(v.eff, 0, 0, 0)
	end

	for i, v in ipairs(self._enemyFmtList) do
		MaterialMgr.resetAll(v.icon)
		goutil.setActive(v.bg, false)
		goutil.setActive(v.icon, false)
	end

	for i, v in pairs(self._lineEffList) do
		UIEffectManager.instance:stopEffect(v)
	end
end

function YishiChallengeLevelView:_getAttrString(id)
	for k, v in pairs(GameEnum.Races) do
		if v == id then
			return v == 0 and "" or k
		end
	end

	return ""
end

function YishiChallengeLevelView:_jugdeHaveLine(list)
	local result = {}

	for idx, v in ipairs(YishiChallengeModel.judgeTable) do
		local temp = 0
		local isRight = true

		for i, val in ipairs(v) do
			if temp == 0 and i == 1 then
				temp = list[val]
			elseif temp ~= list[val] then
				isRight = false
			end

			temp = list[val]
		end

		if temp ~= 0 and isRight then
			table.insert(result, {
				pos = v[2],
				rotationZ = self:_getLineRotation(v),
				index = idx
			})
		end
	end

	return result
end

function YishiChallengeLevelView:_getLineRotation(list)
	if list[1] == 1 and list[3] == 9 then
		return 45
	elseif list[1] == 3 and list[3] == 7 then
		return -45
	elseif list[2] - list[1] == 1 then
		return 90
	end

	return 0
end

return YishiChallengeLevelView
