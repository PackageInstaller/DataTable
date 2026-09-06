-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffCatchPerform.lua

module("logicscene.scene.battle.skills.buffs.BuffCatchPerform", package.seeall)

local BuffCatchPerform = class("BuffCatchPerform", BuffBase)

function BuffCatchPerform:ctor(buffCo, unit, itemId, success)
	self.itemId = itemId
	self.success = success

	BuffCatchPerform.super.ctor(self, buffCo, unit)

	self._catchAnimPlayer = BattleAnimationPlayer.New(unit)
end

function BuffCatchPerform:_buildEffects()
	return
end

function BuffCatchPerform:getBuffId()
	return UnitCompBuffList.CatchPerformId
end

function BuffCatchPerform:onBuffBegin()
	BuffCatchPerform.super.onBuffBegin(self)
	self:_playItemUseEffect()
	self:_startItemPath()
	self._unit.attrs:setItemUsing(true)
end

function BuffCatchPerform:_playItemUseEffect()
	self._itemWidget = BattleItemController.instance:getItemWidget(self.itemId):GetComponent("RectTransform")
	self._itemUseEff = UIEffectManager.instance:playEffectBrief(BattleController.instance.battleMainview, "fx_ui_jinglingbuzhuo/fx_ui_jinglingqiu_chufa.prefab", self._itemWidget, true)

	self._itemUseEff:setParent(BattleController.instance.battleMainview.mainGO.transform)
	self._itemUseEff:setScale(1)
end

function BuffCatchPerform:_destroyItemUseEffect()
	if self._itemUseEff then
		UIEffectManager.instance:stopEffect(self._itemUseEff)

		self._itemUseEff = nil
	end
end

function BuffCatchPerform:_startItemPath()
	local rootTrans = BattleController.instance.battleMainview.mainGO:GetComponent("RectTransform")
	local resTrail = Framework.ResourceCache.Instance:GetResourceNoLoadIfNotExists("effect/prefabs/ui/fx_ui_jinglingbuzhuo/fx_ui_jinglingqiu_guiji.prefab")
	local assetTrail = resTrail:GetMainAsset()
	local item = BattleItemsModel.instance:getBattleItemById(self.itemId)
	local res = Framework.ResourceCache.Instance:GetResourceNoLoadIfNotExists(item:getItemModel())
	local asset = res:GetMainAsset()

	self._trail = UnityEngine.GameObject.Instantiate(assetTrail, rootTrans)

	local ballParent = goutil.findChild(self._trail, "qiu_all")

	self._ballGo = UnityEngine.GameObject.Instantiate(asset, ballParent.transform)

	GoUtil.SetSortingOrder(self._trail, 200)

	self._trail.transform.position = self._itemWidget.position

	local screenPos = self._unit:getUnitScreenPos(UnitConst.spineCenterPointPath)
	local localPos = self._trail.transform.localPosition
	local dest = UGUIToolHelper.ScreenToUGUILocalPosition(rootTrans, GlobalModel.instance.uiCamera, screenPos)
	local bezier = UnityTweens.TweenBezier.StartTween(self._trail, localPos, dest, Vector3.New(-1200, 500, 0), Vector3.New(600, 500, 0), math.random(0.5, 1), UnityTweens.EaseType.easeInSine)

	bezier:AddListener(function()
		self:_startPlayAnimation()
		self:_destroyTrailEffect()
	end, nil)
end

function BuffCatchPerform:_destroyTrailEffect()
	if self._trail then
		UnityEngine.GameObject.Destroy(self._trail)

		self._trail = nil
	end
end

function BuffCatchPerform:_startPlayAnimation()
	local skillPath = self.success and GameUrl.getSkillAnimTakePath(BattleAnimationPlayer.catchSuccessAnim) or GameUrl.getSkillAnimTakePath(BattleAnimationPlayer.catchFailedAnim)
	local resTarget0 = Framework.ResourceCache.Instance:GetResourceNoLoadIfNotExists("effect/prefabs/ui/fx_ui_jinglingbuzhuo/fx_ui_jinglingqiu_buzhuo.prefab")
	local resTarget1 = Framework.ResourceCache.Instance:GetResourceNoLoadIfNotExists("effect/prefabs/ui/fx_ui_jinglingbuzhuo/fx_ui_jinglingqiu_zhengzha.prefab")
	local assetTarget0 = resTarget0:GetMainAsset()
	local assetTarget1 = resTarget1:GetMainAsset()

	self._targetGo0 = UnityEngine.GameObject.Instantiate(assetTarget0)
	self._targetGo1 = UnityEngine.GameObject.Instantiate(assetTarget1)
	self._targetGo0.name = "target0__dontflip"
	self._targetGo1.name = "target1__dontflip"

	BattleItemController.instance:updateItemSprite(self._targetGo0, "buzhuo/qiu", self.itemId)

	local ballParent = goutil.findChild(self._targetGo1, "jlq_zhengzha/qiu")

	self._ballGo.transform:SetParent(ballParent.transform)

	self._ballGo.layer = self._targetGo0.layer

	GoUtil.SetSortingOrderGreatZero(self._targetGo0, 9999)
	GoUtil.SetSortingOrderGreatZero(self._targetGo1, 9999)
	Framework.TransformUtil.SetLocalPos(self._ballGo.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self._ballGo.transform, 700, 700, 700)
	Framework.GameObjectUtil.SetLayerRecursively(self._targetGo0, SceneLayer.SkillAnimation_Value)
	Framework.GameObjectUtil.SetLayerRecursively(self._targetGo1, SceneLayer.SkillAnimation_Value)

	self._catchAnimPlayer.onCollisionHandler = self._onCollision
	self._catchAnimPlayer.onCollisionHandlerTarget = self

	self._catchAnimPlayer:play(skillPath, {
		self._targetGo0,
		self._targetGo1
	}, self._onPlayEvent, self)
end

function BuffCatchPerform:_destroySkillEffects()
	if self._targetGo0 then
		UnityEngine.GameObject.Destroy(self._targetGo0)

		self._targetGo0 = nil
	end

	if self._targetGo1 then
		UnityEngine.GameObject.Destroy(self._targetGo1)

		self._targetGo1 = nil
	end
end

function BuffCatchPerform:_onPlayEvent(evt)
	if evt == "stop" or evt == "break" then
		self._isDone = true
	end
end

function BuffCatchPerform:_onCollision()
	self._unit.unitUI:setVisible(false)
	Framework.GameObjectUtil.SetLayerRecursively(self._unit.go, SceneLayer.Invisible_Value)
end

function BuffCatchPerform:isDone()
	return self._isDone
end

function BuffCatchPerform:onBuffEnd()
	BuffCatchPerform.super.onBuffEnd(self)
	self:_destroyItemUseEffect()
	self:_destroyTrailEffect()
	self:_destroySkillEffects()

	if self.success then
		self._unit:setVisible(false)
		self._unit.attrs:setDead(true)
	end

	self._unit.attrs:setItemUsing(false)
end

function BuffCatchPerform:isCustomBuff()
	return true
end

return BuffCatchPerform
