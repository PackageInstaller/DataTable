-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirePowerContestRecordView.lua

module("logic.extensions.firepowercontest.view.FirePowerContestRecordView", package.seeall)

local FirePowerContestRecordView = class("FirePowerContestRecordView", TableViewComponent)

function FirePowerContestRecordView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "Scrl"
	}
end

function FirePowerContestRecordView:ctor()
	FirePowerContestRecordView.super.ctor(self)
end

function FirePowerContestRecordView:unbindEvents()
	FirePowerContestRecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FirePowerContestRecordView:bindEvents()
	FirePowerContestRecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FirePowerContestRecordView:buildUI()
	FirePowerContestRecordView.super.buildUI(self)

	self._btnClose = self:getBtn("Btn_close")
	self._nodata = self:getGo("nodata")
end

function FirePowerContestRecordView:onExit()
	FirePowerContestRecordView.super.onExit(self)
	FirePowerContestController.instance:unregisterLocalNotify(FirePowerContestController.AfterGetRecord, self._updateRecord, self)
end

function FirePowerContestRecordView:onEnter()
	FirePowerContestRecordView.super.onEnter(self)

	self._activityConf = FirePowerContestConfig.instance:getGameActivityConf()

	if not self._activityConf then
		self:close()
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))

		return
	end

	goutil.setActive(self._nodata, true)
	goutil.setActive(self._cell, false)

	self._defaultWinScore = self._activityConf.winScore

	local actId = FirePowerContestConfig.instance:getActId()

	if actId > 0 then
		FirePowerContestController.instance:registerLocalNotify(FirePowerContestController.AfterGetRecord, self._updateRecord, self)
		FirePowerContestAgent.instance:sendPM_FPCGetGameRecordReq(actId)
	end
end

function FirePowerContestRecordView:_updateRecord(params)
	local infos = params.infos

	goutil.setActive(self._nodata, #infos <= 0)
	self:updateListData(infos)
end

function FirePowerContestRecordView:_cellSize()
	return 870, 90
end

function FirePowerContestRecordView:_updateCell(view, cell, data)
	data = data.infos

	local leftGo = goutil.findChild(cell, "Head_Left")
	local txtLeftDetail = goutil.findChildTextComponent(leftGo, "Txt_Detail")
	local imgLeftTagGo = goutil.findChild(leftGo, "Img_Tag")
	local imgLeftTag = imgLeftTagGo:GetComponent("UIImageSpriteChange")
	local imgLeftHead = goutil.findChild(leftGo, "Img_Head")
	local txtLeftName = goutil.findChildTextComponent(leftGo, "Txt_Name")
	local rightGo = goutil.findChild(cell, "Head_Right")
	local txtRightDetail = goutil.findChildTextComponent(rightGo, "Txt_Detail")
	local imgRightTagGo = goutil.findChild(rightGo, "Img_Tag")
	local imgRightTag = imgRightTagGo:GetComponent("UIImageSpriteChange")
	local imgRightHead = goutil.findChild(rightGo, "Img_Head")
	local txtRightName = goutil.findChildTextComponent(rightGo, "Txt_Name")
	local rivalUserInfo, myUserInfo

	if checknumber(data[2].userId) == checknumber(LoginModel.instance.userId) then
		myUserInfo = data[2]
		rivalUserInfo = data[1]
	else
		myUserInfo = data[1]
		rivalUserInfo = data[2]
	end

	HeadItemController.instance:setHeadCellByInfo(imgRightHead, {
		headIconId = rivalUserInfo.iconId,
		headFrameId = rivalUserInfo.frameId
	})
	HeadItemController.instance:setMyHeadCell(imgLeftHead)

	txtLeftName.text = myUserInfo.userName
	txtRightName.text = rivalUserInfo.userName

	goutil.setActive(imgLeftTagGo, true)
	goutil.setActive(imgRightTagGo, true)

	if myUserInfo.score > rivalUserInfo.score then
		imgLeftTag:SetState(0)
		goutil.setActive(imgRightTagGo, false)
	elseif myUserInfo.score == rivalUserInfo.score then
		imgLeftTag:SetState(1)
		imgRightTag:SetState(1)
	else
		goutil.setActive(imgLeftTagGo, false)
		imgRightTag:SetState(0)
	end

	txtLeftDetail.text = langPara("FirePowerContestRecordView__1", myUserInfo.score)
	txtRightDetail.text = langPara("FirePowerContestRecordView__2", rivalUserInfo.score)
end

function FirePowerContestRecordView:_clearTableview(cell)
	local imgLeftHead = goutil.findChild(cell, "Head_Left/Img_Head")
	local imgRightHead = goutil.findChild(cell, "Head_Right/Img_Head")

	HeadItemController.instance:resetHeadCell(imgLeftHead)
	HeadItemController.instance:resetHeadCell(imgRightHead)
end

return FirePowerContestRecordView
