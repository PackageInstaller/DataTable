-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/PozhenTipsView.lua

module("logic.extensions.breakformation.view.PozhenTipsView", package.seeall)

local PozhenTipsView = class("PozhenTipsView", ViewComponent)

function PozhenTipsView:ctor()
	PozhenTipsView.super.ctor(self)
end

function PozhenTipsView:bindEvents()
	GameUtil.asBtn(self.viewCloseGo):AddClickListener(function()
		self:close()
	end, self)
	self._btnSure:AddClickListener(self.close, self)
end

function PozhenTipsView:unbindEvents()
	GameUtil.asBtn(self.viewCloseGo):RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function PozhenTipsView:buildUI()
	PozhenTipsView.super.buildUI(self)

	self.viewCloseGo = self:getGo("viewMaskIma")
	self.jrgmsycsTxt = goutil.findChildComponent(self.mainGO, "viewBgIma/jrgmsycsTxt", "Text")
	self.gmxhtsTxt = goutil.findChildComponent(self.mainGO, "viewBgIma/gmxhtsTxt", "Text")
	self.jrgmsycsTxt.text = ""
	self.gmxhtsTxt.text = ""
	self._btnSure = self:getBtn("btn_Sure")
end

function PozhenTipsView:destroyUI()
	return
end

function PozhenTipsView:onEnter()
	local count = 1

	if self._viewPresentor._openParam then
		count = self._viewPresentor._openParam[1]
	end

	self.jrgmsycsTxt.text = "最佳纪录更新！"

	local cfg = BreakFormationConfig.instance:GetPozhenTeamCfg()

	self.gmxhtsTxt.text = cfg and "本次挑战<color=#0068b7ff>" .. cfg.conditionDesc .. "：" .. count .. "</color>" or "本次最佳数据：<color=#0068b7ff>" .. count .. "</color>"
end

function PozhenTipsView:onEnterFinished()
	return
end

function PozhenTipsView:onExit()
	return
end

function PozhenTipsView:onExitFinished()
	return
end

return PozhenTipsView
