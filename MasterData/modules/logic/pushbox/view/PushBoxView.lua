-- chunkname: @modules/logic/pushbox/view/PushBoxView.lua

module("modules.logic.pushbox.view.PushBoxView", package.seeall)

local PushBoxView = class("PushBoxView", BaseView)

function PushBoxView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnup = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_up")
	self._btndown = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_down")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_right")
	self._btnrevertoperation = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_revert_operation")
	self._btnrevertgame = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_revert_game")
	self._btntaskreward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task_reward")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PushBoxView:addEvents()
	self._btnup:AddClickListener(self._btnupOnClick, self)
	self._btndown:AddClickListener(self._btndownOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnrevertoperation:AddClickListener(self._btnrevertoperationOnClick, self)
	self._btnrevertgame:AddClickListener(self._btnrevertgameOnClick, self)
	self._btntaskreward:AddClickListener(self._btntaskrewardOnClick, self)
end

function PushBoxView:removeEvents()
	self._btnup:RemoveClickListener()
	self._btndown:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnrevertoperation:RemoveClickListener()
	self._btnrevertgame:RemoveClickListener()
	self._btntaskreward:RemoveClickListener()
end

function PushBoxView:_btnrevertoperationOnClick()
	self._game_mgr:revertStep()
end

function PushBoxView:_btnrevertgameOnClick()
	self._game_mgr:revertGame()
end

function PushBoxView:_btntaskrewardOnClick()
	PushBoxRpc.instance:sendReceiveTaskRewardRequest(nil, 1)
end

function PushBoxView:_btnupOnClick()
	self:_walk(PushBoxGameMgr.Direction.Up)
end

function PushBoxView:_btndownOnClick()
	self:_walk(PushBoxGameMgr.Direction.Down)
end

function PushBoxView:_btnleftOnClick()
	self:_walk(PushBoxGameMgr.Direction.Left)
end

function PushBoxView:_btnrightOnClick()
	self:_walk(PushBoxGameMgr.Direction.Right)
end

function PushBoxView:_editableInitView()
	return
end

function PushBoxView:onUpdateParam()
	return
end

function PushBoxView:onOpen()
	self.viewContainer._navigateButtonView:setOverrideClose(self._onNavigateCloseCallback, self)

	self._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr

	self._game_mgr:startGame(1)
end

function PushBoxView:_onNavigateCloseCallback()
	self.viewContainer._navigateButtonView:setOverrideClose(nil, nil)
	self:closeThis()
	MainController.instance:enterMainScene()
end

function PushBoxView:_walk(direction)
	if not self._last_time then
		self._last_time = Time.time
	elseif Time.time - self._last_time < 0.2 then
		return
	end

	self._last_time = Time.time

	self._game_mgr:_onMove(direction)
end

function PushBoxView:onClose()
	return
end

function PushBoxView:onDestroyView()
	return
end

return PushBoxView
