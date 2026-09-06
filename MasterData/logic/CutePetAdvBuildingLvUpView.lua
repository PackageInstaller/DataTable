-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/adventure/CutePetAdvBuildingLvUpView.lua

module("logic.extensions.cutepet.view.CutePetAdvBuildingLvUpView", package.seeall)

local CutePetAdvBuildingLvUpView = class("CutePetAdvBuildingLvUpView", ViewComponent)

function CutePetAdvBuildingLvUpView:ctor()
	CutePetAdvBuildingLvUpView.super.ctor(self)
end

function CutePetAdvBuildingLvUpView:unbindEvents()
	CutePetAdvBuildingLvUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CutePetAdvBuildingLvUpView:bindEvents()
	CutePetAdvBuildingLvUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CutePetAdvBuildingLvUpView:buildUI()
	CutePetAdvBuildingLvUpView.super.buildUI(self)

	self._txtStoreLimitLeft = self:getTxt("storelimit/txt_left_num")
	self._txtStoreLimitRight = self:getTxt("storelimit/txt_right_num")
	self._txtOutputLimitLeft = self:getTxt("output/txt_left_num")
	self._txtOutputLimitRight = self:getTxt("output/txt_right_num")
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

function CutePetAdvBuildingLvUpView:onExit()
	CutePetAdvBuildingLvUpView.super.onExit(self)

	if self._effs then
		for _, eff in ipairs(self._effs) do
			UIEffectManager.instance:stopEffect(eff)

			eff = nil
		end
	end
end

function CutePetAdvBuildingLvUpView:onEnter()
	CutePetAdvBuildingLvUpView.super.onEnter(self)

	self._effs = UIEffectManager.instance:playHudEffects(effPaths, self.mainGO)

	local params = self:getOpenParam()

	self._txtStoreLimitLeft.text = params[1]
	self._txtStoreLimitRight.text = params[2]
	self._txtOutputLimitLeft.text = langPara("%d/ 小时", params[3])
	self._txtOutputLimitRight.text = langPara("%d/ 小时", params[4])
end

return CutePetAdvBuildingLvUpView
