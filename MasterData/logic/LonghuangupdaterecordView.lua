-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longhuang/LonghuangupdaterecordView.lua

module("logic.extensions.timelimitedchallenge.view.longhuang.LonghuangupdaterecordView", package.seeall)

local LonghuangupdaterecordView = class("LonghuangupdaterecordView", TLChallengeTipView)

function LonghuangupdaterecordView:ctor()
	LonghuangupdaterecordView.super.ctor(self)
end

function LonghuangupdaterecordView:buildUI()
	LonghuangupdaterecordView.super.buildUI(self)

	self._oldBuffCell = PanduolaBuffCell.New(self:getGo("effectOld"))
	self._newBuffCell = PanduolaBuffCell.New(self:getGo("effectNew"))
	self._txtTip = self:getTxt("txtTip")
end

function LonghuangupdaterecordView:onEnter()
	LonghuangupdaterecordView.super.onEnter(self)

	local oldBuffCfg, newBuffCfg = self._params.oldBuffCfg, self._params.newBuffCfg

	self._oldBuffCell:updateWithPanduolaBuffCfg(oldBuffCfg)
	self._newBuffCell:updateWithPanduolaBuffCfg(newBuffCfg)

	if oldBuffCfg.grade < newBuffCfg.grade then
		self._txtTip.text = "新纪录<color=#E1433FFF>优于</color>原纪录，更新战斗鼓舞等级！"
	else
		self._newBuffCell:updateWithPanduolaBuffCfg(oldBuffCfg)

		self._txtTip.text = "新纪录<color=#E1433FFF>没有优于</color>原纪录，保持原来的战斗鼓舞等级！"
	end
end

return LonghuangupdaterecordView
