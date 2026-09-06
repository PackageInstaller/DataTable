-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideForeDragChangePosView.lua

module("logic.extensions.guide.view.GuideForeDragChangePosView", package.seeall)

local GuideForeDragChangePosView = class("GuideForeDragChangePosView", GuideUIObjectBase)

function GuideForeDragChangePosView:ctor()
	GuideForeDragChangePosView.super.ctor(self)
end

function GuideForeDragChangePosView:buildUI()
	self._finger = self:getGo("Finger")
	self._Character = self:getGo("Character")
	self._attach = self:getGo("attach")
end

function GuideForeDragChangePosView:onEnterFinished()
	GuideForeDragChangePosView.super.onEnterFinished(self)
	self._finger:SetActive(false)
	self:_showGuide()
end

function GuideForeDragChangePosView:_showGuide()
	local params = self._currGuide:getJsonParams()
	local startGoUI = params.viewFrom[1]
	local startGoName = params.viewFrom[2]
	local endGoUI = params.viewTo[1]
	local endGoName = params.viewTo[2]
	local widgeList = params.widgeList
	local posGoList = params.posGo

	self._startGo = self:_getWidgetNeedHandler(startGoUI, startGoName)
	self._saveStartGoP = self._startGo.transform.parent
	self._savaStartSiblingIndex = self._startGo.transform:GetSiblingIndex()
	self._endGo = self:_getWidgetNeedHandler(endGoUI, endGoName)
	self._saveEndGoP = self._endGo.transform.parent
	self._savaEndGoSiblingIndex = self._endGo.transform:GetSiblingIndex()

	local view = self._currGuide:getUINode()

	if widgeList then
		self.widgeSaveList = {}

		for i, str in ipairs(widgeList) do
			local go = self:_getWidgetNeedHandler(view, str)
			local goP = go.transform.parent
			local goSiblingIndex = go.transform:GetSiblingIndex()
			local tem = {
				go,
				goP,
				goSiblingIndex
			}

			table.insert(self.widgeSaveList, tem)
		end
	end

	local pos = GameUtil.getPos(self._startGo)

	goutil.addChildToParent(self._startGo, self._attach)
	GameUtil.setPos(self._startGo, pos.x, pos.y, pos.z)

	local posgo

	if posGoList and posGoList[1] then
		posgo = self:_getWidgetNeedHandler(view, posGoList[1])
	end

	self._fingerEff = self:_playEffect(self._startGo, params.pos1, posgo)
	pos = GameUtil.getPos(self._endGo)

	goutil.addChildToParent(self._endGo, self._attach)
	GameUtil.setPos(self._endGo, pos.x, pos.y, pos.z)

	posgo = nil

	if posGoList and posGoList[2] then
		posgo = self:_getWidgetNeedHandler(view, posGoList[2])
	end

	self._fingerEff2 = self:_playEffect(self._endGo, params.pos2, posgo)

	local startX, startY, startZ = self:_getWidgetCenterPosition(self._startGo)
	local endX, endY, endZ = self:_getWidgetCenterPosition(self._endGo)

	Framework.TransformUtil.SetPos(self._finger.transform, endX, endY, endZ)

	endX, endY, endZ = Framework.TransformUtil.GetLocalPos(self._finger.transform, nil, nil, nil)

	Framework.TransformUtil.SetPos(self._finger.transform, startX, startY, startZ)

	startX, startY, startZ = Framework.TransformUtil.GetLocalPos(self._finger.transform, nil, nil, nil)

	local tweenPos = self._finger:GetComponent(UnityTweensType.TweenPosition)

	tweenPos.from = Vector3.New(startX, startY, startZ)
	tweenPos.to = Vector3.New(endX, endY, startZ)
	self._startDropHandler = DropHandler.Get(self._startGo):AddLuaHandler(function(_go, eventData)
		self:_OnDropSeat(_go, eventData)
	end)
	self._endDropHandler = DropHandler.Get(self._endGo):AddLuaHandler(function(_go, eventData)
		self:_OnDropSeat(_go, eventData)
	end)

	if self.widgeSaveList then
		for i, tem in ipairs(self.widgeSaveList) do
			local go = tem[1]
			local pos = GameUtil.getPos(go)

			goutil.addChildToParent(go, self._attach)
			GameUtil.setPos(go, pos.x, pos.y, pos.z)
		end
	end

	self._finger:SetActive(true)
end

function GuideForeDragChangePosView:_OnDropSeat(go, eventData)
	local ItemSeatCls = self:_getItemSeatCls()
	local curItemSeat = ItemSeatCls.Get(go)

	if not curItemSeat then
		return
	end

	local itemSeat = ItemSeatCls.Get(eventData.pointerDrag)

	if itemSeat and curItemSeat:IsOpen() ~= itemSeat:IsOpen() or not itemSeat and curItemSeat:GetData() == -1 then
		return
	end

	local itemPet = ItemPet.Get(eventData.pointerDrag)

	if not itemSeat and not itemPet:isInTeam() and not curItemSeat:isHasPet() then
		return
	end

	local petId

	if itemPet then
		local data = itemPet:GetData()

		if data.forbit then
			return
		end

		petId = data.petId
	elseif itemSeat then
		petId = itemSeat:GetData()

		local endPetId = curItemSeat:GetData()
		local initPos = itemSeat:GetPosition()
	end

	if not petId then
		return
	end

	GuideController.instance:finishGuide()
end

function GuideForeDragChangePosView:onExit()
	if self._fingerEff then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end

	if self._fingerEff2 then
		UIEffectManager.instance:stopEffect(self._fingerEff2)

		self._fingerEff2 = nil
	end
end

function GuideForeDragChangePosView:_playEffect(go, idx, targetGo)
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

function GuideForeDragChangePosView:_getScale(pos)
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

function GuideForeDragChangePosView:onExitFinished()
	GuideForeDragChangePosView.super.onExitFinished(self)
	removetimer(self._onViewDelayShow, self)

	if self._startGo then
		self._startGo.transform:SetParent(self._saveStartGoP)
		self._startGo.transform:SetSiblingIndex(self._savaStartSiblingIndex)

		if self._startDropHandler ~= 0 then
			DropHandler.Get(self._startGo):RemoveLuaHandler(self._startDropHandler)
		end
	end

	if self._endGo then
		self._endGo.transform:SetParent(self._saveEndGoP)
		self._endGo.transform:SetSiblingIndex(self._savaEndGoSiblingIndex)

		if self._endDropHandler ~= 0 then
			DropHandler.Get(self._endGo):RemoveLuaHandler(self._endDropHandler)
		end
	end

	if self.widgeSaveList then
		for i, tem in ipairs(self.widgeSaveList) do
			local go = tem[1]
			local goP = tem[2]
			local idx = tem[3]
			local pos = GameUtil.getPos(go)

			goutil.addChildToParent(go, goP)
			go.transform:SetSiblingIndex(idx)
			GameUtil.setPos(go, pos.x, pos.y, pos.z)
		end
	end

	self.widgeSaveList = nil

	goutil.clearChildren(self._attach)
end

function GuideForeDragChangePosView:_getItemSeatCls()
	return ItemSeat
end

return GuideForeDragChangePosView
