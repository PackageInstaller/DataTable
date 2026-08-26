-- chunkname: @modules/logic/survival/view/map/SurvivalMapRadarView.lua

module("modules.logic.survival.view.map.SurvivalMapRadarView", package.seeall)

local SurvivalMapRadarView = class("SurvivalMapRadarView", BaseView)

function SurvivalMapRadarView:onInitView()
	self._btnRadar = gohelper.findChildButtonWithAudio(self.viewGO, "Radar/#btn_radar")
	self._gotips = gohelper.findChild(self.viewGO, "Radar/#go_tips")
	self._animtips = gohelper.findChildAnim(self.viewGO, "Radar/#go_tips")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "Radar/#go_tips/#txt_dec")
end

function SurvivalMapRadarView:addEvents()
	self._btnRadar:AddClickListener(self._showHideTips, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapPlayerPosChange, self._refreshRadarLevel, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapRadarPosChange, self._refreshRadarLevel, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnFollowTaskUpdate, self._onFollowTaskUpdate, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitPosChange, self._onUnitPosChange, self)
	self.viewContainer:registerCallback(SurvivalEvent.OnClickSurvivalScene, self._onSceneClick, self)
end

function SurvivalMapRadarView:removeEvents()
	self._btnRadar:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapPlayerPosChange, self._refreshRadarLevel, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapRadarPosChange, self._refreshRadarLevel, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnFollowTaskUpdate, self._onFollowTaskUpdate, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitPosChange, self._onUnitPosChange, self)
	self.viewContainer:unregisterCallback(SurvivalEvent.OnClickSurvivalScene, self._onSceneClick, self)
end

function SurvivalMapRadarView:onOpen()
	self._levelGos = self:getUserDataTb_()

	local index = 1

	while true do
		local levelGo = gohelper.findChild(self._btnRadar.gameObject, "#go_level" .. index)

		if levelGo then
			self._levelGos[index] = levelGo
		else
			break
		end

		index = index + 1
	end

	self._isTipsClose = true

	gohelper.setActive(self._gotips, true)

	self._animtips.keepAnimatorControllerStateOnDisable = true

	self._animtips:Play("close", 0, 1)
	self:_refreshRadarLevel()
end

function SurvivalMapRadarView:_onSceneClick()
	if not self._isTipsClose then
		self:_showHideTips()
	end
end

function SurvivalMapRadarView:_showHideTips()
	if not self._levelGo then
		return
	end

	self._isTipsClose = not self._isTipsClose

	SurvivalStatHelper.instance:statBtnClick("onClickRadar_" .. tostring(self._isTipsClose), " SurvivalMapRadarView")
	self._animtips:Play(self._isTipsClose and "close" or "open")
end

function SurvivalMapRadarView:_onFollowTaskUpdate(followTaskMo)
	if followTaskMo.type == 1 then
		self:_refreshRadarLevel()
	end
end

function SurvivalMapRadarView:_onUnitPosChange(_, unitMo)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if unitMo.id == sceneMo.mainTask.followUnitUid then
		self:_refreshRadarLevel()
	end
end

function SurvivalMapRadarView:_refreshRadarLevel()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local playerPos = sceneMo.player.pos
	local mainTargetPos = playerPos
	local isInMiasma = SurvivalMapModel.instance:isInMiasma()

	if sceneMo.mainTask.followUnitUid ~= 0 and not isInMiasma then
		mainTargetPos = sceneMo.sceneProp.radarPosition
	end

	local dis = SurvivalHelper.instance:getDistance(playerPos, mainTargetPos)
	local x1, _, z1 = SurvivalHelper.instance:hexPointToWorldPoint(playerPos.q, playerPos.r)
	local x2, _, z2 = SurvivalHelper.instance:hexPointToWorldPoint(mainTargetPos.q, mainTargetPos.r)
	local angle = math.deg(math.atan2(z2 - z1, x2 - x1))

	angle = angle - 90

	local level = 3
	local desc

	while level > 0 do
		local key = SurvivalEnum.ConstId["RadarLv" .. level]
		local lvDis, lvDesc = SurvivalConfig.instance:getConstValue(key)

		lvDis = tonumber(lvDis) or 0

		if lvDis <= dis then
			desc = lvDesc

			break
		end

		level = level - 1
	end

	if level ~= self._level then
		self._level = level

		for index, go in pairs(self._levelGos) do
			gohelper.setActive(go, index == level)
		end

		self._levelGo = self._levelGos[level]
	end

	if self._levelGo then
		transformhelper.setLocalRotation(self._levelGo.transform, 0, 0, angle)

		self._txtdesc.text = desc
	else
		self._isTipsClose = true

		self._animtips:Play("close")
	end
end

return SurvivalMapRadarView
