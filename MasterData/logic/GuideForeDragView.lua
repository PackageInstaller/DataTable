-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideForeDragView.lua

module("logic.extensions.guide.view.GuideForeDragView", package.seeall)

local GuideForeDragView = class("GuideForeDragView", GuideUIObjectBase)

function GuideForeDragView:ctor()
	GuideForeDragView.super.ctor(self)
end

function GuideForeDragView:buildUI()
	self._finger = self:getGo("Finger")
	self._Character = self:getGo("Character")
	self._attach = self:getGo("attach")
end

function GuideForeDragView:onEnterFinished()
	GuideForeDragView.super.onEnterFinished(self)
	self._finger:SetActive(false)
	self:_showGuide()
end

function GuideForeDragView:_showGuide()
	local params = self._currGuide:getJsonParams()
	local startGoUI = params.viewFrom[1]
	local startGoName = params.viewFrom[2]
	local endGoUI = params.viewTo[1]
	local endGoName = params.viewTo[2]
	local petPos = 0
	local raceId = params.raceId
	local posGoList = params.posGo

	self._curViewDatas = {}

	local pets = BagPetsController.instance:getBagPets()

	for k, v in pairs(pets) do
		self._curViewDatas[#self._curViewDatas + 1] = v
	end

	local names, opt = BagModel.instance:GetSortParms()

	ArraySort.sortOn(self._curViewDatas, names, opt)

	for i, v in ipairs(self._curViewDatas) do
		print(">>>>>>>>>>>> 已经上阵1", v.raceId, "ID", v.petId, "raceId", raceId)

		if v.raceId == raceId then
			print(">>>>>>>>>>>> 已经上阵2", v.raceId, "ID", v.petId, "idx:", i)

			if FormationNewModel.instance:HasPetAtCurFormation(v.petId) then
				print(">>>>>>>>>>>> 已经上阵3", v.raceId, "ID", v.petId)
			else
				petPos = i - 1

				break
			end
		end
	end

	if not self._isDoingDelayShow then
		local delayTime = 0

		if params[6] then
			delayTime = 1
		end

		if delayTime > 0 and not self._hasDelayShowDone then
			self._isDoingDelayShow = true

			settimer(delayTime, self._onViewDelayShow, self, false)
		else
			GlobalDispatcher:dispatch(GlobalNotify.MissionActivty, false)

			self._originStartGo = self._originStartGo or self:_getWidgetIngoreHandler(startGoUI, startGoName)
			self._startGo = self:_getWidgetNeedHandler(startGoUI, startGoName, petPos)
			self._saveStartGoP = self._startGo.transform.parent
			self._savaStartSiblingIndex = self._startGo.transform:GetSiblingIndex()

			local pos = GameUtil.getPos(self._startGo)

			goutil.addChildToParent(self._startGo, self._attach)
			GameUtil.setPos(self._startGo, pos.x, pos.y, pos.z)

			self._endGo = self:_getWidgetNeedHandler(endGoUI, endGoName)
			self._saveEndGoP = self._endGo.transform.parent
			self._savaEndGoSiblingIndex = self._endGo.transform:GetSiblingIndex()
			pos = GameUtil.getPos(self._endGo)

			goutil.addChildToParent(self._endGo, self._attach)
			GameUtil.setPos(self._endGo, pos.x, pos.y, pos.z)

			local posgo
			local view = self._currGuide:getUINode()

			self._fingerEff = self:_playEffect(self._endGo, params.pos, (posGoList and posGoList[1] or nil) and self:_getWidgetNeedHandler(view, posGoList[1]))

			local startX, startY, startZ = self:_getWidgetCenterPosition(self._startGo)
			local endX, endY, endZ = self:_getWidgetCenterPosition(self._endGo)

			Framework.TransformUtil.SetPos(self._finger.transform, endX, endY, endZ)

			endX, endY, endZ = Framework.TransformUtil.GetLocalPos(self._finger.transform, nil, nil, nil)

			Framework.TransformUtil.SetPos(self._finger.transform, startX, startY, startZ)

			startX, startY, startZ = Framework.TransformUtil.GetLocalPos(self._finger.transform, nil, nil, nil)

			local tweenPos = self._finger:GetComponent(UnityTweensType.TweenPosition)

			tweenPos.from = Vector3.New(startX, startY, startZ)
			tweenPos.to = Vector3.New(endX - 20, endY - 50, startZ)

			self:_handleDragEvent()
			self._finger:SetActive(true)
		end
	end
end

function GuideForeDragView:onExit()
	if self._fingerEff then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end
end

function GuideForeDragView:_playEffect(go, idx, targetGo)
	if targetGo then
		local pos = GameUtil.getPos(targetGo)
		local p = goutil.create("test", true)

		goutil.addChildToParent(p, self._attach.transform)
		GameUtil.setPos(p, pos.x, pos.y, pos.z)

		local path = "fx_ui_jinglinggezi/fx_ui_buzhen_02.prefab"
		local scale, ofy = self:_getScale(idx)
		local effect = UIEffectManager.instance:playEffect(self, path, self._attach.transform, 0, 0, true, false, function()
			return
		end, function(ta, eff)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, scale, scale, scale)
		end)

		effect:setParent(p.transform)
		effect:setLocalPos(0, 0, 0)
	end

	return effect
end

function GuideForeDragView:_getScale(pos)
	local params = self._currGuide:getJsonParams()
	local scale = 1
	local ofy = 0
	local num = pos % 3

	if num == 1 then
		scale = 0.9
		ofy = -89
	elseif num == 2 then
		scale = 1
		ofy = -56
	else
		scale = 1.1
		ofy = -38
	end

	return scale, ofy
end

function GuideForeDragView:_onHandleTableviewObjectFinish()
	return
end

function GuideForeDragView:_onViewDelayShow()
	self._isDoingDelayShow = nil
	self._hasDelayShowDone = true

	removetimer(self._onViewDelayShow, self)
	self:_showGuide()
end

function GuideForeDragView:_handleDragEvent()
	if BeginDragHandler.Get(self._startGo) then
		BeginDragHandler.Get(self._startGo):SetOnlyCallBackTop(true)

		self._newBeginHandler = BeginDragHandler.Get(self._startGo):AddLuaHandlerToTop(function(go)
			self:_beginDragFunc(go)
		end)
	end

	if DragHandler.Get(self._startGo) then
		DragHandler.Get(self._startGo):SetOnlyCallBackTop(true)

		self._newDragHandler = DragHandler.Get(self._startGo):AddLuaHandlerToTop(function(go, data)
			self:_OnDragPetMoved(go, data)
		end)
	end

	if EndDragHandler.Get(self._startGo) then
		EndDragHandler.Get(self._startGo):SetOnlyCallBackTop(true)

		self._newEndHandler = EndDragHandler.Get(self._startGo):AddLuaHandlerToTop(function(go, data)
			self:_OnDragPetEnded(go, data)
		end)
	end
end

function GuideForeDragView:_beginDragFunc(go)
	self._dragging = true

	local pet = ItemPet.Get(go):GetData()

	if pet.forbit == true then
		return nil
	end

	GlobalDispatcher:dispatch(GlobalNotify.FormationDragBegin, pet)
	GlobalDispatcher:dispatch(GlobalNotify.FormationGuide_Right_Draging, true)

	self._Character_point = goutil.cloneAndSetParent(self._Character, self.mainGO.transform)
	self._Character_point.transform.position = uGuiUtil.GetTouchWorldPosition()
	self._loader, self._lastCallBack, self._chara = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._chara)
	self._loader, self._lastCallBack = RoleObjectPool.instance:getRoleAsset(pet.curFaceId, function(go)
		local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(pet.curFaceId)

		if not modelCfg[1] then
			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					self._chara = go

					go:SetActive(true)
					goutil.addChildToParent(go, self._Character_point)
					Framework.TransformUtil.SetLocalPos(go.transform, modelCfg[1], y, 0)
					Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)
				end
			end
		end
	end, false)
end

function GuideForeDragView:_OnDragPetMoved(go, eventData)
	if not self._Character_point and not goutil.isNil(self._Character_point) and not self._Character_point.transform and not self._endGo and not goutil.isNil(self._endGo) and not self._endGo.transform then
		return
	end

	self._Character_point.transform.position = uGuiUtil.GetTouchWorldPosition()

	if UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self._endGo.transform, eventData.position, GlobalModel.instance.uiCamera) then
		if self._fingerEff then
			GameUtil.SetActive(self._fingerEff.effGo, false)
		end
	elseif self._fingerEff then
		GameUtil.SetActive(self._fingerEff.effGo, true)
	end
end

function GuideForeDragView:_OnDragPetEnded()
	GlobalDispatcher:dispatch(GlobalNotify.FormationDropBag)
	GlobalDispatcher:dispatch(GlobalNotify.FormationGuide_Right_Draging, false)

	self._loader, self._lastCallBack, self._chara = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._chara)

	if not self._Character_point then
		return
	end

	goutil.destroy(self._Character_point, true)

	self._Character_point = nil
	self._dragging = false

	self:_onCheckPos()
end

function GuideForeDragView:_onCheckPos()
	local params = self._currGuide:getJsonParams()
	local petPos = params.pos
	local raceId = params.raceId
	local pos = FormationFacade.instance:getCurPositions()

	if pos and pos[petPos] > 0 and BagPetsFacade.instance:getPetRaceId(pos[petPos]) == raceId then
		GameUtil.SetActive(self._finger, false)
		print(">>>>>>>>>>>>>>>>  GuideForeDragView:onExitFinished ")
		GuideController.instance:finishGuide()
	end
end

function GuideForeDragView:onExitFinished()
	GuideForeDragView.super.onExitFinished(self)
	removetimer(self._onViewDelayShow, self)

	if self._startGo then
		self._startGo.transform:SetParent(self._saveStartGoP)
		self._startGo.transform:SetSiblingIndex(self._savaStartSiblingIndex)

		if self._newBeginHandler ~= 0 then
			BeginDragHandler.Get(self._startGo):SetOnlyCallBackTop(false)
			BeginDragHandler.Get(self._startGo):RemoveLuaHandler(self._newBeginHandler)
		end

		if self._newDragHandler ~= 0 then
			DragHandler.Get(self._startGo):SetOnlyCallBackTop(false)
			DragHandler.Get(self._startGo):RemoveLuaHandler(self._newDragHandler)
		end

		if self._newEndHandler ~= 0 then
			EndDragHandler.Get(self._startGo):SetOnlyCallBackTop(false)
			EndDragHandler.Get(self._startGo):RemoveLuaHandler(self._newEndHandler)
		end
	end

	if self._endGo then
		self._endGo.transform:SetParent(self._saveEndGoP)
		self._endGo.transform:SetSiblingIndex(self._savaEndGoSiblingIndex)
	end

	goutil.clearChildren(self._attach)
end

return GuideForeDragView
