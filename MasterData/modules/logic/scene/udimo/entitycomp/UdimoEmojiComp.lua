-- chunkname: @modules/logic/scene/udimo/entitycomp/UdimoEmojiComp.lua

module("modules.logic.scene.udimo.entitycomp.UdimoEmojiComp", package.seeall)

local UdimoEmojiComp = class("UdimoEmojiComp", LuaCompBase)

function UdimoEmojiComp:ctor(entity)
	self.entity = entity
end

function UdimoEmojiComp:init(go)
	self.go = go
	self.tmpNodePosV3 = Vector3.New(0, 0, 0)
	self.tmpCamPosV3 = Vector3.New(0, 0, 0)
	self._willDestroy = false

	self:clearAllEmoji()
end

function UdimoEmojiComp:getEmojiNode()
	if gohelper.isNil(self.goEmojiNode) then
		local emojiNodeName = "emoji"
		local goEmojiNode = gohelper.findChild(self.go, emojiNodeName)

		if gohelper.isNil(goEmojiNode) then
			goEmojiNode = gohelper.create3d(self.go, emojiNodeName)
		end

		self.transEmojiNode = goEmojiNode.transform

		local udimoId = self.entity:getId()
		local emojiPos = UdimoConfig.instance:getUdimoEmojiPos(udimoId)
		local x = emojiPos and emojiPos[1]
		local y = emojiPos and emojiPos[2]

		transformhelper.setLocalPosXY(self.transEmojiNode, x, y)

		self.goEmojiNode = goEmojiNode
	end

	return self.goEmojiNode, self.transEmojiNode
end

function UdimoEmojiComp:addEventListeners()
	return
end

function UdimoEmojiComp:removeEventListeners()
	return
end

function UdimoEmojiComp:onUpdate()
	if self.playingEmojiId then
		local emojiItem = self:_getEmojiItme(self.playingEmojiId)

		if self.playingEmojiId then
			local _, transEmojiNode = self:getEmojiNode()
			local nodePosX, nodePosY, nodePosZ = transformhelper.getPos(transEmojiNode)

			self.tmpNodePosV3:Set(nodePosX, nodePosY, nodePosZ)

			local cameraTrans = CameraMgr.instance:getMainCameraTrs()
			local camPosX, camPosY, camPosZ = transformhelper.getPos(cameraTrans)

			self.tmpCamPosV3:Set(camPosX, camPosY, camPosZ)

			local emojiPos = Vector3.Lerp(self.tmpCamPosV3, self.tmpNodePosV3, 0.5)

			transformhelper.setPos(self.playingEmojiId.trans, emojiPos.x, emojiPos.y, emojiPos.z)

			local newDis = Vector3.Distance(emojiPos, self.tmpCamPosV3)
			local originalDis = Vector3.Distance(self.tmpNodePosV3, self.tmpCamPosV3)
			local scale = Vector3.one * (newDis / originalDis)

			transformhelper.setLocalScale(transEmojiNode, scale.x, scale.y, scale.z)
		end
	end
end

function UdimoEmojiComp:playEmoji(emojiId, cb, cbObj, cbParam)
	local scene = UdimoController.instance:getUdimoScene()

	if not scene or not emojiId then
		return
	end

	self:stopEmoji()

	self._finishCb = cb
	self._finishCbObj = cbObj
	self._finishCbParam = cbParam
	self.playingEmojiId = emojiId

	local emojiItem = self:_getEmojiItme(self.playingEmojiId)

	if emojiItem then
		self:_realPlayEmoji()
	else
		local res = UdimoConfig.instance:getEmojiRes(emojiId)
		local resPath = ResUrl.getDungeonMapRes(res)

		scene.loader:makeSureLoaded({
			resPath
		}, self._onLoadEmoji, self)
	end
end

function UdimoEmojiComp:_getEmojiItme(emojiId)
	return self._emojiDict and self._emojiDict[emojiId]
end

function UdimoEmojiComp:_onLoadEmoji()
	local scene = UdimoController.instance:getUdimoScene()

	if self.playingEmojiId then
		local res = UdimoConfig.instance:getEmojiRes(self.playingEmojiId)
		local resPath = ResUrl.getDungeonMapRes(res)

		if not scene or not self.playingEmojiId or string.nilorempty(resPath) then
			return
		end

		local assetRes = scene.loader:getResource(resPath)

		if not assetRes then
			return
		end

		local goEmojiNode = self:getEmojiNode()
		local go = gohelper.clone(assetRes, goEmojiNode, string.format("emoji-%s", self.playingEmojiId))
		local orderLayer = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.UdimoPickedUpOrderLayer, true)
		local meshRenderers = go:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

		for i = 0, meshRenderers.Length - 1 do
			local meshRenderer = meshRenderers[i]

			meshRenderer.sortingOrder = orderLayer + 1
		end

		local animationComp = go:GetComponentInChildren((typeof(UnityEngine.Animation)))

		self._emojiDict = self._emojiDict or {}
		self._emojiDict[self.playingEmojiId] = {
			go = go,
			trans = go.transform,
			animationComp = animationComp
		}

		gohelper.setActive(go, false)
		self:_realPlayEmoji()
	end
end

function UdimoEmojiComp:_realPlayEmoji()
	local emojiItem = self:_getEmojiItme(self.playingEmojiId)

	if not emojiItem then
		logError(string.format("UdimoEmojiComp:_realPlayEmoji error, no emoji, emojiId:%s", self.playingEmojiId))

		return
	end

	local playTime = UdimoEnum.Const.EmojiDefaultPlayTime
	local animComp = emojiItem.animationComp
	local iter = animComp and animComp:GetEnumerator()

	if iter and iter:MoveNext() then
		local animClip = iter.Current

		playTime = animClip and animClip.length
	end

	TaskDispatcher.cancelTask(self._playEmojiFinished, self)
	TaskDispatcher.runDelay(self._playEmojiFinished, self, playTime)
	gohelper.setActive(emojiItem.go, true)
end

function UdimoEmojiComp:_playEmojiFinished()
	local emojiItem = self:_getEmojiItme(self.playingEmojiId)

	if emojiItem then
		gohelper.setActive(emojiItem.go, false)
	end

	self.playingEmojiId = nil

	self:_callFinishCb()
end

function UdimoEmojiComp:_callFinishCb()
	if self._finishCb then
		if self._finishCbObj then
			self._finishCb(self._finishCbObj, self._finishCbParam)
		else
			self._finishCb(self._finishCbParam)
		end
	end

	self._finishCb = nil
	self._finishCbObj = nil
	self._finishCbParam = nil
end

function UdimoEmojiComp:stopEmoji()
	TaskDispatcher.cancelTask(self._playEmojiFinished, self)

	local emojiItem = self:_getEmojiItme(self.playingEmojiId)

	if emojiItem then
		gohelper.setActive(emojiItem.go, false)
	end

	self.playingEmojiId = nil

	self:_callFinishCb()
end

function UdimoEmojiComp:clearAllEmoji()
	self.playingEmojiId = nil

	if self._emojiDict then
		for emojiId, emojiItem in pairs(self._emojiDict) do
			emojiItem.animationComp = nil

			gohelper.destroy(emojiItem.go)

			self._emojiDict[emojiId] = nil
		end
	end

	self._emojiDict = nil
end

function UdimoEmojiComp:beforeDestroy()
	self._willDestroy = true

	self:stopEmoji()
	self:clearAllEmoji()
	self:removeEventListeners()
end

function UdimoEmojiComp:onDestroy()
	return
end

return UdimoEmojiComp
