-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookpetintroduceView.lua

module("logic.extensions.handbook.view.HandbookpetintroduceView", package.seeall)

local HandbookpetintroduceView = class("HandbookpetintroduceView", ViewComponent)
local DEFAULT_INFO_FOLD = true

function HandbookpetintroduceView:buildUI()
	HandbookpetintroduceView.super.buildUI(self)

	self._petScrollGo = self:getGo("petInfo")
	self._petScroll = self._petScrollGo:GetComponent(ComponentType.ScrollRect)
	self._contentGo = self:getGo("petInfo/Viewport/Content")
	self._contentRect = self._contentGo:GetComponent(goutil.Type_RectTransform)
	self._petBasicCell = self:getGo("petInfo/Viewport/Content/base")
	self._petInfoCell = self:getGo("petInfo/Viewport/Content/character")
	self._petInfoCellIndex = self._petInfoCell.transform:GetSiblingIndex()

	goutil.setActive(self._petInfoCell, false)

	self._skinRoot = self:getGo("petInfo/Viewport/Content/skin")
	self._headRoot = self:getGo("petInfo/Viewport/Content/head")
	self._evolutionRoot = self:getGo("petInfo/Viewport/Content/evolution")
	self._evolutionSeries = {
		self:getGo("petInfo/Viewport/Content/evolution/series1"),
		self:getGo("petInfo/Viewport/Content/evolution/series2")
	}
	self._skinView = ScrollerList.create(self:getGo("petInfo/Viewport/Content/skin/scrView"), self:getGo("petInfo/Viewport/Content/skin/scrCell"), GameUtil.handler(self._updateSkinCell, self), GameUtil.handler(self._clearSkinCell, self))
	self._headView = ScrollerList.create(self:getGo("petInfo/Viewport/Content/head/scrView"), self:getGo("petInfo/Viewport/Content/head/scrCell"), GameUtil.handler(self._updateHeadCell, self), GameUtil.handler(self._clearHeadCell, self))
	self._evolutionViews = {
		ScrollerList.create(self:getGo("petInfo/Viewport/Content/evolution/series1/scrView"), self:getGo("petInfo/Viewport/Content/evolution/series1/scrCell"), GameUtil.handler(self._updateEvolutionCell, self), GameUtil.handler(self._clearEvolutionCell, self)),
		ScrollerList.create(self:getGo("petInfo/Viewport/Content/evolution/series2/scrView"), self:getGo("petInfo/Viewport/Content/evolution/series2/scrCell"), GameUtil.handler(self._updateEvolutionCell, self), GameUtil.handler(self._clearEvolutionCell, self))
	}
end

function HandbookpetintroduceView:bindEvents()
	HandbookpetintroduceView.super.bindEvents(self)
end

function HandbookpetintroduceView:unbindEvents()
	HandbookpetintroduceView.super.unbindEvents(self)
end

function HandbookpetintroduceView:onEnter()
	HandbookpetintroduceView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HandBookPetSelect, self._refresh, self)
	self:_refresh()
end

function HandbookpetintroduceView:onExit()
	HandbookpetintroduceView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookPetSelect, self._refresh, self)
	self:_clearPetInfoCells()
	self._skinView:dispose()
	self._headView:dispose()

	for _, view in ipairs(self._evolutionViews or {}) do
		view:dispose()
	end
end

function HandbookpetintroduceView:_refresh()
	self._raceId = PetbookModel.instance:getSelectedPetRaceId()

	self:_setPetBasicInfo()
	self:_setPetInfo()
	self:_setSkinInfo()
	self:_setHeadInfo()
	self:_setEvolutionInfo()
	self:_refreshLayout(true)
end

function HandbookpetintroduceView:_setPetBasicInfo()
	local basicInfo = HandbookController.instance:getPetBasicInfo(self._raceId)
	local name = goutil.findChildTextComponent(self._petBasicCell, "name/txt")
	local sex = goutil.findChildTextComponent(self._petBasicCell, "sex/txt")
	local birthday = goutil.findChildTextComponent(self._petBasicCell, "birthday/date")
	local height = goutil.findChildTextComponent(self._petBasicCell, "height/txt")
	local weight = goutil.findChildTextComponent(self._petBasicCell, "weight/txt")
	local birthplace = goutil.findChildTextComponent(self._petBasicCell, "birthplace/txt")

	name.text = basicInfo.name

	if basicInfo.sex == 1 then
		sex.text = "女"
	elseif basicInfo.sex == 2 then
		sex.text = "男"
	else
		sex.text = "未知"

		FloatWordMgr.instance:show("性别设置错误")
	end

	birthday.text = basicInfo.birthday
	height.text = basicInfo.height
	weight.text = basicInfo.weight
	birthplace.text = basicInfo.birthplace
end

function HandbookpetintroduceView:_setPetInfo()
	self:_clearPetInfoCells()

	local petInfo = HandbookConfig.instance:getPetInfo(self._raceId)

	if petInfo == nil then
		FloatWordMgr.instance:show("该精灵资料不存在")

		return
	end

	local petCo = CharacterConfig.instance:getPetCo(self._raceId)

	if petCo then
		self._faceId = petCo.faceIds or nil
	end

	self.petInfoCells = {}

	for i = 1, #petInfo do
		local cell = goutil.cloneAndSetParent(self._petInfoCell, self._contentGo.transform)

		cell.name = string.format("character_%s", i)

		cell.transform:SetSiblingIndex(self._petInfoCellIndex + i)
		goutil.setActive(cell, true)

		local cellData = {
			go = cell,
			cfg = petInfo[i],
			isFold = DEFAULT_INFO_FOLD,
			btnShowGo = goutil.findChild(cell, "abbrDesc/btnShow"),
			btnHideGo = goutil.findChild(cell, "completeDesc/btnHide"),
			completeSpace = goutil.findChild(cell, "completeDesc/space")
		}

		table.insert(self.petInfoCells, cellData)
		self:_setPetInfoCell(cellData)
	end
end

function HandbookpetintroduceView:_setPetInfoCell(cellData)
	local cell = cellData.go
	local data = cellData.cfg

	if data == nil then
		FloatWordMgr.instance:show("该精灵资料未知")

		return
	end

	local openCondition = string.split(data.openCondition, ",")

	goutil.findChildTextComponent(cell, "title/txt1").text = "人物资料" .. HandbookController.instance:numberToChinese(data.order)

	if FuncOpenController.instance:checkCondition(openCondition) then
		goutil.setActive(goutil.findChild(cell, "lock"), false)

		local abbrDesc = goutil.findChild(cell, "abbrDesc")
		local completeDesc = goutil.findChild(cell, "completeDesc")
		local txtAbbr = goutil.findChildTextComponent(cell, "abbrDesc/txtDesc")
		local txtComplete = goutil.findChildTextComponent(cell, "completeDesc/txtDesc")

		txtAbbr.text = data.content
		txtComplete.text = data.content
		cellData.needFold = self:_needFoldCharacterInfo(cell, data.content)

		self:_setCharacterCellFold(cellData, (cellData.needFold or nil) and (DEFAULT_INFO_FOLD or false))

		if cellData.needFold then
			if cellData.btnShowGo then
				GameUtil.addClickHandler(cellData.btnShowGo, GameUtil.handler(self._setCharacterCellFold, self, cellData, false))
			end

			if cellData.btnHideGo then
				GameUtil.addClickHandler(cellData.btnHideGo, GameUtil.handler(self._setCharacterCellFold, self, cellData, true))
			end
		else
			goutil.setActive(abbrDesc, false)
			goutil.setActive(completeDesc, true)
			goutil.setActive(cellData.btnHideGo, false)
			goutil.setActive(cellData.completeSpace, not GameUtil.GetActive(cellData.btnHideGo))
		end
	else
		goutil.setActive(goutil.findChild(cell, "abbrDesc"), false)
		goutil.setActive(goutil.findChild(cell, "completeDesc"), false)
		goutil.setActive(goutil.findChild(cell, "lock"), true)

		goutil.findChildTextComponent(cell, "lock/txt").text = data.lockedTips
	end
end

function HandbookpetintroduceView:_needFoldCharacterInfo(cell, content)
	if string.nilorempty(content) then
		return false
	end

	local abbrTextRect = goutil.findChildComponent(cell, "abbrDesc/txtDesc", goutil.Type_RectTransform)
	local txtAbbr = goutil.findChildTextComponent(cell, "abbrDesc/txtDesc")
	local txtComplete = goutil.findChildTextComponent(cell, "completeDesc/txtDesc")
	local maxHeight = abbrTextRect and goutil.getHeight(abbrTextRect) or 0

	if txtComplete then
		if not txtComplete.preferredHeight then
			local preferHeight = 0

			if preferHeight <= 0 and txtAbbr then
				preferHeight = txtAbbr.preferredHeight
			end

			return maxHeight > 0 and preferHeight > maxHeight + 2
		end
	end
end

function HandbookpetintroduceView:_setCharacterCellFold(cellData, isFold)
	local cell = cellData.go
	local abbrDesc = goutil.findChild(cell, "abbrDesc")
	local completeDesc = goutil.findChild(cell, "completeDesc")

	cellData.isFold = isFold

	goutil.setActive(abbrDesc, cellData.needFold and isFold)
	goutil.setActive(completeDesc, not isFold)
	goutil.setActive(cellData.btnHideGo, cellData.needFold and not isFold)
	goutil.setActive(cellData.completeSpace, not GameUtil.GetActive(cellData.btnHideGo))
	self:_refreshLayout(false)
end

function HandbookpetintroduceView:_clearPetInfoCells()
	if self.petInfoCells == nil then
		return
	end

	for _, cellData in ipairs(self.petInfoCells) do
		GameUtil.rmClickHandler(cellData.btnShowGo)
		GameUtil.rmClickHandler(cellData.btnHideGo)
		goutil.destroy(cellData.go)
	end

	self.petInfoCells = {}
end

function HandbookpetintroduceView:_setSkinInfo()
	local cfgs = PetSkinConfig.instance:getAllPetSkinListByRaceId(self._raceId) or {}
	local cfgstr = {}

	for _, v in ipairs(cfgs) do
		if checknumber(v.skinId) ~= checknumber(v.raceId) then
			table.insert(cfgstr, {
				matType = MatType.PET_SKIN,
				matId = v.skinId
			})
		end
	end

	goutil.setActive(self._skinRoot, #cfgstr > 0)
	self._skinView:reloadData(cfgstr)
	self._skinView:dragNotifyParent()
end

function HandbookpetintroduceView:_setHeadInfo()
	local cfgstr = {}
	local cfgs = HeadItemConfig.instance:getAllHeadIconList()

	for _, v in ipairs(cfgs) do
		if v.raceId and v.raceId == self._raceId then
			table.insert(cfgstr, {
				matType = MatType.HeadIcon,
				matId = v.id
			})
		end
	end

	cfgs = HeadItemConfig.instance:getAllHeadFrameList()

	for _, v in ipairs(cfgs) do
		if v.raceId and v.raceId == self._raceId then
			table.insert(cfgstr, {
				matType = MatType.HeadFrame,
				matId = v.id
			})
		end
	end

	goutil.setActive(self._headRoot, #cfgstr > 0)
	self._headView:reloadData(cfgstr)
	self._headView:dragNotifyParent()
end

function HandbookpetintroduceView:_setEvolutionInfo()
	local seriesList = self:_getEvolutionSeriesList(self._raceId)
	local hasEvolution = false

	for i, view in ipairs(self._evolutionViews) do
		if not seriesList[i] then
			local seriesData = {}
			local active = #seriesData > 1

			hasEvolution = hasEvolution or active

			goutil.setActive(self._evolutionSeries[i], active)
			view:reloadData(seriesData)
			view:dragNotifyParent()
		end
	end

	goutil.setActive(self._evolutionRoot, hasEvolution)
end

function HandbookpetintroduceView:_updateSkinCell(view, cell, data)
	local matId = data.matId

	if PetskinController.instance:isClientNotShowIfNotForever(matId) then
		matId = PetSkinConfig.instance:getPetSkinRaceId(matId)
	end

	local getFlag = goutil.findChild(cell.gameObject, "getFlag")
	local withTag = goutil.findChild(cell.gameObject, "withTag")
	local item = goutil.findChild(cell.gameObject, "item")
	local isWith = MaterialModel.instance:getMaterialsNumber(data.matType, data.matId) > 0

	GameUtil.SetActive(getFlag, not isWith)
	GameUtil.SetActive(withTag, false)

	local proxy = MaterialMgr.setCellByCfg(string.format("%s:%s:0", data.matType, matId), item)

	proxy.binder:setTagVisible(false)
	proxy.binder:setWithTag(0)

	if isWith then
		proxy.binder:setAutoTips(true)
		proxy.binder:setCallBack(function()
			PetbookModel.instance:setEnterTab(2)
		end)
	else
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			MaterialMgr.openGetSource(data.matType, matId)
		end)
	end
end

function HandbookpetintroduceView:_clearSkinCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(item)
end

function HandbookpetintroduceView:_updateHeadCell(view, cell, data)
	local proxy = MaterialMgr.setCellByCfg(string.format("%s:%s:0", data.matType, data.matId), goutil.findChild(cell.gameObject, "item"))
	local getFlag = goutil.findChild(cell.gameObject, "getFlag")
	local withTag = goutil.findChild(cell.gameObject, "withTag")
	local isWith = MaterialModel.instance:getMaterialsNumber(data.matType, data.matId) > 0

	GameUtil.SetActive(getFlag, not isWith)
	GameUtil.SetActive(withTag, false)

	if data.matType == MatType.HeadFrame then
		proxy.binder:setScale(0.75)
	end
end

function HandbookpetintroduceView:_clearHeadCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(item)
end

function HandbookpetintroduceView:_updateEvolutionCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")
	local tagType = goutil.findChild(cell.gameObject, "tagType")
	local tagNotWith = goutil.findChild(cell.gameObject, "tagNotWith")
	local tagNext = goutil.findChild(cell.gameObject, "tagNext")
	local txtTag = goutil.findChildTextComponent(cell.gameObject, "tagType/txt")
	local hasPet = HandbookModel.instance:isHasPet(data.raceId)
	local proxy = MaterialMgr.setCell(data.matType, data.matId, item)

	if proxy and proxy.binder then
		proxy.binder:setAutoTips(true)
		proxy.binder:setCallBack(nil)
	end

	goutil.setActive(tagType, not string.nilorempty(data.tagText))
	goutil.setActive(tagNotWith, not hasPet)
	goutil.setActive(tagNext, data.hasNext == true)

	txtTag.text = data.tagText
end

function HandbookpetintroduceView:_clearEvolutionCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")
	local tagNotWith = goutil.findChild(cell.gameObject, "tagNotWith")
	local tagNext = goutil.findChild(cell.gameObject, "tagNext")

	goutil.setActive(tagNotWith, false)
	goutil.setActive(tagNext, false)
	MaterialMgr.resetAll(item)
end

function HandbookpetintroduceView:_getEvolutionSeriesList(raceId)
	local childrenMap, prevMap, tagMap, tierMap, orderMap, nodeMap = self:_buildEvolutionRelation()

	raceId = checknumber(raceId)

	if not nodeMap[raceId] then
		return {
			{},
			{}
		}
	end

	local rootRaceId = self:_getEvolutionRootRaceId(raceId, prevMap, tierMap, orderMap)

	return {
		self:_buildEvolutionSeries(rootRaceId, {
			EvolveEnum.EvolutionTier.Initial,
			EvolveEnum.EvolutionTier.Divine,
			EvolveEnum.EvolutionTier.SourceTrace
		}, childrenMap, tagMap, tierMap, orderMap),
		self:_buildEvolutionSeries(rootRaceId, {
			EvolveEnum.EvolutionTier.Initial,
			EvolveEnum.EvolutionTier.DivineEvolve
		}, childrenMap, tagMap, tierMap, orderMap)
	}
end

function HandbookpetintroduceView:_buildEvolutionRelation()
	local childrenMap = {}
	local prevMap = {}
	local tagMap = {}
	local tierMap = {}
	local orderMap = {}
	local nodeMap = {}
	local edgeMap = {}
	local order = 0

	for _, cfg in ipairs(EvolveConfig.instance:getDivineEvolveCfgList() or {}) do
		order = order + 1

		local tier = EvolveEnum.EvolutionTier.DivineEvolve

		self:_appendEvolutionEdge(cfg, ConstString.HandbookPetEvolutionTag[tier], tier, order, childrenMap, prevMap, tagMap, tierMap, orderMap, nodeMap, edgeMap)
	end

	for _, cfg in ipairs(EvolveConfig.instance:getDivineEvolvePlusList() or {}) do
		local tier

		if cfg.evolutionType == EvolveEnum.EvolveType.Divine then
			tier = EvolveEnum.EvolutionTier.Divine
		elseif cfg.evolutionType == EvolveEnum.EvolveType.SourceTrace then
			tier = EvolveEnum.EvolutionTier.SourceTrace
		end

		if tier then
			if not ConstString.HandbookPetEvolutionTag[tier] then
				local tagText

				if tagText then
					order = order + 1

					self:_appendEvolutionEdge(cfg, tagText, tier, order, childrenMap, prevMap, tagMap, tierMap, orderMap, nodeMap, edgeMap)
				end
			end
		end
	end

	return childrenMap, prevMap, tagMap, tierMap, orderMap, nodeMap
end

function HandbookpetintroduceView:_appendEvolutionEdge(cfg, tagText, tier, order, childrenMap, prevMap, tagMap, tierMap, orderMap, nodeMap, edgeMap)
	if cfg == nil then
		return
	end

	local raceId = checknumber(cfg.raceId)
	local newRaceId = checknumber(cfg.newRaceId)

	if raceId <= 0 or newRaceId <= 0 then
		return
	end

	nodeMap[raceId] = true
	nodeMap[newRaceId] = true
	tierMap[raceId] = tierMap[raceId] or EvolveEnum.EvolutionTier.Initial
	tierMap[newRaceId] = tier
	tagMap[newRaceId] = tagText
	orderMap[raceId] = orderMap[raceId] or order
	orderMap[newRaceId] = orderMap[newRaceId] or order

	local edgeKey = string.format("%s_%s", raceId, newRaceId)

	if edgeMap[edgeKey] then
		return
	end

	edgeMap[edgeKey] = true
	childrenMap[raceId] = childrenMap[raceId] or {}

	table.insert(childrenMap[raceId], newRaceId)

	prevMap[newRaceId] = prevMap[newRaceId] or {}

	table.insert(prevMap[newRaceId], raceId)
end

function HandbookpetintroduceView:_getEvolutionRootRaceId(raceId, prevMap, tierMap, orderMap)
	local curRaceId = raceId
	local visited = {}

	while curRaceId and not visited[curRaceId] do
		visited[curRaceId] = true

		if checknumber(tierMap[curRaceId]) == EvolveEnum.EvolutionTier.Initial then
			return curRaceId
		end

		local prevList = {}

		for _, prevRaceId in ipairs(prevMap[curRaceId] or {}) do
			table.insert(prevList, prevRaceId)
		end

		table.sort(prevList, function(a, b)
			return self:_getEvolutionSortValue(a, tierMap, orderMap) < self:_getEvolutionSortValue(b, tierMap, orderMap)
		end)

		curRaceId = prevList[1]
	end

	return raceId
end

function HandbookpetintroduceView:_buildEvolutionSeries(rootRaceId, tierList, childrenMap, tagMap, tierMap, orderMap)
	local res = {}
	local curRaceId = rootRaceId

	for i, tier in ipairs(tierList) do
		if not curRaceId or checknumber(tierMap[curRaceId]) ~= tier then
			break
		end

		self:_appendEvolutionCellData(curRaceId, res, tagMap, tierMap)

		if i < #tierList then
			curRaceId = self:_getEvolutionChildByTier(curRaceId, tierList[i + 1], childrenMap, tierMap, orderMap)
		end
	end

	if #res == 1 and tierList[#tierList] == EvolveEnum.EvolutionTier.SourceTrace then
		local sourceTraceRaceId = self:_getEvolutionChildByTier(rootRaceId, EvolveEnum.EvolutionTier.SourceTrace, childrenMap, tierMap, orderMap)

		if sourceTraceRaceId then
			self:_appendEvolutionCellData(sourceTraceRaceId, res, tagMap, tierMap)
		end
	end

	for i, data in ipairs(res) do
		data.hasNext = i < #res
	end

	return res
end

function HandbookpetintroduceView:_appendEvolutionCellData(raceId, res, tagMap, tierMap)
	local var_30_0 = {
		raceId = raceId,
		matType = MatType.Pet,
		matId = raceId
	}

	var_30_0.tagText = tagMap[raceId] or ConstString.HandbookPetEvolutionTag[tierMap[raceId]] or ""

	table.insert(res, var_30_0)
end

function HandbookpetintroduceView:_getEvolutionChildByTier(raceId, tier, childrenMap, tierMap, orderMap)
	local children = {}

	for _, childRaceId in ipairs(childrenMap[raceId] or {}) do
		if checknumber(tierMap[childRaceId]) == tier then
			table.insert(children, childRaceId)
		end
	end

	table.sort(children, function(a, b)
		return self:_getEvolutionSortValue(a, tierMap, orderMap) < self:_getEvolutionSortValue(b, tierMap, orderMap)
	end)

	return children[1]
end

function HandbookpetintroduceView:_getEvolutionSortValue(raceId, tierMap, orderMap)
	return checknumber(tierMap[raceId]) * 100000000 + checknumber(orderMap[raceId]) * 10000 + checknumber(raceId)
end

function HandbookpetintroduceView:_refreshLayout(resetScrollPos)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._contentRect)

	if resetScrollPos and self._petScroll then
		self._petScroll.verticalNormalizedPosition = 1
	end
end

return HandbookpetintroduceView
