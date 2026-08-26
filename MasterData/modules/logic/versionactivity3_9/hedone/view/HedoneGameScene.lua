-- chunkname: @modules/logic/versionactivity3_9/hedone/view/HedoneGameScene.lua

module("modules.logic.versionactivity3_9.hedone.view.HedoneGameScene", package.seeall)

local HedoneGameScene = class("HedoneGameScene", BaseViewExtended)

local function _delayRecycleVFXItem(vfxItem)
	local scene = vfxItem and vfxItem.scene

	if scene then
		scene:_recycleVFXItem(vfxItem)
	end
end

function HedoneGameScene:onInitView()
	self._gomonsterNode = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer/#go_node/#go_monsterNode")
	self._gomonster = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer/#go_node/#go_monsterNode/#go_monster")
	self._gomonsterHp = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer/#go_node/#go_monsterHpNode/#go_hp")
	self._gomonsterFloats = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer/#go_node/#go_monsterFloatNode/#go_floats")
	self._goeffect = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer/#go_node/#go_effectLayer/#go_effectNode/#go_effect")
	self._goShowEffectNode = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer/#go_node/#go_effectLayer/#go_showEffectNode")
	self._gobullet = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer/#go_node/#go_effectLayer/#go_bulletNode/#go_bullet")
	self._goPlayer = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer/#go_player")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HedoneGameScene:addEvents()
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnAddEntity, self._onAddEntity, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnAddEntities, self._onAddEntities, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnEntityTakeDamage, self._onEntityTakeDamage, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnRemoveEntity, self._onRemoveEntity, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.RefreshEntityMove, self._onRefreshEntityMove, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnPlayerExpChange, self._onPlayerExpChange, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.EntityPlayEffect, self._onEntityPlayEffect, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.EntityPlayAnim, self._onEntityPlayAnim, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.ShowVisualEffect, self._onShowVisualEffect, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnEntityAttributeChange, self._onEntityAttributeChange, self)
	self.addEventCb(self, HedoneGameController.instance, HedoneEvent.OnGameReset, self._onGameReset, self)
end

function HedoneGameScene:removeEvents()
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnAddEntity, self._onAddEntity, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnAddEntities, self._onAddEntities, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnEntityTakeDamage, self._onEntityTakeDamage, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnRemoveEntity, self._onRemoveEntity, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.RefreshEntityMove, self._onRefreshEntityMove, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnPlayerExpChange, self._onPlayerExpChange, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.EntityPlayEffect, self._onEntityPlayEffect, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.EntityPlayAnim, self._onEntityPlayAnim, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.ShowVisualEffect, self._onShowVisualEffect, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnEntityAttributeChange, self._onEntityAttributeChange, self)
	self.removeEventCb(self, HedoneGameController.instance, HedoneEvent.OnGameReset, self._onGameReset, self)
end

function HedoneGameScene:_onAddEntity(uid)
	if not uid then
		return
	end

	self:_tryAddEntity(uid)
end

function HedoneGameScene:_onAddEntities(uidList)
	if not uidList or #uidList <= 0 then
		return
	end

	for _, uid in ipairs(uidList) do
		self:_tryAddEntity(uid)
	end
end

function HedoneGameScene:_tryAddEntity(uid)
	local existEntity = self:getEntity(uid)

	if existEntity then
		logError(string.format("HedoneGameScene:_onAddEntities error, uid:%s already exist", uid))

		return
	end

	local mo = HedoneGameModel.instance:getEntityMO(uid)

	if not mo then
		logError(string.format("HedoneGameScene:_onAddEntities error, uid:%s no mo", uid))

		return
	end

	local entityType = mo:getEntityType()
	local entity = self:_getEntityFromPool(entityType)

	if not entity then
		return
	end

	entity:setUid(uid)

	if entityType == HedoneGameEnum.EntityType.Monster then
		local x, y = mo:getPosition()
		local yLevel = mo:getYLevel()
		local yGO = self._yLevelGODict[yLevel]

		if gohelper.isNil(yGO) then
			logError(string.format("HedoneGameScene:_onAddEntities error, uid:%s yLevel:%s no yLevelGO", uid, yLevel))
		else
			entity:setYLevel(yLevel, yGO)
		end

		local id = entity:getId()
		local isShowHp = HedoneConfig.instance:getHedoneMonsterIsShowHp(id)

		if isShowHp then
			self:_addHpItem(uid, x, y)
		end

		self:_addFloatComp(uid, x, y)
	end

	self._uid2EntityDict[uid] = entity

	local uidDict = GameUtil.tabletool_checkDictTable(self._entityType2UidDict, entityType)

	uidDict[uid] = true

	if HedoneGameEnum.MovableEntityTypeDict[entityType] then
		self._movableUidDict[uid] = true
	end

	local resPath = entity:getPrefabResPath()

	self:_loadEntityRes(uid, resPath)
	entity:playAnim(HedoneGameEnum.EntityAnimName.Born)
end

function HedoneGameScene:_onEntityTakeDamage(uid, damage, isCrit, isAlive)
	if uid == HedoneGameEnum.Const.PlayerUid then
		self._playerEntity:playAnim(HedoneGameEnum.EntityAnimName.Hit)

		return
	end

	local entity = uid and self:getEntity(uid)

	if not entity then
		return
	end

	local floatComp = self._uid2FloatComp[uid]

	if floatComp then
		floatComp:showFloat(damage, isCrit)
	end

	local hpItem = self._uid2HpItem[uid]

	if hpItem then
		local hp = 0
		local hpCap = 0
		local mo = entity:getMO()

		if mo then
			hp = mo:getAttrValue(HedoneGameEnum.Attribute.Hp)
			hpCap = mo:getAttrValue(HedoneGameEnum.Attribute.HpCap)
		end

		if hpCap > 0 then
			hpItem.imagehpfg.fillAmount = hp / hpCap or 0
		end
	end

	entity:onTakeDamage(damage, isCrit)

	if not isAlive then
		entity:playAnim(HedoneGameEnum.EntityAnimName.Die, self._afterEntityPlayDeadAnim, self, uid)
	end
end

function HedoneGameScene:_afterEntityPlayDeadAnim(uid)
	local mo = HedoneGameModel.instance:getEntityMO(uid)
	local entityType = mo and mo:getEntityType()

	if entityType == HedoneGameEnum.EntityType.Monster then
		local id = mo:getId()
		local exp = HedoneConfig.instance:getHedoneMonsterExp(id)
		local x, y = mo:getPosition()

		self._expBallComp:addExpBall(exp, x, y)
	end

	HedoneGameController.instance:removeEntity(uid)
end

function HedoneGameScene:_onRemoveEntity(uid)
	self:_recycleEntity(uid)
end

function HedoneGameScene:_onRefreshEntityMove()
	for uid, _ in pairs(self._movableUidDict) do
		local entity = self:getEntity(uid)

		if entity then
			local mo = entity:getMO()

			if mo then
				local x, y = mo:getPosition()
				local floatComp = self._uid2FloatComp[uid]

				if floatComp then
					floatComp:setPosition(x, y, 0)
				end

				local hpItem = self._uid2HpItem[uid]

				if hpItem then
					transformhelper.setLocalPos(hpItem.trans, x, y, 0)
				end
			end

			entity:refreshPosition()
		end
	end
end

function HedoneGameScene:_onPlayerExpChange(getNewSkillCount)
	if getNewSkillCount and getNewSkillCount > 0 then
		self._playerEntity:onLevelUp()
	end
end

function HedoneGameScene:_onEntityPlayEffect(uid, effectName)
	local entity = self:getEntity(uid)

	if not entity then
		return
	end

	local isNeedLoad = entity:getIsNeedLoadEffect(effectName)

	if isNeedLoad then
		local resPath = string.format(HedoneGameEnum.Const.EffectResPath, effectName)

		self:com_loadAsset((not GameResMgr.IsFromEditorDir or nil) and FightHelper.getEffectAbPath(resPath), self._onLoadEffectFinish, nil, {
			uid = uid,
			effectName = effectName,
			res = resPath
		})
	else
		entity:playEffect(effectName)
	end
end

function HedoneGameScene:_onLoadEffectFinish(assetItem, params)
	local uid = params and params.uid
	local entity = self:getEntity(uid)

	if not assetItem or not entity then
		return
	end

	local res = params.res
	local effectObj = assetItem:GetResource(res)

	entity:addEffect(params.effectName, effectObj)
end

function HedoneGameScene:_onEntityPlayAnim(uid, animName)
	local entity = self:getEntity(uid)

	if not entity then
		return
	end

	entity:playAnim(animName)
end

function HedoneGameScene:_onShowVisualEffect(targetUid, vfxName, duration, x, y, scale)
	if not targetUid or not duration or duration <= 0 or not x or not y then
		return
	end

	if self._playingVfxDict[targetUid] and self._playingVfxDict[targetUid][vfxName] then
		return
	end

	local vfxItem = self:_getVFXItem(vfxName)

	if not vfxItem then
		return
	end

	local dict = GameUtil.tabletool_checkDictTable(self._playingVfxDict, targetUid)

	dict[vfxName] = true
	self._usingVFXItemDict[vfxItem] = targetUid

	transformhelper.setLocalPos(vfxItem.trans, x, y, 0)
	transformhelper.setLocalScale(vfxItem.trans, scale or 1, scale or 1, 1)

	if vfxItem.psComp then
		vfxItem.psComp:Play()
	end

	TaskDispatcher.runDelay(_delayRecycleVFXItem, vfxItem, duration)
end

function HedoneGameScene:_onEntityAttributeChange(uid, attrId, attrSubId, oldValue, newValue)
	if uid ~= HedoneGameEnum.Const.PlayerUid then
		return
	end

	local effectUidDict = self._entityType2UidDict[HedoneGameEnum.EntityType.Effect]

	if attrId == HedoneGameEnum.Attribute.EffectRange and attrSubId and effectUidDict then
		for tUid, _ in pairs(effectUidDict) do
			local entity = self:getEntity(tUid)
			local id = entity and entity:getId()
			local effectGroup = HedoneConfig.instance:getHedoneEffectGroup(id)

			if effectGroup == attrSubId then
				entity:refreshScale()
			end
		end
	end
end

function HedoneGameScene:_onGameReset()
	self:_recycleAllEntity()
	self:_recycleAllVFXItem()
	self._expBallComp:recycleAllExpBallItem()
end

function HedoneGameScene:_editableInitView()
	local goexpnode = gohelper.findChild(self.viewGO, "HedoneGameView_SecondLayer/#go_node/#go_effectLayer/#go_expNode")
	local goExpBallEnd = gohelper.findChild(self.viewGO, "view/#go_playerinfo/#go_exp/#go_expBallEnd")
	local endPos = goexpnode.transform:InverseTransformPoint(goExpBallEnd.transform.position)

	self._expBallComp = MonoHelper.addNoUpdateLuaComOnceToGo(goexpnode, HedoneGameExpBallComp, {
		endX = endPos.x,
		endY = endPos.y
	})
	self._playerEntity = MonoHelper.addNoUpdateLuaComOnceToGo(self._goPlayer, HedonePlayerEntity)

	gohelper.setActive(self._gomonsterHp, false)

	self._yLevelGODict = {}

	local yLevelPosList = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.MonsterYLevel, false, true, "|")

	for i = 1, #yLevelPosList do
		local yGO = gohelper.create2d(self._gomonsterNode, i)
		local yTrans = yGO.transform

		yTrans.anchorMin = Vector2.zero
		yTrans.anchorMax = Vector2.one
		yTrans.offsetMin = Vector2.zero
		yTrans.offsetMax = Vector2.zero
		self._yLevelGODict[i] = yGO
	end

	self._entityTypeGODict = self:getUserDataTb_()
	self._entityTypeGODict[HedoneGameEnum.EntityType.Monster] = self._gomonster
	self._entityTypeGODict[HedoneGameEnum.EntityType.Bullet] = self._gobullet
	self._entityTypeGODict[HedoneGameEnum.EntityType.Effect] = self._goeffect
	self._uid2EntityDict = {}
	self._uid2HpItem = {}
	self._hpItemPool = {}
	self._uid2FloatComp = {}
	self._floatCompPool = {}
	self._entityType2UidDict = {}
	self._entityPool = {}
	self._movableUidDict = {}
	self._loadingEntityDict = {}
	self._vfxName2Pool = {}
	self._usingVFXItemDict = {}
	self._playingVfxDict = {}
	self._loadingVFXItemDict = {}
end

function HedoneGameScene:onUpdateParam()
	return
end

function HedoneGameScene:onOpen()
	return
end

function HedoneGameScene:_loadEntityRes(uid, resPath)
	local isGameEnd = HedoneGameModel.instance:getIsGameEnd()

	if isGameEnd or not uid or string.nilorempty(resPath) then
		return
	end

	local entity = self:getEntity(uid)

	if not entity or self._loadingEntityDict[uid] then
		return
	end

	local assetUrl = resPath

	if not GameResMgr.IsFromEditorDir then
		assetUrl = FightHelper.getEffectAbPath(resPath)
	end

	self._loadingEntityDict[uid] = true

	self:com_loadAsset(assetUrl, self._onLoadEntityResFinish, self._onLoadEntityResFail, {
		uid = uid,
		res = resPath
	})
end

function HedoneGameScene:_onLoadEntityResFinish(assetItem, params)
	local uid = params and params.uid

	if not uid or not self._loadingEntityDict[uid] then
		return
	end

	self._loadingEntityDict[uid] = nil

	local isGameEnd = HedoneGameModel.instance:getIsGameEnd()

	if isGameEnd then
		return
	end

	local entity = self:getEntity(uid)

	if not assetItem or not entity then
		return
	end

	local res = params.res
	local prefabObj = assetItem:GetResource(res)

	entity:setPrefab(prefabObj, res)
end

function HedoneGameScene:_onLoadEntityResFail(assetUrl, params)
	local uid = params and params.uid
	local resPath = params and params.res
	local entity

	if uid then
		self._loadingEntityDict[uid] = nil
		entity = self:getEntity(uid)
	end

	local id = entity and entity:getId()
	local entityType = entity and entity:getEntityType()

	logError(string.format("HedoneGameScene:_onLoadEntityResFail,assetUrl:%s resPath:%s, uid:%s, id:%s, entityType:%s", assetUrl, resPath, tostring(uid), tostring(id), tostring(entityType)))
end

function HedoneGameScene:getEntity(uid)
	if uid == HedoneGameEnum.Const.PlayerUid then
		return self._playerEntity
	else
		return self._uid2EntityDict[uid]
	end
end

function HedoneGameScene:_getEntityFromPool(entityType)
	local pool = self._entityPool[entityType]

	if pool and #pool > 0 then
		return table.remove(pool)
	end

	local entityCls = HedoneGameHelper.getEntityCls(entityType)

	if not entityCls then
		return
	end

	local entityGO = self._entityTypeGODict[entityType]

	if gohelper.isNil(entityGO) then
		logError(string.format("HedoneGameScene:getEntityFromPool error, entityType:%s no entity go", entityType))

		return
	end

	local go = gohelper.cloneInPlace(entityGO, HedoneGameEnum.Const.EntityDefaultName)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, entityCls)
end

function HedoneGameScene:_addHpItem(uid, x, y)
	if not uid or self._uid2HpItem[uid] then
		return
	end

	local hpItem

	if #self._hpItemPool > 0 then
		hpItem = table.remove(self._hpItemPool)
		hpItem.go.name = uid
	else
		hpItem = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gomonsterHp, uid)

		hpItem.go = go
		hpItem.trans = go.transform
		hpItem.imagehpfg = gohelper.findChildImage(go, "#image_hpbg/#image_hpfg")
	end

	if x and y then
		transformhelper.setLocalPos(hpItem.trans, x, y, 0)
	end

	hpItem.imagehpfg.fillAmount = 1

	gohelper.setActive(hpItem.go, true)

	self._uid2HpItem[uid] = hpItem
end

function HedoneGameScene:_addFloatComp(uid, x, y)
	if not uid or self._uid2FloatComp[uid] then
		return
	end

	local floatComp

	if #self._floatCompPool > 0 then
		floatComp = table.remove(self._floatCompPool)

		local go = floatComp:getGO()

		go.name = uid
	else
		local go = gohelper.cloneInPlace(self._gomonsterFloats, uid)

		floatComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, HedoneGameFloatComp)
	end

	self._uid2FloatComp[uid] = floatComp

	floatComp:setPosition(x, y, 0)
end

function HedoneGameScene:_recycleEntity(uid)
	local entity = uid and self:getEntity(uid)

	if not entity then
		return
	end

	self:_recycleHpItem(uid)
	self:_recycleFloatComp(uid)

	local entityType = entity:getEntityType()

	self._uid2EntityDict[uid] = nil

	local uidDict = self._entityType2UidDict[entityType]

	if uidDict then
		uidDict[uid] = nil
	end

	self._movableUidDict[uid] = nil
	self._loadingEntityDict[uid] = nil

	local pool = GameUtil.tabletool_checkDictTable(self._entityPool, entityType)

	entity:recycle()
	table.insert(pool, entity)
end

function HedoneGameScene:_recycleHpItem(uid)
	local hpItem = self._uid2HpItem[uid]

	if hpItem then
		table.insert(self._hpItemPool, hpItem)
		gohelper.setActive(hpItem.go, false)

		self._uid2HpItem[uid] = nil
	end
end

function HedoneGameScene:_recycleFloatComp(uid)
	local floatComp = self._uid2FloatComp[uid]

	if floatComp then
		table.insert(self._floatCompPool, floatComp)
		floatComp:recycleAllFloatItem()

		self._uid2FloatComp[uid] = nil
	end
end

function HedoneGameScene:_recycleAllEntity()
	if self._uid2EntityDict then
		for uid, entity in pairs(self._uid2EntityDict) do
			self:_recycleHpItem(uid)
			self:_recycleFloatComp(uid)

			local entityType = entity:getEntityType()
			local pool = GameUtil.tabletool_checkDictTable(self._entityPool, entityType)

			entity:recycle()
			table.insert(pool, entity)
		end
	end

	self._uid2EntityDict = {}
	self._entityType2UidDict = {}
	self._movableUidDict = {}
	self._loadingEntityDict = {}
end

function HedoneGameScene:_getVFXItem(vfxName)
	if string.nilorempty(vfxName) then
		return
	end

	local pool = self._vfxName2Pool[vfxName]

	if pool and #pool > 0 then
		return table.remove(pool)
	end

	local vfxItem = self:getUserDataTb_()

	vfxItem.go = gohelper.create2d(self._goShowEffectNode, vfxName)
	vfxItem.trans = vfxItem.go.transform
	vfxItem.name = vfxName
	vfxItem.scene = self

	self:_loadVFXRes(vfxItem)

	return vfxItem
end

function HedoneGameScene:_loadVFXRes(vfxItem)
	local vfxName = vfxItem.name

	if string.nilorempty(vfxName) or self._loadingVFXItemDict[vfxItem] then
		return
	end

	self._loadingVFXItemDict[vfxItem] = true

	local resPath = string.format(HedoneGameEnum.Const.EffectResPath, vfxName)

	self:com_loadAsset((not GameResMgr.IsFromEditorDir or nil) and FightHelper.getEffectAbPath(resPath), self._onLoadVFXResFinish, self._onLoadVFXResFail, {
		vfxItem = vfxItem,
		res = resPath
	})
end

function HedoneGameScene:_onLoadVFXResFinish(assetItem, params)
	local vfxItem = params and params.vfxItem

	if not vfxItem or not self._loadingVFXItemDict[vfxItem] then
		return
	end

	self._loadingVFXItemDict[vfxItem] = nil

	local res = params.res
	local vfxObj = assetItem and assetItem:GetResource(res)

	vfxItem.vfxGO = vfxObj and gohelper.clone(vfxObj, vfxItem.go)
	vfxItem.psComp = vfxItem.vfxGO:GetComponent(typeof(Coffee.UIExtensions.UIParticle))
end

function HedoneGameScene:_onLoadVFXResFail(assetUrl, params)
	local vfxItem = params and params.vfxItem
	local resPath = params and params.res

	if vfxItem then
		self._loadingVFXItemDict[vfxItem] = nil
	end

	logError(string.format("HedoneGameScene:_onLoadVFXResFail,assetUrl:%s resPath:%s", assetUrl, resPath))
end

function HedoneGameScene:_recycleVFXItem(vfxItem)
	local vfxName = vfxItem and vfxItem.name

	if string.nilorempty(vfxName) then
		return
	end

	TaskDispatcher.cancelTask(_delayRecycleVFXItem, vfxItem)

	if vfxItem.psComp then
		vfxItem.psComp:Stop()
	end

	local targetUid = self._usingVFXItemDict[vfxItem]

	if not targetUid then
		return
	end

	local dict = self._playingVfxDict[targetUid]

	if dict then
		dict[vfxName] = nil
	end

	self._usingVFXItemDict[vfxItem] = nil

	local pool = GameUtil.tabletool_checkDictTable(self._vfxName2Pool, vfxName)

	pool[#pool + 1] = vfxItem
end

function HedoneGameScene:_recycleAllVFXItem()
	for floatItem, _ in pairs(self._usingVFXItemDict) do
		self:_recycleVFXItem(floatItem)
	end
end

function HedoneGameScene:onClose()
	return
end

function HedoneGameScene:onDestroyView()
	self._entityPool = nil
	self._uid2EntityDict = nil
	self._entityType2UidDict = nil
	self._movableUidDict = nil
	self._loadingEntityDict = nil
end

return HedoneGameScene
