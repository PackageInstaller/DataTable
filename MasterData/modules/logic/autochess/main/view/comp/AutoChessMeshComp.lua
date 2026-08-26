-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessMeshComp.lua

module("modules.logic.autochess.main.view.comp.AutoChessMeshComp", package.seeall)

local AutoChessMeshComp = class("AutoChessMeshComp", LuaCompBase)

function AutoChessMeshComp:init(go)
	self.go = go
	self.uiMesh = gohelper.findChildUIMesh(go, "")
	self.simageRole = gohelper.findChildSingleImage(go, "role")
	self.imageRole = gohelper.findChildImage(go, "role")
	self.imageLock = gohelper.findChildImage(go, "role_lock")
end

function AutoChessMeshComp:setIndependentMaterial()
	self.independent = true
end

function AutoChessMeshComp:setData(resName, isEnemy, isLeader)
	self.simageRole:LoadImage(ResUrl.getAutoChessIcon(resName), self.loadImageCallback, self)

	self.materialUrl = AutoChessHelper.getMaterialUrl(isEnemy)
	self.imageMaterialUrl = AutoChessHelper.getImageMaterialUrl(isLeader)
	self.meshUrl = AutoChessHelper.getMeshUrl(resName)

	self:loadMesh()
end

function AutoChessMeshComp:loadImageCallback()
	if self.imageRole then
		self.imageRole:SetNativeSize()
	end

	if self.imageLock then
		self.imageLock.sprite = self.imageRole.sprite

		self.imageLock:SetNativeSize()
	end
end

function AutoChessMeshComp:loadMesh()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self.loader = MultiAbLoader.New()

	self.loader:addPath(self.meshUrl)

	if not self.hasSetMaterial then
		self.loader:addPath(self.materialUrl)
		self.loader:addPath(self.imageMaterialUrl)
	end

	self.loader:startLoad(self.loadResFinish, self)
end

function AutoChessMeshComp:loadResFinish()
	local assetItem = self.loader:getAssetItem(self.meshUrl)

	if assetItem then
		self.uiMesh.mesh = assetItem:GetResource(self.meshUrl)

		self.uiMesh:SetVerticesDirty()
	end

	if not self.hasSetMaterial then
		assetItem = self.loader:getAssetItem(self.materialUrl)

		if assetItem then
			local mat = assetItem:GetResource(self.materialUrl)

			if self.independent then
				self.matInst1 = UnityEngine.Object.Instantiate(mat)
				self.uiMesh.material = self.matInst1
			else
				self.uiMesh.material = mat
			end

			self.uiMesh:SetMaterialDirty()
		end

		assetItem = self.loader:getAssetItem(self.imageMaterialUrl)

		if assetItem then
			local mat = assetItem:GetResource(self.imageMaterialUrl)

			if self.independent then
				self.matInst2 = UnityEngine.Object.Instantiate(mat)
				self.imageRole.material = self.matInst2
			else
				self.imageRole.material = mat
			end

			self.imageRole:SetMaterialDirty()
		end

		self.hasSetMaterial = true
	end

	gohelper.setActive(self.uiMesh, true)
end

function AutoChessMeshComp:onDestroy()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.independent then
		UnityEngine.Object.Destroy(self.matInst1)
		UnityEngine.Object.Destroy(self.matInst2)
	end
end

function AutoChessMeshComp:setGray(bool)
	gohelper.setActive(self.imageLock, bool)
end

return AutoChessMeshComp
