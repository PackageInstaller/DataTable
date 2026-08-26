-- chunkname: @modules/logic/sp01/library/AssassinLibraryHeroView.lua

module("modules.logic.sp01.library.AssassinLibraryHeroView", package.seeall)

local AssassinLibraryHeroView = class("AssassinLibraryHeroView", BaseView)

function AssassinLibraryHeroView:onInitView()
	self._goherocontainer = gohelper.findChild(self.viewGO, "#go_herocontainer")
	self._goinfocontainer = gohelper.findChild(self.viewGO, "#go_infocontainer")
	self._goinfoitem = gohelper.findChild(self.viewGO, "#go_infoitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinLibraryHeroView:addEvents()
	return
end

function AssassinLibraryHeroView:removeEvents()
	return
end

function AssassinLibraryHeroView:_editableInitView()
	self._infoItemTab = self:getUserDataTb_()

	gohelper.setActive(self._goinfoitem, false)
end

function AssassinLibraryHeroView:onUpdateParam()
	return
end

function AssassinLibraryHeroView:onOpen()
	self:init()
	self:refreshUI()
end

function AssassinLibraryHeroView:refreshUI()
	local useMap = {}

	for index, libraryCo in ipairs(self._libraryCoList) do
		local infoItem = self:_getOrCreateInfoItem(index)

		infoItem:onUpdateMO(libraryCo)

		useMap[infoItem] = true
	end

	for _, infoItem in pairs(self._infoItemTab) do
		if not useMap[infoItem] then
			infoItem:setIsUsing(false)
		end
	end

	local isAllUnlock = AssassinLibraryModel.instance:isUnlockAllLibrarys(self._actId, self._libType)

	gohelper.setActive(self._goall, isAllUnlock)
	gohelper.setActive(self._goempty, not isAllUnlock)
end

function AssassinLibraryHeroView:_getOrCreateInfoItem(index)
	local infoItem = self._infoItemTab[index]
	local gobody = gohelper.findChild(self._goheroes, "go_pos" .. index)
	local goinforoot = gohelper.findChild(self._goinfos, "go_pos" .. index)

	if not infoItem then
		local goinfo = gohelper.clone(self._goinfoitem, goinforoot, "item_" .. index)

		if gohelper.isNil(goinforoot) or gohelper.isNil(gobody) then
			logError(string.format("缺少挂点 index = %s", index))
		end

		infoItem = MonoHelper.addNoUpdateLuaComOnceToGo(goinfo, AssassinLibraryHeroInfoItem)
		self._infoItemTab[index] = infoItem
	end

	infoItem:initRoot(goinforoot)
	infoItem:initBody(gobody)

	return infoItem
end

function AssassinLibraryHeroView:init()
	self._actId = AssassinLibraryModel.instance:getCurActId()
	self._libType = AssassinLibraryModel.instance:getCurLibType()
	self._libraryCoList = AssassinConfig.instance:getLibraryConfigs(self._actId, self._libType)
	self._goheroes = self:_getAndActiveTargetGo(self._goherocontainer, tostring(self._actId))
	self._goinfos = self:_getAndActiveTargetGo(self._goinfocontainer, tostring(self._actId))
	self._goall = gohelper.findChild(self._goheroes, "#go_All")
	self._goempty = gohelper.findChild(self._goheroes, "#go_Empty")
end

function AssassinLibraryHeroView:_getAndActiveTargetGo(rootGo, targetGoName)
	local rootTran = rootGo.transform
	local childCount = rootTran.childCount
	local targetGo

	for i = 1, childCount do
		local childGo = rootTran:GetChild(i - 1).gameObject
		local isTarget = childGo.name == targetGoName

		if isTarget then
			targetGo = childGo
		end

		gohelper.setActive(childGo, isTarget)
	end

	if gohelper.isNil(targetGo) then
		logError(string.format("未找到指定节点 rootGo = %s, targetGoName = %s", rootGo.name, targetGoName))
	end

	return targetGo
end

function AssassinLibraryHeroView:onClose()
	return
end

function AssassinLibraryHeroView:onDestroyView()
	return
end

return AssassinLibraryHeroView
