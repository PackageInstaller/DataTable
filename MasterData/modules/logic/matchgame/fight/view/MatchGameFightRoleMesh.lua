-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightRoleMesh.lua

module("modules.logic.matchgame.fight.view.MatchGameFightRoleMesh", package.seeall)

local MatchGameFightRoleMesh = class("MatchGameFightRoleMesh", LuaCompBase)

function MatchGameFightRoleMesh:init(go)
	self.go = go
	self.uiMesh = gohelper.onceAddComponent(self.go, typeof(UIMesh))

	if self.uiMesh then
		self.worldPosToMatComp = gohelper.onceAddComponent(self.go, typeof(ZProj.RectWorldPosToMat))
	end

	self.independent = true
end

function MatchGameFightRoleMesh:setIndependentMaterial(state)
	self.independent = state
end

function MatchGameFightRoleMesh:refreshMesh(roleConfig, isEnemy, params)
	if self.meshUrl == roleConfig.mesh then
		return
	end

	self.meshUrl = roleConfig.mesh
	self.image = roleConfig.image

	if isEnemy then
		self.career = roleConfig.career or roleConfig.elementId
	end

	self.params = params
	self.materialUrl = MatchGameFightEnum.RoleMeshMaterial[self.career]
	self.imageUrl = roleConfig.image

	self:loadMesh()
end

function MatchGameFightRoleMesh:loadMesh()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self.loader = MultiAbLoader.New()

	self.loader:addPath(self.meshUrl)
	self.loader:addPath(self.materialUrl)
	self.loader:addPath(self.imageUrl)
	self.loader:startLoad(self.loadResFinish, self)
end

function MatchGameFightRoleMesh:loadResFinish()
	local assetItem = self.loader:getAssetItem(self.meshUrl)

	if assetItem then
		self.uiMesh.mesh = assetItem:GetResource(self.meshUrl)

		self.uiMesh:SetVerticesDirty()
	else
		gohelper.setActive(self.uiMesh, false)

		return
	end

	assetItem = self.loader:getAssetItem(self.materialUrl)

	if assetItem then
		local mat = assetItem:GetResource(self.materialUrl)

		if self.independent then
			self.matInst = UnityEngine.Object.Instantiate(mat)
			self.uiMesh.material = self.matInst
		else
			self.uiMesh.material = mat
		end

		self.uiMesh:SetMaterialDirty()
	end

	local assetItem = self.loader:getAssetItem(self.imageUrl)

	if assetItem then
		local roleTexture = assetItem:GetResource(self.imageUrl)

		recthelper.setSize(self.go.transform, roleTexture.width, roleTexture.height)
	end

	gohelper.setActive(self.uiMesh, false)
	gohelper.setActive(self.uiMesh, true)
end

function MatchGameFightRoleMesh:onDestroy()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.independent then
		UnityEngine.Object.Destroy(self.matInst)
	end
end

return MatchGameFightRoleMesh
