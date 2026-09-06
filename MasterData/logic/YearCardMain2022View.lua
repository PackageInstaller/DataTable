-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardMain2022View.lua

module("logic.extensions.yearcard.view.2022.YearCardMain2022View", package.seeall)

local YearCardMain2022View = class("YearCardMain2022View", ViewComponent)

function YearCardMain2022View:buildUI()
	YearCardMain2022View.super.buildUI(self)

	self._curActId = 8002
	self._goCell = self:getGo("cell")
	self._goTable = self:getGo("tableview")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnTip = self:getBtn("btnTip")
	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("txtTime")
	self._curPage = self:getGo("container")
	self._bg = self:getGo("bg")
end

function YearCardMain2022View:bindEvents()
	YearCardMain2022View.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function YearCardMain2022View:unbindEvents()
	YearCardMain2022View.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function YearCardMain2022View:onEnter()
	YearCardMain2022View.super.onEnter(self)

	self._viewCfg = YearCardConfig.instance:getMainViewCfg(self._curActId)
	self._actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.FirstCharge, self._curActId)
	self._isGetInfo = false

	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshViewAfterGetInfo, self)
	YearCardController.instance:getUserAnnuityInfo()
end

function YearCardMain2022View:onExit()
	YearCardMain2022View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refreshViewAfterGetInfo, self)
	self:showTabAt(self._curPage, "")
end

function YearCardMain2022View:_refreshViewAfterGetInfo()
	if not self._isGetInfo then
		self._isGetInfo = true

		YearCardModel.instance:setCurAnnuityId(self._curActId)
		self:_refreshViewByCfg()
	end
end

function YearCardMain2022View:_refreshViewByCfg()
	local openRootId = checkint(self._selectRoot)
	local openLeafId = checkint(self._selectLeaf)
	local seleceData = self._selectData

	self._selectRoot = nil
	self._selectLeaf = nil
	self._selectData = nil
	self._isOpen = false

	if not seleceData then
		local openParam = self:getOpenParam() or {}

		openRootId = checkint(openParam[1])
		openLeafId = checkint(openParam[2])

		if openRootId <= 0 and not string.nilorempty(openParam[1]) then
			openRootId, openLeafId = YearCardConfig.instance:getMainViewRootLeafByJumpInTag(openParam[1])
		end
	end

	if openRootId > 0 then
		if openLeafId > 0 then
			self:_onClickCell(openRootId, 1)
		else
			self:_onClickCell(openRootId, openLeafId)
		end
	else
		local rootIdx = YearCardController.instance:getRootIdx()
		local leafIdx = YearCardController.instance:getLeafIdx()

		rootIdx = rootIdx > 0 and rootIdx or 1
		leafIdx = leafIdx > 0 and leafIdx or 1

		self:_onClickCell(rootIdx, leafIdx)
	end

	local timeStart = GameUtil.string2time(self._actCfg.startTime)
	local timeEnd = GameUtil.string2time(self._actCfg.endTime)
	local isActive = YearCardModel.instance:isActiveAnnuity(self._curActId)

	if isActive and timeEnd < ServerTime.now() then
		local cardEndTime = YearCardModel.instance:getEndTime(self._curActId)
		local date = GameUtil.time2date(cardEndTime)

		self._txtTime.text = string.format("年费有效期截止：%s年%s月%s日5点", date.year, date.month, date.day)
	else
		self._txtTime.text = langPara("年费时间：%s-%s", GameUtil.formatTimeStamp("%Y年%m月%d日", timeStart), GameUtil.formatTimeStamp("%Y年%m月%d日%H点", timeEnd))
	end
end

function YearCardMain2022View:_reloadList()
	self._curDataList = {}

	for k, v in ipairs(self._viewCfg) do
		for k1, v1 in ipairs(v) do
			if v1.leaf == 1 then
				if string.nilorempty(v1.startTime) and string.nilorempty(v1.endTime) then
					table.insert(self._curDataList, v1)
				elseif not string.nilorempty(v1.startTime) and string.nilorempty(v1.endTime) then
					if ServerTime.now() > GameUtil.string2time(v1.startTime) then
						table.insert(self._curDataList, v1)
					end
				elseif string.nilorempty(v1.startTime) and not string.nilorempty(v1.endTime) then
					if ServerTime.now() < GameUtil.string2time(v1.endTime) then
						table.insert(self._curDataList, v1)
					end
				elseif ServerTime.now() > GameUtil.string2time(v1.startTime) and ServerTime.now() < GameUtil.string2time(v1.endTime) then
					table.insert(self._curDataList, v1)
				end
			elseif v1.root == self._selectRoot and self._isOpen then
				if string.nilorempty(v1.startTime) and string.nilorempty(v1.endTime) then
					table.insert(self._curDataList, v1)
				elseif not string.nilorempty(v1.startTime) and string.nilorempty(v1.endTime) then
					if ServerTime.now() > GameUtil.string2time(v1.startTime) then
						table.insert(self._curDataList, v1)
					end
				elseif string.nilorempty(v1.startTime) and not string.nilorempty(v1.endTime) then
					if ServerTime.now() < GameUtil.string2time(v1.endTime) then
						table.insert(self._curDataList, v1)
					end
				elseif ServerTime.now() > GameUtil.string2time(v1.startTime) and ServerTime.now() < GameUtil.string2time(v1.endTime) then
					table.insert(self._curDataList, v1)
				end
			end
		end
	end

	self._tableView:reloadData(self._curDataList)
end

function YearCardMain2022View:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickCell, self, data.root, data.leaf))

	cell.txtName.text = data.tag

	if data.leaf > 1 then
		cell.change:SetState(data == self._selectData and 3 or 2)
	else
		cell.change:SetState(data.root == self._selectRoot and 1 or 0)
	end

	goutil.setActive(cell.redPoint, false)

	if not string.nilorempty(data.redpointId) then
		if data.root == 1 then
			RedPointController.instance:regRedPoint(cell.redPoint, RedPointModel.ID_YEAR, data.redpointId)
		else
			RedPointController.instance:regRedPoint(cell.redPoint, data.redpointId)
		end
	end
end

function YearCardMain2022View:_clearCell(goCell)
	local cell = {}

	cell.go = goCell

	GameUtil.rmClickHandler(goCell)

	cell.btn = GameUtil.asBtn(goCell)
	cell.redPoint = goutil.findChild(goCell, "imgPoint")
	cell.txtName = goutil.findChildTextComponent(goCell, "txtName")
	cell.change = goCell:GetComponent("UIChangeGroup")

	RedPointController.instance:unregRedPoint(cell.redPoint)

	return cell
end

function YearCardMain2022View:_onClickCell(root, leaf)
	if not self._isGetInfo then
		return
	end

	YearCardController.instance:setRootIdx(root)
	YearCardController.instance:setLeafIdx(leaf)

	if self._selectRoot == root then
		if leaf == 1 then
			self._isOpen = not self._isOpen
		else
			self._selectLeaf = leaf
		end
	elseif self._selectRoot ~= root then
		self._selectRoot = root
		self._selectLeaf = 1
		self._isOpen = true
	end

	local data = self._viewCfg[self._selectRoot][self._selectLeaf]

	if string.nilorempty(data.enterView) then
		data = self._viewCfg[self._selectRoot][self._selectLeaf + 1]
	end

	if data ~= self._selectData then
		self._selectData = data

		self:showTabAt(self._curPage, "")

		if not string.nilorempty(data.enterView) then
			goutil.setActive(self._bg, not data.isHideBg)

			if string.nilorempty(data.params) then
				self:showTabAt(self._curPage, data.enterView)
			else
				local params = string.split(data.params, "#")

				self:showTabAt(self._curPage, data.enterView, unpack(params))
			end
		end
	end

	self:_reloadList()
end

function YearCardMain2022View:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "yearcardRule2022")
end

function YearCardMain2022View:_onClickBtnClose()
	self._selectRoot = nil
	self._selectLeaf = nil
	self._selectData = nil

	self:close()
end

return YearCardMain2022View
