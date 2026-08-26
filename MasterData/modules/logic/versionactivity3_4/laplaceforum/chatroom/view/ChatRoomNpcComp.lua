-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomNpcComp.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomNpcComp", package.seeall)

local ChatRoomNpcComp = class("ChatRoomNpcComp", LuaCompBase)

function ChatRoomNpcComp:ctor(npcInfoData)
	self.npcInfoData = npcInfoData
	self.config = npcInfoData.npcConfig
end

function ChatRoomNpcComp:init(go)
	self.go = go
	self.npcRes = self.npcInfoData.npcType == ChatRoomEnum.NpcType.EasterEgg and RoomResHelper.getCharacterPath(self.config.skinId) or RoomResHelper.getCritterPath(self.config.skinId)
	self.npcLoader = MultiAbLoader.New()

	self.npcLoader:addPath(self.npcRes)

	self.materialRes = RoomCharacterEnum.MaterialPath

	self.npcLoader:addPath(self.materialRes)
	self.npcLoader:startLoad(self.loadNpcFinish, self)
end

function ChatRoomNpcComp:addEventListeners()
	return
end

function ChatRoomNpcComp:removeEventListeners()
	return
end

function ChatRoomNpcComp:loadNpcFinish()
	local npcAssetItem = self.npcLoader:getAssetItem(self.npcRes)
	local npcPrefab = npcAssetItem:GetResource(self.npcRes)

	self.npcGO = gohelper.clone(npcPrefab, self.go, "Npc" .. self.config.npcId)

	local posList = self.npcInfoData.posList

	transformhelper.setLocalPos(self.go.transform, posList[1], PartyGameLobbyEnum.InitPos.y, posList[2])
	gohelper.setLayer(self.npcGO, UnityLayer.Scene, true)

	self.meshRender = self.npcGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self.meshRender.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On
	self.meshRender.receiveShadows = true

	ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnNpcLoadFinish, self.config.npcId)
	self:getAnimator()
	self:playAnim("idle")

	local materialAssetItem = self.npcLoader:getAssetItem(self.materialRes)
	local replaceMaterial = materialAssetItem:GetResource(self.materialRes)

	self:replaceRoomMaterial(replaceMaterial)
	self:setNpcColor()
end

function ChatRoomNpcComp:setNpcColor()
	local originColor = self.meshRender.material:GetColor("_MainColor")
	local mpb = UnityEngine.MaterialPropertyBlock.New()

	mpb:SetColor("_MainColor", Color.New(0.45, 0.45, 0.45, originColor.a))
	self.meshRender:SetPropertyBlock(mpb)
end

function ChatRoomNpcComp:replaceRoomMaterial(material)
	local skeletonAnim = self.npcGO:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
	local curMaterial = UnityEngine.GameObject.Instantiate(material)
	local sharedMaterial = self.meshRender.sharedMaterial

	curMaterial:SetTexture("_MainTex", sharedMaterial:GetTexture("_MainTex"))
	curMaterial:SetTexture("_BackLight", sharedMaterial:GetTexture("_NormalMap"))
	curMaterial:SetTexture("_DissolveTex", sharedMaterial:GetTexture("_DissolveTex"))

	local customMaterialOverride = skeletonAnim.CustomMaterialOverride

	if customMaterialOverride then
		customMaterialOverride:Clear()
		customMaterialOverride:Add(sharedMaterial, curMaterial)
	end

	self.meshRender.material = curMaterial
	self.meshRender.sortingLayerName = "Default"
end

function ChatRoomNpcComp:getNpcGO()
	return self.npcGO
end

function ChatRoomNpcComp:getPosZ()
	return self.npcInfoData.posList[2]
end

function ChatRoomNpcComp:getAnimator()
	if not self.npcGO then
		return nil
	end

	self.animator = self.animator or self.npcGO:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

	return self.animator
end

function ChatRoomNpcComp:playAnim(animName)
	if not self.animator or not self.animator:HasAnimation(animName) then
		logError(animName .. "动画不存在")

		return
	end

	self.animator:PlayAnim(animName, true, true)
end

function ChatRoomNpcComp:onDestroy()
	return
end

return ChatRoomNpcComp
