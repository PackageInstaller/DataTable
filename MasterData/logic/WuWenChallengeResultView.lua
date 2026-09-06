-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/WuWenChallengeResultView.lua

module("logic.extensions.wuwenchallenge.view.WuWenChallengeResultView", package.seeall)

local WuWenChallengeResultView = class("WuWenChallengeResultView", ViewComponent)

function WuWenChallengeResultView:ctor()
	WuWenChallengeResultView.super.ctor(self)
end

function WuWenChallengeResultView:unbindEvents()
	WuWenChallengeResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function WuWenChallengeResultView:bindEvents()
	WuWenChallengeResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function WuWenChallengeResultView:buildUI()
	WuWenChallengeResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tabelList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function WuWenChallengeResultView:onExit()
	WuWenChallengeResultView.super.onExit(self)
end

function WuWenChallengeResultView:onEnter()
	WuWenChallengeResultView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._info = WuWenChallengeModel.instance:getFightInfo(self._activityId)

	self._tabelList:setCenterMode(true)
	self._tabelList:reloadData(self._info.curFightPetHpRateInfo)
end

function WuWenChallengeResultView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local txt = goutil.findChildTextComponent(go, "txt")
	local txtColorChange = goutil.findChildComponent(go, "txt", "UITextColorChange")
	local petId = data.left
	local rate = data.right
	local proxy = MaterialMgr.setCellByGId(MatType.Pet, petId, con)

	if proxy then
		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:openMaterialTips(con, MatType.Pet, petId)
		end)
	end

	if rate > 0 then
		txtColorChange:SetState(0)

		txt.text = langPara("%d", rate) .. "%"
	else
		txtColorChange:SetState(1)

		txt.text = langPara("%d", 0) .. "%"
	end
end

function WuWenChallengeResultView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function WuWenChallengeResultView:_onClickSure()
	WuWenClgAgent.instance:sendPM_WuWenClgFightConfirmReq(self._activityId, self._info.confirmNum, true)
	self:close()
end

function WuWenChallengeResultView:_onClickCancel(...)
	WuWenClgAgent.instance:sendPM_WuWenClgFightConfirmReq(self._activityId, self._info.confirmNum, false)
	self:close()
end

return WuWenChallengeResultView
