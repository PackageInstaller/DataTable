-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/guangyuansushi/GuangYuanSuShiMainView.lua

module("logic.extensions.timelimitedchallenge.view.guangyuansushi.GuangYuanSuShiMainView", package.seeall)

local GuangYuanSuShiMainView = class("GuangYuanSuShiMainView", PerfectRuleModeMainView)

function GuangYuanSuShiMainView:buildUI()
	GuangYuanSuShiMainView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._challengeId = 59
end

function GuangYuanSuShiMainView:onEnter()
	GuangYuanSuShiMainView.super.onEnter(self)

	self._txtTime.text = TimeGateController.instance:getActTimeShowByChallengeId(self._challengeId)
end

function GuangYuanSuShiMainView:_activeTipTry(isActive)
	goutil.setActive(self._tipTry.gameObject, false)
end

function GuangYuanSuShiMainView:_activeTipRank(isActive)
	goutil.setActive(self._tipRank.gameObject, false)
end

function GuangYuanSuShiMainView:_setEffectUrls()
	self._effPaths = {
		{
			goPath = "point_fx_fenwei",
			path = "20221223/luotajiemian/fx_ui_luota_tzjm_fw.prefab"
		},
		{
			goPath = "btnStart",
			path = "20221223/luotajiemian/fx_ui_luota_anniu.prefab"
		}
	}
end

return GuangYuanSuShiMainView
