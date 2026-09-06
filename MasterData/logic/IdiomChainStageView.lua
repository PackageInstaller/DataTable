-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/view/IdiomChainStageView.lua

module("logic.extensions.idiomchain.view.IdiomChainStageView", package.seeall)

local IdiomChainStageView = class("IdiomChainStageView", ViewComponent)

function IdiomChainStageView:buildUI()
	IdiomChainStageView.super.buildUI(self)

	self._diffScrView = self:getGo("diffCol/scrView")
	self._diffScrCell = self:getGo("diffCol/scrCell")
	self._diffScrollList = ScrollerList.create(self._diffScrView, self._diffScrCell, GameUtil.handler(self._updateDiffCell, self), GameUtil.handler(self._clearDiffCell, self))

	self._diffScrollList:setCenterMode(true)

	self._btnClose = self:getGo("btnClose")
	self._txtTips = self:getTxt("tips/txt")
end

function IdiomChainStageView:bindEvents()
	IdiomChainStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function IdiomChainStageView:unbindEvents()
	IdiomChainStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function IdiomChainStageView:onEnter()
	IdiomChainStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = IdiomChainController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_IdiomChainInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function IdiomChainStageView:onExit()
	IdiomChainStageView.super.onExit(self)
	self:_onClearDiffCol()
end

function IdiomChainStageView:_onUpdate()
	local maxTimes = self._subMo:getMaxDailyTimes()
	local leftTimes = self._subMo:getLeftDailyTimes()

	self._txtTips.text = leftTimes <= 0 and string.format("剩余游戏次数：<color=#eb4624>%s</color>/%s", leftTimes, maxTimes) or string.format("剩余游戏次数：%s/%s", leftTimes, maxTimes)

	self:_onUpdateDiffColUI()
end

function IdiomChainStageView:_onUpdateDiffColUI()
	local cfg = IdiomChainConfig.instance:getDifficultDatas(self._activityId)

	self._diffScrollList:reloadData(cfg or {})
end

function IdiomChainStageView:_onClearDiffCol()
	self._diffScrollList:dispose()
end

function IdiomChainStageView:_updateDiffCell(view, cell, data, tag)
	local index = cell.data
	local mainGo = cell.gameObject
	local imgBg = goutil.findChild(mainGo, "imgBg")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local length = #self._diffScrollList:getData()

	GameUtil.setUIGroupIdx(mainGo, index % (length + 1) - 1)

	txtName.text = data.name

	imgBg:GetComponent(goutil.Type_UIImage):SetNativeSize()
	GameUtil.addClickHandler(mainGo, function()
		local leftTimes = self._subMo:getLeftDailyTimes()

		if leftTimes <= 0 then
			FloatWordMgr.instance:show("次数不足")

			return
		end

		self:close()
		IdiomChainController.instance:startGame(self._activityId, data.gamePlanId)
	end)
end

function IdiomChainStageView:_clearDiffCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

return IdiomChainStageView
