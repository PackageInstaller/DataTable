-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodchallenge/view/StarGodChallengeMainView.lua

module("logic.extensions.stargodchallenge.view.StarGodChallengeMainView", package.seeall)

local StarGodChallengeMainView = class("StarGodChallengeMainView", ViewComponent)

function StarGodChallengeMainView:ctor()
	StarGodChallengeMainView.super.ctor(self)

	self._gameMaxCount = checknumber(StarGodChallengeConfig.instance:getConstValue("TODAY_GAME_TIMES"))
end

function StarGodChallengeMainView:buildUI()
	StarGodChallengeMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtName = self:getTxt("info/top/txtName")
	self._txtRecmdPower = self:getTxt("info/top/fightpower/txtRecmdPower")
	self._petIcon = self:getGo("info/petIcon")
	self._txtDesc = self:getTxt("info/top/txtDesc")
	self._btnSingle = self:getBtn("info/bottom/single/btnSingle")
	self._txtSingleCost = self:getTxt("info/bottom/single/costPower/txtPower")
	self._txtBtnSingle = self:getTxt("info/bottom/single/btnSingle/Text")
	self._btnTeam = self:getBtn("info/bottom/team/btnTeam")
	self._txtTeamCost = self:getTxt("info/bottom/team/costPower/txtPower")
	self._txtRemainNum = self:getTxt("info/top/remain/txtNum")
	self._btnSave = self:getBtn("info/bottom/btnSave")
	self._prizeTableview = self:getGo("info/bottom/rewardList")
	self._prizeCell = self:getGo("info/bottom/rewardList/item")
	self._prizeScrollList = ScrollerList.create(self._prizeTableview, self._prizeCell, GameUtil.handler(self._prizeUpdateCell, self), GameUtil.handler(self.prizeClearCell, self))
	self._scrollView = self:getGo("ScrollView"):GetComponent("ScrollRectExt")
	self._content = self:getGo("ScrollView/Viewport/Content")
	self._item = self:getGo("ScrollView/item")

	self._item:SetActive(false)

	self._emptyRaycast = self:getGo("ScrollView/Viewport"):GetComponent(typeof(UnityEngine.UI.Graphic))
end

function StarGodChallengeMainView:bindEvents()
	StarGodChallengeMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSingle:AddClickListener(self._onClickSingle, self)
	self._btnTeam:AddClickListener(self._onClickTeam, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function StarGodChallengeMainView:unbindEvents()
	StarGodChallengeMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSingle:RemoveClickListener()
	self._btnTeam:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function StarGodChallengeMainView:onEnter()
	StarGodChallengeMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.StarGodChallengeGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.StarGodChallengeSweepRes, self._onSweepRes, self)
	self._scrollView:AddOnEndDrag(self._onEndDrag, self)

	self._allCfgs = StarGodChallengeConfig.instance:getChallengeCfgList()
	self._curCfgIndex = 0
	self._chapterId = 3
	self._isDragEnabled = false

	self:_updateDetailInfo(self._allCfgs[StarGodChallengeModel.instance:getCurLevel()])
	self:_loadIcon()
	self:_initText()
	StarGodChallengeAgent.instance:sendPM_StarGodChallengeGetInfoReq()
	StarGodChallengeAgent.instance:sendPM_StarGodChallengeGetFormReq()

	self._curSelectIndex = 1

	self:_setDragEnable()
end

function StarGodChallengeMainView:onExit()
	StarGodChallengeMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.StarGodChallengeGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.StarGodChallengeSweepRes, self._onSweepRes, self)
	self._scrollView:RemoveOnEndDrag()
	self._prizeScrollList:dispose()
	self:_removeIcon()
	self:_clearItems()
end

function StarGodChallengeMainView:_setDragEnable()
	local maxCount = #self._allCfgs

	self._isDragEnabled = maxCount > 1
	self._emptyRaycast.enabled = self._isDragEnabled
end

function StarGodChallengeMainView:_onClickClose()
	self:close()
end

function StarGodChallengeMainView:_onClickSingle()
	if StarGodChallengeModel.instance:getTodayGameTimes() >= self._gameMaxCount then
		FloatWordMgr.instance:show("今日次数已用尽")

		return
	end

	local cfg = self._allCfgs[self._curCfgIndex]

	if not MaterialMgr.getMatEnough(cfg.singleCost) then
		FloatWordMgr.instance:show("体力不足")
	end

	if not StarGodChallengeModel.instance:isLevelPass(cfg.tier) then
		StarGodChallengeController.instance:openSingleMissionView(cfg)
	else
		MopupModel.instance:clickStarGodChallengeSweep(cfg.tier)
	end
end

function StarGodChallengeMainView:_onClickTeam()
	FormTeamController.instance:enterFormTeamView(self._allCfgs[self._curCfgIndex].groupId)
end

function StarGodChallengeMainView:_onClickSave()
	StarGodChallengeController.instance:openSaveFormationView()
end

function StarGodChallengeMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "stargodchallengerule")
end

function StarGodChallengeMainView:_onGetInfoRes()
	local level = StarGodChallengeModel.instance:getCurLevel()

	if self._allCfgs[level] then
		self:_updateDetailInfo(self._allCfgs[level], true)
	end

	self:_setScrollList()
end

function StarGodChallengeMainView:_onSweepRes()
	self:_updateSingleRemain()
end

function StarGodChallengeMainView:_prizeUpdateCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")
	local bg = goutil.findChild(cell, "bg")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	MaterialMgr.setCellByCfg(data.rewardStr, node)

	if not string.nilorempty(data.intervalStr) then
		goutil.setActive(bg, true)
		goutil.setActive(txtNum.gameObject, true)

		txtNum.text = data.intervalStr
	else
		goutil.setActive(bg, false)
		goutil.setActive(txtNum.gameObject, false)
	end
end

function StarGodChallengeMainView:prizeClearCell(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll()
end

function StarGodChallengeMainView:_updateDetailInfo(cfg, isForce)
	if cfg.tier == self._curCfgIndex and not isForce then
		return
	end

	printInfo("test _updateDetailInfo", cfg.tier)

	self._curCfgIndex = cfg.tier
	self._txtName.text = cfg.name
	self._txtRecmdPower.text = cfg.recommendPower

	local matType, id, matNum = MaterialMgr.getMatParams(cfg.singleCost)

	self._txtSingleCost.text = matNum

	local curSingleTimes = StarGodChallengeModel.instance:getTodayGameTimes()
	local singleLeftTime = self._gameMaxCount - curSingleTimes

	singleLeftTime = singleLeftTime >= 0 and singleLeftTime or 0
	self._txtRemainNum.text = string.format("%d/%d", singleLeftTime, self._gameMaxCount)

	local matType, id, teamMatNum = MaterialMgr.getMatParams(cfg.groupCost)

	self._txtTeamCost.text = teamMatNum

	local curTeamTimes = StarGodChallengeModel.instance:getTodayGameTimes()
	local leftTime = self._gameMaxCount - curTeamTimes

	leftTime = leftTime >= 0 and leftTime or 0
	self._txtRemainNum.text = string.format("%d/%d", leftTime, self._gameMaxCount)
	self._txtBtnSingle.text = StarGodChallengeModel.instance:isLevelPass(cfg.tier) and "扫荡" or "单人挑战"

	self:_updateReward(cfg.singlePrize, cfg.intervalRewardShow)
end

function StarGodChallengeMainView:_updateSingleRemain()
	local curSingleTimes = StarGodChallengeModel.instance:getTodayGameTimes()

	self._txtRemainNum.text = string.format("%d/%d", self._gameMaxCount - curSingleTimes, self._gameMaxCount)
end

function StarGodChallengeMainView:_updateReward(prize, intervalRewardShow)
	local arr = MaterialMgr.changeItemStrArr(prize)
	local list = {}

	for i, v in ipairs(arr) do
		local data = {}

		data.rewardStr = v

		if intervalRewardShow and intervalRewardShow[i] then
			data.intervalStr = intervalRewardShow[i]
		end

		table.insert(list, data)
	end

	self._prizeScrollList:reloadData(list)
end

function StarGodChallengeMainView:_loadIcon()
	local cfg = MaterialChallengeConfig.instance:getChapter(self._chapterId)

	if cfg then
		uGuiUtil.setSpriteToImage(self._petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCopyChapterBgUrl(cfg.stagePic))
	end
end

function StarGodChallengeMainView:_removeIcon()
	Framework.ImageBigBG.Get(self._petIcon):ClearImage()
end

function StarGodChallengeMainView:_initText()
	self._txtDesc.text = "规则说明：3回合内击败所有精灵（单人）\n每人出手1回合，3回合内击败所有精灵（组队）"
end

function StarGodChallengeMainView:_onEndDrag(curSelectIndex)
	local newSelectIndex = curSelectIndex + 1
	local curMaxLevel = StarGodChallengeModel.instance:getCurLevel()

	printInfo("test _onEndDrag", curSelectIndex, newSelectIndex, curMaxLevel, newSelectIndex <= curMaxLevel)

	if newSelectIndex <= curMaxLevel then
		self._curSelectIndex = newSelectIndex

		self:_updateStageListBg()
		self:_updateDetailInfo(self._allCfgs[self._curSelectIndex])
	else
		self._scrollView:RefreshToIndex(curMaxLevel - 1)
		FloatWordMgr.instance:show("请先通过前一关卡")
	end
end

function StarGodChallengeMainView:_setScrollList()
	goutil.clearChildren(self._content)

	self._scrollItemGos = {}
	self._scrollItemInfos = {}
	self._curSelectIndex = StarGodChallengeModel.instance:getCurLevel()

	local maxLevel = StarGodChallengeModel.instance:getMaxLevel()

	for i = 1, maxLevel do
		local go = goutil.cloneAndSetParent(self._item, self._content.transform, "item" .. tostring(i))

		go:SetActive(true)

		self._scrollItemGos[i] = go

		local itemInfo = {}

		self._scrollItemInfos[i] = itemInfo
		itemInfo.index = i
		itemInfo.isUnlock = not StarGodChallengeModel.instance:isLevelLock(i)
		itemInfo.cfg = self._allCfgs[i]
		itemInfo.isSelect = self._curSelectIndex == i
	end

	for i, data in ipairs(self._scrollItemInfos) do
		self:_updateItem(self._scrollItemGos[i], data)
	end

	self._scrollView:initChildList(self._curSelectIndex - 1)
end

function StarGodChallengeMainView:_updateItem(go, data)
	local txtName1 = goutil.findChild(go, "bg/unSelect/txtName"):GetComponent(goutil.Type_UIText)
	local imgLock1 = goutil.findChild(go, "bg/unSelect/imgLock")
	local txtName2 = goutil.findChild(go, "bg/select/txtName"):GetComponent(goutil.Type_UIText)
	local imgLock2 = goutil.findChild(go, "bg/select/imgLock")
	local emptyRaycast = goutil.findChild(go, "bg"):GetComponent(typeof(UnityEngine.UI.Graphic))
	local btnClick = Framework.ButtonAdapter.GetFrom(go, "bg")

	self:_updateBgState(go, data)

	if data.index > 9 then
		txtName1.text = data.index or string.format("0%d", data.index)
	end

	imgLock1:SetActive(not data.isUnlock)

	txtName2.text = txtName1.text

	imgLock2:SetActive(not data.isUnlock)
	btnClick:AddClickListener(function()
		if not data.isUnlock then
			FloatWordMgr.instance:show("请先通关上一层")
		end
	end)

	emptyRaycast.enabled = self._isDragEnabled
end

function StarGodChallengeMainView:_clearItems()
	if self._scrollItemGos then
		for i, go in ipairs(self._scrollItemGos) do
			local btnClick = Framework.ButtonAdapter.GetFrom(go, "bg")

			btnClick:RemoveClickListener()
		end
	end

	self._scrollItemGos = nil
	self._scrollItemInfos = nil
end

function StarGodChallengeMainView:_updateBgState(go, data)
	local unSelectBg = goutil.findChild(go, "bg/unSelect"):GetComponent("UIChangeGroup")
	local selectBg = goutil.findChild(go, "bg/select"):GetComponent("UIChangeGroup")

	unSelectBg.gameObject:SetActive(not data.isSelect)
	selectBg.gameObject:SetActive(data.isSelect)

	local state = data.isSelect and 1 or 0

	unSelectBg:SetState(state)
	selectBg:SetState(state)
end

function StarGodChallengeMainView:_updateStageListBg()
	if not self._scrollItemInfos then
		return
	end

	for i, v in ipairs(self._scrollItemInfos) do
		v.isSelect = self._curSelectIndex == i

		self:_updateBgState(self._scrollItemGos[i], self._scrollItemInfos[i])
	end
end

return StarGodChallengeMainView
