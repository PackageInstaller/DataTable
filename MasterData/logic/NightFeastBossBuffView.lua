-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossBuffView.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossBuffView", package.seeall)

local NightFeastBossBuffView = class("NightFeastBossBuffView", ViewComponent)

function NightFeastBossBuffView:ctor()
	NightFeastBossBuffView.super.ctor(self)
end

function NightFeastBossBuffView:buildUI()
	NightFeastBossBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnReset = self:getBtn("btnReset")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._coinIcon = self:getGo("buffPoint/coinIcon")
	self._txtNum = self:getTxt("buffPoint/txtNum")
	self._txt1 = self:getTxt("buffPoint/txt1")
end

function NightFeastBossBuffView:bindEvents()
	NightFeastBossBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function NightFeastBossBuffView:unbindEvents()
	NightFeastBossBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
end

function NightFeastBossBuffView:onEnter()
	NightFeastBossBuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.NightFeastBossClgGetInfoRes, self._onGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.NightFeastBossClgResetBuffRes, self._onResetBuffRes, self)
	self.addGEvent(self, GlobalNotify.NightFeastBossClgLvlUpBuffRes, self._onLvlUpBuffRes, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = NightFeastBossConfig.instance:getActivityCfg(self._activityId)
	self._maxResetBuffCount = self._cfgActivity.dailyResetBuffCount

	self:_initBuffPoint()
	self:_updateBuffList()
end

function NightFeastBossBuffView:onExit()
	NightFeastBossBuffView.super.onExit(self)
	self._scrollList:dispose()
	self:_clearBuffIcon()
end

function NightFeastBossBuffView:_onClickReset()
	local isCanReset = NightFeastBossModel.instance:isCanResetBuffPoint(self._activityId)

	if not isCanReset then
		FloatWordMgr.instance:show("无需重置技能点")

		return
	end

	local curCount = NightFeastBossModel.instance:todayResetBuffCount(self._activityId)
	local maxCount = self._maxResetBuffCount

	if maxCount <= curCount then
		FloatWordMgr.instance:show("无重置次数")

		return
	end

	local text = string.format("即将重置所有buff并返还%s\n每日05:00后均有%d次机会\n(今日剩余：%d)", self._cfgActivity.buffPointName, maxCount, Mathf.Max(0, maxCount - curCount))

	local function okFunc()
		NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgResetBuffReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, cencelFunc, okFuncText, cancelFuncText, UnityEngine.TextAnchor.MiddleCenter)
end

function NightFeastBossBuffView:_onGetInfoRes()
	self:_updateBuffList()
end

function NightFeastBossBuffView:_onResetBuffRes()
	self:_updateBuffList()
end

function NightFeastBossBuffView:_onLvlUpBuffRes()
	self:_updateBuffList()
end

function NightFeastBossBuffView:_updateBuffList()
	local list = NightFeastBossConfig.instance:getBuffCfgsList(self._activityId)

	self._scrollList:reloadData(list)
	self:_updateBuffPoint()
end

function NightFeastBossBuffView:_updateCell(view, cell, data, tag)
	local component = GameUtil.AddLuaOnce(cell.gameObject, NightFeastBossBuffCell)

	component:init(data)
end

function NightFeastBossBuffView:clearCell(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, NightFeastBossBuffCell)

	component:clear()
end

function NightFeastBossBuffView:_initBuffPoint()
	local iconPath = self._cfgActivity.buffIconPath

	uGuiUtil.setSpriteToImage(self._coinIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(iconPath))

	self._txt1.text = string.format("%s：", self._cfgActivity.buffPointName)
end

function NightFeastBossBuffView:_clearBuffIcon()
	uGuiUtil.clearImage(self._coinIcon)
end

function NightFeastBossBuffView:_updateBuffPoint()
	local leftNum = NightFeastBossModel.instance:getLeftBuffPoint(self._activityId)

	self._txtNum.text = string.format("x%d", leftNum)
end

return NightFeastBossBuffView
