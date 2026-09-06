-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapReportView.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapReportView", package.seeall)

local FiveYearRecapReportView = class("FiveYearRecapReportView", ViewComponent)
local BarCellFuncs = {
	cell_normal = {
		"_updateBarCellNormalUI",
		"_clearBarCellNormalUI"
	},
	cell_item = {
		"_updateBarCellItemUI",
		"_clearBarCellItemUI"
	},
	cell_pet = {
		"_updateBarCellPetUI",
		"_clearBarCellPetUI"
	},
	cell_dress = {
		"_updateBarCellDressUI",
		"_clearBarCellDressUI"
	},
	cell_pve = {
		"_updateBarCellPveUI",
		"_clearBarCellPveUI"
	},
	cell_pve_jingjichang = {
		"_updateBarCellPveJingjichangUI",
		"_clearBarCellPveJingjichangUI"
	}
}

function FiveYearRecapReportView:ctor()
	FiveYearRecapReportView.super.ctor(self)

	self._barCells = {}
	self._barGoPools = {}
end

function FiveYearRecapReportView:buildUI()
	FiveYearRecapReportView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnNext = self:getGo("btnNext")
	self._btnLast = self:getGo("btnLast")
	self._bubble = self:getGo("head/bubble")
	self._txtBubbleDesc = self:getTxt("head/bubble/txt")
	self._bubbleGo = self:getGo("head/bubble")
	self._headGo = self:getGo("head")
	self._headIcon = self:getGo("head/icon")
	self._txtTitle = self:getTxt("title/txt")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._barGoTemplates = {}

	local bars = self:getGo("bars")

	for idx = 1, bars.transform.childCount do
		local mainGo = bars.transform:GetChild(idx - 1).gameObject

		GameUtil.SetActive(mainGo, false)

		self._barGoTemplates[mainGo.name] = mainGo
	end

	self._showView = self:getGo("showView")
end

function FiveYearRecapReportView:bindEvents()
	FiveYearRecapReportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnNext, GameUtil.handler(self._changePage, self, 1))
	GameUtil.addClickHandler(self._btnLast, GameUtil.handler(self._changePage, self, -1))
end

function FiveYearRecapReportView:unbindEvents()
	FiveYearRecapReportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnNext)
	GameUtil.rmClickHandler(self._btnLast)
end

function FiveYearRecapReportView:onEnter()
	FiveYearRecapReportView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = FiveYearRecapController.instance:getSubMo(self._activityId)
	self._pageId = 1
	self._maxPageId = self._subMo:getMaxPageId()

	self:_onUpdate()
	self:_startAllBarByAnim()
end

function FiveYearRecapReportView:onExit()
	FiveYearRecapReportView.super.onExit(self)
	self:_onClear()
end

function FiveYearRecapReportView:destroyUI()
	FiveYearRecapReportView.super.destroyUI(self)
	self:_disposeBarCellPool()
end

function FiveYearRecapReportView:_onUpdate()
	self:_onUpdatePageButtonUI()
	self:_onUpdateShowView()
	self:_onUpdateTagCol()

	local pageData = FiveYearRecapConfig.instance:getPageData(self._activityId, self._pageId)

	self._txtTitle.text = pageData.title
end

function FiveYearRecapReportView:_onClear()
	self:_clearAllBarAnim()
	self:_onClearShowView()
	self:_onClearTagCol()
end

function FiveYearRecapReportView:_startAllBarByAnim()
	self:_clearAllBarAnim()
	GameUtil.SetActive(self._headGo, false)
	GameUtil.SetActive(self._bubble, false)

	local datas = FiveYearRecapConfig.instance:getReportPageDatas(self._activityId, self._pageId)

	if not datas or #datas <= 0 then
		return
	end

	local sortedBarIds = {}

	for _, data in ipairs(datas) do
		table.insert(sortedBarIds, data.barId)
	end

	table.sort(sortedBarIds)

	local offsetX = 120
	local duration = 0.35
	local staggerDelay = duration * 0.5
	local sequence = DG.Tweening.DOTween.Sequence()

	for i, barId in ipairs(sortedBarIds) do
		local cell = self._barCells[barId]

		if cell then
			local mainGo = cell.mainGo
			local pos = GameUtil.getLocalPos(mainGo)

			GameUtil.setLocalPos(mainGo, pos.x + offsetX, pos.y)
			GameUtil.SetActive(mainGo, false)

			local canvasGroup = goutil.addComponentOnce(mainGo, ComponentType.CanvasGroup)

			canvasGroup.alpha = 0

			local moveTweener = mainGo.transform:DOLocalMoveX(pos.x, duration)

			moveTweener:SetEase(DG.Tweening.Ease.OutExpo)
			moveTweener:OnStart(function()
				GameUtil.SetActive(mainGo, true)
			end)

			local fadeTweener = canvasGroup:DOFade(1, duration * 0.8)

			fadeTweener:SetEase(DG.Tweening.Ease.OutQuad)

			local insertTime = (i - 1) * staggerDelay

			sequence:Insert(insertTime, moveTweener)
			sequence:Insert(insertTime, fadeTweener)
		end
	end

	local pageData = FiveYearRecapConfig.instance:getPageData(self._activityId, self._pageId)
	local isNeedShowHead = pageData.skinId > 0

	if isNeedShowHead then
		local barsEndTime = (#sortedBarIds - 1) * staggerDelay + duration
		local headStartTime = barsEndTime + 0.15
		local headDuration = 0.25
		local bubbleStartTime = headStartTime + headDuration * 0.6
		local bubbleDuration = 0.3
		local headCanvasGroup = goutil.addComponentOnce(self._headGo, ComponentType.CanvasGroup)

		headCanvasGroup.alpha = 0

		local headFadeTweener = headCanvasGroup:DOFade(1, headDuration)

		headFadeTweener:SetEase(DG.Tweening.Ease.OutQuad)
		headFadeTweener:OnStart(function()
			GameUtil.SetActive(self._headGo, true)
		end)
		sequence:Insert(headStartTime, headFadeTweener)

		local bubbleCanvasGroup = goutil.addComponentOnce(self._bubble, ComponentType.CanvasGroup)

		bubbleCanvasGroup.alpha = 0

		local bubbleFadeTweener = bubbleCanvasGroup:DOFade(1, bubbleDuration)

		bubbleFadeTweener:SetEase(DG.Tweening.Ease.OutQuad)
		bubbleFadeTweener:OnStart(function()
			GameUtil.SetActive(self._bubble, true)
		end)
		sequence:Insert(bubbleStartTime, bubbleFadeTweener)
	end

	self._barAnimSequence = sequence
end

function FiveYearRecapReportView:_clearAllBarAnim()
	if self._barAnimSequence then
		self._barAnimSequence:Kill(true)

		self._barAnimSequence = nil

		GameUtil.SetActive(self._headGo, true)
		GameUtil.SetActive(self._bubble, true)
	end
end

function FiveYearRecapReportView:_onUpdateTagCol()
	local pageData = FiveYearRecapConfig.instance:getPageData(self._activityId, self._pageId)
	local skinId = pageData.skinId

	if skinId <= 0 then
		self:_onClearTagCol()
		GameUtil.SetActive(self._headGo, false)

		return
	end

	GameUtil.SetActive(self._headGo, true)

	local fitDataList = {}
	local dataList = FiveYearRecapConfig.instance:getPersonTagDataListByPageId(self._activityId, self._pageId)

	for _, data in ipairs(dataList) do
		if self._subMo:isFitTag(data.tagId) then
			table.insert(fitDataList, data)
		end
	end

	local desc = ""

	for i, data in ipairs(fitDataList) do
		desc = i == 1 and desc .. data.desc or desc .. " / " .. data.desc
	end

	self._txtBubbleDesc.text = string.find(pageData.bubbleFormatDesc, "%%s") and string.format(pageData.bubbleFormatDesc, desc) or pageData.bubbleFormatDesc

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._txtBubbleDesc.transform:GetComponent(goutil.Type_RectTransform))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._bubbleGo.transform:GetComponent(goutil.Type_RectTransform))

	if skinId > 0 then
		MaterialMgr.setIcon(self._headIcon, MatType.Pet, skinId, nil, nil)
	else
		MaterialMgr.clearIcon(self._headIcon)
	end
end

function FiveYearRecapReportView:_onClearTagCol()
	self._txtBubbleDesc.text = ""

	MaterialMgr.clearIcon(self._headIcon)
end

function FiveYearRecapReportView:_onUpdateShowView()
	self:_onClearShowView()

	local datas = FiveYearRecapConfig.instance:getReportPageDatas(self._activityId, self._pageId)

	for barId, data in ipairs(datas) do
		local cell = self:_getBarCell(data.barId)

		self:_updateBarCellUI(cell)
	end
end

function FiveYearRecapReportView:_onClearShowView()
	local list = {}

	for barId, cell in pairs(self._barCells) do
		table.insert(list, cell)
	end

	for _, cell in ipairs(list) do
		self:_clearBarCellUI(cell)
		self:_returnBarCell(cell)
	end
end

function FiveYearRecapReportView:_updateBarCellUI(cell)
	local barId = cell.barId
	local cellName = cell.cellName
	local mainGo = cell.mainGo
	local data = FiveYearRecapConfig.instance:getReportPageData(self._activityId, self._pageId, barId)

	if not data.pos then
		if not data.pos[3] then
			local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y)
			GameUtil.setLocalScale(mainGo, data.pos[3])
			GameUtil.SetActive(mainGo, true)

			local updateFunc = self[BarCellFuncs[cellName][1]]

			GameUtil.callBack(updateFunc, self, mainGo, data)
		end
	end
end

function FiveYearRecapReportView:_clearBarCellUI(cell)
	local cellName = cell.cellName
	local mainGo = cell.mainGo
	local clearFunc = self[BarCellFuncs[cellName][2]]

	GameUtil.callBack(clearFunc, self, mainGo)
	GameUtil.SetActive(mainGo, false)
end

function FiveYearRecapReportView:_updateBarCellNormalUI(mainGo, data)
	local adapterFormat = data.adapterFormat
	local descContent, isHaveEmptyData = self._subMo:getAdapterContent(adapterFormat.txtDesc)
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtDesc.text = isHaveEmptyData and data.noDataDesc or descContent
end

function FiveYearRecapReportView:_clearBarCellNormalUI(mainGo)
	return
end

function FiveYearRecapReportView:_updateBarCellItemUI(mainGo, data)
	local adapterFormat = data.adapterFormat
	local descContent, isHaveEmptyData = self._subMo:getAdapterContent(adapterFormat.txtDesc)
	local itemMat = adapterFormat.item
	local itemGo = goutil.findChild(mainGo, "item")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	MaterialMgr.setCellByCfg(itemMat, itemGo)

	txtDesc.text = isHaveEmptyData and data.noDataDesc or descContent
end

function FiveYearRecapReportView:_clearBarCellItemUI(mainGo)
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(itemGo)
end

function FiveYearRecapReportView:_updateBarCellPetUI(mainGo, data)
	local adapterFormat = data.adapterFormat
	local descContent, isHaveEmptyData = self._subMo:getAdapterContent(adapterFormat.txtDesc)
	local raceId = checknumber(self._subMo:getAdapterResult(adapterFormat.petId))
	local itemGo = goutil.findChild(mainGo, "item")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	if raceId > 0 then
		MaterialMgr.setCell(MatType.Pet, raceId, itemGo)
	else
		MaterialMgr.resetAll(itemGo)
	end

	txtDesc.text = isHaveEmptyData and data.noDataDesc or descContent
end

function FiveYearRecapReportView:_clearBarCellPetUI(mainGo)
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(itemGo)
end

function FiveYearRecapReportView:_updateBarCellDressUI(mainGo, data)
	local adapterFormat = data.adapterFormat
	local descContent, isHaveEmptyData = self._subMo:getAdapterContent(adapterFormat.txtDesc)
	local itemMat = adapterFormat.item
	local itemGo = goutil.findChild(mainGo, "item")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	MaterialMgr.setCellByCfg(itemMat, itemGo)

	txtDesc.text = isHaveEmptyData and data.noDataDesc or descContent
end

function FiveYearRecapReportView:_clearBarCellDressUI(mainGo)
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(itemGo)
end

function FiveYearRecapReportView:_updateBarCellPveUI(mainGo, data)
	local adapterFormat = data.adapterFormat
	local name = adapterFormat.name
	local maxRank = self._subMo:getAdapterContent(adapterFormat.maxRank)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtChampionCount = goutil.findChildTextComponent(mainGo, "txtChampionCount")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtMaxRank = goutil.findChildTextComponent(mainGo, "txtMaxRank")

	if txtDesc then
		local content, isEmpty = self._subMo:getAdapterContent(adapterFormat.txtDesc)

		txtDesc.text = isEmpty and data.noDataDesc or content
	end

	if txtChampionCount then
		local content, isEmpty = self._subMo:getAdapterContent(adapterFormat.championCount)

		txtChampionCount.text = isEmpty and adapterFormat.championCountDefault or content
	end

	if txtMaxRank then
		local content, isEmpty = self._subMo:getAdapterContent(adapterFormat.maxRank)

		txtMaxRank.text = isEmpty and adapterFormat.maxRankDefault or content
	end

	txtName.text = name
end

function FiveYearRecapReportView:_clearBarCellPveUI(mainGo)
	return
end

function FiveYearRecapReportView:_updateBarCellPveJingjichangUI(mainGo, data)
	local adapterFormat = data.adapterFormat
	local name = adapterFormat.name
	local descContent, isHaveEmptyData = self._subMo:getAdapterContent(adapterFormat.txtDesc)
	local maxRank = self._subMo:getAdapterContent(adapterFormat.maxRank)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtMaxRank = goutil.findChildTextComponent(mainGo, "txtMaxRank")

	txtName.text = name

	if txtDesc then
		local content, isEmpty = self._subMo:getAdapterContent(adapterFormat.txtDesc)

		txtDesc.text = isEmpty and data.noDataDesc or content
	end

	if txtMaxRank then
		local content, isEmpty = self._subMo:getAdapterContent(adapterFormat.maxRank)

		txtMaxRank.text = isEmpty and adapterFormat.maxRankDefault or content
	end
end

function FiveYearRecapReportView:_clearBarCellPveJingjichangUI(mainGo)
	return
end

function FiveYearRecapReportView:_getBarCell(barId)
	local barData = FiveYearRecapConfig.instance:getReportPageData(self._activityId, self._pageId, barId)
	local cellName = barData.cellName
	local cell = {}

	cell.mainGo = self:_fetchBarGo(cellName)
	cell.barId = barId
	cell.cellName = cellName
	self._barCells[barId] = cell

	return cell
end

function FiveYearRecapReportView:_returnBarCell(cell)
	local barId = cell.barId
	local cell = self._barCells[cell.barId]
	local cellName = cell.cellName

	self:_returnBarGo(cellName, cell.mainGo)
	table.clear(cell)

	self._barCells[barId] = nil
end

function FiveYearRecapReportView:_returnBarCellAll()
	for barId, cell in pairs(self._barCells) do
		self:_returnBarCell(cell)
	end
end

function FiveYearRecapReportView:_fetchBarGo(cellName)
	if self._barGoPools[cellName] == nil then
		self:_creatBarGoPool(cellName)
	end

	return self._barGoPools[cellName]:fetchObject()
end

function FiveYearRecapReportView:_returnBarGo(cellName, go)
	if self._barGoPools[cellName] then
		self._barGoPools[cellName]:returnObject(go)
	end
end

function FiveYearRecapReportView:_creatBarGoPool(cellName)
	self._barGoPools = self._barGoPools or {}

	if self._barGoPools[cellName] ~= nil then
		return
	end

	local function createFunc()
		local template = self._barGoTemplates[cellName]
		local go = goutil.cloneAndSetParent(template, self._showView.transform)

		GameUtil.SetActive(go, false)

		return go
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		GameUtil.SetActive(go, false)
	end

	self._barGoPools[cellName] = ObjectPool.New(3, createFunc, disposeFunc, resetFunc)
end

function FiveYearRecapReportView:_disposeBarCellPool()
	self:_returnBarCellAll()

	if self._barGoPools then
		for _, pool in pairs(self._barGoPools) do
			pool:clear()
		end

		self._barGoPools = nil
	end
end

function FiveYearRecapReportView:_onUpdatePageButtonUI()
	GameUtil.SetActive(self._btnLast, self._pageId > 1)
	GameUtil.SetActive(self._btnNext, self._pageId <= self._maxPageId)
end

function FiveYearRecapReportView:_changePage(delta)
	local nextPageId = self._pageId + delta

	if nextPageId > self._maxPageId then
		self:close()
		UIStateManager.instance:push(ViewName.FiveYearRecapReportSummaryView, self._activityId)
	else
		self._pageId = Mathf.Clamp(self._pageId + delta, 1, self._maxPageId)

		self:_onClear()
		self:_onUpdate()
		self:_startAllBarByAnim()
	end
end

function FiveYearRecapReportView:_onClickBtnTip()
	local actData = FiveYearRecapConfig.instance:getActivityData(self._activityId)

	TipsFacade.instance:openRulesView(actData.ruleKey)
end

return FiveYearRecapReportView
