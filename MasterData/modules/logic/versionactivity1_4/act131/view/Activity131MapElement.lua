-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131MapElement.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131MapElement", package.seeall)

local Activity131MapElement = class("Activity131MapElement", LuaCompBase)

function Activity131MapElement:ctor(param)
	self._info = param[1]

	local actId = VersionActivity1_4Enum.ActivityId.Role6

	self._config = Activity131Config.instance:getActivity131ElementCo(actId, self._info.elementId)
	self._stageMap = param[2]
end

function Activity131MapElement:updateInfo(info)
	self._info = info
end

function Activity131MapElement:init(go)
	self._go = go
	self._transform = go.transform
end

function Activity131MapElement:dispose(destoryGo)
	if self._lightGo then
		gohelper.destroy(self._lightGo)
	end

	if destoryGo and self._itemGo then
		gohelper.destroy(self._itemGo)

		return
	end

	if self._itemGo then
		local box = self._itemGo:GetComponent(typeof(UnityEngine.BoxCollider2D))

		if box then
			box.enabled = false
		end
	end
end

function Activity131MapElement:disappear(fadeOut)
	if string.nilorempty(self._config.res) then
		fadeOut = false
	end

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

function Activity131MapElement:_fadeOut()
	self:_initMats()

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.8, self._frameUpdate, self._fadeOutFinish, self)

	self:_lightFadeOut()
end

function Activity131MapElement:_fadeOutFinish()
	self:dispose()
end

function Activity131MapElement:_lightFadeOut()
	if self._lightGo then
		self._lightAnimator:Play("out", 0, 0)
		TaskDispatcher.runDelay(self.dispose, self, 0.37)
	end
end

function Activity131MapElement:getResName()
	return self._config.res
end

function Activity131MapElement:_loadRes()
	if self._resLoader then
		return
	end

	self._lightPath = "scenes/v1a4_m_s12_37jshd/prefab/v1a4_m_s12_kejiaohu_light.prefab"
	self._resLoader = MultiAbLoader.New()

	self._resLoader:addPath(self._lightPath)
	self._resLoader:startLoad(self._onResLoaded, self)

	return true
end

function Activity131MapElement:isValid()
	return not gohelper.isNil(self._go) and not self._isDisappear and self._info:isAvailable()
end

function Activity131MapElement:onDown()
	self:_onDown()
end

function Activity131MapElement:_onDown()
	self._stageMap:setElementDown(self)
end

function Activity131MapElement:onClick()
	self._info = Activity131Model.instance:getCurMapElementInfo(self._info.elementId)

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnClickElement, self)
end

function Activity131MapElement:setItemGo(go, fadeIn)
	if string.nilorempty(self._config.res) then
		fadeIn = false
	end

	self._isFadeIn = fadeIn

	gohelper.setActive(go, true)

	self._itemGo = go

	if not self:_loadRes() then
		self:_checkFadeIn()
	end

	if not string.nilorempty(self._config.type) then
		Activity131MapElement.addBoxColliderListener(self._itemGo, self._onDown, self)
	end
end

function Activity131MapElement:_checkFadeIn()
	self:_initMats()

	if self._isFadeIn then
		self:_frameUpdate(1)
	end
end

function Activity131MapElement:_frameUpdate(value)
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

function Activity131MapElement:_initMats()
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

function Activity131MapElement:_onResLoaded(go)
	if self._config.skipFinish == 1 then
		return
	end

	self:_addLightEffect()
end

function Activity131MapElement:_addLightEffect()
	if self._lightPath then
		local assetItem = self._resLoader:getAssetItem(self._lightPath)
		local mainPrefab = assetItem:GetResource(self._lightPath)

		self._lightGo = gohelper.clone(mainPrefab, self._go)

		local x, y = transformhelper.getLocalPos(self._itemGo.transform)

		transformhelper.setLocalPos(self._lightGo.transform, x, y, 0)

		self._lightAnimator = self._lightGo:GetComponent(typeof(UnityEngine.Animator))

		self._lightAnimator:Play("in", 0, 0)
	end
end

function Activity131MapElement:addEventListeners()
	return
end

function Activity131MapElement:removeEventListeners()
	return
end

function Activity131MapElement:onStart()
	return
end

function Activity131MapElement.addBoxCollider2D(go)
	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	clickListener:SetIgnoreUI(true)

	local collider = go:GetComponent(typeof(UnityEngine.Collider2D))

	if collider then
		collider.enabled = false
		collider.enabled = true

		return clickListener
	end

	local box = gohelper.onceAddComponent(go, typeof(UnityEngine.BoxCollider2D))

	box.enabled = false
	box.enabled = true
	box.size = Vector2(1.5, 1.5)

	return clickListener
end

function Activity131MapElement.addBoxColliderListener(go, callback, callbackTarget)
	local clickListener = Activity131MapElement.addBoxCollider2D(go)

	clickListener:AddClickListener(callback, callbackTarget)
end

function Activity131MapElement:refreshClick()
	local collider = self._itemGo:GetComponent(typeof(UnityEngine.BoxCollider2D))

	if collider then
		collider.enabled = false
		collider.enabled = true
	end
end

function Activity131MapElement:onDestroy()
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

return Activity131MapElement
