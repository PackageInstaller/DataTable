-- chunkname: @modules/logic/fight/view/FightSeasonChangeHeroView.lua

module("modules.logic.fight.view.FightSeasonChangeHeroView", package.seeall)

local FightSeasonChangeHeroView = class("FightSeasonChangeHeroView", FightBaseView)

function FightSeasonChangeHeroView:onInitView()
	self._block = gohelper.findChildClick(self.viewGO, "block")
	self._blockTransform = self._block:GetComponent(gohelper.Type_RectTransform)
	self._confirmPart = gohelper.findChild(self.viewGO, "#go_SeasonConfirm")

	gohelper.setActive(self._confirmPart, false)

	self._txt_Tips = gohelper.findChildText(self.viewGO, "#go_SeasonConfirm/image_TipsBG/txt_Tips")
	self._selectIcon = gohelper.findChild(self.viewGO, "#go_SeasonConfirm/#go_Selected").transform
	self._skillRoot = gohelper.findChild(self.viewGO, "#go_SeasonConfirm/skillPart/skillRoot")
	self._restrainGO = gohelper.findChild(self.viewGO, "#go_SeasonConfirm/skillPart/restrain/restrain")
	self._beRestrainGO = gohelper.findChild(self.viewGO, "#go_SeasonConfirm/skillPart/restrain/beRestrain")
	self._restrainAnimator = self._restrainGO:GetComponent(typeof(UnityEngine.Animator))
	self._beRestrainAnimator = self._beRestrainGO:GetComponent(typeof(UnityEngine.Animator))
	self._goHeroListRoot = gohelper.findChild(self.viewGO, "#go_fightseasonsubherolist")
end

function FightSeasonChangeHeroView:addEvents()
	self:com_registClick(self._block, self._onBlock)
	self:com_registFightEvent(FightEvent.ReceiveChangeSubHeroReply, self._onReceiveChangeSubHeroReply)
	self:com_registFightEvent(FightEvent.GuideSeasonChangeHeroClickEntity, self._onGuideSeasonChangeHeroClickEntity)
end

function FightSeasonChangeHeroView:removeEvents()
	return
end

function FightSeasonChangeHeroView:_onReceiveChangeSubHeroReply()
	self:_exitOperate(true)
end

function FightSeasonChangeHeroView:_getEntityList()
	return FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)
end

function FightSeasonChangeHeroView:_onGuideSeasonChangeHeroClickEntity(skinId)
	skinId = tonumber(skinId)

	local entityId
	local entityList = FightDataHelper.entityMgr:getMyNormalList()

	for i, entityMO in ipairs(entityList) do
		if entityMO.skin == skinId then
			entityId = entityMO.id

			local entity = FightHelper.getEntity(entityMO.id)
			local rectPos1X, rectPos1Y, rectPos2X, rectPos2Y = FightHelper.calcRect(entity, self._blockTransform)
			local mountmiddleGO = entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
			local rectPosX, rectPosY

			if mountmiddleGO then
				local trposX, trposY, trposZ = transformhelper.getPos(mountmiddleGO.transform)

				rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(trposX, trposY, trposZ, self._blockTransform)
			else
				rectPosX = (rectPos1X + rectPos2X) / 2
				rectPosY = (rectPos1Y + rectPos2Y) / 2
			end

			self:_clickEntity(entityId, rectPosX, rectPosY)

			break
		end
	end
end

function FightSeasonChangeHeroView:_onBlock(param, screenPosition)
	if not self._selectItem then
		self:_exitOperate()

		return
	end

	local entityList = self:_getEntityList()
	local entityId, rectPosX, rectPosY = FightHelper.getClickEntity(entityList, self._blockTransform, screenPosition)

	if entityId then
		local entityMO = FightDataHelper.entityMgr:getById(entityId)

		if not entityMO then
			return
		end

		self:_clickEntity(entityId, rectPosX, rectPosY)

		return
	end

	self:_exitOperate()
end

function FightSeasonChangeHeroView:_clickEntity(entityId, rectPosX, rectPosY)
	if self._curSelectEntityId == entityId then
		FightRpc.instance:sendChangeSubHeroRequest(self._selectItem._entityId, entityId)
	else
		self._txt_Tips.text = luaLang("fight_season_change_hero_confirm")
		self._curSelectEntityId = entityId

		gohelper.setActive(self._selectIcon, false)
		gohelper.setActive(self._selectIcon, true)
		recthelper.setAnchor(self._selectIcon, rectPosX, rectPosY)
		self:com_sendFightEvent(FightEvent.SeasonSelectChangeHeroTarget, self._curSelectEntityId)
	end
end

function FightSeasonChangeHeroView:_onLoadFinish(success, loader)
	if not success then
		return
	end

	local tarPrefab = loader:GetResource()
	local obj = gohelper.clone(tarPrefab, self._skillRoot)

	self._skillItem = MonoHelper.addNoUpdateLuaComOnceToGo(obj, FightViewCardItem)

	self:_refreshSkill()
end

function FightSeasonChangeHeroView:_refreshSkill()
	if not self._skillItem then
		return
	end

	if self._selectItem then
		local entityMO = FightDataHelper.entityMgr:getById(self._selectItem._entityId)

		self._skillItem:updateItem(entityMO.id, entityMO.exSkill)

		local newRestrainStatus = FightViewHandCardItemRestrain.getNewRestrainStatus(entityMO.id, entityMO.exSkill)
		local gmHandCardRestrain = GMFightShowState.handCardRestrain

		gohelper.setActive(self._restrainGO, newRestrainStatus == FightViewHandCardItemRestrain.RestrainMvStatus.Restrain and gmHandCardRestrain)
		gohelper.setActive(self._beRestrainGO, newRestrainStatus == FightViewHandCardItemRestrain.RestrainMvStatus.BeRestrain and gmHandCardRestrain)

		if newRestrainStatus == FightViewHandCardItemRestrain.RestrainMvStatus.Restrain then
			self._restrainAnimator:Play("fight_restrain_all_not", 0, 0)
			self._restrainAnimator:Update(0)
		elseif newRestrainStatus == FightViewHandCardItemRestrain.RestrainMvStatus.BeRestrain then
			self._beRestrainAnimator:Play("fight_restrain_all_not", 0, 0)
			self._beRestrainAnimator:Update(0)
		end
	end
end

function FightSeasonChangeHeroView:selectItem(item)
	self._selectItem = item

	if not self._loadedSkill then
		self._loadedSkill = true

		local cardPath = "ui/viewres/fight/fightcarditem.prefab"

		self:com_loadAsset(cardPath, self._onLoadFinish)
	else
		self:_refreshSkill()
	end
end

function FightSeasonChangeHeroView:_exitOperate(changed)
	gohelper.setActive(self._block, false)
	gohelper.setActive(self._confirmPart, false)
	gohelper.setActive(self._selectIcon, false)

	if self._fightdardObj then
		gohelper.setActive(self._fightdardObj, false)
	end

	local entityList = self:_getEntityList()

	for i, entity in ipairs(entityList) do
		if entity.spine then
			entity:setRenderOrder(FightRenderOrderMgr.instance:getOrder(entity.id))
			FightRenderOrderMgr.instance:register(entity.id)
		end
	end

	self._curSelectEntityId = nil
	self._selectItem = nil

	self._heroListView:_exitOperate(changed)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)
	NavigateMgr.instance:removeEscape(self.viewContainer.viewName)
end

function FightSeasonChangeHeroView:_enterOperate()
	self._txt_Tips.text = luaLang("fight_season_change_hero_select")

	if not self._loadedFightDard then
		self._loadedFightDard = true

		local fightdard = "effects/prefabs/buff/fightdark.prefab"

		self:com_loadAsset(fightdard, self._onFightdardLoadFinish)
	elseif self._fightdardObj then
		gohelper.setActive(self._fightdardObj, true)
	end

	local entityList = self:_getEntityList()

	for i, entity in ipairs(entityList) do
		if entity.spine then
			if not entity.spine._renderOrder then
				entity:setRenderOrder(20000 + entity.spine._renderOrder)
				FightRenderOrderMgr.instance:unregister(entity.id)
			end
		end
	end

	gohelper.setActive(self._block, true)
	gohelper.setActive(self._confirmPart, true)
	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)
	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onBtnEsc, self)
end

function FightSeasonChangeHeroView:_onFightdardLoadFinish(success, loader)
	if not success then
		return
	end

	local baseOrder = 20000
	local tarPrefab = loader:GetResource()

	self._fightdardObj = gohelper.clone(tarPrefab)

	local obj = gohelper.findChild(self._fightdardObj, "fightdark")

	obj:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = baseOrder

	if FightDataHelper.stageMgr:getCurOperateState() ~= FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(self._fightdardObj, false)
	end
end

function FightSeasonChangeHeroView:_onBtnEsc()
	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.SeasonChangeHero then
		self:_exitOperate()
	end
end

function FightSeasonChangeHeroView:onOpen()
	gohelper.setActive(self._block, false)
	gohelper.setActive(self._selectIcon, false)

	self._heroListView = self:com_openSubView(FightSeasonSubHeroList, "ui/viewres/fight/fightseasonsubherolist.prefab", self._goHeroListRoot)
end

function FightSeasonChangeHeroView:onClose()
	if self._fightdardObj then
		gohelper.destroy(self._fightdardObj)
	end
end

function FightSeasonChangeHeroView:onDestroyView()
	return
end

return FightSeasonChangeHeroView
