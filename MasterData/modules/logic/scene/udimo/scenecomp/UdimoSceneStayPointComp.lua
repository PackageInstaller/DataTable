-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneStayPointComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneStayPointComp", package.seeall)

local UdimoSceneStayPointComp = class("UdimoSceneStayPointComp", BaseSceneComp)

function UdimoSceneStayPointComp:onInit()
	self:_clear()
end

function UdimoSceneStayPointComp:onSceneStart(sceneId, levelId)
	self:_clear()
end

function UdimoSceneStayPointComp:init(sceneId, levelId)
	local useBg = UdimoItemModel.instance:getUseBg()
	local bgAirPointList = UdimoConfig.instance:getBgAirPointList(useBg)

	for _, bgAirPoint in ipairs(bgAirPointList) do
		self._airPointList[#self._airPointList + 1] = bgAirPoint
	end

	local useDecorationDict = UdimoItemModel.instance:getUseDecorationDict()

	if useDecorationDict then
		for decorationId, _ in pairs(useDecorationDict) do
			local decorationAirPointList = UdimoConfig.instance:getDecorationAirPointList(decorationId)

			if decorationAirPointList and #decorationAirPointList > 0 then
				for _, decorationAirPoint in ipairs(decorationAirPointList) do
					self._airPointList[#self._airPointList + 1] = decorationAirPoint
				end
			end
		end
	end

	self:addEventListeners()
end

function UdimoSceneStayPointComp:onScenePrepared(sceneId, levelId)
	return
end

function UdimoSceneStayPointComp:addEventListeners()
	UdimoController.instance:registerCallback(UdimoEvent.OnChangeBg, self._onChangeBg, self)
	UdimoController.instance:registerCallback(UdimoEvent.OnChangeDecoration, self._onChangeDecoration, self)
end

function UdimoSceneStayPointComp:removeEventListeners()
	UdimoController.instance:unregisterCallback(UdimoEvent.OnChangeBg, self._onChangeBg, self)
	UdimoController.instance:unregisterCallback(UdimoEvent.OnChangeDecoration, self._onChangeDecoration, self)
end

function UdimoSceneStayPointComp:_onChangeBg()
	return
end

function UdimoSceneStayPointComp:_onChangeDecoration(useDecoration, removeDecoration)
	for udimoId, pointData in pairs(self._usedAirPointDict) do
		if pointData and pointData.decorationId == removeDecoration then
			local scene = self:getCurScene()

			scene.udimomgr:updateUdimoCurStateParam(udimoId, UdimoEnum.UdimoState.Idle, {
				forceFly = true
			})

			self._usedAirPointDict[udimoId] = nil
		end
	end

	for i = #self._airPointList, 1, -1 do
		local pointData = self._airPointList[i]

		if pointData and pointData.decorationId == removeDecoration then
			table.remove(self._airPointList, i)
		end
	end

	local decorationAirPointList = UdimoConfig.instance:getDecorationAirPointList(useDecoration)

	if decorationAirPointList and #decorationAirPointList > 0 then
		for _, decorationAirPoint in ipairs(decorationAirPointList) do
			self._airPointList[#self._airPointList + 1] = decorationAirPoint
		end
	end
end

function UdimoSceneStayPointComp:recycleAirPoint(udimoId)
	if not self._usedAirPointDict[udimoId] then
		return
	end

	self._airPointList[#self._airPointList + 1] = self._usedAirPointDict[udimoId]
	self._usedAirPointDict[udimoId] = nil
end

function UdimoSceneStayPointComp:getAirPointPos(udimoId, udimoPos, udimoZLevel)
	local resultPos
	local udimoPosX = udimoPos and udimoPos.x

	if udimoPos then
		if not udimoPos.z then
			local udimoPosZ = udimoZLevel
			local needX = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.AirNeedXValue, false, nil, true)
			local rangZ = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.AirPointZRange, false, nil, true)
			local canLandPointList = {}

			for i, airPoint in ipairs(self._airPointList) do
				local pointX = airPoint.x
				local pointZ = airPoint.z

				if not pointZ then
					local scene = self:getCurScene()

					if scene then
						::label_10_0::

						local sideEntity = scene.decoration:getSiteEntityByDecorationId(airPoint.decorationId)
						local pos = sideEntity and sideEntity:getWorldPos()

						pointZ = pos and pos.z
					end
				end

				if pointZ then
					local zOffset = pointZ - udimoPosZ

					if (not udimoPosX or needX <= math.abs(pointX - udimoPosX)) and zOffset > 0 and zOffset <= rangZ then
						canLandPointList[#canLandPointList + 1] = {
							pointIndex = i,
							point = airPoint
						}
					end
				end
			end

			local isLand = true

			if #canLandPointList > 0 then
				local weightList = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.AirPointOrLandWeight, false, "#", true)

				if weightList then
					if not weightList[1] then
						local airPointWeight = 0

						if weightList then
							if not weightList[2] then
								local landWeight = 0
								local randomWeight = math.random(airPointWeight + landWeight)

								isLand = randomWeight <= landWeight
							end
						end
					end
				end
			end

			if isLand then
				local landX = UdimoHelper.getAirUdimoTargetX(udimoId, udimoPosX)
				local useBg = UdimoItemModel.instance:getUseBg()
				local yLevelList = UdimoConfig.instance:getBgAreaYLevelList(useBg, UdimoEnum.UdimoType.Land)
				local var_10_3 = {
					x = landX
				}

				if yLevelList then
					var_10_3.y = yLevelList[1] or 0
				end

				resultPos = var_10_3
			else
				local randomIndex = math.random(#canLandPointList)
				local pointData = canLandPointList[randomIndex]

				if pointData then
					resultPos = {
						x = pointData.point.x,
						y = pointData.point.y,
						z = pointData.point.z,
						decorationId = pointData.point.decorationId
					}
					self._usedAirPointDict[udimoId] = pointData.point

					table.remove(self._airPointList, pointData.pointIndex)
				end
			end

			resultPos = resultPos or {
				x = 0,
				y = 0
			}

			return resultPos
		end
	end
end

function UdimoSceneStayPointComp:getUseAirPoint(udimoId)
	return self._usedAirPointDict and self._usedAirPointDict[udimoId]
end

function UdimoSceneStayPointComp:_clear()
	self._airPointList = {}
	self._usedAirPointDict = {}
end

function UdimoSceneStayPointComp:onSceneClose()
	self:removeEventListeners()
	self:_clear()
end

return UdimoSceneStayPointComp
