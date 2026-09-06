-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/view/DragonKingARuiShiClgRuleView.lua

module("logic.extensions.dragonkingaruishiclg.view.DragonKingARuiShiClgRuleView", package.seeall)

local DragonKingARuiShiClgRuleView = class("DragonKingARuiShiClgRuleView", ViewComponent)

function DragonKingARuiShiClgRuleView:ctor()
	DragonKingARuiShiClgRuleView.super.ctor(self)
end

function DragonKingARuiShiClgRuleView:unbindEvents()
	DragonKingARuiShiClgRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnShow)
end

function DragonKingARuiShiClgRuleView:bindEvents()
	DragonKingARuiShiClgRuleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)
end

function DragonKingARuiShiClgRuleView:buildUI()
	DragonKingARuiShiClgRuleView.super.buildUI(self)

	self._info = self:getGo("info")
	self._showGo = self:getGo("showGo")
	self._btnShow = self:getGo("showGo/btnShow")
	self._btnHide = self:getGo("info/btnHide")
	self._teamReviveTime = self:getGo("info/emenyFmt/teamEnemy")
	self._teamReviveList = {}

	for i = 1, 9 do
		local go = goutil.findChild(self._teamReviveTime, "cell_" .. i)

		self._teamReviveList[i] = goutil.findChildTextComponent(go, "txt")
	end
end

function DragonKingARuiShiClgRuleView:onExit()
	DragonKingARuiShiClgRuleView.super.onExit(self)
end

function DragonKingARuiShiClgRuleView:onEnter()
	DragonKingARuiShiClgRuleView.super.onEnter(self)

	local fmtMo = self:getFirstParam()
	local curCfg = DragonKingARuiShiClgConfig.instance:getStageCfg(fmtMo:getActivityId(), fmtMo:getStageId())

	for i = 1, 9 do
		self._teamReviveList[i].text = curCfg.reviveTime[i]
	end
end

function DragonKingARuiShiClgRuleView:_onClickHide()
	GameUtil.SetActive(self._info, false)
	GameUtil.SetActive(self._showGo, true)
end

function DragonKingARuiShiClgRuleView:_onClickShow()
	GameUtil.SetActive(self._info, true)
	GameUtil.SetActive(self._showGo, false)
end

return DragonKingARuiShiClgRuleView
