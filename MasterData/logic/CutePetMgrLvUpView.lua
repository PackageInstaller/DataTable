-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetMgrLvUpView.lua

module("logic.extensions.cutepet.view.CutePetMgrLvUpView", package.seeall)

local CutePetMgrLvUpView = class("CutePetMgrLvUpView", ViewComponent)

function CutePetMgrLvUpView:ctor()
	CutePetMgrLvUpView.super.ctor(self)
end

function CutePetMgrLvUpView:unbindEvents()
	CutePetMgrLvUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CutePetMgrLvUpView:bindEvents()
	CutePetMgrLvUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CutePetMgrLvUpView:buildUI()
	CutePetMgrLvUpView.super.buildUI(self)

	self._txtStoreLimitLeft = self:getTxt("storelimit/txt_left_num")
	self._txtStoreLimitRight = self:getTxt("storelimit/txt_right_num")
	self._btnClose = self:getBtn("bg")
end

local effPaths = {
	{
		loop = true,
		goPath = "point_tishengchenggong",
		path = "fx_ui_tishengchenggong/fx_ui_tishengchenggong.prefab"
	},
	{
		loop = true,
		goPath = "point_bg",
		path = "fx_ui_huodejiangli/fx_ui_huodejiangli_bg.prefab"
	}
}

function CutePetMgrLvUpView:onExit()
	CutePetMgrLvUpView.super.onExit(self)

	if self._effs then
		for _, eff in ipairs(self._effs) do
			UIEffectManager.instance:stopEffect(eff)

			eff = nil
		end
	end
end

function CutePetMgrLvUpView:onEnter()
	CutePetMgrLvUpView.super.onEnter(self)

	self._effs = UIEffectManager.instance:playHudEffects(effPaths, self.mainGO)

	local params = self:getOpenParam()

	self._txtStoreLimitLeft.text = params[1]
	self._txtStoreLimitRight.text = params[2]
end

return CutePetMgrLvUpView
