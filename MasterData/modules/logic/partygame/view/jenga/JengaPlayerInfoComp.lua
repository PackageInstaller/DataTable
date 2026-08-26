-- chunkname: @modules/logic/partygame/view/jenga/JengaPlayerInfoComp.lua

module("modules.logic.partygame.view.jenga.JengaPlayerInfoComp", package.seeall)

local JengaPlayerInfoComp = class("JengaPlayerInfoComp", PlayerInfoComp)

function JengaPlayerInfoComp:onInitView()
	self.viewGO = self.viewGO.transform.parent.gameObject

	JengaPlayerInfoComp.super.onInitView(self)
end

function JengaPlayerInfoComp:getItemCls()
	return JengaPlayerInfoItem
end

return JengaPlayerInfoComp
