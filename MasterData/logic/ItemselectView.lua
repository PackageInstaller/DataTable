-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfareequiprecycle/view/ItemselectView.lua

module("logic.extensions.welfareequiprecycle.view.ItemselectView", package.seeall)

local ItemselectView = class("ItemselectView", ViewComponent)

function ItemselectView:ctor()
	ItemselectView.super.ctor(self)
end

function ItemselectView:buildUI()
	ItemselectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._btnSelectAll = self:getGo("btnSelectAll")
	self._petScrollerview = self:getGo("petCol/petScrollerview")
	self._petScrollercell = self:getGo("petCol/petScrollercell")
	self._empty = self:getGo("petCol/empty")
	self._scrollList = ScrollerList.create(self._petScrollerview, self._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._btnSort = self:getGo("btnSort")
	self._btnFilter = self:getGo("btnFilter")
	self._InputC_Search = self:getGo("InputC_Search")
	self._inputSearch = self:getInput("InputC_Search")
	self._btnClear = self:getGo("InputC_Search/btnClear")
end

function ItemselectView:bindEvents()
	ItemselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnSelectAll, self._onClickSelectAll, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnClear, self._onClearSearch, self)
	GameUtil.addClickHandler(self._InputC_Search, self._OnSearchTextChanged, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function ItemselectView:unbindEvents()
	ItemselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnSelectAll)
	GameUtil.rmClickHandler(self._btnSort)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnClear)
	self._inputSearch:RemoveOnValueChanged()
end

function ItemselectView:destroyUI()
	ItemselectView.super.destroyUI(self)
end

function ItemselectView:onEnter()
	ItemselectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	if not params[1] then
		local list = {}
		local callBack = params[2]

		if not params[3] then
			if not params[4] then
				self._limitCount = 300
				self._currSelectCount = 0
				self._selectPool = {}

				for i, itemMo in ipairs(params[3]) do
					self._selectPool[itemMo] = true
					self._currSelectCount = self._currSelectCount + 1
				end

				self._callBack = callBack
				self._list = list
				self._pinyinCache = {}

				self:_onUpdatePetColUI()
			end
		end
	end
end

function ItemselectView:onExit()
	ItemselectView.super.onExit(self)
	removetimer(self._timerChange, self)
	self:_onClearPetCol()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_ITEM_SELECT_EQUIP)
end

function ItemselectView:_onUpdatePetColUI()
	self._viewItemMoList = {}

	for _, itemMo in pairs(self._list) do
		if self:_onFilter(itemMo) then
			table.insert(self._viewItemMoList, itemMo)
		end
	end

	self._scrollList:reloadData(self._viewItemMoList)
	GameUtil.SetActive(self._empty, #self._viewItemMoList == 0)
end

function ItemselectView:_onClearPetCol()
	if self._viewItemMoList then
		table.clear(self._viewItemMoList)
	end

	self._pinyinCache = nil

	self._scrollList:dispose()
end

function ItemselectView:_onFilter(itemMo)
	local isHit = true
	local raceId = itemMo:getThroneRelatedSkinId()

	if isHit then
		local petCo = CharacterConfig.instance:getPetCo(raceId)

		if petCo then
			isHit = PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_ITEM_SELECT_EQUIP, petCo, petCo.rare)
		end
	end

	if isHit and not string.nilorempty(self._currSearching) then
		isHit = false

		local petCo = CharacterConfig.instance:getPetCo(raceId)

		if petCo and petCo.name and self:_multiLevelMatch(petCo.name, self._currSearching) then
			isHit = true
		end

		if not isHit then
			local matName = MaterialMgr.getMaterialsName(itemMo:getMatType(), itemMo:getDefineId())

			if self:_multiLevelMatch(matName, self._currSearching) then
				isHit = true
			end
		end
	end

	return isHit
end

function ItemselectView:_onRefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())

	if not self._isOnTimer then
		self._isOnTimer = true

		settimer(0.1, self._timerChange, self, false)
	end
end

function ItemselectView:_timerChange()
	self._isOnTimer = false

	self:_onUpdatePetColUI()
end

function ItemselectView:_updatePetCell(view, cell, itemMo, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local isSelected = self._selectPool[itemMo]

	GameUtil.SetActive(imgSelected, isSelected)
	MaterialMgr.setCellByMo(itemMo, item)
	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickPetCell, self, itemMo))
end

function ItemselectView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnSelect)
end

function ItemselectView:_onClickPetCell(itemMo)
	if not self._selectPool[itemMo] then
		if self._currSelectCount + 1 > self._limitCount then
			TipsFacade.instance:openCommonTips(langPara("选中的道具不能超过%s个", self._limitCount))

			return
		end

		self._currSelectCount = self._currSelectCount + 1
	else
		self._currSelectCount = self._currSelectCount - 1
	end

	self._selectPool[itemMo] = not self._selectPool[itemMo]

	self._scrollList:refresh()
end

function ItemselectView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function ItemselectView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnSort.gameObject)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self, arr, GameUtil.handler(self._onRefreshPetSort, self))
end

function ItemselectView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_ITEM_SELECT_EQUIP, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function ItemselectView:updateFilterData(starList, jobList, rareList)
	self:_onUpdatePetColUI()
end

function ItemselectView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = StringUtil.RelpaceEscapeChar(text)

		self:_onUpdatePetColUI()
	end
end

function ItemselectView:_onClearSearch()
	self._inputSearch.input.text = ""
	self._currSearching = nil

	self:_onUpdatePetColUI()
end

function ItemselectView:_splitTokens(searchText)
	local text = tostring(searchText or "")

	text = string.gsub(text, "[,;，。/\\|]+", " ")

	local tokens = {}

	for token in string.gmatch(text, "%S+") do
		table.insert(tokens, token)
	end

	return tokens
end

function ItemselectView:_plainFindCI(haystack, needle)
	if string.nilorempty(haystack) or string.nilorempty(needle) then
		return false
	end

	local upHay = string.upper(tostring(haystack))
	local upNeedle = string.upper(tostring(needle))

	return string.find(upHay, upNeedle, 1, true) ~= nil
end

function ItemselectView:_getPinyinForms(targetText)
	self._pinyinCache = self._pinyinCache or {}

	local cache = self._pinyinCache[targetText]

	if cache then
		return cache.full, cache.initials
	end

	local pySimple = Framework.PinyinConverter and Framework.PinyinConverter.HZToPYSimple and Framework.PinyinConverter.HZToPYSimple(targetText) or nil

	if not pySimple or pySimple == "" then
		return nil, nil
	end

	local initialsUp = string.upper(pySimple)

	self._pinyinCache[targetText] = {
		initials = initialsUp
	}

	return nil, initialsUp
end

function ItemselectView:_isSubsequenceCI(text, pattern)
	if string.nilorempty(text) or string.nilorempty(pattern) then
		return false
	end

	local t = string.upper(tostring(text))
	local p = string.upper(tostring(pattern))
	local index = 1

	for i = 1, #p do
		local ch = string.sub(p, i, i)
		local pos = string.find(t, ch, index, true)

		if not pos then
			return false
		end

		index = pos + 1
	end

	return true
end

function ItemselectView:_approximateInitialsFromFullPinyin(token)
	if string.nilorempty(token) then
		return ""
	end

	local up = string.upper(tostring(token))
	local vowels = {
		E = true,
		A = true,
		V = true,
		U = true,
		O = true,
		I = true
	}

	local function isInitialStart(s, i)
		local c1 = string.sub(s, i, i)
		local c2 = string.sub(s, i, i + 1)

		if c2 == "ZH" or c2 == "CH" or c2 == "SH" then
			return 2, string.sub(c2, 1, 1)
		end

		if c1:match("%a") then
			return 1, c1
		end

		return 0, nil
	end

	local function hasVowelAhead(s, i, look)
		local maxj = math.min(#s, i + (look or 3))

		for j = i, maxj do
			local ch = string.sub(s, j, j)

			if vowels[ch] then
				return true
			end
		end

		return false
	end

	local i = 1
	local seenVowel = false
	local inSyllable = false
	local res = {}

	while i <= #up do
		local didStep = false

		if not inSyllable or seenVowel then
			local step, ini = isInitialStart(up, i)

			if step > 0 and ini and hasVowelAhead(up, i + step, 3) then
				table.insert(res, ini)

				inSyllable = true
				seenVowel = false
				i = i + step
				didStep = true
			end
		end

		if not didStep then
			local c = string.sub(up, i, i)

			if vowels[c] then
				seenVowel = true
			end

			i = i + 1
		end
	end

	return table.concat(res)
end

function ItemselectView:_utf8ToChars(s)
	local chars = {}

	s = tostring(s or "")

	local i = 1
	local len = #s

	while i <= len do
		local c = string.byte(s, i)
		local n = 1

		if c then
			n = c >= 240 and 4 or c >= 224 and 3 or c >= 192 and 2 or 1
		end

		table.insert(chars, string.sub(s, i, i + n - 1))

		i = i + n
	end

	return chars
end

function ItemselectView:_isUtf8SubsequenceCI(text, pattern)
	if string.nilorempty(text) or string.nilorempty(pattern) then
		return false
	end

	local tChars = self:_utf8ToChars(text)
	local pChars = self:_utf8ToChars(pattern)
	local ti = 1

	for pi = 1, #pChars do
		local pch = string.upper(pChars[pi])
		local found = false

		while ti <= #tChars do
			local tch = string.upper(tChars[ti])

			if tch == pch then
				found = true
				ti = ti + 1

				break
			end

			ti = ti + 1
		end

		if not found then
			return false
		end
	end

	return true
end

function ItemselectView:_fuzzySearch(text, searchText)
	local index = 1
	local isMatch = true
	local upperText = string.upper(text)
	local upperSearch = string.upper(searchText)

	string.gsub(upperSearch, ".", function(char)
		if isMatch then
			local pos = string.find(upperText, char, index)

			if pos and pos >= index then
				index = pos + 1
			else
				isMatch = false
			end
		end
	end)

	return isMatch
end

function ItemselectView:_multiLevelMatch(targetText, searchText)
	if string.nilorempty(targetText) or string.nilorempty(searchText) then
		return false
	end

	local tokens = self:_splitTokens(searchText)

	if #tokens == 0 then
		return false
	end

	for i = 1, #tokens do
		local token = tokens[i]

		if self:_plainFindCI(targetText, token) then
			return true
		end
	end

	local fullPY, initialsPY = self:_getPinyinForms(targetText)

	if not string.nilorempty(initialsPY) then
		for i = 1, #tokens do
			local token = tokens[i]
			local approx = self:_approximateInitialsFromFullPinyin(token)

			if self:_plainFindCI(initialsPY, token) then
				return true
			end

			if not string.nilorempty(approx) and self:_plainFindCI(initialsPY, approx) then
				return true
			end
		end
	end

	for i = 1, #tokens do
		local token = tokens[i]
		local approx = self:_approximateInitialsFromFullPinyin(token)

		if self:_isUtf8SubsequenceCI(targetText, token) then
			return true
		end

		if not string.nilorempty(initialsPY) then
			if self:_isSubsequenceCI(initialsPY, token) then
				return true
			end

			if not string.nilorempty(approx) and self:_isSubsequenceCI(initialsPY, approx) then
				return true
			end
		end
	end

	return false
end

function ItemselectView:_onClickSure()
	local list = {}

	for k, v in pairs(self._selectPool) do
		if v then
			table.insert(list, k)
		end
	end

	GameUtil.callBack(self._callBack, list)
	self:close()
end

function ItemselectView:_onClickSelectAll()
	self._currSelectCount = 0

	table.clear(self._selectPool)

	self._isNeedSelectAll = not self._isNeedSelectAll

	if self._isNeedSelectAll then
		for i, itemMo in ipairs(self._viewItemMoList or {}) do
			if self._currSelectCount < self._limitCount then
				self._selectPool[itemMo] = true
				self._currSelectCount = self._currSelectCount + 1
			else
				break
			end
		end
	end

	self._scrollList:refresh()
end

return ItemselectView
