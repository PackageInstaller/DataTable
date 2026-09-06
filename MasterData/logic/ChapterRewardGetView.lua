-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/ChapterRewardGetView.lua

module("logic.extensions.plotcopy.view.ChapterRewardGetView", package.seeall)

local ChapterRewardGetView = class("ChapterRewardGetView", ViewComponent)

function ChapterRewardGetView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnGet = self:getBtn("main/btnGet")
	self._tableview = self:getGo("main/scrollList"):GetComponent("UITableview")
	self._tableCell = self:getGo("main/scrollList/item")

	self._tableCell:SetActive(false)
end

function ChapterRewardGetView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
end

function ChapterRewardGetView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnGet:RemoveClickListener()
end

function ChapterRewardGetView:onEnter()
	self._chapterId = self:getFirstParam()

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}

	local rewardCfgs = PlotCopyModel.instance:getChapterRewardCfgs()

	for i, v in ipairs(rewardCfgs) do
		local chapterId = v.progressId
		local index = v.condition
		local stages = CopyConfig.instance:getStagesExceptPurePlot(chapterId)
		local cfgChapter = CopyConfig.instance:getChapter(chapterId)

		if cfgChapter and stages and stages[index] then
			local element = {}

			element.descStr = string.match(stages[index].stageName, "%d+-%d+")
			element.rewardStr = v.reward

			table.insert(self._curViewDatas, element)
		end
	end

	self._tableview:ReloadData()
end

function ChapterRewardGetView:onExit()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil

	self._tableview:UnRegisterAllCallbacks()
end

function ChapterRewardGetView:_onClickClose()
	self:close()
end

function ChapterRewardGetView:_onClickGet()
	PlotChallengeAgent.instance:sendGainPreciousBoxPrizeReq(self._chapterId)
	self:_onClickClose()
end

function ChapterRewardGetView:_numInView()
	return #self._curViewDatas
end

function ChapterRewardGetView:_cellSize(view, idx)
	return 116, 150
end

function ChapterRewardGetView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	cell.index = index

	self:_updateCell(view, cell, data)

	return cell
end

function ChapterRewardGetView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local node = goutil.findChild(go, "node")
	local txtDesc = goutil.findChild(go, "txtDesc"):GetComponent(goutil.Type_UIText)

	txtDesc.text = data.descStr

	MaterialMgr.setCellByCfg(data.rewardStr, node)
end

function ChapterRewardGetView:_clearTableview(cell)
	local go = cell.gameObject
	local node = goutil.findChild(go, "node")

	MaterialMgr.resetAll(node)
end

return ChapterRewardGetView
