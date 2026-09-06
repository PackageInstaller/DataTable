-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/view/WishTreeListView.lua

module("logic.extensions.wishtree.view.WishTreeListView", package.seeall)

local WishTreeListView = class("WishTreeListView", ViewComponent)

function WishTreeListView:ctor()
	WishTreeListView.super.ctor(self)
end

function WishTreeListView:unbindEvents()
	WishTreeListView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function WishTreeListView:bindEvents()
	WishTreeListView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function WishTreeListView:buildUI()
	WishTreeListView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._tableview = self:getGo("ScrollView")
	self._tablecell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regValueChanged(GameUtil.handler(self._onVoteScrollValueChanged, self))
end

function WishTreeListView:onExit()
	WishTreeListView.super.onExit(self)
	self._scrollList:dispose()
end

function WishTreeListView:onEnter()
	WishTreeListView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._wishIdx = params[2]
	self._cfgs = WishTreeConfig.instance:getWishTreeCfgsByActId(self._activityId)

	self:_reloadData()
end

function WishTreeListView:_reloadData()
	local prizeCfgs = WishTreeConfig.instance:getWishTreeRewardCfgs(self._cfgs.rewardPlanId)
	local items = WishTreeModel.instance:getItems()
	local isFirst = true
	local selectedMap = {}
	local list = {}

	for i, v in ipairs(items) do
		selectedMap[v.selectedPrizeId] = true
	end

	for i, v in ipairs(prizeCfgs) do
		local data = {}

		data.prizeId = v.prizeId
		data.prize = v.prize
		data.selected = selectedMap[v.prizeId] == true

		if not data.selected and isFirst then
			self._curSelect = v.prizeId
			isFirst = false
		end

		table.insert(list, data)
	end

	self._scrollList:reloadData(list)
end

function WishTreeListView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)
	local type, id, num = MaterialMgr.getMatParams(data.prize)
	local btnCell = cell.go:GetComponent(goutil.Type_UIButton)
	local materialName = MaterialMgr.getMaterialsName(type, id)

	MaterialMgr.setCell(type, id, cell.item)
	GameUtil.SetActive(cell.select, self._curSelect == data.prizeId)
	GameUtil.SetActive(cell.selected, data.selected)

	btnCell.enabled = not data.selected
	cell.txtCount.text = "x" .. num
	cell.txtName.text = materialName

	if not data.selected then
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickPrize, self, data.prizeId))
	end
end

function WishTreeListView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.select = goutil.findChild(cell.go, "content/imgSelect")
	cell.selected = goutil.findChild(cell.go, "content/imgSelected")
	cell.item = goutil.findChild(cell.go, "content/item")
	cell.txtName = goutil.findChildTextComponent(cell.go, "content/name/txtName")
	cell.txtCount = goutil.findChildTextComponent(cell.go, "content/txtCount")

	MaterialMgr.resetAll(cell)
	GameUtil.rmClickHandler(cell.go)

	return cell
end

function WishTreeListView:_onVoteScrollValueChanged(tableview)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local conX, _, _ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local width = goutil.getWidth(viewPortTrans)
	local ofh = 5
	local hw = width * 0.5
	local R = ofh + hw * hw / ofh
	local r = R * 0.5
	local a = hw
	local b = r + ofh
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local locx, locy, locz = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local ofx = conX + locx
			local xx = ofx - a
			local ta = math.atan2(-b, xx)
			local yy = r * math.sin(ta) + b
			local angle = math.deg(ta)
			local cellContent = goutil.findChild(cell, "content")

			GameUtil.setLocalPos(cellContent.transform, 0, yy - 20, 0)
			GameUtil.setLocalRotation(cellContent, 0, 0, angle + 90)
		end
	end
end

function WishTreeListView:_onClickClose()
	self:close()
end

function WishTreeListView:_onClickPrize(prizeId)
	self._curSelect = prizeId

	self._scrollList:refresh()
end

function WishTreeListView:_onClickSure()
	local function okFunc()
		WishTreeController.instance:sendSelectWishPrizeReq(self._activityId, self._wishIdx, self._curSelect)
		self:close()
	end

	TipsFacade.instance:openPopupWindow("提示", "是否确认选择该奖励作为心愿，确认后将无法更改", okFunc, nil, "确定", "取消")
end

return WishTreeListView
