-- chunkname: @modules/logic/survival/view/shelter/SurvivalMonsterEventNpcItem.lua

module("modules.logic.survival.view.shelter.SurvivalMonsterEventNpcItem", package.seeall)

local SurvivalMonsterEventNpcItem = class("SurvivalMonsterEventNpcItem", ListScrollCellExtend)

function SurvivalMonsterEventNpcItem:onInitView()
	self.goGrid = gohelper.findChild(self.viewGO, "Grid")
	self.goSmallItem = gohelper.findChild(self.viewGO, "#go_SmallItem")

	gohelper.setActive(self.goSmallItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalMonsterEventNpcItem:addEvents()
	return
end

function SurvivalMonsterEventNpcItem:removeEvents()
	return
end

local unNeedTagBgColorAlpha = 0.6

function SurvivalMonsterEventNpcItem:_editableInitView()
	self.itemList = self:getUserDataTb_()
end

function SurvivalMonsterEventNpcItem:onClickGridItem(item)
	if not item.data then
		return
	end

	local status = item.data:getShelterNpcStatus()

	if status == SurvivalEnum.ShelterNpcStatus.InDestoryBuild then
		GameFacade.showToast(ToastEnum.SurvivalBossSelectNpcBuildDestroy)

		return
	end

	if status == SurvivalEnum.ShelterNpcStatus.NotInBuild or status == SurvivalEnum.ShelterNpcStatus.OutSide then
		return
	end

	local npcId = item.data.id

	if SurvivalShelterNpcMonsterListModel.instance:isSelectNpc(npcId) then
		if SurvivalShelterNpcMonsterListModel.instance:cancelSelect(npcId) then
			self._view.viewContainer:refreshView()
		end
	else
		if not SurvivalShelterNpcMonsterListModel.instance:canSelect() then
			GameFacade.showToast(ToastEnum.SurvivalBossSelectNpcFull)

			return
		end

		if SurvivalShelterNpcMonsterListModel.instance:setSelectNpcId(npcId) then
			self._view.viewContainer:refreshView()
		end
	end
end

function SurvivalMonsterEventNpcItem:onUpdateMO(mo)
	self.mo = mo

	if not mo then
		return
	end

	local list = mo.dataList

	for i = 1, math.max(#list, #self.itemList) do
		local item = self:getGridItem(i)

		self:refreshGridItem(item, list[i])
	end
end

local ZProj_UIEffectsCollection = ZProj.UIEffectsCollection

function SurvivalMonsterEventNpcItem:getGridItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.go = gohelper.clone(self.goSmallItem, self.goGrid, tostring(index))
		item.imgChess = gohelper.findChildSingleImage(item.go, "#image_Chess")
		item.txtName = gohelper.findChildTextMesh(item.go, "#txt_PartnerName")
		item.goSelect = gohelper.findChild(item.go, "#go_Selected")
		item.goRecommend = gohelper.findChild(item.go, "#go_recommend")
		item.goTagItem = gohelper.findChild(item.go, "#scroll_tag/viewport/content/#go_tagitem")
		item.goEffect = ZProj_UIEffectsCollection.Get(item.go)

		gohelper.setActive(item.goTagItem, false)

		item.btn = gohelper.findButtonWithAudio(item.go)

		item.btn:AddClickListener(self.onClickGridItem, self, item)

		item.allTags = self:getUserDataTb_()
		self.itemList[index] = item
	end

	return item
end

function SurvivalMonsterEventNpcItem:refreshGridItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)
	gohelper.setActive(item.goSelect, SurvivalShelterNpcMonsterListModel.instance:isSelectNpc(data.id))

	local recommendNum = SurvivalShelterMonsterModel.instance:calRecommendNum(data.id)

	gohelper.setActive(item.goRecommend, recommendNum > 0)

	item.txtName.text = data.co.name

	SurvivalUnitIconHelper.instance:setNpcIcon(item.imgChess, data.co.headIcon)

	if item.goEffect then
		local status = item.data:getShelterNpcStatus()
		local showGray = status == SurvivalEnum.ShelterNpcStatus.NotInBuild or status == SurvivalEnum.ShelterNpcStatus.OutSide

		item.goEffect:SetGray(showGray)
	end

	if item.allTags then
		for i = 1, #item.allTags do
			gohelper.destroy(item.allTags[i])
		end

		item.allTags = {}
	end

	local _, tags = SurvivalConfig.instance:getNpcConfigTag(data.id)

	for i = 1, #tags do
		local tag = tags[i]

		if tag then
			local config = lua_survival_tag.configDict[tag]

			if config ~= nil then
				local tagGo = gohelper.cloneInPlace(item.goTagItem, tag)
				local image = gohelper.findChildImage(tagGo, "#image_Type")
				local color = SurvivalConst.ShelterTagColor[config.tagType]

				if color then
					local _color = GameUtil.parseColor(color)
					local isNeed = SurvivalShelterMonsterModel.instance:isNeedNpcTag(tag)

					_color.a = isNeed and 1 or unNeedTagBgColorAlpha
					image.color = _color
				end

				local txt = gohelper.findChildText(tagGo, "#txt_Type")

				txt.text = config.name

				gohelper.setActive(tagGo, true)
				table.insert(item.allTags, tagGo)
			else
				logError("SurvivalMonsterEventNpcItem:refreshGridItem tag config is nil, tagId = " .. tostring(tag) .. " npcId = " .. tostring(data.id))
			end
		end
	end
end

function SurvivalMonsterEventNpcItem:onDestroyView()
	for k, v in pairs(self.itemList) do
		v.btn:RemoveClickListener()
	end
end

return SurvivalMonsterEventNpcItem
