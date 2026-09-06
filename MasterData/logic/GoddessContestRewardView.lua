-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestRewardView.lua

module("logic.extensions.goddesscontest.view.GoddessContestRewardView", package.seeall)

local GoddessContestRewardView = class("GoddessContestRewardView", ViewComponent)

function GoddessContestRewardView:buildUI()
	GoddessContestRewardView.super.buildUI(self)

	self._goRankCell = self:getGo("rewardCom/rankCell")
	self._goRankTableView = self:getGo("rewardCom/rankTableview")
	self._rankTableView = ScrollerList.create(self._goRankTableView, self._goRankCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._subCell = self:getGo("rewardCom/subCell")
	self._showItem = self:getGo("rewardCom/showItem")

	goutil.setActive(self._subCell, false)
end

function GoddessContestRewardView:bindEvents()
	GoddessContestRewardView.super.bindEvents(self)
end

function GoddessContestRewardView:unbindEvents()
	GoddessContestRewardView.super.unbindEvents(self)
end

function GoddessContestRewardView:onEnter()
	GoddessContestRewardView.super.onEnter(self)

	self._curActId = GoddessContestModel.instance:getCurActId()
	self._prizeCfgs = GoddessContestConfig.instance:getSettlementCfgsByActId(self._curActId) or {}

	self._rankTableView:reloadData(self._prizeCfgs)
	self._rankTableView:MoveCellToBegin(0)
end

function GoddessContestRewardView:onExit()
	GoddessContestRewardView.super.onExit(self)
	self._rankTableView:dispose()
end

function GoddessContestRewardView:_updateRankCell(view, goCell, datas)
	local cell = self:_clearRankCell(goCell, datas)

	cell.imgRank:SetState(datas[1].rank - 1)
end

function GoddessContestRewardView:_clearRankCell(goCell, datas)
	local cell = {}

	cell.go = goCell
	cell.imgRank = goutil.findChildComponent(cell.go, "imgRank", "UIImageSpriteChange")
	cell.layoutCom = goutil.findChild(cell.go, "layoutCom")

	local skinChildren = GameUtil.getChildren(cell.layoutCom)

	for k, v in ipairs(skinChildren) do
		goutil.setActive(v, false)

		local subCom = goutil.findChild(v, "tableview/Viewport/Content")
		local subSkinChildren = GameUtil.getChildren(subCom)

		for k1, v1 in ipairs(subSkinChildren) do
			self:_clearItemCell(v1)
		end
	end

	cell.subCellList = {}

	if datas then
		for k, v in ipairs(datas) do
			local subCell = {}

			subCell.go = goutil.findChild(cell.layoutCom, "subCell_" .. k) or goutil.cloneAndSetParent(self._subCell, cell.layoutCom.transform, "subCell_" .. k)
			subCell.title = goutil.findChildComponent(subCell.go, "title", "UIImageSpriteChange")
			subCell.txtTitle = goutil.findChildTextComponent(subCell.go, "title/txtTitle")

			local gradeCfg = GoddessContestConfig.instance:getGradeCfg(v.grade)

			subCell.title:SetState(v.grade - 1)

			subCell.txtTitle.text = gradeCfg and gradeCfg.name
			subCell.goTableview = goutil.findChild(subCell.go, "tableview")
			subCell.tableview = ScrollerList.create(subCell.goTableview, self._showItem, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			subCell.tableview:dispose()

			if not string.nilorempty(v.prize) then
				subCell.tableview:reloadData(string.split(v.prize, "#"))
			end

			goutil.setActive(subCell.go, true)
			table.insert(cell.subCellList, subCell)
		end
	end

	return cell
end

function GoddessContestRewardView:_updateItemCell(view, goCell, data)
	local cell = self:_clearItemCell(goCell)

	MaterialMgr.setCellByCfg(data, cell.go)
end

function GoddessContestRewardView:_clearItemCell(goCell)
	local cell = {}

	cell.go = goCell

	MaterialMgr.resetAll(cell.go)

	return cell
end

return GoddessContestRewardView
