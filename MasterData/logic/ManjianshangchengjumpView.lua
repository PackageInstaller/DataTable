-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/manjianshangcheng/ManjianshangchengjumpView.lua

module("logic.extensions.bonus.view.manjianshangcheng.ManjianshangchengjumpView", package.seeall)

local ManjianshangchengjumpView = class("ManjianshangchengjumpView", SummarySubTabView)

function ManjianshangchengjumpView:buildBtnJump()
	self.btnJump[1] = self:getGo("btnGoto")

	for _, cfg in pairs(self._cfgs) do
		GameUtil.addClickHandler(self.btnJump[cfg.id], GameUtil.handler(self._onJump, self, cfg))
	end
end

function ManjianshangchengjumpView:thisViewName()
	return ViewName.ManjianshangchengjumpView
end

return ManjianshangchengjumpView
