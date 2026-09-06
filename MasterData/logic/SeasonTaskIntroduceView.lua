-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonTaskIntroduceView.lua

module("logic.extensions.season.view.SeasonTaskIntroduceView", package.seeall)

local SeasonTaskIntroduceView = class("SeasonTaskIntroduceView", ViewComponent)

function SeasonTaskIntroduceView:ctor()
	SeasonTaskIntroduceView.super.ctor(self)
end

function SeasonTaskIntroduceView:unbindEvents()
	SeasonTaskIntroduceView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i = 1, 9 do
		self._topBtn[i].btn:RemoveClickListener()
	end
end

function SeasonTaskIntroduceView:bindEvents()
	SeasonTaskIntroduceView.super.bindEvents(self)

	for i = 1, 9 do
		self._topBtn[i].btn:AddClickListener(function()
			self:_onClickTopBtn(i)
		end, self)
	end

	self._btnClose:AddClickListener(self.close, self)
end

function SeasonTaskIntroduceView:buildUI()
	SeasonTaskIntroduceView.super.buildUI(self)

	self._topBtn = {}

	for i = 1, 9 do
		local go = self:getGo("levels/cell_" .. i)

		self._topBtn[i] = {
			go = go,
			btn = self:getBtn("levels/cell_" .. i),
			selected = self:getGo("levels/cell_" .. i .. "/select"),
			uiTxtColorChange = goutil.findChildComponent(go, "txtName", "UITextColorChange"),
			redPoint = goutil.findChild(go, "redPoint")
		}
	end

	self._taskTableView = self:getGo("taskInfo/tableview")
	self._taskCell = self:getGo("taskInfo/taskCell")
	self._taskInfos = ScrollerList.create(self._taskTableView, self._taskCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtBubble = self:getTxt("bubble/txt")
	self._roleCon = self:getGo("roleCon")
	self._btnClose = self:getBtn("btnClose")
end

function SeasonTaskIntroduceView:onExit()
	SeasonTaskIntroduceView.super.onExit(self)
	self._taskInfos:dispose()
end

function SeasonTaskIntroduceView:onEnter()
	SeasonTaskIntroduceView.super.onEnter(self)

	local params = self:getFirstParam()

	for i = 1, #self._topBtn do
		GameUtil.SetActive(self._topBtn[i].redPoint, false)
	end

	if params and checknumber(params) > 0 then
		self:_onClickTopBtn(checknumber(params))
	else
		self:_onClickTopBtn(1)
	end
end

function SeasonTaskIntroduceView:_refreshInfo()
	local seasonId = SeasonModel.instance:getSeasonId()
	local infoCfg = SeasonConfig.instance:getTaskIntroducePageInfo(seasonId)
	local data = infoCfg[self._curPage]
	local isChange = false

	if SeasonModel.instance:isOccupied(data.changePos) then
		self._curPage = data.changePage
		data = infoCfg[self._curPage]
		isChange = true
	end

	local dataList = {}

	if data and data.taskIds then
		for i, v in ipairs(data.taskIds) do
			local taskCfg = SeasonConfig.instance:getTaskIntroduce(v)

			table.insert(dataList, taskCfg)
		end
	end

	self._taskInfos:reloadData(dataList)

	if not string.nilorempty(data.imgRes) then
		uGuiUtil.setSpriteToImage(self._roleCon, nil, GameUrl.getBigbgFolderUrl("season", data.imgRes))
	end

	self._txtBubble.text = data.txtBubble
end

function SeasonTaskIntroduceView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local desc = goutil.findChildTextComponent(go, "txtDesc")
	local txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	local select = goutil.findChild(go, "select")
	local img = goutil.findChild(go, "icon")
	local btnGoto = GameUtil.asBtn(goutil.findChild(go, "btnGoto"))
	local txtBtn = goutil.findChildTextComponent(go, "btnGoto/Text")
	local mo = SeasonModel.instance:getMapInfoById(data.jumpTo)

	txtBtn.text = mo and mo:isOccupied() and "已完成" or "查看"

	if data.tag == 2 then
		GameUtil.SetActive(select, true)
	else
		GameUtil.SetActive(select, false)
	end

	txtTitle.text = data.txtTitle
	desc.text = data.txtDesc

	uGuiUtil.setSpriteToImage(img, nil, GameUrl.getBigbgFolderUrl("season", data.imgRes))
	btnGoto:AddClickListener(function()
		self:_onClickGoto(data.jumpTo)
	end)
end

function SeasonTaskIntroduceView:_clearCell(cell)
	local go = cell.gameObject
	local img = goutil.findChild(go, "icon")
	local btnGoto = GameUtil.asBtn(goutil.findChild(go, "btnGoto"))

	uGuiUtil.clearImage(img)
	btnGoto:RemoveClickListener()
end

function SeasonTaskIntroduceView:_onClickTopBtn(index)
	for i = 1, 9 do
		GameUtil.SetActive(self._topBtn[i].selected, false)
		self._topBtn[i].uiTxtColorChange:SetState(0)
	end

	self._curPage = index

	self._topBtn[index].uiTxtColorChange:SetState(1)
	GameUtil.SetActive(self._topBtn[index].selected, true)
	self:_refreshInfo()
end

function SeasonTaskIntroduceView:_onClickGoto(jumpTo)
	self:close()

	local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(jumpTo)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.eventsAnimation then
		scene.eventsAnimation:playCamera2Grid(gridX, gridY)
		GlobalDispatcher:dispatch(GlobalNotify.SeasonSelectGrid_R_C, gridX, gridY)
	end
end

return SeasonTaskIntroduceView
