-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/longhuang/LonghuanggameresultView.lua

module("logic.extensions.timelimitedchallenge.view.longhuang.LonghuanggameresultView", package.seeall)

local LonghuanggameresultView = class("LonghuanggameresultView", TLChallengeTipView)

function LonghuanggameresultView:buildUI()
	LonghuanggameresultView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._txtEffect = self:getTxt("effect/txtEffect")
end

function LonghuanggameresultView:onEnter()
	LonghuanggameresultView.super.onEnter(self)

	self._txtTime.text = string.format("%.2f<size=24><color=#ffffff>秒</color></size>", self._params.tickedTime)

	local buffCfg = self._params.newBuffCfg

	self._txtEffect.text = string.format("%s <size=30><color=#EB4642FF>%s</color></size> 级     %s", buffCfg.name, buffCfg.grade, buffCfg.desc)
end

function LonghuanggameresultView:_onClickOk()
	self:close()

	local oldBuffCfg = self._params.oldBuffCfg
	local newBuffCfg = self._params.newBuffCfg

	if oldBuffCfg ~= nil then
		if oldBuffCfg.grade < newBuffCfg.grade then
			UIStateManager.instance:push(ViewName.LonghuangupdaterecordView, self._params)
		else
			FloatWordMgr.instance:show("新记录没有优于原记录，保持原来的战斗鼓舞等级！")
		end
	end
end

return LonghuanggameresultView
