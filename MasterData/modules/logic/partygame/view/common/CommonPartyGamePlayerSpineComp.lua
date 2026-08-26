-- chunkname: @modules/logic/partygame/view/common/CommonPartyGamePlayerSpineComp.lua

module("modules.logic.partygame.view.common.CommonPartyGamePlayerSpineComp", package.seeall)

local CommonPartyGamePlayerSpineComp = class("CommonPartyGamePlayerSpineComp", LuaCompBase)

function CommonPartyGamePlayerSpineComp:init(go)
	self._parent = go
	self.grayActive = false
	self._updateEnable = true
end

function CommonPartyGamePlayerSpineComp:initSpine(uid)
	self.spine = self.spine or PartyGameGuiSpine.Create(self._parent)

	local resMap = PartyClothModel.instance:getCurWearClothRes()
	local playerInfo = PartyGameModel.instance:getPlayerMoByUid(uid)

	if playerInfo == nil then
		logError("玩家数据不存在, uid->" .. tostring(uid))
	else
		local skinIds = playerInfo.skinIds

		if not skinIds or #skinIds == 0 then
			skinIds = PartyClothConfig.instance:getDefaultSuitSkinIds()
		end

		resMap = PartyClothConfig.instance:getSkinRes(skinIds)
		self.isMainPlayer = playerInfo:isMainPlayer()
	end

	self.spine:setSkin(resMap)
	self.spine:setResPath(PartyGameEnum.PartyGameUISpineRes, self.onLoadResDone, self)
end

function CommonPartyGamePlayerSpineComp:onLoadResDone()
	self:changeGray()
	self:enableSpineUpdate(self._updateEnable)
end

function CommonPartyGamePlayerSpineComp:playAnim(animName, loop, isBackToIdle, isAudio)
	if isAudio == nil and self.isMainPlayer then
		isAudio = true
	end

	if self.spine then
		self.spine:play(animName, loop, isBackToIdle, isAudio)
	else
		logError("spine 未初始化")
	end
end

function CommonPartyGamePlayerSpineComp:setGray(active)
	if active == self.grayActive then
		return
	end

	self.grayActive = active

	self:changeGray()
end

function CommonPartyGamePlayerSpineComp:enableSpineUpdate(enable)
	self._updateEnable = enable

	if self.spine then
		local skeleton = self.spine:getSkeletonGraphic()

		if skeleton then
			skeleton.freeze = not self._updateEnable
		end
	end
end

local GrayId = UnityEngine.Shader.PropertyToID("_LumFactor")

function CommonPartyGamePlayerSpineComp:changeGray()
	if not self.spine then
		return
	end

	self.spine:setGraphicMatPropFloat(GrayId, self.grayActive and 1 or 0)
end

function CommonPartyGamePlayerSpineComp:onDestroy()
	if self.spine then
		self.spine:doClear()

		self.spine = nil
	end
end

return CommonPartyGamePlayerSpineComp
