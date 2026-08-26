-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EquipSpineView.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EquipSpineView", package.seeall)

local Season123_3_5EquipSpineView = class("Season123_3_5EquipSpineView", BaseView)

function Season123_3_5EquipSpineView:onInitView()
	self._gospine = gohelper.findChild(self.viewGO, "left/hero/#go_herocontainer/dynamiccontainer/#go_spine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_3_5EquipSpineView:addEvents()
	return
end

function Season123_3_5EquipSpineView:removeEvents()
	return
end

function Season123_3_5EquipSpineView:_editableInitView()
	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self:createSpine()
end

function Season123_3_5EquipSpineView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

function Season123_3_5EquipSpineView:onOpen()
	self:refreshHeroSkin()
end

function Season123_3_5EquipSpineView:onClose()
	if self._uiSpine then
		self._uiSpine:setModelVisible(false)
	end
end

function Season123_3_5EquipSpineView:createSpine(skinConfig)
	if skinConfig then
		self._uiSpine:useRT()

		local root = ViewMgr.instance:getUIRoot()

		self._uiSpine:setImgSize(root.transform.sizeDelta.x * 1.25, root.transform.sizeDelta.y * 1.25)
		self._uiSpine:setResPath(skinConfig, self.onSpineLoaded, self)

		local offsets, isNil = SkinConfig.instance:getSkinOffset(skinConfig.characterGetViewOffset)

		if isNil then
			offsets, _ = SkinConfig.instance:getSkinOffset(skinConfig.characterViewOffset)
			offsets = SkinConfig.instance:getAfterRelativeOffset(505, offsets)
		end

		logNormal(string.format("offset = %s, %s, scale = %s", tonumber(offsets[1]), tonumber(offsets[2]), tonumber(offsets[3])))
		recthelper.setAnchor(self._gospine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._gospine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	end
end

function Season123_3_5EquipSpineView:refreshHeroSkin()
	local curPos = Season123EquipItemListModel.instance.curPos
	local heroUid = Season123EquipItemListModel.instance:getPosHeroUid(curPos)

	if not heroUid or heroUid == Activity123Enum.EmptyUid then
		gohelper.setActive(self._gospine, false)

		return nil
	end

	local heroMO = HeroModel.instance:getById(tostring(heroUid)) or HeroGroupTrialModel.instance:getById(heroUid)

	if not heroMO and Season123EquipItemListModel.instance.stage ~= nil then
		heroMO = Season123HeroUtils.getHeroMO(Season123EquipItemListModel.instance.activityId, heroUid, Season123EquipItemListModel.instance.stage)
	end

	if not heroMO then
		logError(string.format("pos heroId [%s] can't find MO", tostring(heroUid)))
		gohelper.setActive(self._gospine, false)

		return nil
	end

	local heroSkinId = heroMO.skin
	local skinCo = SkinConfig.instance:getSkinCo(heroSkinId)

	if skinCo then
		gohelper.setActive(self._gospine, true)
		self:createSpine(skinCo)
	else
		logError("skin config nil ! skin Id = " .. tostring(heroSkinId))
	end
end

function Season123_3_5EquipSpineView:onSpineLoaded()
	self._spineLoaded = true

	self._uiSpine:setUIMask(true)
end

return Season123_3_5EquipSpineView
