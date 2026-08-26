-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaOperView.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaOperView", package.seeall)

local TianShiNaNaOperView = class("TianShiNaNaOperView", BaseView)

function TianShiNaNaOperView:onInitView()
	self._btnBack = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_back")
	self._gofull = gohelper.findChild(self.viewGO, "#go_full")
	self._clickFull = gohelper.findChildClick(self.viewGO, "#go_full")
	self._btnEndRotate = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_endrotate")
end

function TianShiNaNaOperView:addEvents()
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.ResetScene, self.onSceneReset, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.LoadLevelFinish, self.onLevelLoadFinish, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.OnFlowEnd, self.onFlowEnd, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.RoundFail, self.onRoundFail, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.StatuChange, self._onStatuChange, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.RoundUpdate, self._onRoundChange, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.GuideClickNode, self._onGuideClickNode, self)
	self._btnBack:AddClickListener(self._onBackClick, self)
	self._clickFull:AddClickListener(self._onClickFull, self)
	self._btnEndRotate:AddClickListener(self._onEndRotate, self)
	CommonDragHelper.instance:registerDragObj(self._gofull, nil, self._onDrag, self._onEndDrag, self._checkLockDrag, self, nil, true)
end

function TianShiNaNaOperView:removeEvents()
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.ResetScene, self.onSceneReset, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.LoadLevelFinish, self.onLevelLoadFinish, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.OnFlowEnd, self.onFlowEnd, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.RoundFail, self.onRoundFail, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.StatuChange, self._onStatuChange, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.RoundUpdate, self._onRoundChange, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.GuideClickNode, self._onGuideClickNode, self)
	self._btnBack:RemoveClickListener()
	self._clickFull:RemoveClickListener()
	self._btnEndRotate:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(self._gofull)
end

function TianShiNaNaOperView:onLevelLoadFinish(sceneGo)
	TianShiNaNaModel.instance.sceneLevelLoadFinish = true
	self._cubeContainer = gohelper.create3d(sceneGo.transform.parent.gameObject, "CubeContainer")
	self._placeContainer = gohelper.create3d(sceneGo.transform.parent.gameObject, "PlaceContainer")
	self._effectContainer = gohelper.create3d(sceneGo.transform.parent.gameObject, "EffectContainer")

	TianShiNaNaEffectPool.instance:setRoot(self._effectContainer)

	local trans = self._cubeContainer.transform

	transformhelper.setLocalPos(trans, 0, 1.113595, -4.8425)
	transformhelper.setLocalRotation(trans, 152.637, 52.768, 31.166)
	transformhelper.setLocalScale(trans, 1.5, -1.5, -1.5)

	if TianShiNaNaModel.instance.waitStartFlow then
		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
		TianShiNaNaController.instance:checkBeginFlow()
	else
		self:beginSelectDir()
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EnterMapAndInitDone, tostring(TianShiNaNaModel.instance.episodeCo.id))
end

function TianShiNaNaOperView:onSceneReset()
	if TianShiNaNaModel.instance.waitStartFlow then
		self:clearCubes()
		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
		TianShiNaNaController.instance:checkBeginFlow()

		return
	end

	local operList = TianShiNaNaModel.instance.curOperList

	if #operList == 0 then
		self:beginSelectDir()
	else
		self:clearCubes()

		self.cube = self:_placeCubes(operList[1], TianShiNaNaModel.instance:getNextCubeType())

		self:setCurOperCube(operList[1], self.cube)

		local len = #operList

		for i = 2, len do
			local oper = operList[i]

			self.cube:doRotate(oper)
			self:markOpers(oper)

			if i == 4 and len == 5 then
				local downIndex = self.cube:getOperDownIndex(operList[5])

				if not self._finishIndex[7 - downIndex] then
					table.remove(operList)

					break
				end
			end

			if i == 5 and len == 6 then
				table.remove(operList)

				break
			end
		end
	end
end

function TianShiNaNaOperView:_onStatuChange(preStatu, nowStatu)
	gohelper.setActive(self._btnEndRotate, nowStatu == TianShiNaNaEnum.CurState.Rotate)

	if preStatu == TianShiNaNaEnum.CurState.SelectDir and nowStatu == TianShiNaNaEnum.CurState.DoStep then
		self:clearCubes()
	end
end

function TianShiNaNaOperView:_onRoundChange()
	if TianShiNaNaModel.instance:isWaitClick() then
		self:clearCubes(true)
		gohelper.setActive(self._btnEndRotate, true)
	end
end

function TianShiNaNaOperView:_onBackClick()
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	local nowState = TianShiNaNaModel.instance:getState()

	if nowState == TianShiNaNaEnum.CurState.SelectDir or TianShiNaNaModel.instance:isWaitClick() then
		Activity167Rpc.instance:sendAct167RollbackRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
	elseif nowState == TianShiNaNaEnum.CurState.Rotate then
		if self:_checkLockDrag() then
			return
		end

		local operList = TianShiNaNaModel.instance.curOperList

		if #operList <= 1 then
			self:beginSelectDir()
		else
			local operDir = table.remove(operList)

			self:rollbackOper(operDir)
		end
	end
end

function TianShiNaNaOperView:rollbackOper(operDir)
	local index = self.cube:getCurDownIndex()

	self.cube:revertPlane(index)
	self.cube:doRotate(-operDir)

	self._isErrorOper = true
	self._dragValue = 1
	self._nowOper = operDir
	self._finishIndex[index] = nil

	self:_doOperTween()
end

function TianShiNaNaOperView:beginSelectDir()
	self:clearCubes()
	TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.SelectDir)

	local heroPos = TianShiNaNaModel.instance:getHeroMo()
	local cubeType = TianShiNaNaModel.instance:getNextCubeType()

	if not cubeType then
		logError("没有方块了？？？")

		return
	end

	self._nowCubeType = cubeType

	local canPlaceDirs = TianShiNaNaHelper.getCanOperDirs(heroPos, cubeType)

	if not next(canPlaceDirs) then
		TianShiNaNaModel.instance.curOperList = {}
		self._finishIndex = {}

		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.Rotate)
	else
		self._placeEntity = TianShiNaNaPlaceEntity.Create(heroPos.x, heroPos.y, canPlaceDirs, cubeType, self._placeContainer)
	end
end

function TianShiNaNaOperView:_placeCubes(dir, cubeType)
	local heroPos = TianShiNaNaModel.instance:getHeroMo()
	local placePosX = heroPos.x
	local placePosY = heroPos.y

	if cubeType == TianShiNaNaEnum.CubeType.Type1 then
		local offset = TianShiNaNaHelper.getOperOffset(dir)

		placePosX = placePosX + offset.x
		placePosY = placePosY + offset.y
	end

	local cube = TianShiNaNaCubeEntity.Create(placePosX, placePosY, self._cubeContainer)

	if cubeType == TianShiNaNaEnum.CubeType.Type2 then
		cube:doRotate(dir)
	end

	return cube
end

function TianShiNaNaOperView:_onClickFull(nodePos)
	local nowState = TianShiNaNaModel.instance:getState()

	if nowState == TianShiNaNaEnum.CurState.SelectDir then
		local clickPos = nodePos or TianShiNaNaHelper.getClickNodePos()
		local clickDir = self._placeEntity:getClickDir(clickPos)

		if clickDir then
			local nextCubeType = TianShiNaNaModel.instance:getNextCubeType()
			local cube = self:_placeCubes(clickDir, nextCubeType)

			cube:playOpenAnim(nextCubeType)
			self:setCurOperCube(clickDir, cube)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_deploy)
		end
	elseif nowState == TianShiNaNaEnum.CurState.Rotate and not self._nowOper and not self:_checkLockDrag() then
		local clickPos = nodePos or TianShiNaNaHelper.getClickNodePos()

		for _, operDir in pairs(TianShiNaNaEnum.OperDir) do
			local points = self.cube:getOperGrids(operDir)
			local operIndex = self.cube:getOperDownIndex(operDir)

			if not self._finishIndex[operIndex] and TianShiNaNaHelper.havePos(points, clickPos) and self:checkCanOper(operDir, points) then
				self._dragValue = 0
				self._nowOper = operDir

				local len = tabletool.len(self._finishIndex)

				if len == 4 and not self._finishIndex[7 - operIndex] then
					self._hidePlanIndex = 7 - operIndex

					local plan = self.cube:getPlaneByIndex(self._hidePlanIndex)

					gohelper.setActive(plan, false)
				end

				self:_doOperTween(true)

				return
			elseif self._finishIndex[operIndex] and TianShiNaNaHelper.havePos(points, clickPos) then
				local operList = TianShiNaNaModel.instance.curOperList
				local leftOper = #operList > 1 and operList[#operList]

				if leftOper == -operDir then
					self._dragValue = 0
					self._nowOper = operDir

					local nowDownIndex = self.cube:getCurDownIndex()

					self.cube:revertPlane(nowDownIndex)
					self:_doOperTween(true)

					return
				end
			end
		end
	end
end

function TianShiNaNaOperView:_onGuideClickNode(posStr)
	local arr = string.splitToNumber(posStr, ",")
	local nodePos = {
		x = arr[1],
		y = arr[2]
	}

	self:_onClickFull(nodePos)
end

function TianShiNaNaOperView:setCurOperCube(operDir, selectCube)
	TianShiNaNaModel.instance.curOperList = {}
	self._finishIndex = {}
	self.cube = selectCube

	if self._placeEntity then
		self._placeEntity:dispose()

		self._placeEntity = nil
	end

	TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.Rotate)
	self:markOpers(operDir)
end

function TianShiNaNaOperView:_onEndRotate()
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	if TianShiNaNaModel.instance:isWaitClick() then
		gohelper.setActive(self._btnEndRotate, false)

		TianShiNaNaModel.instance.waitClickJump = false

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.WaitClickJumpRound)

		return
	end

	if TianShiNaNaModel.instance:getState() ~= TianShiNaNaEnum.CurState.Rotate then
		return
	end

	if self._tweenId then
		return
	end

	if self.cube then
		local points = self.cube:getCurGrids()

		for _, point in pairs(points) do
			TianShiNaNaEffectPool.instance:getFromPool(point.x, point.y, 1, (tabletool.len(self._finishIndex) == 6 or nil) and 0.2, 0.2)
		end

		self.cube:hideOtherPlane()
	end

	TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
	Activity167Rpc.instance:sendAct167BeginRoundRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id, TianShiNaNaModel.instance.curOperList)

	TianShiNaNaModel.instance.curOperList = {}
end

function TianShiNaNaOperView:onFlowEnd(isSuccess)
	if not isSuccess then
		return
	end

	self:beginSelectDir()
end

function TianShiNaNaOperView:onRoundFail()
	self:beginSelectDir()
end

function TianShiNaNaOperView:clearCubes(noSetStatu)
	if not noSetStatu then
		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.None)
	end

	if self.cube then
		gohelper.destroy(self.cube.go)
	end

	if self._placeEntity then
		self._placeEntity:dispose()

		self._placeEntity = nil
	end
end

function TianShiNaNaOperView:onClose()
	TianShiNaNaModel.instance.sceneLevelLoadFinish = false

	self:clearCubes()

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TianShiNaNaEffectPool.instance:clear()
end

function TianShiNaNaOperView:_checkLockDrag()
	return self._tweenId or not self.cube or TianShiNaNaModel.instance:getState() ~= TianShiNaNaEnum.CurState.Rotate
end

function TianShiNaNaOperView:_onDrag(_, pointerEventData)
	local nowPos = pointerEventData.position
	local pressPos = pointerEventData.pressPosition
	local xDrag = nowPos.x - pressPos.x
	local yDrag = nowPos.y - pressPos.y
	local absXDrag = math.abs(xDrag)
	local absYDrag = math.abs(yDrag)

	if not self._nowOper and (absXDrag > TianShiNaNaEnum.OperDragBegin or absYDrag > TianShiNaNaEnum.OperDragBegin) then
		self._nowOper = TianShiNaNaHelper.getOperDir(xDrag, yDrag)

		local downIndex = self.cube:getOperDownIndex(self._nowOper)
		local canOper = true

		self._isErrorOper = false

		local isRevert = false

		if self._finishIndex[downIndex] then
			local operList = TianShiNaNaModel.instance.curOperList
			local leftOper = #operList > 1 and operList[#operList]

			if leftOper ~= -self._nowOper then
				canOper = false
			else
				local nowDownIndex = self.cube:getCurDownIndex()

				self.cube:revertPlane(nowDownIndex)

				isRevert = true
			end
		elseif not self:checkCanOper(self._nowOper) then
			self._isErrorOper = true
		end

		if not canOper then
			self._nowOper = nil
		else
			local len = tabletool.len(self._finishIndex)

			if not isRevert and len == 4 and not self._finishIndex[7 - downIndex] then
				self._hidePlanIndex = 7 - downIndex

				local plan = self.cube:getPlaneByIndex(self._hidePlanIndex)

				gohelper.setActive(plan, false)
			end
		end
	elseif self._nowOper and TianShiNaNaHelper.isRevertDir(self._nowOper, xDrag, yDrag) then
		absYDrag = 0
		absXDrag = 0
	end

	if self._nowOper then
		self._dragValue = Mathf.Clamp((((self._nowOper == TianShiNaNaEnum.OperDir.Left or self._nowOper == TianShiNaNaEnum.OperDir.Right) and absXDrag or absYDrag) - TianShiNaNaEnum.OperDragBegin) / TianShiNaNaEnum.OperDragMax, 0, 1)

		self.cube:doCubeTween(self._nowOper, self._dragValue)
	end
end

function TianShiNaNaOperView:_onEndDrag()
	self:_doOperTween()
end

function TianShiNaNaOperView:_doOperTween(isForce)
	if self._nowOper and self._dragValue then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_unfold)

		self._tweenId = (self._dragValue > TianShiNaNaEnum.OperDragVaild and not self._isErrorOper or isForce) and ZProj.TweenHelper.DOTweenFloat(self._dragValue, 1, (1 - self._dragValue) * 0.3, self.onFrameDragCube, self.onFinishDragCube, self) or ZProj.TweenHelper.DOTweenFloat(self._dragValue, 0, self._dragValue * 0.3, self.onFrameDragCube, self.onFinishDragCube2, self)
		self._dragValue = nil
	end
end

function TianShiNaNaOperView:onFrameDragCube(value)
	self.cube:doCubeTween(self._nowOper, value)
end

function TianShiNaNaOperView:onFinishDragCube()
	local operList = TianShiNaNaModel.instance.curOperList
	local leftOper = #operList > 1 and operList[#operList]

	if leftOper == -self._nowOper then
		table.remove(operList)

		local index = self.cube:getCurDownIndex()

		self.cube:doRotate(-leftOper)

		self._finishIndex[index] = nil
	else
		local points = self.cube:getCurGrids()

		for _, point in pairs(points) do
			TianShiNaNaEffectPool.instance:getFromPool(point.x, point.y, 1, 0, 0.2)
		end

		self.cube:doRotate(self._nowOper)
		self:markOpers(self._nowOper)
	end

	self._nowOper = nil
	self._tweenId = nil

	if self._hidePlanIndex then
		self._finishIndex[self._hidePlanIndex] = true
		self._hidePlanIndex = nil
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.OnWaitDragEnd)

	if tabletool.len(self._finishIndex) == 6 then
		self:_onEndRotate()

		return
	end
end

function TianShiNaNaOperView:checkCanOper(operDir, pointList)
	if not pointList then
		::label_26_0::

		local points = self.cube:getOperGrids(operDir)
		local len = #points

		for k, point in pairs(points) do
			if not TianShiNaNaModel.instance:isNodeCanPlace(point.x, point.y, len == 1) then
				return false
			end
		end

		return true
	end
end

function TianShiNaNaOperView:markOpers(operDir)
	table.insert(TianShiNaNaModel.instance.curOperList, operDir)

	local downIndex = self.cube:getCurDownIndex()

	self._finishIndex[downIndex] = true

	self.cube:setPlaneParent(downIndex, self._cubeContainer.transform)
end

function TianShiNaNaOperView:onFinishDragCube2()
	local operList = TianShiNaNaModel.instance.curOperList
	local leftOper = #operList > 1 and operList[#operList]

	if leftOper == -self._nowOper then
		local downIndex = self.cube:getCurDownIndex()

		self.cube:setPlaneParent(downIndex, self._cubeContainer.transform)
	end

	self._nowOper = nil
	self._tweenId = nil

	if self._hidePlanIndex then
		local plan = self.cube:getPlaneByIndex(self._hidePlanIndex)

		gohelper.setActive(plan, true)

		self._hidePlanIndex = nil
	end
end

return TianShiNaNaOperView
