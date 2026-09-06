-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazyPartnerTaskView.lua

module("logic.extensions.crazypartner.view.CrazyPartnerTaskView", package.seeall)

local CrazyPartnerTaskView = class("CrazyPartnerTaskView", TableViewComponent)

function CrazyPartnerTaskView:ctor()
	CrazyPartnerTaskView.super.ctor(self)
end

function CrazyPartnerTaskView:_getPath()
	return {
		cellPath = "middle/cell",
		viewPath = "middle/tableview"
	}
end

function CrazyPartnerTaskView:unbindEvents()
	CrazyPartnerTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CrazyPartnerTaskView:bindEvents()
	CrazyPartnerTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CrazyPartnerTaskView:buildUI()
	CrazyPartnerTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function CrazyPartnerTaskView:onExit()
	CrazyPartnerTaskView.super.onExit(self)
	CrazyPartnerController.instance:unregisterLocalNotify(CrazyPartnerController.AfterGetInfoResponse, self._updateUI, self)
end

function CrazyPartnerTaskView:onEnter()
	CrazyPartnerTaskView.super.onEnter(self)
	CrazyPartnerController.instance:registerLocalNotify(CrazyPartnerController.AfterGetInfoResponse, self._updateUI, self)
	self:_updateUI()
end

function CrazyPartnerTaskView:_updateUI()
	local taskConfs = CrazyPartnerConfig.instance:getTaskConfs()

	self:updateListData(taskConfs)
end

function CrazyPartnerTaskView:_updateCell(view, cell, data)
	local pass = goutil.findChild(cell, "pass")
	local noPass = goutil.findChild(cell, "noPass")
	local imgTag = goutil.findChild(cell, "imgTag"):GetComponent("UIImageSpriteChange")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local info = CrazyPartnerModel.instance:getDifficultyInfoByIndex(data.difficulty) or {}
	local bFinishTask = info.finishTask
	local conf = data.conf

	pass:SetActive(bFinishTask)
	noPass:SetActive(not bFinishTask)
	imgTag:SetState(conf.difficulty - 1)

	txtDesc.text = conf.desc
	txtScore.text = string.format("积分+%d", conf.score)
end

function CrazyPartnerTaskView:_clearTableview(cell)
	return
end

return CrazyPartnerTaskView
