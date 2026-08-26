-- chunkname: @modules/logic/sp01/odyssey/view/OdysseySuitListView.lua

module("modules.logic.sp01.odyssey.view.OdysseySuitListView", package.seeall)

local OdysseySuitListView = class("OdysseySuitListView", BaseView)

function OdysseySuitListView:ctor(goRootPath)
	self._goRootPath = goRootPath
end

function OdysseySuitListView:onInitView()
	if self._goRootPath then
		self.viewGO = gohelper.findChild(self.viewGO, self._goRootPath)
	end

	self._scrollSuit = gohelper.findChildScrollRect(self.viewGO, "#scroll_Suit")
	self._scrollSuitContent = gohelper.findChild(self.viewGO, "#scroll_Suit/Viewport/Content")
	self._gosuit = gohelper.findChild(self.viewGO, "#scroll_Suit/Viewport/Content/#go_suit")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseySuitListView:_editableInitView()
	self._suitItemList = {}

	gohelper.setActive(self._gosuit, false)
end

function OdysseySuitListView:addEvents()
	self.addEventCb(self, OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, self.refreshSuitInfo, self)
end

function OdysseySuitListView:removeEvents()
	self.addEventCb(self, OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, self.refreshSuitInfo, self)
end

function OdysseySuitListView:onOpen()
	self:refreshSuitInfo()
end

function OdysseySuitListView:refreshSuitInfo()
	local allConfigList = OdysseyConfig.instance:getEquipSuitConfigList()
	local haveSuit = allConfigList ~= nil and allConfigList[1] ~= nil

	gohelper.setActive(self._scrollSuit, haveSuit)

	if haveSuit == false then
		return
	end

	local suitItemList = self._suitItemList
	local needSuitItemCount = 0
	local haveSuitItemCount = #suitItemList
	local tempSuitInfoList = {}
	local curHeroGroupMo = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	for _, config in ipairs(allConfigList) do
		local suitLevelList = OdysseyConfig.instance:getEquipSuitAllEffect(config.id)

		if suitLevelList == nil or next(suitLevelList) == nil then
			logError(string.format("奥德赛 套装 id : %s 没有套装效果数据", tostring(config.id)))
		else
			local suitInfo = curHeroGroupMo:getOdysseyEquipSuit(config.id)

			if suitInfo and suitInfo.count > 0 then
				needSuitItemCount = needSuitItemCount + 1

				local suitItem

				if haveSuitItemCount < needSuitItemCount then
					local suitItemGo = gohelper.clone(self._gosuit, self._scrollSuitContent)

					table.insert(suitItemList, (MonoHelper.addNoUpdateLuaComOnceToGo(suitItemGo, OdysseySuitListItem)))
				else
					suitItem = suitItemList[needSuitItemCount]
				end

				table.insert(tempSuitInfoList, suitInfo)
			end
		end
	end

	table.sort(tempSuitInfoList, self.sortSuit)

	for i = 1, needSuitItemCount do
		local suitInfo = tempSuitInfoList[i]
		local suitItem = suitItemList[i]
		local config = OdysseyConfig.instance:getEquipSuitConfig(suitInfo.suitId)

		suitItem:setActive(true)
		suitItem:setInfo(suitInfo.suitId, config)
		suitItem:refreshUI()
	end

	if needSuitItemCount < haveSuitItemCount then
		for i = needSuitItemCount + 1, haveSuitItemCount do
			local item = suitItemList[i]

			item:setActive(false)
		end
	end
end

function OdysseySuitListView.sortSuit(a, b)
	if a.level == b.level then
		return a.count > b.count
	end

	return a.level > b.level
end

return OdysseySuitListView
