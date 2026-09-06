-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeChapter4ResultView.lua

module("logic.extensions.luyngarde.view.LuyngardeChapter4ResultView", package.seeall)

local LuyngardeChapter4ResultView = class("LuyngardeChapter4ResultView", ViewComponent)

function LuyngardeChapter4ResultView:ctor()
	LuyngardeChapter4ResultView.super.ctor(self)
end

function LuyngardeChapter4ResultView:unbindEvents()
	LuyngardeChapter4ResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LuyngardeChapter4ResultView:bindEvents()
	LuyngardeChapter4ResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function LuyngardeChapter4ResultView:buildUI()
	LuyngardeChapter4ResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txt = self:getTxt("txt")
	self._txtTitle = self:getTxt("txtTitle")
end

function LuyngardeChapter4ResultView:onExit()
	LuyngardeChapter4ResultView.super.onExit(self)
end

function LuyngardeChapter4ResultView:onEnter()
	LuyngardeChapter4ResultView.super.onEnter(self)

	local info = self:getFirstParam()

	if info.leftHp <= 0 then
		self._txt.text = "已击杀敌阵boss，boss剩余血量为0，挑战失败。\n在不击杀敌阵精灵的条件下，其血量越接近0成绩越好。"
		self._txtTitle.text = "挑战失败"
	else
		self._txt.text = string.format("对Boss造成总伤害：<color=#eb4642>%s</color>\nBoss剩余血量：<color=#eb4642>%s</color>", info.damage, info.leftHp)
		self._txtTitle.text = "挑战成功"
	end
end

function LuyngardeChapter4ResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

return LuyngardeChapter4ResultView
