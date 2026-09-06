-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lordnoah/LordNoahChallengeView.lua

module("logic.extensions.timelimitedchallenge.view.lordnoah.LordNoahChallengeView", package.seeall)

local LordNoahChallengeView = class("LordNoahChallengeView", MississiChallengeView)

function LordNoahChallengeView:buildUI()
	LordNoahChallengeView.super.buildUI(self)
	self._tableView:regValueChanged(GameUtil.handler(self.onScrollValueChange, self))

	self._drag = Framework.UIDragTrigger.Get(goutil.findChild(self._goTableView, "uidrag"))
	self._scrollrect = self._goTableView:GetComponent("ScrollRect")

	self._tableView:regReloadFinish(GameUtil.handler(self._onReloadFinishEnd, self))

	self._content = goutil.findChild(self._goTableView, "Viewport/Content")
end

function LordNoahChallengeView:bindEvents()
	LordNoahChallengeView.super.bindEvents(self)
	self._drag:AddEndDragListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
end

function LordNoahChallengeView:unbindEvents()
	LordNoahChallengeView.super.unbindEvents(self)
	self._drag:RemoveEndDragListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
end

function LordNoahChallengeView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local stageId = data.stageId

	if not stageId then
		goutil.setActive(cell.con, false)
	else
		goutil.setActive(cell.con, true)

		if stageId <= self._curPassStage then
			goutil.setActive(cell.pass, true)
		end

		if stageId ~= self._curSelectId then
			cell.txtChange:SetState(0)

			cell.txtLevel.text = langPara("第%s关", stageId)
		else
			cell.txtChange:SetState(1)

			cell.txtLevel.text = langPara("第<size=28>%s</size>关", stageId)
		end
	end
end

function LordNoahChallengeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.con = goutil.findChild(cell.go, "con")
	cell.pass = goutil.findChild(cell.con, "pass")
	cell.txtLevel = goutil.findChildTextComponent(cell.con, "txtLevel")
	cell.txtChange = goutil.findChildComponent(cell.con, "txtLevel", "UITextColorChange")

	goutil.setActive(cell.pass, false)

	return cell
end

function LordNoahChallengeView:getFightEndMianViewName()
	return ViewName.LordNoahMainView
end

function LordNoahChallengeView:onScrollValueChange(tableview)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local conX, conY, conZ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local width = goutil.getWidth(viewPortTrans)
	local heigth = goutil.getHeight(viewPortTrans)
	local ofh = 100
	local hh = heigth * 0.5
	local R = ofh + hh * hh / ofh
	local r = R * 0.5
	local a = hh
	local b = -r + ofh
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local locx, locy, locz = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local ofy = conY + locy
			local yy = ofy - a
			local ta = math.atan2(-b, yy)
			local xx = r * math.sin(ta) + b
			local angle = math.deg(ta)
			local cellContent = goutil.findChild(cell, "con")

			GameUtil.setLocalPos(cellContent.transform, xx - 45, 0, 0)
		end
	end
end

function LordNoahChallengeView:_onDrag(eventData)
	self._scrollrect:OnDrag(eventData)
end

function LordNoahChallengeView:_onBeginDrag(eventData)
	self._scrollrect:OnBeginDrag(eventData)
end

function LordNoahChallengeView:_onDragEnd(eventData)
	local pos = GameUtil.getAnchoredPos(self._content)

	if pos then
		if not pos.y then
			local conY = 0
			local curId = checkint((conY + 28) / -158) + 1

			curId = MathUtil.clamp(curId, 1, #self._stageCfgs)

			self:_updateView(curId)
		end
	end
end

function LordNoahChallengeView:_getCurDataList()
	local dataList = {}

	table.insert(dataList, {})
	table.insert(dataList, {})

	for i, v in ipairs(self._stageCfgs) do
		table.insert(dataList, v)
	end

	table.insert(dataList, {})
	table.insert(dataList, {})

	return dataList
end

function LordNoahChallengeView:_updateView(stageId)
	if stageId > self._showStage then
		GameUtil.setAnchoredPos(self._content, 0, -28 + (self._curSelectId - 1) * -158)
		FloatWordMgr.instance:show(lang("请先通关当前关卡"))

		return
	end

	if self._curSelectId ~= stageId then
		self._curSelectId = stageId

		self._tableView:reloadData(self:_getCurDataList())
		self:_updateRightPart()
	end

	GameUtil.setAnchoredPos(self._content, 0, -28 + (self._curSelectId - 1) * -158)
	self._tableView:refresh()
end

function LordNoahChallengeView:_onReloadFinishEnd()
	GameUtil.setAnchoredPos(self._content, 0, -28 + (self._curSelectId - 1) * -158)
end

function LordNoahChallengeView:onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "lordnoahchallengerule")
end

return LordNoahChallengeView
