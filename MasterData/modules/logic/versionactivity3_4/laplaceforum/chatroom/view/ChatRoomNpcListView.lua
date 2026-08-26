-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomNpcListView.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomNpcListView", package.seeall)

local ChatRoomNpcListView = class("ChatRoomNpcListView", BaseView)

function ChatRoomNpcListView:onInitView()
	self._goheadInfoContent = gohelper.findChild(self.viewGO, "root/#go_headInfo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChatRoomNpcListView:addEvents()
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.DailyReresh, self.onDailyReresh, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self, LuaEventSystem.Low)
end

function ChatRoomNpcListView:removeEvents()
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.DailyReresh, self.onDailyReresh, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self, LuaEventSystem.Low)
end

function ChatRoomNpcListView:_editableInitView()
	local scene = GameSceneMgr.instance:getCurScene()
	local sceneGo = scene.level:getSceneGo()

	self._goSceneNpc = UnityEngine.GameObject.New("npcList")

	gohelper.addChild(sceneGo, self._goSceneNpc)
	ChatRoomModel.instance:buildNpcInfoData()

	self.npcItemMap = self:getUserDataTb_()
	self.shaderColorProName = "_MainColor"

	self:createAndRefreshNpc()
end

function ChatRoomNpcListView:onOpen()
	return
end

function ChatRoomNpcListView:onDailyReresh()
	self:createAndRefreshNpc()
end

function ChatRoomNpcListView:createAndRefreshNpc()
	local npcInfoMap = ChatRoomModel.instance:getNpcInfoMap()

	for npcType, npcInfoData in pairs(npcInfoMap) do
		local canShowNpc = ChatRoomModel.instance:checkCanShowNpc(npcType)

		if canShowNpc then
			local npcItem = self.npcItemMap[npcType]

			if not npcItem and npcInfoData then
				npcItem = {
					npcInfoData = npcInfoData,
					go = UnityEngine.GameObject.New(string.format("npc_%s_%s", npcType, npcInfoData.npcConfig.npcId))
				}

				gohelper.addChild(self._goSceneNpc, npcItem.go)

				local resPath = self.viewContainer:getSetting().otherRes.npcInfo

				npcItem.InfoGO = self.viewContainer:getResInst(resPath, self._goheadInfoContent)
				npcItem.npcInfoComp = MonoHelper.addLuaComOnceToGo(npcItem.InfoGO, ChatRoomNpcInfoComp, npcInfoData)
				npcItem.npcComp = MonoHelper.addLuaComOnceToGo(npcItem.go, ChatRoomNpcComp, npcInfoData)
				self.npcItemMap[npcType] = npcItem
			end

			npcItem.npcInfoComp:bindNpcInfoGo(npcItem.go)
			npcItem.npcInfoComp:refresh()
		end

		if not npcInfoData or not canShowNpc then
			self:removeNpc(npcType)
		end
	end
end

function ChatRoomNpcListView:getNpcItemMap()
	return self.npcItemMap
end

function ChatRoomNpcListView:removeNpc(npcType)
	local npcItem = self.npcItemMap[npcType]

	if not npcItem then
		return
	end

	self.removeNpcItem = npcItem

	self:playNpcFadeAnim(npcItem)
end

function ChatRoomNpcListView:playNpcFadeAnim(npcItem)
	local npcGO = npcItem.npcComp:getNpcGO()

	if not npcGO then
		return
	end

	self.meshRender = npcGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self.npcMaterial = self.meshRender and self.meshRender.material
	self.mpb = self.mpb or UnityEngine.MaterialPropertyBlock.New()

	if not gohelper.isNil(self.npcMaterial) and self.npcMaterial:HasProperty(self.shaderColorProName) then
		self.originColor = self.npcMaterial:GetColor(self.shaderColorProName)
		self.npcFadeTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, ChatRoomEnum.NpcRemoveTime, self.doFadeNpcTween, self.doFadeNpcTweenFinish, self)
	end
end

function ChatRoomNpcListView:doFadeNpcTween(value)
	self.originColor.a = value

	self.mpb:SetColor(self.shaderColorProName, self.originColor)
	self.meshRender:SetPropertyBlock(self.mpb)
end

function ChatRoomNpcListView:doFadeNpcTweenFinish()
	if self.removeNpcItem then
		gohelper.destroy(self.removeNpcItem.go)
		gohelper.destroy(self.removeNpcItem.InfoGO)
	end

	ChatRoomModel.instance:removeNpc(self.removeNpcItem.npcInfoData.npcType)

	self.npcItemMap[self.removeNpcItem.npcInfoData.npcType] = nil
	self.removeNpcItem = nil

	ChatRoomController.instance:dispatchEvent(ChatRoomEvent.OnShowNpcPlayerType, nil)
end

function ChatRoomNpcListView:onCloseViewFinish(viewName)
	if viewName == ViewName.ChatRoomNpcQAndAView or viewName == ViewName.ChatRoomFingerGameResultView then
		self:createAndRefreshNpc()
	elseif viewName == ViewName.ChatRoomNpcEasterEggView then
		self:removeNpc(ChatRoomEnum.NpcType.EasterEgg)
	end
end

function ChatRoomNpcListView:onClose()
	if self.npcFadeTweenId then
		ZProj.TweenHelper.KillById(self.npcFadeTweenId)

		self.npcFadeTweenId = nil
	end
end

function ChatRoomNpcListView:onDestroyView()
	return
end

return ChatRoomNpcListView
