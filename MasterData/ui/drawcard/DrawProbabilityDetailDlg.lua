-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawProbabilityDetailDlg.lua

local ResDrawProbilityClient = require("ClientData/ResDrawProbilityClient")
local ResDrawProbilityDetailClient = require("ClientData/ResDrawProbilityDetailClient")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResHero = require("ClientData/ResHero")
local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResClientProbShow = require("ClientData/ResClientProbShow")
local DrawProbabilityDetailDlg = Class("DrawProbabilityDetailDlg", UIControls.Window)
local HeroProbabilityCell = Class("HeroProbabilityCell", UIControls.ScrollViewLoopCell)

function HeroProbabilityCell:ctor(...)
	self:initUI()
end

function HeroProbabilityCell:initUI(...)
	self.nameTxt = UIControls.Label(self, "TextName")
	self.numTxt = UIControls.Label(self, "TextNum")
	self.arrowImg = UIControls.Image(self, "TextName/IconArrow")
end

function HeroProbabilityCell:setProbabilityData(name, prob, needArrow)
	self.nameTxt:setText(name)
	self.numTxt:setText(prob)
	self.arrowImg:setVisible(needArrow or false)
end

local ProbQualityPage = Class("ProbQualityPage", UIControls.Panel)

function ProbQualityPage:ctor(...)
	self:initUI()
end

function ProbQualityPage:initUI(...)
	self.qualityPageRuleTxt = UIControls.Label(self, self.mPath .. "/TextRule")
	self.qualityPageScroll = UIControls.ScrollViewLoopV(self, self.mPath .. "/QualityListPanel")

	self.qualityPageScroll:addEventCellChanged(self.onQualityCellChanged)

	self.qualityCells = {}
end

function ProbQualityPage:showPage(poolId)
	local poolInfo = DrawCardUtils.getPoolClientInfo(poolId)

	if poolInfo and poolInfo.probability_rule then
		self.qualityPageRuleTxt:setVisible(true)
		self.qualityPageRuleTxt:setText(poolInfo.probability_rule)
	else
		self.qualityPageRuleTxt:setVisible(false)
	end

	local probabilityInfo = ResDrawProbilityClient[poolId]

	if not probabilityInfo then
		return
	end

	self.probInfos = {}

	for index, info in ipairs(probabilityInfo) do
		local name = info.name
		local probability = info.probability
		local isTitleCell = info.type ~= nil
		local needUpIcon = info.up_icon ~= nil

		if isTitleCell then
			-- block empty
		else
			table.insert(self.probInfos, {
				name,
				probability,
				needUpIcon
			})
		end
	end

	self.qualityPageScroll:setTotalCount(#self.probInfos)
end

function ProbQualityPage:onQualityCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = HeroProbabilityCell(sender, "System/HeroPool/HeroProbabilityNum", newIdx, 0, 0)
	else
		self.qualityCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local probInfo = self.probInfos[newIdx]

	if probInfo then
		targetCell:setProbabilityData(probInfo[1], probInfo[2], probInfo[3])
	end

	self.qualityCells[newIdx] = targetCell
end

local ProbDetailPage = Class("ProbDetailPage", UIControls.Panel)

function ProbDetailPage:ctor(...)
	self:initUI()
end

function ProbDetailPage:initUI(...)
	self.detailPageScroll = UIControls.ScrollViewLoopV(self, self.mPath .. "/ProbabilityListPanel")

	self.detailPageScroll:addEventCellChanged(self.onDetailCellChanged)

	self.detailCells = {}
end

function ProbDetailPage:showPage(poolId, groupId)
	local poolInfo = ResDrawProbilityDetailClient[poolId]

	if not poolInfo or not poolInfo[groupId] then
		return
	end

	poolInfo = poolInfo[groupId]
	self.probInfos = {}

	if poolInfo.spec_hero_1 then
		local prob = string.format("%.2f%%", poolInfo.spec_prob_1 * 100)

		table.insert(self.probInfos, {
			poolInfo.spec_hero_1,
			prob,
			true
		})
	end

	if poolInfo.spec_hero_2 then
		local prob = string.format("%.2f%%", poolInfo.spec_prob_2 * 100)

		table.insert(self.probInfos, {
			poolInfo.spec_hero_2,
			prob,
			true
		})
	end

	if poolInfo.spec_hero_3 then
		local prob = string.format("%.2f%%", poolInfo.spec_prob_3 * 100)

		table.insert(self.probInfos, {
			poolInfo.spec_hero_3,
			prob,
			true
		})
	end

	local goldHeros = poolInfo.gold_heros

	if poolInfo.valid_time_id and ClientUtils.isTimeConfigPassed(poolInfo.valid_time_id) then
		goldHeros = poolInfo.time_gold_heros
	end

	for i, heroList in ipairs({
		poolInfo.light_heros or {},
		goldHeros or {},
		poolInfo.light_a_heros or {},
		poolInfo.purple_heros or {},
		poolInfo.blue_heros or {},
		poolInfo.green_heros or {}
	}) do
		if #heroList > 0 then
			local totalProb, iconPath

			if i == 1 then
				totalProb = poolInfo.light_prob
				iconPath = "<0305>"
			elseif i == 2 then
				totalProb = poolInfo.gold_prob
				iconPath = "<0305>"
			elseif i == 3 then
				totalProb = poolInfo.light_a_prob
				iconPath = "<0303>"
			elseif i == 4 then
				totalProb = poolInfo.purple_prob
				iconPath = "<0303>"
			elseif i == 5 then
				totalProb = poolInfo.blue_prob
				iconPath = "<0302>"
			else
				totalProb = poolInfo.green_prob
				iconPath = "<0301>"
			end

			totalProb = totalProb or 0

			local realList = {}

			for _, heroId in ipairs(heroList) do
				local heroInfo = ResHero[heroId]

				if not heroInfo then
					-- block empty
				end

				if not heroInfo.valid_time_id or ClientUtils.isTimeConfigPassed(heroInfo.valid_time_id) then
					table.insert(realList, heroId)
				end
			end

			local prob = string.format("%.2f%%", math.floor(0.5 + totalProb * 10000 / #realList) / 100)

			for _, heroId in ipairs(realList) do
				local heroInfo = ResHero[heroId]

				table.insert(self.probInfos, {
					iconPath .. heroInfo.hero_name,
					prob
				})
			end
		end
	end

	if poolInfo.common_index then
		local probabilityInfo = ResDrawProbilityClient[poolId]

		if not probabilityInfo then
			return
		end

		for _, index in ipairs(poolInfo.common_index) do
			local info = probabilityInfo[index]

			if info then
				local name = info.name
				local probability = info.probability
				local needUpIcon = info.up_icon ~= nil

				table.insert(self.probInfos, {
					name,
					probability,
					needUpIcon
				})
			end
		end
	end

	self.detailPageScroll:setTotalCount(#self.probInfos)
end

function ProbDetailPage:onDetailCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = HeroProbabilityCell(sender, "System/HeroPool/HeroProbabilityNum", newIdx, 0, 0)
	else
		self.detailCells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local probInfo = self.probInfos[newIdx]

	if probInfo then
		targetCell:setProbabilityData(probInfo[1], probInfo[2], probInfo[3])
	end

	self.detailCells[newIdx] = targetCell
end

local ProbabilityRulePageCell = Class("ProbabilityRulePageCell", UIControls.Child)

function ProbabilityRulePageCell:ctor()
	self.textTitle = UIControls.Label(self, "TextName")
	self.textProb = UIControls.Label(self, "TextNum")
end

function ProbabilityRulePageCell:setData(probData, totalRate)
	self.textTitle:setText(probData.desc or "")
	self.textProb:setText(string.format("%.2f%%", 100 * probData.rate / totalRate))
end

local ProbRulePage = Class("ProbRulePage", UIControls.Panel)

function ProbRulePage:ctor(...)
	self:initUI()
end

function ProbRulePage:initUI(...)
	self.ruleTxt = UIControls.Label(self, self.mPath .. "/TextRuleListPanel/Content/MinimumTextRule")
	self.panelProbTitle = UIControls.Panel(self, self.mPath .. "/TextRuleListPanel/Content/TitlePanel")
	self.panelProbCell = UIControls.Panel(self, self.mPath .. "/TextRuleListPanel/Content/ProbabilityListPanel")
	self.probCells = {}
end

function ProbRulePage:showPage(poolId, groupId)
	local poolInfo = ResDrawProbilityDetailClient[poolId]

	if not poolInfo or not poolInfo[groupId] then
		return
	end

	local noticeId = poolInfo[groupId].rule_notice

	if not noticeId or not ResInfoNotice[noticeId] then
		return
	end

	self.ruleTxt:setText(ResInfoNotice[noticeId].content)

	local probId = poolInfo[groupId].prob_id

	if probId and ResClientProbShow[probId] then
		self.panelProbTitle:setVisible(true)
		self.panelProbCell:setVisible(true)

		local probData = ResClientProbShow[probId]

		for index = #self.probCells, #probData - 1 do
			local newCell = ProbabilityRulePageCell(self, self.mPath .. "/TextRuleListPanel/Content/ProbabilityListPanel", "System/Common/CellItemProbabilityNum")

			table.insert(self.probCells, newCell)
		end

		local totalRate = 0

		for _, d in ipairs(probData) do
			totalRate = totalRate + d.rate
		end

		for index, cell in ipairs(self.probCells) do
			if probData[index] then
				cell:setVisible(true)
				cell:setData(probData[index], totalRate)
			else
				cell:setVisible(false)
			end
		end
	else
		self.panelProbTitle:setVisible(false)
		self.panelProbCell:setVisible(false)
	end
end

function DrawProbabilityDetailDlg:ctor(...)
	self:initUI()
end

function DrawProbabilityDetailDlg:initUI(...)
	self.tabBtns = {}

	for i = 1, 3 do
		local btn = UIControls.Button(self, "BgPanel/TabPanel/Btn" .. i)

		btn.index = i

		btn:addEventClick(self._onClickTab)

		self.tabBtns[i] = btn
	end

	self.titleTxt = UIControls.Label(self, "BgPanel/TextTitle")
	self.qualityPage = ProbQualityPage(self, "BgPanel/QualityInfo")
	self.detailPage = ProbDetailPage(self, "BgPanel/ProbabilityInfo")
	self.rulePage = ProbRulePage(self, "BgPanel/MinimumInfo")
end

function DrawProbabilityDetailDlg:setPoolInfo(poolName, poolId, groupId)
	self.titleTxt:setText(poolName or "")

	self.poolId = poolId
	self.groupId = groupId or 1

	self:showPage(1)
end

function DrawProbabilityDetailDlg:showPage(pageIdx)
	for idx, btn in ipairs(self.tabBtns) do
		btn:setEnable(idx ~= pageIdx)
	end

	self.qualityPage:setVisible(pageIdx == 1)
	self.detailPage:setVisible(pageIdx == 2)
	self.rulePage:setVisible(pageIdx == 3)

	local curPage

	if pageIdx == 1 then
		curPage = self.qualityPage
	elseif pageIdx == 2 then
		curPage = self.detailPage
	else
		curPage = self.rulePage
	end

	curPage:showPage(self.poolId, self.groupId)
end

function DrawProbabilityDetailDlg:_onClickTab(sender)
	local clickIdx = sender.index

	self:showPage(clickIdx)
end

return DrawProbabilityDetailDlg
