-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenTipsView.lua

module("logic.extensions.dragonawaken.view.DragonAwakenTipsView", package.seeall)

local DragonAwakenTipsView = class("DragonAwakenTipsView", ViewComponent)

function DragonAwakenTipsView:ctor()
	DragonAwakenTipsView.super.ctor(self)
end

function DragonAwakenTipsView:unbindEvents()
	DragonAwakenTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._goBtn1)
	GameUtil.rmClickHandler(self._goBtn2)
end

function DragonAwakenTipsView:bindEvents()
	DragonAwakenTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._goBtn1, self._onClickSure, self)
	GameUtil.addClickHandler(self._goBtn2, self._onClickCancel, self)
end

function DragonAwakenTipsView:buildUI()
	DragonAwakenTipsView.super.buildUI(self)

	self._goBtn1 = self:getGo("Btns/Btn1")
	self._goBtn2 = self:getGo("Btns/Btn2")
	self._txtShow = self:getTxt("txtShow")
	self._goTableview = self:getGo("prizeCom/tableview")
	self._goItem = self:getGo("prizeCom/item")
	self._tableview = ScrollerList.create(self._goTableview, self._goItem, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DragonAwakenTipsView:onExit()
	DragonAwakenTipsView.super.onExit(self)
	self._tableview:dispose()
end

function DragonAwakenTipsView:onEnter()
	DragonAwakenTipsView.super.onEnter(self)

	local result = self:getFirstParam()

	self._activityId = checknumber(result.activityId)
	self._isWin = result.isWin
	self._curHard = result.hard

	local trainCfg = DragonAwakenConfig.instance:getTrainingCfgByHard(self._activityId, self._curHard)
	local prizeStr = trainCfg and trainCfg.prize
	local arr = string.split(prizeStr, "#")

	self._tableview:setCenterMode(true)
	self._tableview:reloadData(arr)

	if self._isWin then
		self._txtShow.text = "是否需要保存本次战斗结果？保存后获得以下奖励"

		goutil.setActive(self._goTableview, true)
	else
		self._txtShow.text = "是否需要保存本次关卡，以便再次挑战？"

		goutil.setActive(self._goTableview, false)
	end
end

function DragonAwakenTipsView:_onClickSure()
	if self._isWin then
		DragonAwakenController.instance:confirmTrainingResult(self._activityId)
	end

	self:close()
end

function DragonAwakenTipsView:_onClickCancel()
	if not self._isWin then
		DragonAwakenController.instance:randomTrainingForm(self._activityId, self._curHard)
	else
		DragonAwakenModel.instance:resetCurTrainingHard(self._activityId)
		GlobalDispatcher:dispatch(GlobalNotify.DragonAwakenUpdateTrainInfo)
	end

	self:close()
end

function DragonAwakenTipsView:_updateCell(view, cell, data)
	local pos = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.setCellByCfg(data, pos)
end

function DragonAwakenTipsView:_clearCell(cell)
	local pos = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(pos)
end

return DragonAwakenTipsView
