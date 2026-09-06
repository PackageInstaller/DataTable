-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/TeammateInfoView.lua

module("logic.extensions.formteam.view.TeammateInfoView", package.seeall)

local TeammateInfoView = class("TeammateInfoView", ViewComponent)

function TeammateInfoView:bindEvents()
	TeammateInfoView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._Btn_Info:AddClickListener(self._onClickInfo, self)
	self._Btn_AddFriend:AddClickListener(self._onClickAddFriend, self)
	self._Btn_Kick:AddClickListener(self._onClickKick, self)
end

function TeammateInfoView:unbindEvents()
	TeammateInfoView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._Btn_Info:RemoveClickListener()
	self._Btn_AddFriend:RemoveClickListener()
	self._Btn_Kick:RemoveClickListener()
end

function TeammateInfoView:buildUI()
	TeammateInfoView.super.buildUI(self)

	local Nego_Bottom = self:getGo("Nego_Content/Nego_Bottom")
	local Nego_Info = self:getGo("Nego_Content/Nego_Top/Nego_Info")

	self._closeButton = self:getBtn("Close")
	self._Btn_Info = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Info")
	self._Btn_AddFriend = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_AddFriend")
	self._Btn_Kick = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Kick")
	self._TxtC_Name = goutil.findChildComponent(Nego_Info, "TxtC_Name", "Text")
	self._TxtC_Zdl = goutil.findChildComponent(Nego_Info, "ImgZdl/TxtZdl", "Text")
	self._imageChange = self:getGo("Nego_Content/Nego_Top/Nego_Icon/ImgC_Icon")
end

function TeammateInfoView:onEnter()
	TeammateInfoView.super.onEnter(self)

	local params = self:getOpenParam()

	self._mo = params[1]
	self._clickGo = params[2]
	self._isTeammateLeader = params[3]
	self._isUserLeader = params[4]

	self:_refresh()
end

function TeammateInfoView:onExit()
	TeammateInfoView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._imageChange)
end

function TeammateInfoView:_refresh()
	goutil.setActive(self._Btn_Kick.gameObject, self._isUserLeader)

	self._TxtC_Name.text = self._mo.headInfo.userName
	self._TxtC_Zdl.text = self._mo.zdl

	HeadItemController.instance:setHeadCellByInfo(self._imageChange, self._mo.headInfo)
end

function TeammateInfoView:_checkInBattleOrAnswerQuestion()
	if SceneMgr.instance.isGogingToEnterBattleScene or AnswerSceneController.instance:isAnsweringQuestion() then
		FloatWordMgr.instance:show("该状态不可进行此操作!")

		return true
	end

	return false
end

function TeammateInfoView:_onClickClose()
	self:close()
end

function TeammateInfoView:_onClickInfo()
	if self:_checkInBattleOrAnswerQuestion() then
		return
	end

	self:close()
	RoleController.instance:openCardByUserId(self._mo.headInfo.userId)
end

function TeammateInfoView:_onClickAddFriend()
	FriendController.instance:addFriend(self._mo.headInfo.userId)
	self:close()
end

function TeammateInfoView:_onClickKick()
	self:close()

	local tip = lang("确定将该玩家踢出队伍吗？")

	TipsFacade.instance:openPopupWindow(lang("提示"), tip, function()
		FormTeamController.instance:kickTeammate(self._mo.headInfo.userId)
	end)
end

return TeammateInfoView
