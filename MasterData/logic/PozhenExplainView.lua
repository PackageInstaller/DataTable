-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/PozhenExplainView.lua

module("logic.extensions.breakformation.view.PozhenExplainView", package.seeall)

local PozhenExplainView = class("PozhenExplainView", ViewComponent)

function PozhenExplainView:ctor()
	PozhenExplainView.super.ctor(self)
end

function PozhenExplainView:bindEvents()
	GameUtil.asBtn(self.viewCloseBtn):AddClickListener(function()
		self:close()
	end, self)
end

function PozhenExplainView:unbindEvents()
	GameUtil.asBtn(self.viewCloseBtn):RemoveClickListener()
end

function PozhenExplainView:buildUI()
	PozhenExplainView.super.buildUI(self)

	self.viewCloseBtn = self:getBtn("viewCloseBtn")
	self.putongShowGo = self:getGo("viewInfoTran/putongShow")
	self.ptGoodsShowGo = goutil.findChild(self.putongShowGo, "ptGoodsShow")
	self.jinduShowGo = self:getGo("viewInfoTran/jinduShow")
	self.jdGoodsShowGo = goutil.findChild(self.jinduShowGo, "jdGoodsShow")
	self.paihangShowGo = self:getGo("viewInfoTran/paihangShow")
	self.phGoodsShowGo = goutil.findChild(self.paihangShowGo, "phGoodsShow")
end

function PozhenExplainView:destroyUI()
	return
end

function PozhenExplainView:onEnter()
	local ptGoodsStr = BreakFormationModel.instance:GetExplainViewRewardList(1)

	if ptGoodsStr ~= nil and ptGoodsStr ~= "" then
		MaterialMgr.setCellListByCfg(ptGoodsStr, self.ptGoodsShowGo)
	end

	local jdGoodsStr = BreakFormationModel.instance:GetExplainViewRewardList(2)

	if jdGoodsStr ~= nil and jdGoodsStr ~= "" then
		MaterialMgr.setCellListByCfg(jdGoodsStr, self.jdGoodsShowGo)
	end

	local phGoodsStr = BreakFormationModel.instance:GetExplainViewRewardList(3)

	if phGoodsStr ~= nil and phGoodsStr ~= "" then
		MaterialMgr.setCellListByCfg(phGoodsStr, self.phGoodsShowGo)
	end
end

function PozhenExplainView:onEnterFinished()
	return
end

function PozhenExplainView:onExit()
	return
end

function PozhenExplainView:onExitFinished()
	return
end

return PozhenExplainView
