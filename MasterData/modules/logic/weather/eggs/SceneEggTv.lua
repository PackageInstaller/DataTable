-- chunkname: @modules/logic/weather/eggs/SceneEggTv.lua

module("modules.logic.weather.eggs.SceneEggTv", package.seeall)

local SceneEggTv = class("SceneEggTv", SceneBaseEgg)

function SceneEggTv:_onEnable()
	gohelper.setActive(self._go, false)
	self:_showIcon()
end

function SceneEggTv:_onDisable()
	if self._srcLoader then
		self._srcLoader:dispose()

		self._srcLoader = nil
	end

	gohelper.setActive(self._go, false)
	self:_openAnim(false)
end

function SceneEggTv:_openAnim(value)
	if value then
		gohelper.setActive(self._goWhite, true)

		if self._whiteAnimator and self._whiteAnimator.isActiveAndEnabled then
			self._whiteAnimator:Play("open", self._onAnimDone, self)
		else
			gohelper.setActive(self._goWhite, false)
		end
	elseif self._isOpenAnim then
		gohelper.setActive(self._goWhite, true)

		if self._whiteAnimator and self._whiteAnimator.isActiveAndEnabled then
			self._whiteAnimator:Play("close", self._onAnimDone, self)
		else
			gohelper.setActive(self._goWhite, false)
		end
	else
		gohelper.setActive(self._goWhite, false)
	end

	self._isOpenAnim = value
end

function SceneEggTv:_onAnimDone()
	gohelper.setActive(self._goWhite, false)
end

function SceneEggTv:_onInit()
	self._go = self._goList[1]
	self._goWhite = self._goList[2]
	self._whiteAnimator = SLFramework.AnimatorPlayer.Get(self._goWhite)

	if not self._whiteAnimator then
		logError("SceneEggTv white animator is null")
	end

	gohelper.setActive(self._goWhite, false)
	gohelper.setActive(self._go, false)

	self._iconIndex = 1

	self:_initIconId()

	local renderer = self._go:GetComponent(typeof(UnityEngine.MeshRenderer))

	self._mat = UnityEngine.Object.Instantiate(renderer.sharedMaterial)
	renderer.material = self._mat
end

function SceneEggTv:_initIconId()
	self._iconList = {
		0
	}

	for i, v in ipairs(SceneConfig.instance:getLoadingIcons()) do
		table.insert(self._iconList, v.id)
	end
end

function SceneEggTv:_showIcon()
	if self._srcLoader then
		self._srcLoader:dispose()

		self._srcLoader = nil
	end

	local iconUrl = self:_getRandomIcon()

	self._iconUrl = iconUrl
	self._srcLoader = MultiAbLoader.New()

	self._srcLoader:addPath(iconUrl)
	self._srcLoader:startLoad(self._onLoadIconComplete, self)
end

function SceneEggTv:_onLoadIconComplete()
	local assetItem = self._srcLoader:getFirstAssetItem()

	if assetItem then
		self._mat.mainTexture = assetItem:GetResource(self._iconUrl)

		gohelper.setActive(self._go, true)
		self:_openAnim(true)
	end
end

function SceneEggTv:_getRandomIcon()
	local index = self:_getRandomIndex()
	local iconId = self._iconList[index]

	if iconId > 0 then
		local config = lua_loading_icon.configDict[iconId]

		if config then
			return ResUrl.getLoadingBg(config.pic)
		end
	end

	return "scenes/dynamic/v2a5_m_s01_zjm_a/lightmaps/dianshiji.png"
end

function SceneEggTv:_getRandomIndex()
	local index = math.random(1, #self._iconList)

	if index ~= self._iconIndex then
		self._iconIndex = index

		return index
	end

	self._iconIndex = self._iconIndex + 1

	if self._iconIndex > #self._iconList then
		self._iconIndex = 1
	end

	return self._iconIndex
end

function SceneEggTv:_onSceneClose()
	if self._srcLoader then
		self._srcLoader:dispose()

		self._srcLoader = nil
	end
end

return SceneEggTv
