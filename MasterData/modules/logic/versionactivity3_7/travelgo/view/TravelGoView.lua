-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/TravelGoView.lua

module("modules.logic.versionactivity3_7.travelgo.view.TravelGoView", package.seeall)

local TravelGoView = class("TravelGoView", BaseView)

function TravelGoView:onInitView()
	self.controller = TravelGoController.instance
	self.TravelGoBattleComp = gohelper.findChild(self.viewGO, "TravelGoBattleComp")
	self.TravelGoDayComp = gohelper.findChild(self.viewGO, "TravelGoDayComp")
	self.travelGoDayComp = GameFacade.createLuaCompByGo(self.TravelGoDayComp, TravelGoDayComp, self, self.viewContainer)
	self.travelGoBattleComp = GameFacade.createLuaCompByGo(self.TravelGoBattleComp, TravelGoBattleComp, self, self.viewContainer)
	self.playerActor = gohelper.findChild(self.viewGO, "SceneView/playerActor")
	self.playerSpine = MonoHelper.addNoUpdateLuaComOnceToGo(self.playerActor, TravelGoPlayerSpine, self)
	self.SceneView = gohelper.findChild(self.viewGO, "SceneView")
	self.entitys = gohelper.findChild(self.viewGO, "SceneView/entitys")
	self.goActor = gohelper.findChild(self.viewGO, "SceneView/entitys/actor")
	self.effect = gohelper.findChild(self.viewGO, "SceneView/effect")

	gohelper.setActive(self.goActor, false)

	self.simage_FG = gohelper.findChildSingleImage(self.viewGO, "SceneView/#simage_FG")
	self.simage_FG_img = gohelper.findChildImage(self.viewGO, "SceneView/#simage_FG")
	self.moveBkg1 = gohelper.findChildSingleImage(self.viewGO, "SceneView/moveBkgs/imgBkg1")
	self.moveBkg2 = gohelper.findChildSingleImage(self.viewGO, "SceneView/moveBkgs/imgBkg2")
	self.moveBkg3 = gohelper.findChildSingleImage(self.viewGO, "SceneView/moveBkgs/imgBkg3")
	self.moveImgBkgs = {
		self.moveBkg1,
		self.moveBkg2,
		self.moveBkg3
	}
	self.numbers = gohelper.findChild(self.SceneView, "numbers")
	self.TravelGoFloatItem = gohelper.findChild(self.numbers, "TravelGoFloatItem")

	gohelper.setActive(self.TravelGoFloatItem, false)

	self.moveBkgTrans = {
		self.moveBkg1.transform,
		self.moveBkg2.transform,
		self.moveBkg3.transform
	}
	self.moveEntityTrans = {}
	self.bkgW = recthelper.getWidth(self.moveBkg1.transform)
	self.bkgWHalf = self.bkgW / 2
	self.left = -self.bkgW - self.bkgWHalf
	self.floatingTexts = {}
	self.effectPool = {}

	self.travelGoDayComp:onOpen()
end

function TravelGoView:addEvents()
	self.addEventCb(self, self.controller, TravelGoEvent.OnPlayerStartMove, self.onPlayerStartMove, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnPlayerStopMove, self.onPlayerStopMove, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnPlayerMoveToEventPos, self.onPlayerMoveToEventPos, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnPlayerMoveToAttack, self.onPlayerMoveToAttack, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnCreateEntity, self.onCreateEntity, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnRemoveEntity, self.onRemoveEntity, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnCreateFloatItem, self.createFloatItem, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnExecuteEffect, self.onExecuteEffect, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnGameSettle, self.onGameSettle, self)
	self.addEventCb(self, self.controller, TravelGoEvent.OnBattleStart, self.onBattleStart, self)
	self.travelGoDayComp:addEvents()
	self.travelGoBattleComp:addEvents()
end

function TravelGoView:onOpen()
	self.controller:onViewOpen()

	self.cfg = lua_activity220_game.configDict[TravelGoModel.instance.gameId]

	local map = self.cfg.background

	for i, v in ipairs(self.moveImgBkgs) do
		local str = string.format("v3a7_xiaoruiannong_game_scene_%s_%s", map, i)
		local res = ResUrl.getTravelGoSingleBg(str)

		v:LoadImage(res)
	end

	local str = string.format("v3a7_xiaoruiannong_game_scenefg%s", map)

	self.res = ResUrl.getTravelGoSingleBg(str)

	self.simage_FG:LoadImage(self.res, self.onImageLoaded, self)
	TaskDispatcher.runRepeat(self.tick, self, 0)
	recthelper.setAnchorX(self.moveBkg1.transform, -self.bkgW)
	recthelper.setAnchorX(self.moveBkg2.transform, 0)
	recthelper.setAnchorX(self.moveBkg3.transform, self.bkgW)

	self.isStopMove = true

	for i, spine in ipairs(self.moveEntityTrans) do
		gohelper.destroy(spine.viewGO)
	end

	self.moveEntityTrans = {}

	self.playerSpine:setData(self.controller.travelGoEntityMgr.playerEntity)
	self.travelGoDayComp:onOpen()
end

function TravelGoView:onImageLoaded()
	if self.res == "singlebg/v3a7_xiaoruiannong_singlebg/v3a7_xiaoruiannong_game_scenefg3.png" then
		self.simage_FG_img:SetNativeSize()
	else
		recthelper.setSize(self.simage_FG_img.transform, 2592, 648)
	end
end

function TravelGoView:onClose()
	self:clearView()
	TravelGoController.instance:onGameEnd()

	for i, v in ipairs(self.moveImgBkgs) do
		v:UnLoadImage()
	end

	self.simage_FG:UnLoadImage()
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.stop_ui_beiai_xran_foot_loop)
end

function TravelGoView:onDestroyView()
	self:clearView()
end

function TravelGoView:onGameSettle()
	self.isStopMove = true

	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.stop_ui_beiai_xran_foot_loop)
end

function TravelGoView:clearView()
	TaskDispatcher.cancelTask(self.tick, self)

	if self.attackTweenId then
		ZProj.TweenHelper.KillById(self.attackTweenId)

		self.attackTweenId = nil
	end
end

function TravelGoView:onClickBattleFight()
	self.playerSpine:playUIAnim(UIAnimationName.Close)
	gohelper.setActive(self.entitys, false)
end

function TravelGoView:onBattleStart()
	for i, v in ipairs(self.moveEntityTrans) do
		if v:isNpc() then
			gohelper.destroy(v.viewGO)
			table.remove(self.moveEntityTrans, i)

			break
		end
	end
end

function TravelGoView:onBattleStartCompleteShowEntity()
	gohelper.setActive(self.entitys, true)

	local animaName = UIAnimationName.Open

	self.playerSpine:playUIAnim(animaName)
	self:playEnemyAnim(animaName)
end

function TravelGoView:onBattleEventFinishHideEntity()
	local animaName = UIAnimationName.Close

	self.playerSpine:playUIAnim(animaName)
	self:playEnemyAnim(animaName)
end

function TravelGoView:afterBattleCompCloseShowEntityAndDayComp()
	self.travelGoDayComp:onAfterBattleCompCloseShowDayComp()

	local animaName = UIAnimationName.Open

	self.playerSpine:playUIAnim(animaName)
	self:playEnemyAnim(animaName)
end

function TravelGoView:playEnemyAnim(animaName)
	local enemys = TravelGoController.instance.travelGoEntityMgr.enemyEntityList

	for i, v in ipairs(enemys) do
		local spine = self:getEntityActor(v.uid)

		spine:playUIAnim(animaName, true)
	end
end

function TravelGoView:onCreateEntity(entity)
	local go = gohelper.clone(self.goActor, self.entitys)

	gohelper.setActive(go, true)
	recthelper.setAnchor(go.transform, self.controller.EntityCreatePosX, -318)

	local spine = MonoHelper.addNoUpdateLuaComOnceToGo(go, TravelGoEntitySpine, self)

	spine:setData(entity)
	table.insert(self.moveEntityTrans, spine)
end

function TravelGoView:onRemoveEntity(uid)
	for i, v in ipairs(self.moveEntityTrans) do
		if v.uid == uid then
			if v.entityType == TravelGoBattleEnum.EntityType.Enemy then
				gohelper.destroy(v.viewGO)
				table.remove(self.moveEntityTrans, i)
			end

			break
		end
	end
end

function TravelGoView:getEntityActor(uid)
	if uid == self.controller.travelGoEntityMgr.playerEntity.uid then
		return self.playerSpine
	end

	for i, v in ipairs(self.moveEntityTrans) do
		if uid == v.uid then
			return v
		end
	end
end

function TravelGoView:onPlayerStartMove()
	self.isStopMove = false

	self.playerSpine:play("walk", true, false)
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_beiai_xran_foot_loop)
end

function TravelGoView:onPlayerStopMove()
	self.isStopMove = true

	self.playerSpine:play("idle", true, false)
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.stop_ui_beiai_xran_foot_loop)
end

function TravelGoView:onPlayerMoveToEventPos(data)
	local isBattle = data.isBattle

	self.isStopMove = true

	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.stop_ui_beiai_xran_foot_loop)
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_beiai_xran_fly)

	self.moveToTarCurTimeS = 0

	if isBattle then
		if not self.controller.EnemyStopMovePosX then
			local stopMoveX = self.controller.NpcStopMovePosX
			local dis = stopMoveX - self.controller.EntityCreatePosX

			self.moveToTarSpeed = math.abs(dis) / self.controller.PlayerMoveToTime

			self.playerSpine:play("unique2", true, false)
		end
	end
end

function TravelGoView:onPlayerMoveToAttack(uid, isBack, moveTime)
	local actor = self:getEntityActor(uid)

	actor:onPlayerMoveToAttack(isBack, moveTime)
end

function TravelGoView:tick()
	if self.controller.isSettle then
		return
	end

	local deltaTime = Time.deltaTime
	local speed

	if self.moveToTarCurTimeS then
		local curTimeS = self.moveToTarCurTimeS + deltaTime

		if curTimeS >= self.controller.PlayerMoveToTime then
			deltaTime = self.controller.PlayerMoveToTime - self.moveToTarCurTimeS
			self.moveToTarCurTimeS = nil

			self.playerSpine:play("idle", true, false)
		else
			self.moveToTarCurTimeS = curTimeS
		end

		speed = self.moveToTarSpeed
	else
		if self.isStopMove then
			return
		end

		speed = self.controller.bkgMoveSpeed
	end

	local dis = speed * deltaTime

	for i, trans in ipairs(self.moveBkgTrans) do
		local oldX, oldY = recthelper.getAnchor(trans)
		local newPos = oldX - dis

		if newPos <= self.left then
			local remain = newPos - self.left

			recthelper.setAnchor(trans, self.bkgW + self.bkgWHalf + remain, oldY)
		else
			recthelper.setAnchor(trans, oldX - dis, oldY)
		end
	end

	local temps = {}

	for i, spine in ipairs(self.moveEntityTrans) do
		local trans = spine.transform
		local oldX, oldY = recthelper.getAnchor(trans)
		local newPos = oldX - dis

		if newPos <= self.left then
			gohelper.destroy(spine.viewGO)
		else
			table.insert(temps, spine)
			recthelper.setAnchor(trans, oldX - dis, oldY)
		end
	end

	self.moveEntityTrans = temps
end

function TravelGoView:createFloatItem(param)
	local travelGoFloatItem

	if #self.floatingTexts <= 0 then
		local go = gohelper.clone(self.TravelGoFloatItem, self.numbers)

		gohelper.setActive(go, true)

		travelGoFloatItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, TravelGoFloatItem, self)
	else
		travelGoFloatItem = table.remove(self.floatingTexts, 1)
	end

	local actor = self:getEntityActor(param.uid)

	if actor then
		local anchorX, anchorY = recthelper.getAnchor(actor.transform)

		if actor:isPlayer() then
			recthelper.setAnchor(travelGoFloatItem.viewGO.transform, anchorX, anchorY + 530)
		else
			recthelper.setAnchor(travelGoFloatItem.viewGO.transform, anchorX, anchorY + 300)
		end
	else
		recthelper.setAnchor(travelGoFloatItem.viewGO.transform, 0, 0)
	end

	travelGoFloatItem:setData(param, self.onReturnFloatItem, self)

	return travelGoFloatItem
end

function TravelGoView:onReturnFloatItem(item)
	self:returnFloatItem(item)
end

function TravelGoView:returnFloatItem(item)
	table.insert(self.floatingTexts, item)
end

function TravelGoView:onExecuteEffect(uid, res, time, speed)
	local actor = self:getEntityActor(uid)
	local item

	self.effectPool[res] = self.effectPool[res] or {}

	local pool = self.effectPool[res]

	if #pool > 0 then
		item = table.remove(pool, 1)
	else
		local asset = TravelGoController.instance.travelGoBattleMgr:getRes(res)
		local go = gohelper.clone(asset, self.effect)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, TravelGoEffectItem)
	end

	gohelper.setActive(item.viewGO, true)
	item:setData(time, res, speed, self.returnEffect, self)

	local anchorX, anchorY = recthelper.getAnchor(actor.transform)

	recthelper.setAnchor(item.viewGO.transform, anchorX, anchorY)
end

function TravelGoView:returnEffect(item)
	gohelper.setActive(item.viewGO, false)

	local pool = self.effectPool[item.res]

	table.insert(pool, item)
end

return TravelGoView
