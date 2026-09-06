-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightPlanetariumView.lua

module("logic.extensions.originfight.view.OriginFightPlanetariumView", package.seeall)

local OriginFightPlanetariumView = class("OriginFightPlanetariumView", PlanetariumView)

function OriginFightPlanetariumView:buildUI()
	OriginFightPlanetariumView.super.buildUI(self)

	self._passEff = self:getGo("passEff")
end

function OriginFightPlanetariumView:onEnter()
	self.addGEvent(self, GlobalNotify.PM_OriginFightCommonGodFavorRes, self._onGodFavorRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageId = 1
	self._godFavorId = checknumber(params[2])

	self:_initData()

	self._isGameStart = false
	self._isSuccess = false
	self._isRotating = false
	self._tweenRotate = {}

	self:_initStarRingUI()
	self:_initStarRingAngle()
	GameUtil.SetActive(self._success, false)
	self:_initUI()
	self:_refreshStarMap()
	self:_showMainEffect()
end

function OriginFightPlanetariumView:_passGameUI()
	self._isGameStart = false

	local effectPath = "20230630/tianwenguanyouxi/fx_ui_tianwenguanyouxi_yuanpan.prefab"

	self._passEffect = UIEffectManager.instance:playEffect(self, effectPath, self.mainGO, 0, 0, false, nil, nil, nil, self)

	self._passEffect:setParent(self._passEff.transform)
	self._passEffect:setLocalPos(0, 0, 0)
	self._passEffect:setScale(1)
	settimer(3, self._showSucessTip, self, false)
	OriginFightController.instance:sendPM_OriginFightCommonGodFavorReq(self._activityId, self._godFavorId)
end

function OriginFightPlanetariumView:_onGodFavorRes()
	local godFavorCfg = OriginFightConfig.instance:getGodFavorCfgById(self._activityId, self._godFavorId)

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, godFavorCfg.storyId, StoryModel.StoryType.SCCopy)
	self:close()
end

function OriginFightPlanetariumView:_initData()
	self._rulePlanId = OriginFightConfig.instance:getPlaneAriumRulePlanId(self._activityId)

	if not GameUtil.getUserDayData(ViewName.PlanetariumView .. "_" .. self._activityId) then
		self:_onClickTip()
		GameUtil.saveUserDayData(ViewName.PlanetariumView .. "_" .. self._activityId, true)
	end
end

function OriginFightPlanetariumView:_initUI()
	return
end

function OriginFightPlanetariumView:_getGameRingCfgById(stageId, value)
	return OriginFightConfig.instance:getPlaneAriumGameRingCfgById(stageId, value)
end

function OriginFightPlanetariumView:_onClickTip()
	local list = {}
	local cfgs = OriginFightConfig.instance:getPlaneAriumRuleCfg(self._rulePlanId)

	for i, v in ipairs(cfgs) do
		local info = {}

		info.url = string.format("ui/bigbg/planetarium/%s.png", v.picturePath)
		info.desc = v.txtRule

		table.insert(list, info)
	end

	TipsFacade.instance:openImageRuleView(list)
end

function OriginFightPlanetariumView:_sendGameStartReq()
	return
end

function OriginFightPlanetariumView:_sendGameEndReq()
	OriginFightController.instance:sendPM_OriginFightCommonGodFavorReq(self._activityId, self._godFavorId)
end

function OriginFightPlanetariumView:_sendGetInfoReq()
	return
end

function OriginFightPlanetariumView:_endGame()
	if not self._isGameStart then
		return
	end

	local checkGameSuccess = self:_checkSuccess()

	if checkGameSuccess then
		OriginFightController.instance:sendPM_OriginFightCommonGodFavorReq(self._activityId, self._godFavorId)
	else
		self:close()
	end
end

return OriginFightPlanetariumView
