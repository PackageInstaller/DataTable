-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGloryruleView.lua

module("logic.extensions.recastglory.view.RecastGloryruleView", package.seeall)

local RecastGloryruleView = class("RecastGloryruleView", ViewComponent)

function RecastGloryruleView:ctor()
	RecastGloryruleView.super.ctor(self)
end

function RecastGloryruleView:unbindEvents()
	RecastGloryruleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function RecastGloryruleView:bindEvents()
	RecastGloryruleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function RecastGloryruleView:buildUI()
	RecastGloryruleView.super.buildUI(self)

	self._ruleImagL = self:getGo("ruleImagL")
	self._ruleImagR = self:getGo("ruleImagR")
	self._txtRuleL = self:getTxt("txtRuleL")
	self._txtRuleR = self:getTxt("txtRuleR")
	self._btnSure = self:getBtn("btnSure")
end

function RecastGloryruleView:onExit()
	RecastGloryruleView.super.onExit(self)
	uGuiUtil.clearImage(self._ruleImagL)
	uGuiUtil.clearImage(self._ruleImagR)
end

function RecastGloryruleView:onEnter()
	RecastGloryruleView.super.onEnter(self)

	local params = self:getOpenParam()

	self._ruleId = checknumber(params[1])
	self._ruleData = RecastGloryConfig.instance:getGloryRuleCfg(self._ruleId)
	self._txtRuleL.text = self._ruleData.descL
	self._txtRuleR.text = self._ruleData.descR

	uGuiUtil.setSpriteToImage(self._ruleImagL, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("recastglory", self._ruleData.ImgpathL))
	uGuiUtil.setSpriteToImage(self._ruleImagR, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("recastglory", self._ruleData.ImgpathR))
end

return RecastGloryruleView
