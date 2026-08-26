-- chunkname: @modules/logic/weekwalk/view/WeekWalkMapElement.lua

module("modules.logic.weekwalk.view.WeekWalkMapElement", package.seeall)

local WeekWalkMapElement = class("WeekWalkMapElement", LuaCompBase)

function WeekWalkMapElement:ctor(param)
	self._info = param[1]
	self._config = self._info.config
	self._weekwalkMap = param[2]
	self._curMapInfo = WeekWalkModel.instance:getCurMapInfo()
	self._elementRes = self._info:getRes()

	self:_playBgm()
end

function WeekWalkMapElement:_playBgm()
	local type = self._info:getType()

	if type ~= WeekWalkEnum.ElementType.General then
		return
	end

	if self._config.generalType ~= WeekWalkEnum.GeneralType.Bgm then
		return
	end

	self._audioId = self._config.param

	self._weekwalkMap:_playBgm(self._audioId)
end

function WeekWalkMapElement:_stopBgm()
	local type = self._info:getType()

	if type ~= WeekWalkEnum.ElementType.General then
		return
	end

	if self._config.generalType ~= WeekWalkEnum.GeneralType.Bgm or not self._audioId then
		return
	end

	self._weekwalkMap:_stopBgm()

	self._audioId = nil
end

function WeekWalkMapElement:updateInfo(info)
	self._info = info
end

function WeekWalkMapElement:init(go)
	self._go = go
	self._transform = go.transform
end

function WeekWalkMapElement:dispose()
	gohelper.setActive(self._itemGo, false)
	gohelper.destroy(self._go)

	local smokeMaskOffset = self._config.smokeMaskOffset

	if not string.nilorempty(smokeMaskOffset) then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnRemoveSmokeMask, self._config.id)
	end

	self:_stopBgm()
end

function WeekWalkMapElement:disappear(fadeOut)
	if string.nilorempty(self._elementRes) then
		fadeOut = false
	end

	self:_stopBgm()

	self._isDisappear = true

	if not fadeOut then
		if self._lightGo then
			self:_lightFadeOut(self.dispose)

			return
		end

		self:dispose()

		return
	end

	self:_fadeOut()
end

function WeekWalkMapElement:_fadeOut()
	self:_initMats()

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.8, self._frameUpdate, self._fadeOutFinish, self)

	self:_lightFadeOut(self._lightFadeOutDone)
end

function WeekWalkMapElement:_lightFadeOut(callback)
	if self._lightGo then
		local animatorPlayer = SLFramework.AnimatorPlayer.Get(self._lightGo)

		animatorPlayer:Play("weekwalk_deepdream_light_blend_out", callback, self)
	end
end

function WeekWalkMapElement:_lightFadeOutDone()
	return
end

function WeekWalkMapElement:_frameUpdate(value)
	if not self._mats then
		return
	end

	for i, mat in ipairs(self._mats) do
		if mat:HasProperty("_MainCol") then
			local color = mat:GetColor("_MainCol")

			color.a = value

			mat:SetColor("_MainCol", color)
		end
	end
end

function WeekWalkMapElement:_fadeOutFinish()
	self:dispose()
end

function WeekWalkMapElement:getResName()
	return self._elementRes
end

function WeekWalkMapElement:_initStarEffect()
	self._starEffect = self._battleInfo.index == #self._curMapInfo.battleInfos and string.format("scenes/m_s09_rgmy/prefab/s09_rgmy_star_red.prefab") or string.format("scenes/m_s09_rgmy/prefab/s09_rgmy_star.prefab")
end

function WeekWalkMapElement:_loadRes()
	if self._resLoader then
		return
	end

	local mapInfo = self._curMapInfo

	if mapInfo.isFinish > 0 and self._info:getType() == WeekWalkEnum.ElementType.Battle then
		local battleId = self._info:getBattleId()
		local battleInfo = mapInfo:getBattleInfo(battleId)

		if battleInfo and battleInfo.star > 0 then
			self._battleInfo = battleInfo

			self:_initStarEffect()
		end
	end

	if not string.nilorempty(self._config.disappearEffect) then
		self._disappearEffectPath = string.format("scenes/m_s09_rgmy/prefab/%s.prefab", self._config.disappearEffect)
	end

	if not string.nilorempty(self._config.lightOffsetPos) then
		self._lightPath = WeekWalkModel.isShallowMap(mapInfo.id) and "scenes/m_s09_rgmy/prefab/weekwalk_deepdream_light_blend.prefab" or "scenes/m_s09_rgmy/prefab/weekwalk_deepdream_light.prefab"
	end

	local smokeMaskOffset = self._config.smokeMaskOffset

	if not string.nilorempty(smokeMaskOffset) then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnAddSmokeMask, self._config.id, smokeMaskOffset)
	end

	if self._elementRes == "s09_rgmy_c03_wuqi_a" or self._elementRes == "s09_rgmy_c04_wuqi_b" or self._elementRes == "s09_rgmy_c05_wuqi_c" then
		self._sceneEffectPath = string.format("scenes/m_s09_rgmy/prefab/%s.prefab", self._elementRes)
	end

	if string.nilorempty(self._config.effect) and not self._disappearEffectPath and not self._starEffect and not self._lightPath and not self._sceneEffectPath then
		return
	end

	self._resLoader = MultiAbLoader.New()

	if not string.nilorempty(self._config.effect) then
		self._resLoader:addPath(self._config.effect)
	end

	if self._disappearEffectPath then
		self._resLoader:addPath(self._disappearEffectPath)
	end

	if self._starEffect then
		self._resLoader:addPath(self._starEffect)
	end

	if self._lightPath then
		self._resLoader:addPath(self._lightPath)
	end

	if self._sceneEffectPath then
		self._resLoader:addPath(self._sceneEffectPath)
	end

	self._resLoader:startLoad(self._onResLoaded, self)

	return true
end

function WeekWalkMapElement:isValid()
	return not gohelper.isNil(self._go) and not self._isDisappear and self._info:isAvailable()
end

function WeekWalkMapElement:setWenHaoVisible(value)
	if not self._wenhaoGo then
		return
	end

	self._wenhaoAnimator = self._wenhaoAnimator or self._wenhaoGo:GetComponent(typeof(UnityEngine.Animator))

	if value then
		self._wenhaoAnimator:Play("wenhao_a_001_in")
	else
		self._wenhaoAnimator:Play("wenhao_a_001_out")
	end
end

function WeekWalkMapElement:onDown()
	self:_onDown()
end

function WeekWalkMapElement:_onDown()
	self._weekwalkMap:setElementDown(self)
end

function WeekWalkMapElement:onClick()
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnClickElement, self)
end

function WeekWalkMapElement:hasEffect()
	return self._wenhaoGo
end

function WeekWalkMapElement:setItemGo(go, fadeIn)
	if string.nilorempty(self._elementRes) then
		fadeIn = false
	end

	self._isFadeIn = fadeIn

	gohelper.setActive(go, true)

	self._itemGo = go

	if not self:_loadRes() then
		self:_checkFadeIn()
	end

	if not string.nilorempty(self._config.type) then
		WeekWalkMapElement.addBoxColliderListener(self._itemGo, self._onDown, self)
	end
end

function WeekWalkMapElement:_checkFadeIn()
	self:_initMats()

	if self._isFadeIn then
		self:_frameUpdate(0)
		self:_fadeIn()
	end
end

function WeekWalkMapElement:_initMats()
	if self._mats then
		return
	end

	self._mats = {}

	local meshRenderList = self._itemGo:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, meshRenderList.Length - 1 do
		local mat = meshRenderList[i].material

		table.insert(self._mats, mat)
	end
end

function WeekWalkMapElement:_fadeIn()
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.8, self._frameUpdate, self._fadeInFinish, self)
end

function WeekWalkMapElement:_fadeInFinish()
	self:_frameUpdate(1)
end

function WeekWalkMapElement:_onResLoaded(go)
	if not string.nilorempty(self._config.effect) then
		local offsetPos = string.splitToNumber(self._config.tipOffsetPos, "#")

		if not offsetPos[1] then
			if not offsetPos[2] then
				local offsetY = 0
				local assetItem = self._resLoader:getAssetItem(self._config.effect)
				local mainPrefab = assetItem:GetResource(self._config.effect)

				self._wenhaoGo = gohelper.clone(mainPrefab, self._go)

				local x, y = transformhelper.getLocalPos(self._itemGo.transform)

				transformhelper.setLocalPos(self._wenhaoGo.transform, x + offsetPos[1], y + offsetY, -2)
			end
		end
	end

	if not self:noRemainStars() then
		self:_addStarEffect()
	end

	self:_addLightEffect()
	self:_addSceneEffect()
end

function WeekWalkMapElement:noRemainStars()
	local mapInfo = self._curMapInfo

	if not mapInfo or mapInfo.isFinish <= 0 then
		return
	end

	local cur, total = mapInfo:getCurStarInfo()

	return cur == total
end

function WeekWalkMapElement:_addStarEffect()
	if self._starEffect then
		local offsetPos = string.splitToNumber(self._config.starOffsetPos, "#")

		if not offsetPos[1] then
			local offsetX = 0

			if not offsetPos[2] then
				local offsetY = 0
				local assetItem = self._resLoader:getAssetItem(self._starEffect)
				local mainPrefab = assetItem:GetResource(self._starEffect)

				self._starGo = gohelper.clone(mainPrefab, self._go)

				local txt = gohelper.findChildComponent(self._starGo, "text_number", typeof(TMPro.TextMeshPro))

				if txt then
					txt.text = "0" .. self._battleInfo.index
				end

				local starNum = self._curMapInfo:getStarNumConfig()
				local star2Go = gohelper.findChild(self._starGo, "star2")
				local star3Go = gohelper.findChild(self._starGo, "star3")
				local showStar2Go = starNum == 2

				gohelper.setActive(star2Go, showStar2Go)
				gohelper.setActive(star3Go, not showStar2Go)

				local starGo = showStar2Go and star2Go or star3Go

				for i = 1, starNum do
					gohelper.setActive(gohelper.findChild(starGo, "star_highlight/star_highlight0" .. i), i <= self._battleInfo.star)
				end

				if offsetX ~= 0 or offsetY ~= 0 then
					transformhelper.setLocalPos(self._starGo.transform, offsetX, offsetY, 0)
				else
					local x, y = transformhelper.getLocalPos(self._itemGo.transform)

					transformhelper.setLocalPos(self._starGo.transform, x + offsetX, y + offsetY, 0)
				end
			end
		end
	end
end

function WeekWalkMapElement:_addLightEffect()
	if self._lightPath then
		local offsetPos = string.splitToNumber(self._config.lightOffsetPos, "#")

		if not offsetPos[1] then
			if not offsetPos[2] then
				local offsetY = 0
				local assetItem = self._resLoader:getAssetItem(self._lightPath)
				local mainPrefab = assetItem:GetResource(self._lightPath)

				self._lightGo = gohelper.clone(mainPrefab, self._go)

				if offsetPos[1] ~= 0 or offsetY ~= 0 then
					transformhelper.setLocalPos(self._lightGo.transform, offsetPos[1], offsetY, 0)
				else
					local x, y = transformhelper.getLocalPos(self._itemGo.transform)

					transformhelper.setLocalPos(self._lightGo.transform, x + offsetPos[1], y + offsetY, 0)
				end
			end
		end
	end
end

function WeekWalkMapElement:_addSceneEffect()
	if self._sceneEffectPath then
		local assetItem = self._resLoader:getAssetItem(self._sceneEffectPath)
		local mainPrefab = assetItem:GetResource(self._sceneEffectPath)

		self._sceneEffectGo = gohelper.clone(mainPrefab, gohelper.findChild(self._go, self._elementRes))
	end
end

function WeekWalkMapElement:addEventListeners()
	return
end

function WeekWalkMapElement:removeEventListeners()
	return
end

function WeekWalkMapElement:onStart()
	return
end

function WeekWalkMapElement.addBoxCollider2D(go)
	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	clickListener:SetIgnoreUI(true)

	local collider = go:GetComponent(typeof(UnityEngine.Collider2D))

	if collider then
		collider.enabled = true

		return clickListener
	end

	local box = gohelper.onceAddComponent(go, typeof(UnityEngine.BoxCollider2D))

	box.enabled = true
	box.size = Vector2(1.5, 1.5)

	return clickListener
end

function WeekWalkMapElement.addBoxColliderListener(go, callback, callbackTarget)
	local clickListener = WeekWalkMapElement.addBoxCollider2D(go)

	clickListener:AddClickListener(callback, callbackTarget)
end

function WeekWalkMapElement:onDestroy()
	if self._resLoader then
		self._resLoader:dispose()

		self._resLoader = nil
	end

	TaskDispatcher.cancelTask(self.dispose, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._mats then
		for k, v in pairs(self._mats) do
			rawset(self._mats, k, nil)
		end

		self._mats = nil
	end
end

return WeekWalkMapElement
