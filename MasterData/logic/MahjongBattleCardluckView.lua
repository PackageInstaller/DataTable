-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleCardluckView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleCardluckView", package.seeall)

local MahjongBattleCardluckView = class("MahjongBattleCardluckView", ViewComponent)

function MahjongBattleCardluckView:ctor()
	MahjongBattleCardluckView.super.ctor(self)
end

function MahjongBattleCardluckView:unbindEvents()
	MahjongBattleCardluckView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function MahjongBattleCardluckView:bindEvents()
	MahjongBattleCardluckView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function MahjongBattleCardluckView:buildUI()
	MahjongBattleCardluckView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._txtTitle = self:getTxt("info/txtTitle")
	self._imgIcon = self:getGo("info/imgIcon")
end

function MahjongBattleCardluckView:onExit()
	MahjongBattleCardluckView.super.onExit(self)
	uGuiUtil.clearImage(self._imgIcon)
end

function MahjongBattleCardluckView:onEnter()
	MahjongBattleCardluckView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 571001
	end

	self:_updateUIByInfo()
end

function MahjongBattleCardluckView:_updateUIByInfo()
	self._todayCardLuckId = 0

	local baseInfo = MahjongBattleModel.instance:getBaseInfoByActId(self._activityId)

	if baseInfo then
		self._todayCardLuckId = baseInfo.todayCardLuckId or 0
	end

	local cardLuckCfg = MahjongBattleConfig.instance:getCardLuckCfgById(self._activityId, self._todayCardLuckId)

	if cardLuckCfg then
		self._txtTitle.text = cardLuckCfg.buffName or ""
		self._txtDesc.text = cardLuckCfg.showDesc or ""

		local spriteName = GameUrl.getIconUrl(cardLuckCfg.buffIcon)

		uGuiUtil.setSpriteToImage(self._imgIcon, nil, spriteName)
	else
		self:close()
	end
end

return MahjongBattleCardluckView
