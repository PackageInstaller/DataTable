-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/view/OriginhuociyuanbuffView.lua

module("logic.extensions.originhuociyuan.view.OriginhuociyuanbuffView", package.seeall)

local OriginhuociyuanbuffView = class("OriginhuociyuanbuffView", ViewComponent)

function OriginhuociyuanbuffView:ctor()
	OriginhuociyuanbuffView.super.ctor(self)
end

function OriginhuociyuanbuffView:unbindEvents()
	OriginhuociyuanbuffView.super.unbindEvents(self)

	for i = 1, 9 do
		if self._cellMap[i] then
			GameUtil.rmClickHandler(self._cellMap[i].btn)
		end
	end

	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function OriginhuociyuanbuffView:bindEvents()
	OriginhuociyuanbuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)

	for i = 1, 9 do
		if self._cellMap[i] then
			GameUtil.addClickHandler(self._cellMap[i].btn, function()
				self:_onClickCell(i)
			end, self)
		end
	end
end

function OriginhuociyuanbuffView:buildUI()
	OriginhuociyuanbuffView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._btnCancel = self:getGo("btnCancel")
	self._txtDesc = self:getTxt("moveNode/txtDesc")
	self._empty = self:getGo("moveNode/empty")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._cellMap = {}

	local fmtGo = self:getGo("moveNode/fmt")

	for i = 1, 9 do
		local cell = {}

		cell.go = goutil.findChild(fmtGo, "cell_" .. i)
		cell.con = goutil.findChild(cell.go, "con")
		cell.conTag = goutil.findChild(cell.go, "tag")
		cell.txt = goutil.findChildTextComponent(cell.go, "tag/txt")
		cell.emptyTag = goutil.findChild(fmtGo, string.format("bg/cell_%d/tag", i))
		cell.btn = goutil.findChild(fmtGo, string.format("btns/btnCell_%d", i))
		cell.typeImgChange = goutil.findChildComponent(cell.conTag, "typeImg", ComponentType.UIImageSpriteChange)
		cell.bgTypeImgChange = goutil.findChildComponent(cell.emptyTag, "typeImg", ComponentType.UIImageSpriteChange)
		self._cellMap[i] = cell
	end

	self._tagTableCell = self:getGo("moveNode/tagTableView/tablecell")
	self._tagTableView = self:getGo("moveNode/tagTableView")
	self._tagTableList = ScrollerList.create(self._tagTableView, self._tagTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._dragcell = self:getGo("dragcell")
	self._dragCellTypeImg = goutil.findChildComponent(self._dragcell, "typeImg", ComponentType.UIImageSpriteChange)

	self._tagTableList:getView():RegisterDraggingCallback(nil, GameUtil.handler(self._onDragCellStart, self), nil, nil, GameUtil.handler(self._onCloneDragObj, self), nil)
	self._tagTableList:getView():RegisterDragEndedCallback(self._onDragCellEnd, self)
end

function OriginhuociyuanbuffView:onExit()
	OriginhuociyuanbuffView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.ORIGIN_HUOCIYUAN_BUFF_SELECT_CHANGE)
end

function OriginhuociyuanbuffView:onEnter()
	OriginhuociyuanbuffView.super.onEnter(self)

	self._customFmtMo = self:getFirstParam()
	self._activityId = self._customFmtMo.activityId
	self._stageId = self._customFmtMo.stageId
	self._isPopupState = true
	self._actCfg = OriginHuociyuanConfig.instance:getActCfgById(self._activityId) or {}
	self._txtDesc.text = self._actCfg.buffDesc

	self:_initView()
	self:_refreshView()
end

function OriginhuociyuanbuffView:_initView()
	local fmo = self._customFmtMo:getCurFormation()

	for i = 1, 9 do
		GameUtil.SetActive(self._cellMap[i].go, false)

		local pId = checknumber(fmo:GetPosition(i))

		if pId > 0 then
			local petMo = fmo:_getPet(pId)

			if petMo then
				MaterialMgr.setIcon(self._cellMap[i].con, MatType.Pet, petMo.raceId)
				GameUtil.SetActive(self._cellMap[i].go, true)
			end
		end
	end

	GameUtil.SetActive(self._dragcell, false)
end

function OriginhuociyuanbuffView:_refreshView()
	local stageCfg = OriginHuociyuanConfig.instance:getStageCfgById(self._activityId, self._stageId) or {}

	if not stageCfg.needUseBlockBuff then
		local tagList = {}
		local map = {}

		for i, v in ipairs(tagList) do
			map[v] = true
		end

		GameUtil.SetActive(self._empty, true)

		local fmo = self._customFmtMo:getCurFormation()

		for i = 1, 9 do
			local cell = self._cellMap[i]
			local pId = checknumber(fmo:GetPosition(i))

			if pId > 0 then
				GameUtil.SetActive(self._empty, false)
			end

			local buffId = self._customFmtMo:getPetBuff(pId)

			if buffId > 0 then
				map[buffId] = nil

				GameUtil.SetActive(cell.conTag, true)
				GameUtil.SetActive(cell.emptyTag, true)

				local buffCfg = OriginHuociyuanConfig.instance:getBuffCfgById(self._activityId, buffId) or {}

				cell.txt.text = checknumber(buffCfg.buffNum)

				local tagTypeImageName = buffCfg.buffIcon

				if string.nilorempty(tagTypeImageName) then
					tagTypeImageName = "board_yq_xuanyun"
				end

				cell.typeImgChange:ChangeSprite(tagTypeImageName)
				cell.bgTypeImgChange:ChangeSprite(tagTypeImageName)
			else
				GameUtil.SetActive(cell.conTag, false)
				GameUtil.SetActive(cell.emptyTag, false)
			end
		end

		local list = {}

		for k, v in pairs(map) do
			if v == true then
				table.insert(list, k)
			end
		end

		ArraySort.sortOn(list)
		self._tagTableList:reloadData(list)
	end
end

function OriginhuociyuanbuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local tagTypeChange = goutil.findChildComponent(go, "typeImg", ComponentType.UIImageSpriteChange)
	local txtNum = goutil.findChildTextComponent(go, "txt")

	go.name = "cell_" .. data

	local buffCfg = OriginHuociyuanConfig.instance:getBuffCfgById(self._activityId, data) or {}

	txtNum.text = checknumber(buffCfg.buffNum)

	local tagTypeImageName = buffCfg.buffIcon

	if string.nilorempty(tagTypeImageName) then
		tagTypeImageName = "board_yq_xuanyun"
	end

	tagTypeChange:ChangeSprite(tagTypeImageName)
end

function OriginhuociyuanbuffView:_clearCell(cell)
	return
end

function OriginhuociyuanbuffView:_onDragCellStart(startContainer, cell)
	local cellGoStrArr = string.split(cell.gameObject.name, "_")
	local cellId = checknumber(cellGoStrArr[2])

	self._currDragId = cellId

	local buffCfg = OriginHuociyuanConfig.instance:getBuffCfgById(self._activityId, cellId) or {}
	local tagTypeImageName = buffCfg.buffIcon

	if string.nilorempty(tagTypeImageName) then
		tagTypeImageName = "board_yq_xuanyun"
	end

	self._dragCellTypeImg:ChangeSprite(tagTypeImageName)
	GameUtil.SetActive(self._dragcell, true)

	self._drag = true
end

function OriginhuociyuanbuffView:_onDragCellEnd(startContainer, cell, endContainer)
	if endContainer then
		local cellGoStrArr = string.split(endContainer.name, "_")
		local cellIdx = checknumber(cellGoStrArr[2])
		local fmo = self._customFmtMo:getCurFormation()
		local pId = checknumber(fmo:GetPosition(cellIdx))

		if pId > 0 then
			local lastBuffId = checknumber(self._customFmtMo:getPetBuff(pId))

			if lastBuffId > 0 then
				self._customFmtMo:setBuffInfo(lastBuffId, nil)
			end

			self._customFmtMo:setBuffInfo(self._currDragId, pId)

			self._currDragId = nil

			self:_refreshView()
		else
			TipsFacade.instance:openCommonTips("请拖动标记到上阵精灵位置")
		end
	end

	GameUtil.SetActive(self._dragcell, false)

	self._drag = false

	return true
end

function OriginhuociyuanbuffView:_onCloneDragObj(table, cell)
	local targetPos = GameUtil.getPos(cell.gameObject)

	GameUtil.setPos(self._dragcell, targetPos.x, targetPos.y, targetPos.z)

	return self._dragcell
end

function OriginhuociyuanbuffView:_onClickCell(index)
	local fmo = self._customFmtMo:getCurFormation()
	local pId = checknumber(fmo:GetPosition(index))
	local buffId = self._customFmtMo:getPetBuff(pId)

	if buffId > 0 then
		self._customFmtMo:setBuffInfo(buffId, nil)
		self:_refreshView()
	end
end

return OriginhuociyuanbuffView
