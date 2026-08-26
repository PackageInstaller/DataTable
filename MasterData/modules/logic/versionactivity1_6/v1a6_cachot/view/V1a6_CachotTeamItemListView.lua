-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTeamItemListView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamItemListView", package.seeall)

local V1a6_CachotTeamItemListView = class("V1a6_CachotTeamItemListView", BaseView)

function V1a6_CachotTeamItemListView:onInitView()
	self._gopresetcontent = gohelper.findChild(self.viewGO, "#go_tipswindow/left/scroll_view/Viewport/#go_presetcontent")
	self._gopreparecontent = gohelper.findChild(self.viewGO, "#go_tipswindow/right/scroll_view/Viewport/#go_preparecontent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotTeamItemListView:addEvents()
	return
end

function V1a6_CachotTeamItemListView:removeEvents()
	return
end

function V1a6_CachotTeamItemListView:_editableInitView()
	return
end

function V1a6_CachotTeamItemListView:_initPresetItemList()
	if self._presetItemList then
		return
	end

	self._presetItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, V1a6_CachotEnum.HeroCountInGroup do
		local childGO = self:getResInst(path, self._gopresetcontent, "item" .. tostring(i))
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotTeamItem)

		self._presetItemList[i] = item

		item:setInteractable(self._isInitSelect)
		item:setHpVisible(not self._isInitSelect)
	end
end

function V1a6_CachotTeamItemListView:_initPrepareItemList()
	if self._prepareItemList then
		return
	end

	self._prepareItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[2]
	local num = V1a6_CachotTeamModel.instance:getPrepareNum()

	for i = 1, 4 do
		local childGO = self:getResInst(path, self._gopreparecontent, "item" .. tostring(i))
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotTeamPrepareItem)

		self._prepareItemList[i] = item

		item:setInteractable(self._isInitSelect and i <= num)
		item:setHpVisible(not self._isInitSelect)

		if num < i then
			item:showNone()
		end
	end
end

function V1a6_CachotTeamItemListView:_initParams()
	self._isInitSelect = self.viewParam and self.viewParam.isInitSelect
end

function V1a6_CachotTeamItemListView:onOpen()
	self:_initParams()

	if self._isInitSelect then
		self:_initModel()
	end

	self:_initPresetItemList()
	self:_initPrepareItemList()
	self:_updatePresetAndPrepare()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._modifyHeroGroup, self)
end

function V1a6_CachotTeamItemListView:_modifyHeroGroup()
	self._isModify = true

	self:_updatePresetAndPrepare()

	self._isModify = false
end

function V1a6_CachotTeamItemListView:_updatePresetAndPrepare()
	V1a6_CachotTeamModel.instance:clearSeatInfos()
	self:_updatePresetItemList()
	self:_updatePrepareItemList()
end

function V1a6_CachotTeamItemListView:_initModel()
	local num = V1a6_CachotTeamModel.instance:getPrepareNum()
	local rogueStateInfo = V1a6_CachotModel.instance:getRogueStateInfo()
	local heroList, equips = rogueStateInfo:getLastGroupInfo(num)
	local groupMO = V1a6_CachotHeroGroupMO.New()

	groupMO:setMaxHeroCount(V1a6_CachotEnum.InitTeamMaxHeroCountInGroup)

	local curGroupId = 1

	groupMO:init({
		groupId = curGroupId,
		heroList = heroList,
		equips = equips
	})
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.InitTeamMaxHeroCountInGroup)
	V1a6_CachotHeroSingleGroupModel.instance:setSingleGroup(groupMO)
end

function V1a6_CachotTeamItemListView:_updatePresetItemList()
	for i, item in ipairs(self._presetItemList) do
		local mo = V1a6_CachotHeroSingleGroupModel.instance:getById(i)

		V1a6_CachotTeamModel.instance:setSeatInfo(i, V1a6_CachotTeamModel.instance:getInitSeatLevel(i), mo)

		local heroMo = mo:getHeroMO()

		if self._isModify and heroMo and item:getHeroMo() ~= heroMo then
			item:showSelectEffect()
		end

		item:onUpdateMO(mo)
	end
end

function V1a6_CachotTeamItemListView:_updatePrepareItemList()
	for i, item in ipairs(self._prepareItemList) do
		local mo = V1a6_CachotHeroSingleGroupModel.instance:getById(i + V1a6_CachotEnum.HeroCountInGroup)
		local heroMo = mo:getHeroMO()

		if self._isModify and heroMo and item:getHeroMo() ~= heroMo then
			item:showSelectEffect()
		end

		item:onUpdateMO(mo)
	end
end

function V1a6_CachotTeamItemListView:onClose()
	return
end

function V1a6_CachotTeamItemListView:onDestroyView()
	return
end

return V1a6_CachotTeamItemListView
