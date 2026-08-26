-- chunkname: @modules/logic/fight/view/preview/SkillEditorSkillSelectTargetView.lua

module("modules.logic.fight.view.preview.SkillEditorSkillSelectTargetView", package.seeall)

local SkillEditorSkillSelectTargetView = class("SkillEditorSkillSelectTargetView", BaseView)

function SkillEditorSkillSelectTargetView:ctor(side)
	self._side = side
end

function SkillEditorSkillSelectTargetView:onInitView()
	local goPath = self._side == FightEnum.EntitySide.MySide and "right" or "left"
	local go = gohelper.findChild(self.viewGO, goPath)

	self._containerGO = gohelper.findChild(go, "skillSelect")
	self._containerTr = self._containerGO.transform
	self._imgSelectGO = gohelper.findChild(go, "skillSelect/imgSkillSelect")
	self._imgSelectTr = self._imgSelectGO.transform
	self._clickGOArr = {
		gohelper.findChild(go, "skillSelect/click")
	}

	gohelper.setActive(self._imgSelectGO, false)
	self:_updateClickPos()
	self:_updateSelectUI()

	local hudLayer = ViewMgr.instance:getUILayer(UILayerName.Hud)

	gohelper.addChild(hudLayer, self._containerGO)
	gohelper.setAsFirstSibling(self._containerGO)

	self._containerGO.name = "skillSelect" .. goPath
end

function SkillEditorSkillSelectTargetView:onDestroyView()
	gohelper.destroy(self._containerGO)
end

function SkillEditorSkillSelectTargetView:addEvents()
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	TaskDispatcher.runRepeat(self._onSecond, self, 3)
end

function SkillEditorSkillSelectTargetView:removeEvents()
	for _, clickGO in ipairs(self._clickGOArr) do
		SLFramework.UGUI.UIClickListener.Get(clickGO):RemoveClickListener()

		local listener = SLFramework.UGUI.UILongPressListener.Get(clickGO)

		listener:RemoveLongPressListener()
	end

	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, self._onSpineLoaded, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	TaskDispatcher.cancelTask(self._onSecond, self)
	TaskDispatcher.cancelTask(self._hideSelectGO, self)
end

function SkillEditorSkillSelectTargetView:_onSkillPlayStart()
	gohelper.setActive(self._containerGO, false)
end

function SkillEditorSkillSelectTargetView:_onSkillPlayFinish()
	gohelper.setActive(self._containerGO, true)
end

function SkillEditorSkillSelectTargetView:_onSecond()
	self:_updateClickPos()
end

function SkillEditorSkillSelectTargetView:_onSpineLoaded()
	self:_updateClickPos()
end

function SkillEditorSkillSelectTargetView:_updateSelectUI()
	local posId = SkillEditorView.selectPosId[self._side]
	local entityMO = FightDataHelper.entityMgr:getByPosId(self._side, posId)

	if entityMO then
		local entity = FightHelper.getEntity(entityMO.id or 0)

		gohelper.setActive(self._imgSelectGO, entity ~= nil)

		if entity then
			local middlePosX, middlePosY = self:_getEntityMiddlePos(entity)

			recthelper.setAnchor(self._imgSelectTr, middlePosX, middlePosY)
		else
			SkillEditorView.selectPosId[self._side] = 1
			entityMO = FightDataHelper.entityMgr:getByPosId(self._side, 1)
			entity = FightHelper.getEntity((entityMO or nil) and (entityMO.id or 0))

			gohelper.setActive(self._imgSelectGO, entity ~= nil)

			if entity then
				local middlePosX, middlePosY = self:_getEntityMiddlePos(entity)

				recthelper.setAnchor(self._imgSelectTr, middlePosX, middlePosY)
			end
		end

		TaskDispatcher.cancelTask(self._hideSelectGO, self)
		TaskDispatcher.runDelay(self._hideSelectGO, self, 0.5)
	end
end

function SkillEditorSkillSelectTargetView:_getEntityMiddlePos(entity)
	if FightHelper.isAssembledMonster(entity) then
		local entityMO = entity:getMO()
		local config = lua_fight_assembled_monster.configDict[entityMO.skin]
		local worldPos = entity.go.transform.position

		worldPos = Vector3.New(worldPos.x + config.selectPos[1], worldPos.y + config.selectPos[2], worldPos.z)

		local rectPos = recthelper.worldPosToAnchorPos(worldPos, self._containerTr)

		return rectPos.x, rectPos.y
	end

	local mountMiddleGO = self:_getHangPointObj(entity, ModuleEnum.SpineHangPoint.mountmiddle)

	if mountMiddleGO and mountMiddleGO.name == ModuleEnum.SpineHangPoint.mountmiddle then
		local worldPos = Vector3.New(transformhelper.getPos(mountMiddleGO.transform))
		local rectPos = recthelper.worldPosToAnchorPos(worldPos, self._containerTr)

		return rectPos.x, rectPos.y
	else
		local rectPos1, rectPos2 = self:_calcRect(entity)

		return (rectPos1.x + rectPos2.x) / 2, (rectPos1.y + rectPos2.y) / 2
	end
end

function SkillEditorSkillSelectTargetView:_hideSelectGO()
	gohelper.setActive(self._imgSelectGO, false)
end

function SkillEditorSkillSelectTargetView:_updateClickPos()
	local list = {}

	FightDataHelper.entityMgr:getNormalList(self._side, list)
	FightDataHelper.entityMgr:getSubList(self._side, list)

	local assembledMonster = {}

	for i, entityMO in ipairs(list) do
		local clickGO = self._clickGOArr[i]

		if not clickGO then
			clickGO = gohelper.clone(self._clickGOArr[1], self._containerGO, "click" .. i)

			table.insert(self._clickGOArr, clickGO)
		end

		gohelper.setActive(clickGO, true)

		local entity = FightHelper.getEntity(entityMO.id)

		if entity then
			local rectPos1, rectPos2 = self:_calcRect(entity)
			local clickTr = clickGO.transform

			recthelper.setAnchor(clickTr, (rectPos1.x + rectPos2.x) / 2, (rectPos1.y + rectPos2.y) / 2)
			recthelper.setSize(clickTr, math.abs(rectPos1.x - rectPos2.x), math.abs(rectPos1.y - rectPos2.y))
			SLFramework.UGUI.UIClickListener.Get(clickGO):AddClickListener(self._onClick, self, entityMO.id)

			local tarEntity = FightHelper.getEntity(entityMO.id)

			if isTypeOf(tarEntity, FightEntityAssembledMonsterMain) or isTypeOf(tarEntity, FightEntityAssembledMonsterSub) then
				table.insert(assembledMonster, {
					entity = tarEntity,
					clickTr = clickTr,
					clickGO = clickGO
				})
			end

			local listener = SLFramework.UGUI.UILongPressListener.Get(clickGO)

			listener:AddLongPressListener(self._onLongPress, self, entityMO.id)
			listener:SetLongPressTime({
				0.5,
				99999
			})
		end
	end

	for i = #list + 1, #self._clickGOArr do
		gohelper.setActive(self._clickGOArr[i], false)
	end

	if #assembledMonster > 0 then
		self:_dealAssembledMonsterClick(assembledMonster)
	end
end

function SkillEditorSkillSelectTargetView.sortAssembledMonster(item1, item2)
	local entityMO1 = item1.entity:getMO()
	local entityMO2 = item2.entity:getMO()
	local config1 = lua_fight_assembled_monster.configDict[entityMO1.skin]
	local config2 = lua_fight_assembled_monster.configDict[entityMO2.skin]

	return config1.clickIndex < config2.clickIndex
end

function SkillEditorSkillSelectTargetView:_dealAssembledMonsterClick(assembledMonster)
	table.sort(assembledMonster, SkillEditorSkillSelectTargetView.sortAssembledMonster)

	for i, v in ipairs(assembledMonster) do
		gohelper.setAsLastSibling(v.clickGO)

		local entityMO = v.entity:getMO()
		local config = lua_fight_assembled_monster.configDict[entityMO.skin]
		local entityPos = v.entity.go.transform.position

		entityPos = Vector3.New(entityPos.x + config.virtualSpinePos[1], entityPos.y + config.virtualSpinePos[2], entityPos.z + config.virtualSpinePos[3])

		local rectPos = recthelper.worldPosToAnchorPos(entityPos, self._containerTr)

		recthelper.setAnchor(v.clickTr, rectPos.x, rectPos.y)

		local halfX = config.virtualSpineSize[1] * 0.5
		local halfY = config.virtualSpineSize[2] * 0.5
		local worldPos1 = Vector3.New(entityPos.x - halfX, entityPos.y - halfY, entityPos.z)
		local worldPos2 = Vector3.New(entityPos.x + halfX, entityPos.y + halfY, entityPos.z)
		local rectPos1 = recthelper.worldPosToAnchorPos(worldPos1, self._containerTr)
		local rectPos2 = recthelper.worldPosToAnchorPos(worldPos2, self._containerTr)

		recthelper.setSize(v.clickTr, rectPos2.x - rectPos1.x, rectPos2.y - rectPos1.y)
	end
end

function SkillEditorSkillSelectTargetView:_calcRect(entity)
	local bodyStaticGO = self:_getHangPointObj(entity, ModuleEnum.SpineHangPoint.BodyStatic)
	local bodyPos = bodyStaticGO.transform.position
	local size, _ = FightHelper.getEntityBoxSizeOffsetV2(entity)
	local sideOp = entity:isMySide() and 1 or -1
	local worldPos1 = Vector3.New(bodyPos.x - size.x * 0.5, bodyPos.y - size.y * 0.5 * sideOp, bodyPos.z)
	local worldPos2 = Vector3.New(bodyPos.x + size.x * 0.5, bodyPos.y + size.y * 0.5 * sideOp, bodyPos.z)
	local rectPos1 = recthelper.worldPosToAnchorPos(worldPos1, self._containerTr)
	local rectPos2 = recthelper.worldPosToAnchorPos(worldPos2, self._containerTr)

	return rectPos1, rectPos2
end

function SkillEditorSkillSelectTargetView:_getHangPointObj(entity, hang_type)
	local is_sub = FightDataHelper.entityMgr:isSub(entity:getMO().uid)

	return (is_sub or nil) and (entity.go or entity:getHangPoint(hang_type))
end

function SkillEditorSkillSelectTargetView:_onClick(entityId)
	local oldPosId = SkillEditorView.selectPosId[self._side]
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	SkillEditorView.setSelectPosId(self._side, entityMO.position)

	SkillEditorMgr.instance.cur_select_entity_id = entityId
	SkillEditorMgr.instance.cur_select_side = FightGameMgr.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id):getSide()

	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, SkillEditorMgr.instance.cur_select_side, entityId)
	self:_updateSelectUI()

	if entityMO.position == oldPosId and self._lastClickTime and Time.time - self._lastClickTime < 0.5 then
		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.ShowHeroSelectView, self._side, entityMO.position)
	end

	self._lastClickTime = Time.time
end

function SkillEditorSkillSelectTargetView:_onLongPress(entityId)
	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if entityMO then
		ViewMgr.instance:openView(ViewName.FightFocusView, {
			entityId = entityMO.id
		})
	end
end

return SkillEditorSkillSelectTargetView
