-- chunkname: @modules/logic/towercompose/view/TowerComposeModIconComp.lua

module("modules.logic.towercompose.view.TowerComposeModIconComp", package.seeall)

local TowerComposeModIconComp = class("TowerComposeModIconComp", LuaCompBase)

function TowerComposeModIconComp:ctor(param)
	self.param = param
end

function TowerComposeModIconComp:init(go)
	self:__onInit()

	self.go = go
end

function TowerComposeModIconComp:addEventListeners()
	return
end

function TowerComposeModIconComp:removeEventListeners()
	return
end

function TowerComposeModIconComp:refreshMod(modId, imageModIcon, imageModColorIcon, imageModLvColorIcon, materialModIcon, materialModLvIcon)
	gohelper.setActive(imageModIcon.gameObject, false)
	gohelper.setActive(imageModLvColorIcon.gameObject, false)

	self.materialModIcon = materialModIcon
	self.materialModLvIcon = materialModLvIcon
	self.simageModColorIcon = gohelper.findChildSingleImage(imageModColorIcon.gameObject, "")
	self.simageModLvColorIcon = gohelper.findChildSingleImage(imageModLvColorIcon.gameObject, "")

	if modId > 0 then
		local modconfig = TowerComposeConfig.instance:getComposeModConfig(modId)

		self:cleanLoader()

		self.modLoader = MultiAbLoader.New()
		self.modIconUrl = ResUrl.getTowerComposeModIcon((modconfig.level > 1 or nil) and (modconfig.icon .. "_jiaobiao" or modconfig.icon))

		self.modLoader:addPath(self.modIconUrl)

		if modconfig.level > 1 then
			gohelper.setActive(imageModLvColorIcon.gameObject, true)

			self.modLevelUrl = ResUrl.getTowerComposeModIcon("jiaobiao" .. modconfig.level)

			self.modLoader:addPath(self.modLevelUrl)
		end

		self.simageModColorIcon:LoadImage(ResUrl.getTowerComposeModIcon("caizhi" .. modconfig.level))
		self.simageModLvColorIcon:LoadImage(ResUrl.getTowerComposeModIcon("caizhi" .. modconfig.level))
		self.modLoader:startLoad(self.loadModIconFinish, self)
	end
end

function TowerComposeModIconComp:loadModIconFinish()
	if not string.nilorempty(self.modIconUrl) then
		local assetItem = self.modLoader:getAssetItem(self.modIconUrl)
		local materialModIconTexture = assetItem:GetResource(self.modIconUrl)

		self.materialModIcon:SetTexture("_MaskTex", materialModIconTexture)
		self.materialModIcon:SetTexture("_MainTex", materialModIconTexture)
	end

	if not string.nilorempty(self.modLevelUrl) then
		local assetItem = self.modLoader:getAssetItem(self.modLevelUrl)
		local materialModLevelTexture = assetItem:GetResource(self.modLevelUrl)

		self.materialModLvIcon:SetTexture("_MaskTex", materialModLevelTexture)
		self.materialModLvIcon:SetTexture("_MainTex", materialModLevelTexture)
	end
end

function TowerComposeModIconComp:cleanLoader()
	if self.modLoader then
		self.modLoader:dispose()

		self.modLoader = nil
	end

	self.modLevelUrl = nil
	self.modIconUrl = nil
end

function TowerComposeModIconComp:onDestroy()
	self:cleanLoader()

	if self.simageModColorIcon then
		self.simageModColorIcon:UnLoadImage()
	end

	if self.simageModLvColorIcon then
		self.simageModLvColorIcon:UnLoadImage()
	end
end

return TowerComposeModIconComp
