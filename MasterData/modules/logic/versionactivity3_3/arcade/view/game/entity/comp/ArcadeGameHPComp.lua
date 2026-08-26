-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/comp/ArcadeGameHPComp.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.comp.ArcadeGameHPComp", package.seeall)

local ArcadeGameHPComp = class("ArcadeGameHPComp", LuaCompBase)

function ArcadeGameHPComp:ctor(param)
	self._entity = param.entity
	self._compName = param.compName
end

function ArcadeGameHPComp:init(go)
	self.go = go
	self.trans = go.transform
	self.goHpBar = gohelper.create3d(self.go, "hpBar")
	self._initialized = true

	local scene = ArcadeGameController.instance:getGameScene()

	if scene then
		local hpItemResUrl = ResUrl.getArcadeSceneRes(ArcadeGameEnum.Const.HpItemResName)

		scene.loader:loadRes(hpItemResUrl, self._onLoadHpBarFinished, self)
	end

	if self._entity then
		local mo = self._entity:getMO()

		if mo then
			local x, y = mo:getHpPos()

			transformhelper.setLocalPos(self.trans, x or 0, y or 0, ArcadeGameEnum.Const.HpZLevel)
		end

		local scale = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.HpBarScale, true)

		if scale then
			transformhelper.setLocalScale(self.trans, scale, scale, 1)
		end
	end
end

function ArcadeGameHPComp:_onLoadHpBarFinished()
	local scene = ArcadeGameController.instance:getGameScene()

	if not self._initialized or not scene then
		return
	end

	local hpItemResUrl = ResUrl.getArcadeSceneRes(ArcadeGameEnum.Const.HpItemResName)
	local assetRes = scene.loader:getResource(hpItemResUrl)

	if not assetRes then
		return
	end

	self._goHpItem = gohelper.clone(assetRes, self.goHpBar)

	self:setHpCap()
	self:refreshShow()
end

function ArcadeGameHPComp:addEventListeners()
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnChangeEntityHp, self._onHpChange, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillAttrChange, self._onSkillChangeAttr, self)
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnResetArcadeGame, self._onResetArcadeGame, self)
end

function ArcadeGameHPComp:removeEventListeners()
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnChangeEntityHp, self._onHpChange, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnSkillAttrChange, self._onSkillChangeAttr, self)
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnResetArcadeGame, self._onResetArcadeGame, self)
end

function ArcadeGameHPComp:_onHpChange(mo)
	if not mo or not self._initialized or not self._entity then
		return
	end

	local curMO = self._entity:getMO()

	if not curMO then
		return
	end

	local curEntityType = curMO:getEntityType()
	local curUid = curMO:getUid()
	local entityType = mo:getEntityType()
	local uid = mo:getUid()

	if curEntityType == entityType and curUid == uid then
		self:refreshHP()
		self:refreshShow()
	end
end

function ArcadeGameHPComp:_onSkillChangeAttr(entityType, uid, attrId)
	if not self._initialized or not self._entity then
		return
	end

	local curMO = self._entity:getMO()

	if not curMO then
		return
	end

	local curEntityType = curMO:getEntityType()
	local curUid = curMO:getUid()

	if curEntityType == entityType and curUid == uid then
		if attrId == ArcadeGameEnum.BaseAttr.hp then
			self:refreshHP()
			self:refreshShow()
		elseif attrId == ArcadeGameEnum.BaseAttr.hpCap then
			self:setHpCap()
			self:refreshShow()
		end
	end
end

function ArcadeGameHPComp:_onResetArcadeGame()
	self:setHpCap()
	self:refreshShow()
end

function ArcadeGameHPComp:setHpCap()
	if gohelper.isNil(self._goHpItem) or not self._entity then
		return
	end

	local mo = self._entity:getMO()
	local hpCap = mo and mo:getAttributeValue(ArcadeGameEnum.BaseAttr.hpCap) or 0
	local maxShowCount = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.MaxShowHpCount, true)

	self._showHpCount = math.min(hpCap, maxShowCount)
	self._hpItemList = {}

	gohelper.CreateNumObjList(self.goHpBar, self._goHpItem, self._showHpCount, self._onCreateHpItem, self)
	self:refreshHP()
end

function ArcadeGameHPComp:_onCreateHpItem(obj, index)
	local hpItem = self:getUserDataTb_()

	hpItem.go = obj
	hpItem.trans = obj.transform
	hpItem.golight = gohelper.findChild(hpItem.go, "light")
	hpItem.goback = gohelper.findChild(hpItem.go, "back")
	hpItem.hpGODict = self:getUserDataTb_()

	local translight = hpItem.golight.transform
	local childCount = translight.childCount

	for i = 1, childCount do
		local child = translight:GetChild(i - 1)

		hpItem.hpGODict[child.name] = child.gameObject
	end

	local interval = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.HpItemSpace, true)
	local startPos = -((self._showHpCount - 1) / 2) * interval
	local x = startPos + (index - 1) * interval

	transformhelper.setLocalPos(hpItem.trans, x, 0, 0)

	self._hpItemList[index] = hpItem
end

function ArcadeGameHPComp:refreshHP()
	if not self._entity then
		return
	end

	local entityMO = self._entity:getMO()
	local curHp = entityMO and entityMO:getHp() or 0

	if self._hpItemList then
		local showHpCount = #self._hpItemList

		for i, hpItem in ipairs(self._hpItemList) do
			local belongHpSeqIndex = ArcadeGameHelper.getHPSeqIndex(curHp, showHpCount, i)

			if belongHpSeqIndex and belongHpSeqIndex >= 0 then
				local imgIndex = ArcadeConfig.instance:getHpColorImgIndex(belongHpSeqIndex)

				for index, goHp in pairs(hpItem.hpGODict) do
					gohelper.setActive(goHp, index == imgIndex)
				end

				gohelper.setActive(hpItem.golight, true)
				gohelper.setActive(hpItem.goback, false)
			else
				gohelper.setActive(hpItem.golight, false)
				gohelper.setActive(hpItem.goback, true)
			end
		end
	end
end

function ArcadeGameHPComp:refreshShow()
	local isShow = false
	local mo = self._entity:getMO()

	if mo then
		local curEntityType = mo:getEntityType()

		if curEntityType == ArcadeGameEnum.EntityType.Character then
			isShow = true
		else
			local characterMO = ArcadeGameModel.instance:getCharacterMO()
			local curHp = mo:getHp() or 0
			local hpCap = mo:getAttributeValue(ArcadeGameEnum.BaseAttr.hpCap)

			if curHp < hpCap then
				isShow = true
			elseif characterMO then
				isShow = ArcadeGameHelper.entityIsAdjacent(mo, characterMO)
			end
		end
	end

	gohelper.setActive(self.goHpBar, isShow)
end

function ArcadeGameHPComp:getCompName()
	return self._compName
end

function ArcadeGameHPComp:clear()
	self._entity = nil
	self._initialized = false
	self._hpItemList = nil
end

function ArcadeGameHPComp:onDestroy()
	return
end

return ArcadeGameHPComp
