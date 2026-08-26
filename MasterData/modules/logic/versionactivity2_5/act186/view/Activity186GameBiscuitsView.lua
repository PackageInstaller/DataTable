-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186GameBiscuitsView.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186GameBiscuitsView", package.seeall)

local Activity186GameBiscuitsView = class("Activity186GameBiscuitsView", BaseView)

function Activity186GameBiscuitsView:onInitView()
	self.goUnopen = gohelper.findChild(self.viewGO, "unopen")
	self.goOpened = gohelper.findChild(self.viewGO, "opened")
	self.txtReward = gohelper.findChildTextMesh(self.viewGO, "opened/#txt_reward")
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186GameBiscuitsView:addEvents()
	self:addTouchEvents()
end

function Activity186GameBiscuitsView:removeEvents()
	if not gohelper.isNil(self._touchEventMgr) then
		TouchEventMgrHepler.remove(self._touchEventMgr)
	end
end

function Activity186GameBiscuitsView:_editableInitView()
	return
end

function Activity186GameBiscuitsView:onClickBtnClose()
	self:closeThis()
end

function Activity186GameBiscuitsView:onUpdateParam()
	return
end

function Activity186GameBiscuitsView:onOpen()
	self.config = self.viewParam.config
	self.act186Id = self.viewParam.act186Id
	self.actId = self.config.activityId
	self.id = self.config.id
	self.status = Activity186Enum.GameStatus.Start

	local status = Activity186SignModel.instance:getSignStatus(self.actId, self.act186Id, self.id)

	if status == Activity186Enum.SignStatus.Canplay then
		AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_help_switch)
		self.anim:Play("open")
		self:startGame()
	else
		self.anim:Play("open1")
		self:showResult()
	end
end

function Activity186GameBiscuitsView:startGame()
	self.status = Activity186Enum.GameStatus.Playing
end

function Activity186GameBiscuitsView:showResult()
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_tangren_cookies_open)

	self.status = Activity186Enum.GameStatus.Result

	Activity186Model.instance:setLocalPrefsState(Activity186Enum.LocalPrefsKey.SignMark, self.act186Id, self.id, 1)

	self.txtReward.text = luaLang(string.format("act186_signview_day%s", self.id))
end

function Activity186GameBiscuitsView:addTouchEvents()
	if self._touchEventMgr then
		return
	end

	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self.viewGO)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetOnlyTouch(true)
	self._touchEventMgr:SetOnClickCb(self.onClickBtnClose, self)
	self._touchEventMgr:SetOnDragEndCb(self._onDragEnd, self)
end

function Activity186GameBiscuitsView:_onDragEnd()
	if self.status == Activity186Enum.GameStatus.Playing then
		self.anim:Play("opened")
		self:showResult()
	end
end

function Activity186GameBiscuitsView:onClose()
	if self.status == Activity186Enum.GameStatus.Result and self.actId and self.id and ActivityType101Model.instance:isType101RewardCouldGet(self.actId, self.id) then
		Activity101Rpc.instance:sendGet101BonusRequest(self.actId, self.id)
	end
end

function Activity186GameBiscuitsView:onDestroyView()
	return
end

return Activity186GameBiscuitsView
