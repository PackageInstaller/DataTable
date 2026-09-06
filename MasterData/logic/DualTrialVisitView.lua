-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualtrial/view/DualTrialVisitView.lua

module("logic.extensions.dualtrial.view.DualTrialVisitView", package.seeall)

local DualTrialVisitView = class("DualTrialVisitView", ViewComponent)

function DualTrialVisitView:ctor()
	DualTrialVisitView.super.ctor(self)
end

function DualTrialVisitView:unbindEvents()
	DualTrialVisitView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEnter)
end

function DualTrialVisitView:bindEvents()
	DualTrialVisitView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickbtnTip, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickbtnEnter, self)
end

function DualTrialVisitView:buildUI()
	DualTrialVisitView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnEnter = self:getGo("playerroot/btnEnter")
	self._playerroot = self:getGo("playerroot")
	self._blocklist = self:getGo("blocklist")
	self._posStart = self:getGo("posStart")
	self._cellBlockList = {}

	for i = 1, 9 do
		local cell = {}

		cell.go = self:getGo("blocklist/cell_" .. i)
		cell.pos = goutil.findChild(cell.go, "pos")
		cell.lock = goutil.findChild(cell.go, "lock")
		cell.unlock = goutil.findChild(cell.go, "unlock")
		self._cellBlockList[i] = cell
	end
end

function DualTrialVisitView:onExit()
	DualTrialVisitView.super.onExit(self)

	if self._lastTween then
		self._lastTween:Kill()

		self._lastTween = nil
	end
end

function DualTrialVisitView:onEnter()
	DualTrialVisitView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.DualTrialVisitBlock, self._handleStartVisit, self)
	self:_updateUIByCfg()
	self:_updateUIByInfo()

	self._isMoving = false

	if self._curBlockId <= 0 then
		DualTrialController.instance:visitBlock(self._activityId)
	end
end

function DualTrialVisitView:_updateUIByCfg()
	self._actCfg = DualTrialConfig.instance:getActivityCfgById(self._activityId)
	self._blockCfgs = DualTrialConfig.instance:getBlockCfgsById(self._activityId)

	for i, cell in ipairs(self._cellBlockList) do
		local cfg = self._blockCfgs[i]

		goutil.setActive(cell.go, cfg)
	end
end

function DualTrialVisitView:_updateUIByInfo()
	local info = DualTrialModel.instance:getInfoByActId(self._activityId)

	self._curBlockId = 0
	self._curFinishVisiteBlockIds = {}

	if info then
		self._curBlockId = checknumber(info.curBlockId)
		self._curFinishVisiteBlockIds = info.finishVisiteBlockIds or {}
	end

	for i, cfg in ipairs(self._blockCfgs) do
		local cell = self._cellBlockList[i]

		if cell then
			local isUnlock = table.keyof(self._curFinishVisiteBlockIds, i)

			goutil.setActive(cell.lock, not isUnlock)
			goutil.setActive(cell.unlock, isUnlock)

			if self._curBlockId == i then
				goutil.addChildToParent(self._playerroot, cell.pos)
				GameUtil.setAnchoredPos(self._playerroot, 0, 0)
				self._playerroot.transform:SetParent(self._posStart.transform)
				goutil.setActive(cell.lock, false)
				goutil.setActive(cell.unlock, false)
			end
		else
			printError("预制区域缺失" .. i)
		end
	end

	if self._curBlockId <= 0 then
		goutil.addChildToParent(self._playerroot, self._posStart)
	end
end

function DualTrialVisitView:_onClickbtnTip()
	local ruleKey = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(ruleKey)
end

function DualTrialVisitView:_onClickClose()
	self:close()
end

function DualTrialVisitView:_playMove()
	self._isMoving = true

	if self._lastTween then
		self._lastTween:Kill()

		self._lastTween = nil
	end

	self._lastTween = self._playerroot.transform:DOMove(self._cellBlockList[self._curBlockId].pos.transform.position, 1)

	self._lastTween:SetEase(DG.Tweening.Ease.Linear)
	self._lastTween:OnComplete(function()
		self._isMoving = false

		self:_updateUIByInfo()
		DualTrialController.instance:onepEventView(self._activityId, true)
	end)
end

function DualTrialVisitView:_handleStartVisit()
	local info = DualTrialModel.instance:getInfoByActId(self._activityId)

	self._curBlockId = 0

	if info then
		self._curBlockId = checknumber(info.curBlockId)

		self:_playMove()
	end

	self:_playMove()
end

function DualTrialVisitView:_onClickbtnEnter()
	if self._isMoving then
		return
	end

	DualTrialController.instance:onepEventView(self._activityId, false)
end

return DualTrialVisitView
