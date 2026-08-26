-- chunkname: @modules/logic/dungeon/view/map/DungeonMapElement.lua

module("modules.logic.dungeon.view.map.DungeonMapElement", package.seeall)

local DungeonMapElement = class("DungeonMapElement", LuaCompBase)

DungeonMapElement.InAnimName = "wenhao_a_001_in"

function DungeonMapElement:ctor(param)
	self._config = param[1]
	self._mapScene = param[2]
	self._sceneElements = param[3]
end

function DungeonMapElement:getElementId()
	return self._config.id
end

function DungeonMapElement:init(go)
	self._go = go
	self._transform = go.transform

	local pos = string.splitToNumber(self._config.pos, "#")

	transformhelper.setLocalPos(self._transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)

	if self._resLoader then
		return
	end

	self._resLoader = MultiAbLoader.New()

	if not string.nilorempty(self._config.res) then
		self._resLoader:addPath(self._config.res)
	end

	self._effectPath = self._config.effect

	if not string.nilorempty(self._effectPath) then
		self._resLoader:addPath(self._effectPath)
	end

	self._exEffectPath = DungeonEnum.ElementExEffectPath[self:getElementId()]

	if self._exEffectPath then
		self._resLoader:addPath(self._exEffectPath)
	end

	self._resLoader:startLoad(self._onResLoaded, self)
end

function DungeonMapElement:hide()
	gohelper.setActive(self._go, false)
end

function DungeonMapElement:show()
	gohelper.setActive(self._go, true)
end

function DungeonMapElement:getVisible()
	return not gohelper.isNil(self._go) and self._go.activeSelf
end

function DungeonMapElement:hasEffect()
	return self._effectPath
end

function DungeonMapElement:showArrow()
	return self._config.showArrow == 1
end

function DungeonMapElement:isValid()
	return not gohelper.isNil(self._go)
end

function DungeonMapElement:setWenHaoGoVisible(value)
	self._wenhaoVisible = value

	gohelper.setActive(self._wenhaoGo, value)
end

function DungeonMapElement:setWenHaoVisible(value)
	if self._config.type == DungeonEnum.ElementType.ToughBattle then
		return
	end

	self._itemGoVisible = value

	if value then
		self:setWenHaoAnim(DungeonMapElement.InAnimName)
	else
		gohelper.setActive(self._itemGo, self._itemGoVisible)
		self:setWenHaoAnim("wenhao_a_001_out")
	end
end

function DungeonMapElement:setWenHaoAnim(name)
	self._wenhaoAnimName = name

	if gohelper.isNil(self._wenhaoGo) then
		return
	end

	if not self._wenhaoGo.activeInHierarchy then
		self:_wenHaoAnimDone()

		return
	end

	if self._wenhaoAnimator == nil then
		local anim = self._wenhaoGo:GetComponent(typeof(UnityEngine.Animator))

		self._wenhaoAnimator = anim and SLFramework.AnimatorPlayer.Get(self._wenhaoGo) or false
	end

	if self._wenhaoAnimator and self._wenhaoAnimator.animator:HasState(0, UnityEngine.Animator.StringToHash(name)) then
		self._wenhaoAnimator:Play(name, self._wenHaoAnimDone, self)
	else
		self:_wenHaoAnimDone()
	end
end

function DungeonMapElement:_wenHaoAnimDone()
	if self._wenhaoAnimator then
		self._wenhaoAnimator.animator.enabled = true
	end

	if self._wenhaoAnimName == "finish" then
		gohelper.destroy(self._go)
		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFinishAndDisposeElement, self._config)
	end

	if self._wenhaoAnimName == DungeonMapElement.InAnimName then
		gohelper.setActive(self._itemGo, self._itemGoVisible)
	end
end

function DungeonMapElement:_destroyGo()
	gohelper.destroy(self._go)
end

function DungeonMapElement:_destroyItemGo()
	gohelper.destroy(self._itemGo)
end

function DungeonMapElement:getItemGo()
	return self._itemGo
end

function DungeonMapElement:setFinish()
	if not self._wenhaoGo or self._config and self._config.type == DungeonEnum.ElementType.ToughBattle then
		self:_destroyGo()

		return
	end

	self:setWenHaoAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(self._destroyItemGo, self, 0.77)
	TaskDispatcher.runDelay(self._destroyGo, self, 1.6)
end

function DungeonMapElement:setFinishAndDotDestroy()
	if not self._wenhaoGo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)

	if self.finishGo then
		gohelper.setActive(self.finishGo, true)

		self.animatorPlayer = SLFramework.AnimatorPlayer.Get(self.finishGo)

		self.animatorPlayer:Play(UIAnimationName.Open, self.setFinishAndDotDestroyAnimationDone, self)
	else
		self:dispose()
	end
end

function DungeonMapElement:setFinishAndDotDestroyAnimationDone()
	self.animatorPlayer:Play(UIAnimationName.Idle, function()
		return
	end, self)
	self:dispose()
end

function DungeonMapElement:onDown()
	self:_onDown()
end

function DungeonMapElement:_onDown()
	self._sceneElements:setElementDown(self)
end

function DungeonMapElement:onClick()
	self._sceneElements:clickElement(self._config.id)
end

function DungeonMapElement:_onResLoaded()
	DungeonController.instance:registerCallback(DungeonEvent.OnSetEpisodeListVisible, self._onSetEpisodeListVisible, self)

	if not string.nilorempty(self._config.res) then
		local assetItem = self._resLoader:getAssetItem(self._config.res)
		local mainPrefab = assetItem:GetResource(self._config.res)

		self._itemGo = gohelper.clone(mainPrefab, self._go)

		local resScale = self._config.resScale

		if resScale and resScale ~= 0 then
			transformhelper.setLocalScale(self._itemGo.transform, resScale, resScale, 1)
		end

		gohelper.setLayer(self._itemGo, UnityLayer.Scene, true)
		DungeonMapElement.addBoxColliderListener(self._itemGo, self._onDown, self)
		transformhelper.setLocalPos(self._itemGo.transform, 0, 0, -1)
	end

	if not string.nilorempty(self._effectPath) then
		local offsetPos = string.splitToNumber(self._config.tipOffsetPos, "#")

		self._offsetX = offsetPos[1] or 0
		self._offsetY = offsetPos[2] or 0
		self._offsetZ = offsetPos[3] or -3

		local assetItem = self._resLoader:getAssetItem(self._effectPath)
		local mainPrefab = assetItem:GetResource(self._effectPath)

		self._wenhaoGo = gohelper.clone(mainPrefab, self._go)

		if self._wenhaoVisible == false then
			self:setWenHaoGoVisible(false)
		end

		DungeonMapElement.addBoxColliderListener(self._wenhaoGo, self._onDown, self)
		transformhelper.setLocalPos(self._wenhaoGo.transform, self._offsetX, self._offsetY, self._offsetZ)

		self.finishGo = gohelper.findChild(self._wenhaoGo, "ani/yuanjian_new_07/gou")

		gohelper.setActive(self.finishGo, false)

		if self._mapScene:showInteractiveItem() then
			self:setWenHaoVisible(false)
		elseif self._wenhaoAnimName then
			self:setWenHaoAnim(self._wenhaoAnimName)
		end

		if string.find(self._effectPath, "hddt_front_lubiao_a_002") then
			local plane = gohelper.findChild(self._wenhaoGo, "ani/plane")
			local renderer = plane:GetComponent(typeof(UnityEngine.Renderer))
			local mat = renderer.material
			local vec4 = mat:GetVector("_Frame")

			vec4.w = DungeonEnum.ElementTypeIconIndex[string.format("%s0", self._config.type)]

			mat:SetVector("_Frame", vec4)
		end
	end

	if self._exEffectPath then
		local assetItem = self._resLoader:getAssetItem(self._exEffectPath)
		local mainPrefab = assetItem:GetResource(self._exEffectPath)

		self._exEffectGo = gohelper.clone(mainPrefab, self._go)

		transformhelper.setLocalPos(self._exEffectGo.transform, 0, 0, 0)
	end

	if self._config.param == tostring(DungeonMapModel.instance.lastElementBattleId) then
		DungeonMapModel.instance.lastElementBattleId = nil

		self:_clickDirect()
	end
end

function DungeonMapElement:_onAddAnimDone()
	if self._config.type == DungeonEnum.ElementType.ToughBattle then
		local actId = tonumber(self._config.param) or 0

		if actId == 0 then
			if ToughBattleModel.instance:getStoryInfo() then
				self:_checkToughBattleIsFinish()
			else
				self._waitId = SiegeBattleRpc.instance:sendGetSiegeBattleInfoRequest(self._checkToughBattleIsFinish, self)
			end
		elseif ToughBattleModel.instance:getIsJumpActElement() then
			self:_delayClick(1)
		end
	end
end

function DungeonMapElement:_checkToughBattleIsFinish()
	self._waitId = nil

	if ToughBattleModel.instance:isStoryFinish() then
		self:_delayClick(0.5)
	end
end

function DungeonMapElement:_delayClick(sec)
	UIBlockHelper.instance:startBlock("DungeonMapElementDelayClick", sec, ViewName.DungeonMapView)
	TaskDispatcher.runDelay(self._clickDirect, self, sec)
end

function DungeonMapElement:_clickDirect()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipClickElement) then
		return
	end

	DungeonMapModel.instance.directFocusElement = true

	self:onClick()

	DungeonMapModel.instance.directFocusElement = false
end

function DungeonMapElement:_onSetEpisodeListVisible(value)
	self:setWenHaoVisible(value)
end

function DungeonMapElement:addEventListeners()
	return
end

function DungeonMapElement:removeEventListeners()
	DungeonController.instance:unregisterCallback(DungeonEvent.OnSetEpisodeListVisible, self._onSetEpisodeListVisible, self)
end

function DungeonMapElement:onStart()
	return
end

function DungeonMapElement.addBoxCollider2D(go)
	local clickListener = ZProj.BoxColliderClickListener.Get(go)
	local box = go:GetComponent(typeof(UnityEngine.BoxCollider2D))

	if not box then
		box = gohelper.onceAddComponent(go, typeof(UnityEngine.BoxCollider2D))
		box.size = Vector2(1.5, 1.5)
	end

	box.enabled = true

	clickListener:SetIgnoreUI(true)

	return clickListener
end

function DungeonMapElement.addBoxColliderListener(go, callback, callbackTarget)
	local clickListener = DungeonMapElement.addBoxCollider2D(go)

	clickListener:AddClickListener(callback, callbackTarget)
end

function DungeonMapElement:getTransform()
	return self._transform
end

function DungeonMapElement:dispose()
	self._itemGo = nil
	self._wenhaoGo = nil
	self._go = nil
	self.animatorPlayer = nil

	if self._resLoader then
		self._resLoader:dispose()

		self._resLoader = nil
	end

	TaskDispatcher.cancelTask(self._destroyItemGo, self)
	TaskDispatcher.cancelTask(self._destroyGo, self)
end

function DungeonMapElement:onDestroy()
	if self._itemGo then
		gohelper.destroy(self._itemGo)

		self._itemGo = nil
	end

	if self._wenhaoGo then
		gohelper.destroy(self._wenhaoGo)

		self._wenhaoGo = nil
	end

	if self._go then
		gohelper.destroy(self._go)

		self._go = nil
	end

	if self._resLoader then
		self._resLoader:dispose()

		self._resLoader = nil
	end

	if self.animatorPlayer then
		self.animatorPlayer = nil
	end

	if self._waitId then
		SiegeBattleRpc.instance:removeCallbackById(self._waitId)

		self._waitId = nil
	end

	TaskDispatcher.cancelTask(self._clickDirect, self)
	TaskDispatcher.cancelTask(self._destroyItemGo, self)
	TaskDispatcher.cancelTask(self._destroyGo, self)
end

return DungeonMapElement
