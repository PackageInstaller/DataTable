-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RuneresolveView.lua

module("logic.extensions.rune.view.RuneresolveView", package.seeall)

local RuneresolveView = class("RuneresolveView", ViewComponent)
local LIMIT = 300

function RuneresolveView:ctor()
	RuneresolveView.super.ctor(self)
end

function RuneresolveView:buildUI()
	RuneresolveView.super.buildUI(self)

	self.goldBarCon = self:getGo("goldBarCon")
	self.btnClose = self:getGo("container/upInfo/btnClose")
	self.btnHelp = self:getGo("container/upInfo/btnHelp")
	self.rightInfo = self:getGo("container/rightInfo")
	self.equipListSR = self:getGo("container/rightInfo/equipListSR")
	self.itemGridGo = self:getGo("container/rightInfo/itemGridGo")
	self.imgEmptyRight = self:getGo("container/rightInfo/imgEmpty")
	self.txtCount = self:getTxt("container/rightInfo/txtCount")
	self.filters = {}

	for i = 1, 10 do
		self.filters[i] = self:getToggle("container/rightInfo/fliter/btn" .. i)
	end

	self._tableviewBag = ScrollerList.create(self.equipListSR, self.itemGridGo, GameUtil.handler(self._updateCellBag, self), GameUtil.handler(self._clearCellBag, self))
	self.rightInfo = self:getGo("container/leftInfo")
	self.equipListLeft = self:getGo("container/leftInfo/equipListSR")
	self.item = self:getGo("container/leftInfo/item")
	self.imgEmptyLeft = self:getGo("container/leftInfo/imgEmpty")
	self.btnSure = self:getGo("container/leftInfo/btnSure")
	self._tableviewLeft = ScrollerList.create(self.equipListLeft, self.item, GameUtil.handler(self._updateCellLeft, self), GameUtil.handler(self._clearCellLeft, self))
	self.ScrollView = self:getGo("container/leftInfo/ScrollView")
	self._tableviewDown = ScrollerList.create(self.ScrollView, self.item, GameUtil.handler(self._updateCellDown, self), GameUtil.handler(self._clearCellDown, self))
end

function RuneresolveView:bindEvents()
	RuneresolveView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self.onSureDepart, self)
end

function RuneresolveView:unbindEvents()
	RuneresolveView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnSure)
	GameUtil.rmClickHandler(self.btnHelp)
end

function RuneresolveView:destroyUI()
	RuneresolveView.super.destroyUI(self)
end

function RuneresolveView:onEnter()
	RuneresolveView.super.onEnter(self)

	self.leftList = {}

	for k, v in pairs(self.filters) do
		if GameUtil.GetActive(v) then
			v.isOn = false

			v:AddOnValueChanged(GameUtil.handler(self.onClickFilter, self, k))
		end
	end

	RuneController.instance:getSuitInfo(GameUtil.handler(self.refresh, self))
	GlobalDispatcher:addListener(GlobalNotify.RUNE_SUIT_UPDATE, self.refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.RUNE_ITEM_UPDATE, self.refresh, self)

	local btn_list = {
		{
			showAdd = false,
			id = GameEnum.GoldType.RuneCoin
		}
	}

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, btn_list)
end

function RuneresolveView:onEnterFinished()
	RuneresolveView.super.onEnterFinished(self)
end

function RuneresolveView:onExit()
	RuneresolveView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RUNE_SUIT_UPDATE, self.refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.RUNE_ITEM_UPDATE, self.refresh, self)

	for k, v in pairs(self.filters) do
		v:RemoveOnValueChanged()
	end

	self._tableviewBag:dispose()
	self._tableviewLeft:dispose()
	self._tableviewDown:dispose()
end

function RuneresolveView:onExitFinished()
	RuneresolveView.super.onExitFinished(self)
end

function RuneresolveView:refresh()
	self:showLeftView()
	self:showRightView()
	self:showMaterial()
end

function RuneresolveView:_clearCellLeft(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function RuneresolveView:_updateCellLeft(view, cell, data)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.setCellByData(MatType.Rune, data, con)
end

function RuneresolveView:_clearCellDown(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function RuneresolveView:_updateCellDown(view, cell, data)
	local con = goutil.findChild(cell, "con")

	GameUtil.setLocalScale(con, 0.75)
	MaterialMgr.setCellListByCfg(data, con)
end

function RuneresolveView:_updateCellBag(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local reduceBtn = goutil.findChild(cell, "reduceBtn")

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onSelectRune, self, data))
	GameUtil.addClickHandler(reduceBtn, GameUtil.handler(self.onSelectRune, self, data))
	MaterialMgr.setCellByData(MatType.Rune, data, con)

	local idx = table.indexof(self.leftList, data)

	if idx == false then
		GameUtil.SetActive(reduceBtn, false)
	else
		GameUtil.SetActive(reduceBtn, true)
	end
end

function RuneresolveView:_clearCellBag(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function RuneresolveView:onSelectRune(runeMo)
	local idx = table.indexof(self.leftList, runeMo)

	if idx == false then
		if #self.leftList >= LIMIT then
			TipsFacade.instance:openCommonTips(lang("一次分解符文数量不能超过 ") .. LIMIT)

			return
		end

		table.insert(self.leftList, runeMo)
	else
		table.remove(self.leftList, idx)
	end

	self._tableviewBag:refresh()
	self:showLeftView()
end

function RuneresolveView:onClickFilter(quality)
	quality = checknumber(quality)

	local tg = self.filters[quality]
	local count = 0
	local allList = RuneModel.instance:getAllFreeRune()

	for k, v in pairs(allList) do
		if quality == v:getQuality() then
			local idx = table.indexof(self.leftList, v)

			if tg.isOn then
				count = count + 1

				if idx == false then
					if #self.leftList >= LIMIT then
						TipsFacade.instance:openCommonTips(lang("一次分解符文数量不能超过：") .. LIMIT)

						break
					end

					table.insert(self.leftList, v)
				end
			elseif idx == false then
				-- block empty
			else
				count = count + 1

				table.remove(self.leftList, idx)
			end
		end
	end

	if tg.isOn then
		if count == 0 then
			tg.isOn = false

			FloatWordMgr.instance:show(langPara("暂时没有可以分解的%s星辉", ConstString.Quality[quality]))
		end
	elseif count > 0 then
		FloatWordMgr.instance:show(langPara("被选择的%s星辉已经全部取消", ConstString.Quality[quality]))
	end

	self._tableviewBag:refresh()
	self:showLeftView()
end

function RuneresolveView:onSureDepart()
	RuneController.instance:sendDepart(self.leftList, function()
		self.leftList = {}

		self:refresh()
	end)
end

function RuneresolveView:showRightView()
	local allList = RuneModel.instance:getAllFreeRune()

	self._tableviewBag:reloadData(allList)
	GameUtil.SetActive(self.imgEmptyRight, allList == nil or #allList == 0)
end

function RuneresolveView:showLeftView()
	self._tableviewLeft:reloadData(self.leftList)
	GameUtil.SetActive(self.imgEmptyLeft, self.leftList == nil or #self.leftList == 0)
	self:showMaterial()
end

function RuneresolveView:showMaterial()
	self.txtCount.text = langPara("已经选中：(%s/%s)", #self.leftList, LIMIT)

	local str = RuneConfig.instance:getConst("RUNE_MATERIAL_ADD_EXP")
	local matStr = RuneConfig.instance:getConst("RUNE_MATERIAL_ID")
	local arr = string.split(str, ",")
	local matArr = string.split(matStr, ",")
	local val = 0
	local count = 0

	for k, v in pairs(self.leftList) do
		val = val + v:getTotalExp()
		count = count + v:getDepartItemCount()
	end

	local top = math.floor(val / arr[3])

	val = val - top * arr[3]

	local mid = math.floor(val / arr[2])

	val = val - mid * arr[2]

	local low = math.floor(val / arr[1])
	local list = {}

	if count > 0 then
		table.insert(list, "8:12:" .. count)
	end

	if top > 0 then
		table.insert(list, "4:" .. matArr[3] .. ":" .. top)
	end

	if mid > 0 then
		table.insert(list, "4:" .. matArr[2] .. ":" .. mid)
	end

	if low > 0 then
		table.insert(list, "4:" .. matArr[1] .. ":" .. low)
	end

	self._tableviewDown:reloadData(list)
end

return RuneresolveView
