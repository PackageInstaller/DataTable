-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/PkmainView.lua

module("logic.extensions.pk.view.PkmainView", package.seeall)

local PkmainView = class("PkmainView", ViewComponent)

function PkmainView:ctor()
	PkmainView.super.ctor(self)
end

function PkmainView:unbindEvents()
	PkmainView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnJoin:RemoveClickListener()
	self._btnCreate:RemoveClickListener()
	self._btnBattleList:RemoveClickListener()
	self._btnSetFmt:RemoveClickListener()
end

function PkmainView:bindEvents()
	PkmainView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnJoin:AddClickListener(self._onClickbtnJoin, self)
	self._btnCreate:AddClickListener(self._onClickbtnCreate, self)
	self._btnBattleList:AddClickListener(self._onClickBattleList, self)
	self._btnSetFmt:AddClickListener(self._onClickbtnSetFmt, self)
end

function PkmainView:buildUI()
	PkmainView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnClose = self:getBtn("btnClose")
	self._btnJoin = self:getBtn("btnJoin")
	self._btnCreate = self:getBtn("btnCreate")
	self._btnBattleList = self:getBtn("btnBattleList")
	self._btnBattleRed = self:getGo("btnBattleList/red_point")
	self._goPopupMsg = self:getGo("popupMsg")

	goutil.setActive(self._goPopupMsg, false)

	self._goPopupMsgContainer = goutil.findChild(self._goPopupMsg, "tableview/Viewport/Content")
	self._btnSetFmt = self:getBtn("btnSetFmt")
	self._setFmtRedpointGo = self:getGo("btnSetFmt/redpoint")
end

function PkmainView:onExit()
	PkmainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._btnBattleRed)
	RedPointController.instance:unregRedPoint(self._setFmtRedpointGo)
	self:_destroyPopMsgs()
end

function PkmainView:onEnter()
	PkmainView.super.onEnter(self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_FightSwitchInfoRes, self._onTC_FightSwitchInfoRes, self)
	self.addGEvent(self, GlobalNotify.PopupMsgReqAddView, self._onAddPopMsg, self)
	self.addGEvent(self, GlobalNotify.PopupMsgReqDelView, self._onDelPopMsg, self)
	self.addGEvent(self, GlobalNotify.PopupMsgReqDestroySelf, self._onDestroyPopMsgCell, self)
	TraincampqiecuoModel.instance:setDefenseForm()
	RedPointController.instance:regRedPoint(self._btnBattleRed, RedPointModel.ID_PK)
	RedPointController.instance:regRedPoint(self._setFmtRedpointGo, RedPointModel.ID_PK_SETFMT_RED)
	TraincampdefenseController.instance:getFormData()
	self:_initPopupMsg()
end

function PkmainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("pkmainview")
end

function PkmainView:_onClickbtnClose()
	self:close()
end

function PkmainView:_onClickbtnJoin()
	UIStateManager.instance:push(ViewName.PkjoinView)
end

function PkmainView:_onClickbtnCreate()
	UIStateManager.instance:push(ViewName.PkcreateroomView)
end

function PkmainView:_onClickBattleList()
	self._needClickBattleList = false

	if SceneMgr.instance.isGogingToEnterBattleScene then
		FloatWordMgr.instance:show("该状态不可进行此操作!")

		return
	end

	if not FuncOpenModel.instance:getFuncIsOpen(230) then
		FloatWordMgr.instance:show(FuncOpenModel:getFuncLockDescription(230))

		return
	end

	local switch, stranger = TraincampqiecuoModel.instance:getPkSwitch()

	if switch == nil then
		self._needClickBattleList = true

		TrainCampQieCuoAgent.instance:sendPM_TC_FightSwitchInfoReq()

		return
	end

	if switch then
		UIStateManager.instance:push(ViewName.PkListView)
	else
		TipsFacade.instance:openPopupWindow(lang("tip"), "你关闭了切磋挑战的申请,是否前往设置？", function()
			self:close()
			UIStateManager.instance:push(ViewName.SystemSetting, 4)
		end, nil, "前往")
	end
end

function PkmainView:_onClickbtnSetFmt()
	TraincampdefenseController.instance:openSetDefenseForm()
end

function PkmainView:_onTC_FightSwitchInfoRes()
	if self._needClickBattleList then
		self._needClickBattleList = false

		self:_onClickBattleList()
	end
end

function PkmainView:_initPopupMsg()
	self:_destroyPopMsgs()

	local queue = MainUIPopupMsgController.instance:getQueue()

	self._msgCells = {}

	for i, data in ipairs(queue) do
		if data.invateFromTrainQiecuo then
			self:_addOnePopupMsg(data)
		end
	end

	self:_invalidatePopMsg()
end

function PkmainView:_addOnePopupMsg(data)
	trycall(function()
		local cellTemplate = self:getGo(data.info.cellName)

		if cellTemplate and data.info.class then
			if data.info.cd == nil and data.info.showInitCD then
				data.info.cd = data.info.showInitCD + ServerTime.now()
				data.cd = data.info.cd
			end

			if data.info.cd and (data.info.cd <= 0 or data.info.cd - ServerTime.now() > 0) or data.info.showInitCD then
				local cell = goutil.cloneAndSetParent(cellTemplate, self._goPopupMsgContainer.transform)

				goutil.setActive(cell, true)

				local instance = data.info.class.New(cell, data)

				instance:startup()

				self._msgCells[data.key] = instance
			else
				dump(data.info)
			end
		else
			printError("cellTemplate or class is nil")
		end
	end)
end

function PkmainView:_destroyPopMsgs()
	if self._msgCells then
		for id, instance in pairs(self._msgCells) do
			instance:dispose()
		end

		self._msgCells = nil
	end

	self:_invalidatePopMsg()
end

function PkmainView:_onAddPopMsg(data)
	if not data.info.invateFromTrainQiecuo then
		return
	end

	self:_addOnePopupMsg(data)
	self:_invalidatePopMsg()
end

function PkmainView:_onDelPopMsg(data)
	self:_onDestroyPopMsgCell(data)
end

function PkmainView:_onDestroyPopMsgCell(data)
	local instance = self._msgCells[data.key]

	if instance then
		instance:dispose()

		self._msgCells[data.key] = nil

		self:_invalidatePopMsg()
		MainUIPopupMsgController.instance:removePopMsg(data.key)
	end
end

function PkmainView:_invalidatePopMsg()
	local bEmpty = true

	if self._msgCells then
		for i, v in pairs(self._msgCells) do
			bEmpty = false

			break
		end
	end

	goutil.setActive(self._goPopupMsg, not bEmpty)
end

return PkmainView
