-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/view/DivineFuYaoClgNormalView.lua

module("logic.extensions.divinefuyaoclg.view.DivineFuYaoClgNormalView", package.seeall)

local DivineFuYaoClgNormalView = class("DivineFuYaoClgNormalView", ViewComponent)

function DivineFuYaoClgNormalView:buildUI()
	DivineFuYaoClgNormalView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")

	local stageScrView = self:getGo("stageCol/scrView")
	local stageScrCell1 = self:getGo("stageCol/scrCell1")
	local stageScrCell2 = self:getGo("stageCol/scrCell2")
	local scrCellList = {
		stageScrCell1,
		stageScrCell2
	}

	self._sizeList = {}

	for tag, go in ipairs(scrCellList) do
		local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._stageScrollerList = ScrollerList.create(stageScrView, scrCellList, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	self._stageScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._stageScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._itemPrize = self:getGo("prize/item")
	self._tagHasGain = self:getGo("prize/tagHasGain")
	self._btnTipPrize = self:getGo("prize/btnTip")
end

function DivineFuYaoClgNormalView:bindEvents()
	DivineFuYaoClgNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnTipPrize, self._onClickBtnTipPrize, self)
end

function DivineFuYaoClgNormalView:unbindEvents()
	DivineFuYaoClgNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTipPrize)
end

function DivineFuYaoClgNormalView:onEnter()
	DivineFuYaoClgNormalView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = DivineFuYaoClgController.instance:getSubMo(self._activityId)
	self._actData = DivineFuYaoClgConfig.instance:getActivityData(self._activityId)
	self._curStageId = 0

	self.addGEvent(self, GlobalNotify.HandlePM_DivineFuYaoClgInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function DivineFuYaoClgNormalView:onExit()
	DivineFuYaoClgNormalView.super.onExit(self)
	MaterialMgr.resetAll(self._itemPrize)
	self:_onClearStageCol()
end

function DivineFuYaoClgNormalView:_onUpdate()
	self:_onUpdateStageColUI()
end

function DivineFuYaoClgNormalView:_onUpdateStageColUI()
	local datas = DivineFuYaoClgConfig.instance:getNormalStageDatas(self._activityId) or {}
	local max = self._subMo:getMaxNormalStageId()

	self._curStageId = Mathf.Min(self._subMo:getNormalStageId() + 1, max)

	self._stageScrollerList:reloadData(datas)
	self._stageScrollerList:MoveCellToCenter(self._curStageId - 1)

	local stageData = DivineFuYaoClgConfig.instance:getNormalStageData(self._activityId, self._curStageId)

	MaterialMgr.setCellByCfg(stageData.prize, self._itemPrize)

	local isPass = self._subMo:isPassStageInNor(self._curStageId)

	GameUtil.SetActive(self._tagHasGain, isPass)
end

function DivineFuYaoClgNormalView:_onClearStageCol()
	self._stageScrollerList:dispose()
end

function DivineFuYaoClgNormalView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local isUnlock = self._subMo:isUnlockStageInNor(stageId)
	local isPass = self._subMo:isPassStageInNor(stageId)
	local mainGo = cell.gameObject
	local btnClg = goutil.findChild(mainGo, "btnClg")
	local tagSelect = goutil.findChild(mainGo, "btnClg/tagSelect")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local tagPass = goutil.findChild(mainGo, "tagPass")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = string.format("第%s关", stageId)

	GameUtil.SetActive(tagLock, not isUnlock)
	GameUtil.SetActive(tagSelect, self._curStageId == stageId)
	GameUtil.SetActive(tagPass, isPass)
	GameUtil.addClickHandler(btnClg, function()
		if not isUnlock then
			FloatWordMgr.instance:show("未解锁")

			return
		end

		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		end

		DivineFuYaoClgController.instance:enterBattleNormal(self._activityId, stageId)
	end)
end

function DivineFuYaoClgNormalView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local btnClg = goutil.findChild(mainGo, "btnClg")

	GameUtil.rmClickHandler(btnClg)
end

function DivineFuYaoClgNormalView:_getTagByIdx(data, idx)
	return 2 - (idx + 1) % 2
end

function DivineFuYaoClgNormalView:_getCellSize(view, idx)
	local list = self._stageScrollerList:getData()
	local data = list[idx + 1]
	local tag = self:_getTagByIdx(data, idx)

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

function DivineFuYaoClgNormalView:_onClickBtnTip()
	local key = self._actData.mainRuleKey

	TipsFacade.instance:openRulesView(key)
end

function DivineFuYaoClgNormalView:_onClickBtnTipPrize()
	local key = self._actData.prizeKeyMain

	TipsFacade.instance:openRulesView(key)
end

return DivineFuYaoClgNormalView
