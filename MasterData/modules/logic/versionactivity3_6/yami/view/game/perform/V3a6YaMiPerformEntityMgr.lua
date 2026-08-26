-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiPerformEntityMgr.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiPerformEntityMgr", package.seeall)

local V3a6YaMiPerformEntityMgr = class("V3a6YaMiPerformEntityMgr", BaseView)

function V3a6YaMiPerformEntityMgr:onInitView()
	self._gohero = gohelper.findChild(self.viewGO, "root/hero")
	self._gofloat = gohelper.findChild(self.viewGO, "root/float")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiPerformEntityMgr:addEvents()
	return
end

function V3a6YaMiPerformEntityMgr:removeEvents()
	return
end

function V3a6YaMiPerformEntityMgr:_editableInitView()
	self._heroEntities = self:getUserDataTb_()
	self._heroRootList = self:getUserDataTb_()

	for i = 1, 8 do
		self._heroRootList[i] = gohelper.findChild(self._gohero, i)
	end

	self._scene = V3a6YaMiController.instance:getScene()
end

function V3a6YaMiPerformEntityMgr:onOpen()
	self._curTalkCount = 0

	self:checkLoadRes()
	self:showHeros()
end

function V3a6YaMiPerformEntityMgr:checkLoadRes()
	self._heroPrefab = self._heroPrefab or self.viewContainer:getRes(V3a6YaMiEnum.ResPath.HeroEntity)
	self._attrFloatPrefab = self._attrFloatPrefab or self.viewContainer:getRes(V3a6YaMiEnum.ResPath.AttrFloat)
	self._talkFloatPrefab = self._talkFloatPrefab or self.viewContainer:getRes(V3a6YaMiEnum.ResPath.Talk)
end

function V3a6YaMiPerformEntityMgr:showHeros()
	local heros = V3a6YaMiModel.instance:getSelectHeros()

	self._heroDict = {}

	local count = 0

	if heros then
		for i, heroId in ipairs(heros) do
			local mo = V3a6YaMiModel.instance:getHeroMoById(heroId)
			local item = self:_getHeroEntity(i)

			item:refreshMo(mo)
			item:refreshHero(heroId, i)
			item:appear()

			self._heroDict[heroId] = i
			count = count + 1
		end
	end

	for i = 1, #self._heroEntities do
		self._heroEntities[i]:setActive(i <= count)
	end

	self:_checkTalk()
end

function V3a6YaMiPerformEntityMgr:_getHeroEntity(index)
	local entity = self._heroEntities[index]

	if not entity then
		local go = gohelper.clone(self._heroPrefab, self._heroRootList[index])

		recthelper.setAnchor(go.transform, 0, 0)

		entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a6YaMiHeroEntity)
		self._heroEntities[index] = entity
	end

	return entity
end

function V3a6YaMiPerformEntityMgr:getHeroEntityById(heroId)
	local index = self._heroDict[heroId]

	if index then
		return self._heroEntities[index]
	end
end

function V3a6YaMiPerformEntityMgr:useSkill(heroId, skillId, effectId)
	local entity = self:getHeroEntityById(heroId)

	if entity then
		entity:playEffectAnim(effectId)
	end
end

function V3a6YaMiPerformEntityMgr:showAttrFloatItem(type, value, heroId, delayTime, callback, callbackObj)
	local item = self:_getCanUseAttrFloat()

	if item then
		local index = self._heroDict[heroId]
		local x, y = recthelper.getAnchor(self._heroRootList[index].transform)

		recthelper.setAnchor(item.go.transform, x or 0, (y or 0) + 200)
		item:showAttrFloat(type, value, delayTime, callback, callbackObj)
	end
end

function V3a6YaMiPerformEntityMgr:_getCanUseAttrFloat()
	self._attrFloatItems = self._attrFloatItems or {}

	for _, item in ipairs(self._attrFloatItems) do
		if not item.isShow then
			return item
		end
	end

	if not self._attrFloatPrefab then
		return
	end

	local go = gohelper.clone(self._attrFloatPrefab, self._gofloat)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a6YaMiAttrFloatItem)

	table.insert(self._attrFloatItems, item)
	item:hide()

	return item
end

function V3a6YaMiPerformEntityMgr:_checkTalk()
	self._talkItems = {}

	local heros = V3a6YaMiModel.instance:getSelectHeros()
	local count = 0

	if heros then
		for i, heroId in ipairs(heros) do
			local item = self:_getTalkItem(i)
			local index = self._heroDict[heroId]
			local x, y = recthelper.getAnchor(self._heroRootList[index].transform)

			recthelper.setAnchor(item.go.transform, x or 0, (y or 0) + 80)
			item:onUpdateMO(heroId, self)
			item:checkTalk()

			count = count + 1
		end
	end

	for i = 1, #self._talkItems do
		self._talkItems[i]:setActive(false)
	end
end

function V3a6YaMiPerformEntityMgr:_getTalkItem(index)
	if not self._talkItems[index] then
		local go = gohelper.clone(self._talkFloatPrefab, self._gofloat)

		self._talkItems[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a6YaMiHeroTalkItem)
	end

	return self._talkItems[index]
end

function V3a6YaMiPerformEntityMgr:modifyTalkCount(isAdd)
	self._curTalkCount = self._curTalkCount or 0

	if isAdd then
		self._curTalkCount = self._curTalkCount + 1 or self._curTalkCount - 1
	end
end

function V3a6YaMiPerformEntityMgr:getTalkCount()
	return self._curTalkCount
end

function V3a6YaMiPerformEntityMgr:isCanShow()
	self._talkMaxCount = self._talkMaxCount or V3a6YaMiConfig.instance:getConstValueByConst(V3a6YaMiEnum.ConstId.TalkMaxCount) or 4

	return self._curTalkCount < self._talkMaxCount
end

function V3a6YaMiPerformEntityMgr:onClose()
	return
end

return V3a6YaMiPerformEntityMgr
