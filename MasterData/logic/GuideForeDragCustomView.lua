-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideForeDragCustomView.lua

module("logic.extensions.guide.view.GuideForeDragCustomView", package.seeall)

local GuideForeDragCustomView = class("GuideForeDragCustomView", GuideUIObjectBase)

function GuideForeDragCustomView:ctor()
	GuideForeDragCustomView.super.ctor(self)
end

function GuideForeDragCustomView:buildUI()
	self._finger = self:getGo("Finger")
	self._Character = self:getGo("Character")
	self._attach = self:getGo("attach")
end

function GuideForeDragCustomView:onEnter()
	GuideForeDragCustomView.super.onEnter(self)

	self._hasDragPetEndCall = false

	self.addGEvent(self, GlobalNotify.FormationPosChanged, self._onSeatChange, self)
end

function GuideForeDragCustomView:onEnterFinished()
	GuideForeDragCustomView.super.onEnterFinished(self)
	self._finger:SetActive(false)
	self:_showGuide()
	GuideController.instance:setViewVar(GuideConst.VIEW_VAR_KEY_PET_CLICK_BLOCK, 1)
end

function GuideForeDragCustomView:_showGuide()
	local params = self._currGuide:getJsonParams()
	local startGoUI = params.viewFrom[1]
	local startGoName = params.viewFrom[2]
	local endGoUI = params.viewTo[1]
	local endGoName = params.viewTo[2]
	local petPos = 0
	local raceId = params.raceId
	local posGoList = params.posGo
	local dragGoName = params.dragGoName
	local customFmtMo = CustomFmtController.instance:getTempFmtMo()

	self._curViewDatas = {}

	local pets = customFmtMo:getAllShowPetList()

	if FormationController.instance:checkCanSort(pets) then
		local names, opt = BagModel.instance:GetSortParms(function(petMo)
			local res = 2

			if self:getInTeam(customFmtMo, petMo) then
				res = 3
			elseif self:getHasUp(petMo) then
				res = 1
			end

			return (customFmtMo:checkPetIsForbit(petMo) or nil) and 0
		end)

		ArraySort.sortOn(pets, names, opt)
	end

	for k, v in pairs(pets) do
		self._curViewDatas[#self._curViewDatas + 1] = v
	end

	local name = MaterialMgr.getMaterialsName(MatType.PET_SKIN, raceId)

	for i, v in ipairs(self._curViewDatas) do
		print(">>>>>>>>>>>> 已经上阵1", v.raceId, v.name, "ID", v.petId, "raceId", raceId, name)

		if v.raceId == raceId then
			print(">>>>>>>>>>>> 已经上阵2", v.raceId, v.name, "ID", v.petId, "idx:", i)

			if FormationNewModel.instance:HasPetAtCurFormation(v.petId) then
				print(">>>>>>>>>>>> 已经上阵3", v.raceId, v.name, "ID", v.petId)
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
			self._dragGo = self._startGo

			if not string.nilorempty(dragGoName) then
				self._dragGo = goutil.findChild(self._startGo, dragGoName)
			end

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

function GuideForeDragCustomView:getPetAtCurFormationFunc(customFmtMo)
	return function(petMo)
		local res = 2

		if self:getInTeam(customFmtMo, petMo) then
			res = 3
		elseif self:getHasUp(petMo) then
			res = 1
		end

		return (customFmtMo:checkPetIsForbit(petMo) or nil) and 0
	end
end

function GuideForeDragCustomView:getInTeam(customFmtMo, data)
	local formationMo = customFmtMo:getCurFormation()

	return data ~= nil and formationMo:HasPet(data.petId)
end

function GuideForeDragCustomView:getHasUp(customFmtMo, data)
	if data then
		local formation = customFmtMo:getCurFormation()

		for _, petId in ipairs(formation:GetPositions()) do
			if petId > 0 then
				local pet = formation:_getPet(petId)

				if pet and pet.raceId == data.raceId then
					return true
				end
			end
		end
	end

	return false
end

function GuideForeDragCustomView:onExit()
	if self._fingerEff then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end
end

function GuideForeDragCustomView:_playEffect(go, idx, targetGo)
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

		return effect
	end
end

function GuideForeDragCustomView:_getScale(pos)
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

function GuideForeDragCustomView:_onHandleTableviewObjectFinish()
	return
end

function GuideForeDragCustomView:_onViewDelayShow()
	self._isDoingDelayShow = nil
	self._hasDelayShowDone = true

	removetimer(self._onViewDelayShow, self)
	self:_showGuide()
end

function GuideForeDragCustomView:_handleDragEvent()
	if BeginDragHandler.Get(self._dragGo) then
		BeginDragHandler.Get(self._dragGo):SetOnlyCallBackTop(true)

		self._newBeginHandler = BeginDragHandler.Get(self._dragGo):AddLuaHandlerToTop(function(go)
			self:_beginDragFunc(go)
		end)
	end

	if DragHandler.Get(self._dragGo) then
		DragHandler.Get(self._dragGo):SetOnlyCallBackTop(true)

		self._newDragHandler = DragHandler.Get(self._dragGo):AddLuaHandlerToTop(function(go, data)
			self:_OnDragPetMoved(go, data)
		end)
	end

	if EndDragHandler.Get(self._dragGo) then
		EndDragHandler.Get(self._dragGo):SetOnlyCallBackTop(true)

		self._newEndHandler = EndDragHandler.Get(self._dragGo):AddLuaHandlerToTop(function(go, data)
			self:_OnDragPetEnded(go, data)
		end)
	end
end

function GuideForeDragCustomView:_beginDragFunc(go)
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

function GuideForeDragCustomView:_OnDragPetMoved(go, eventData)
	if not self._Character_point and not goutil.isNil(self._Character_point) and not self._Character_point.transform and not self._endGo and not goutil.isNil(self._endGo) and not self._endGo.transform then
		return
	end

	self._Character_point.transform.position = uGuiUtil.GetTouchWorldPosition()

	if UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self._endGo.transform, eventData.position, GlobalModel.instance.uiCamera) then
		-- block empty
	end
end

function GuideForeDragCustomView:_onSeatChange()
	if self._hasDragPetEndCall == false then
		self:_OnDragPetEnded()
	end
end

function GuideForeDragCustomView:_OnDragPetEnded()
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

function GuideForeDragCustomView:_onCheckPos()
	local params = self._currGuide:getJsonParams()
	local petPos = params.pos
	local raceId = params.raceId
	local customFmtMo = CustomFmtController.instance:getTempFmtMo()
	local formationMo = customFmtMo:getCurFormation()
	local pos = formationMo:GetPositions()

	if pos and pos[petPos] > 0 then
		local petMo = formationMo:_getPet(pos[petPos])

		if petMo and petMo.raceId == raceId then
			GameUtil.SetActive(self._finger, false)
			print(">>>>>>>>>>>>>>>>  GuideForeDragCustomView:onExitFinished ")

			self._hasDragPetEndCall = true

			GuideController.instance:finishGuide()
		end
	end
end

function GuideForeDragCustomView:onExitFinished()
	GuideForeDragCustomView.super.onExitFinished(self)
	GuideController.instance:setViewVar(GuideConst.VIEW_VAR_KEY_PET_CLICK_BLOCK, nil)
	removetimer(self._onViewDelayShow, self)

	if self._startGo then
		self._startGo.transform:SetParent(self._saveStartGoP)
		self._startGo.transform:SetSiblingIndex(self._savaStartSiblingIndex)

		if self._newBeginHandler ~= 0 then
			BeginDragHandler.Get(self._dragGo):SetOnlyCallBackTop(false)
			BeginDragHandler.Get(self._dragGo):RemoveLuaHandler(self._newBeginHandler)
		end

		if self._newDragHandler ~= 0 then
			DragHandler.Get(self._dragGo):SetOnlyCallBackTop(false)
			DragHandler.Get(self._dragGo):RemoveLuaHandler(self._newDragHandler)
		end

		if self._newEndHandler ~= 0 then
			EndDragHandler.Get(self._dragGo):SetOnlyCallBackTop(false)
			EndDragHandler.Get(self._dragGo):RemoveLuaHandler(self._newEndHandler)
		end
	end

	if self._endGo then
		self._endGo.transform:SetParent(self._saveEndGoP)
		self._endGo.transform:SetSiblingIndex(self._savaEndGoSiblingIndex)
	end

	goutil.clearChildren(self._attach)
end

return GuideForeDragCustomView
