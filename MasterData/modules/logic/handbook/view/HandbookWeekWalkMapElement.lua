-- chunkname: @modules/logic/handbook/view/HandbookWeekWalkMapElement.lua

module("modules.logic.handbook.view.HandbookWeekWalkMapElement", package.seeall)

local HandbookWeekWalkMapElement = class("HandbookWeekWalkMapElement", LuaCompBase)

function HandbookWeekWalkMapElement:ctor(param)
	self.parentView = param.parentView
	self.diffuseGo = param.diffuseGo
end

function HandbookWeekWalkMapElement:init(go)
	self.go = go
	self.transform = go.transform
end

function HandbookWeekWalkMapElement:updateInfo(elementId)
	self.elementId = elementId

	self:updateConfig(WeekWalkConfig.instance:getElementConfig(elementId))
end

function HandbookWeekWalkMapElement:updateConfig(config)
	self.config = config
end

function HandbookWeekWalkMapElement:dispose()
	gohelper.setActive(self._itemGo, false)
	gohelper.destroy(self.go)
end

function HandbookWeekWalkMapElement:fadeOut()
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.8, self._frameUpdate, self._fadeOutFinish, self)
end

function HandbookWeekWalkMapElement:fadeIn()
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.8, self._frameUpdate, self._fadeInFinish, self)
end

function HandbookWeekWalkMapElement:_fadeInFinish()
	self:_frameUpdate(1)
end

function HandbookWeekWalkMapElement:_fadeOutFinish()
	self:dispose()
end

function HandbookWeekWalkMapElement:_frameUpdate(value)
	if not self._color then
		return
	end

	self._color.a = value

	for i, v in ipairs(self._mats) do
		v:SetColor("_MainCol", self._color)
	end
end

function HandbookWeekWalkMapElement:getResName()
	return self._config.res
end

function HandbookWeekWalkMapElement:refresh()
	local resName = self:getResName()

	if string.nilorempty(resName) then
		return
	end

	local resGo = gohelper.findChild(self.diffuseGo, resName)

	if not resGo then
		logError(tostring(self.elementId) .. " no resGo:" .. tostring(resName))
	end

	self.resItemGo = gohelper.clone(resGo, self.go, resName)

	self:_loadEffectRes()

	self._mats = {}

	local meshRenderList = self._itemGo:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, meshRenderList.Length - 1 do
		local mat = meshRenderList[i].material

		table.insert(self._mats, mat)

		self._color = self._color or mat:GetColor("_MainCol")
	end

	self:fadeIn()
end

function HandbookWeekWalkMapElement:_loadEffectRes()
	if self._resLoader then
		return
	end

	if not string.nilorempty(self._config.disappearEffect) then
		self._disappearEffectPath = string.format("scenes/m_s09_rgmy/prefab/%s.prefab", self._config.disappearEffect)
	end

	if string.nilorempty(self._config.effect) and not self._disappearEffectPath then
		return
	end

	self._resLoader = MultiAbLoader.New()

	if not string.nilorempty(self._config.effect) then
		self._resLoader:addPath(self._config.effect)
	end

	if self._disappearEffectPath then
		self._resLoader:addPath(self._disappearEffectPath)
	end

	self._resLoader:startLoad(self._onResLoaded, self)
end

function HandbookWeekWalkMapElement:_onResLoaded(go)
	if not string.nilorempty(self._config.effect) then
		local offsetPos = string.splitToNumber(self._config.tipOffsetPos, "#")

		self._offsetX = offsetPos[1] or 0
		self._offsetY = offsetPos[2] or 0

		local assetItem = self._resLoader:getAssetItem(self._config.effect)
		local mainPrefab = assetItem:GetResource(self._config.effect)

		self._wenhaoGo = gohelper.clone(mainPrefab, self._go)

		local x, y = transformhelper.getLocalPos(self.resItemGo.transform)

		transformhelper.setLocalPos(self._wenhaoGo.transform, x + self._offsetX, y + self._offsetY, -2)
	end
end

function HandbookWeekWalkMapElement:setWenHaoVisible(value)
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

function HandbookWeekWalkMapElement:hasEffect()
	return self._wenhaoGo
end

function HandbookWeekWalkMapElement:onDestroy()
	if self._resLoader then
		self._resLoader:dispose()

		self._resLoader = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._mats = nil
	self._color = nil
end

return HandbookWeekWalkMapElement
