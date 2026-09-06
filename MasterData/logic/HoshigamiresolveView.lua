-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiresolveView.lua

module("logic.extensions.hoshigami.view.HoshigamiresolveView", package.seeall)

local HoshigamiresolveView = class("HoshigamiresolveView", ViewComponent)
local LIMIT = 30000

function HoshigamiresolveView:ctor()
	HoshigamiresolveView.super.ctor(self)
end

function HoshigamiresolveView:buildUI()
	HoshigamiresolveView.super.buildUI(self)

	self.goldBarCon = self:getGo("goldBarCon")
	self.btnClose = self:getGo("container/upInfo/btnClose")
	self.btnHelp = self:getGo("container/upInfo/btnHelp")
	self.rightInfo = self:getGo("container/rightInfo")
	self.equipListSR = self:getGo("container/rightInfo/equipListSR")
	self.itemGridGo = self:getGo("container/rightInfo/itemGridGo")
	self.imgEmptyRight = self:getGo("container/rightInfo/imgEmpty")
	self.txtCount = self:getTxt("container/rightInfo/txtCount")
	self.filters = {}
	self._toggleList = {}

	for i = 1, 10 do
		local toggle = self:getToggle("container/rightInfo/fliter/btn" .. i)

		self.filters[i] = toggle
		self._toggleList[i - 1] = toggle
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

function HoshigamiresolveView:bindEvents()
	HoshigamiresolveView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self.onSureDepart, self)
end

function HoshigamiresolveView:unbindEvents()
	HoshigamiresolveView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnSure)
	GameUtil.rmClickHandler(self.btnHelp)
end

function HoshigamiresolveView:destroyUI()
	HoshigamiresolveView.super.destroyUI(self)
end

function HoshigamiresolveView:onEnter()
	HoshigamiresolveView.super.onEnter(self)
	GlobalDispatcher:addListener(HoshigamiController.PM_DecomposeHoshigamisRes, self._resolveRes, self)

	self._leftList = {}

	for k, v in pairs(self.filters) do
		if GameUtil.GetActive(v) then
			v.isOn = false

			v:AddOnValueChanged(GameUtil.handler(self.onClickFilter, self, k - 1))
		end
	end

	self:_refresh()
end

function HoshigamiresolveView:onEnterFinished()
	HoshigamiresolveView.super.onEnterFinished(self)
end

function HoshigamiresolveView:onExit()
	HoshigamiresolveView.super.onExit(self)
	GlobalDispatcher:removeListener(HoshigamiController.PM_DecomposeHoshigamisRes, self._resolveRes, self)

	for k, v in pairs(self.filters) do
		v:RemoveOnValueChanged()
	end

	self._tableviewDown:dispose()
	self._tableviewBag:dispose()
	self._tableviewLeft:dispose()
end

function HoshigamiresolveView:onExitFinished()
	HoshigamiresolveView.super.onExitFinished(self)
end

function HoshigamiresolveView:_refresh()
	self:showLeftView()
	self:showRightView()
	self:showMaterial()
end

function HoshigamiresolveView:_clearCellLeft(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function HoshigamiresolveView:_updateCellLeft(view, cell, data)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.setCellByData(MatType.Hoshigami, data, con)
end

function HoshigamiresolveView:_clearCellDown(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function HoshigamiresolveView:_updateCellDown(view, cell, data)
	local con = goutil.findChild(cell, "con")

	GameUtil.setLocalScale(con, 0.75)
	MaterialMgr.setCellListByCfg(data, con)
end

function HoshigamiresolveView:_updateCellBag(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local reduceBtn = goutil.findChild(cell, "reduceBtn")

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onSelectHoshigami, self, data))
	GameUtil.addClickHandler(reduceBtn, GameUtil.handler(self._onSelectHoshigami, self, data))
	MaterialMgr.setCellByData(MatType.Hoshigami, data, con)

	local idx = table.indexof(self._leftList, data)

	if idx == false then
		GameUtil.SetActive(reduceBtn, false)
	else
		GameUtil.SetActive(reduceBtn, true)
	end
end

function HoshigamiresolveView:_clearCellBag(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function HoshigamiresolveView:_onSelectHoshigami(mo)
	local idx = table.indexof(self._leftList, mo)

	if idx == false then
		if #self._leftList >= LIMIT then
			TipsFacade.instance:openCommonTips(lang("一次分解符文数量不能超过 ") .. LIMIT)

			return
		end

		table.insert(self._leftList, mo)
	else
		table.remove(self._leftList, idx)
	end

	self._tableviewBag:refresh()
	self:showLeftView()
end

function HoshigamiresolveView:onClickFilter(quality)
	quality = checknumber(quality)

	local tg = self._toggleList[quality]
	local count = 0
	local allList = HoshigamiModel.instance:getResolveHoshigamiMos()

	for k, v in pairs(allList) do
		if quality == v:getQuality() then
			local idx = table.indexof(self._leftList, v)

			if tg.isOn then
				count = count + 1

				if idx == false then
					if #self._leftList >= LIMIT then
						TipsFacade.instance:openCommonTips(lang("一次分解符文数量不能超过：") .. LIMIT)

						break
					end

					table.insert(self._leftList, v)
				end
			elseif idx == false then
				-- block empty
			else
				count = count + 1

				table.remove(self._leftList, idx)
			end
		end
	end

	if tg.isOn then
		if count == 0 then
			tg.isOn = false

			FloatWordMgr.instance:show(langPara("暂时没有可以分解的%s星神", ConstString.Quality[quality + 1]))
		end
	elseif count > 0 then
		FloatWordMgr.instance:show(langPara("被选择的%s星神已经全部取消", ConstString.Quality[quality + 1]))
	end

	self._tableviewBag:refresh()
	self:showLeftView()
end

function HoshigamiresolveView:onSureDepart()
	if self._leftList and #self._leftList > 0 then
		local hoshigamiIds_i32_Ary = {}

		for i, v in ipairs(self._leftList) do
			table.insert(hoshigamiIds_i32_Ary, v:getId())
		end

		HoshigamiAgent.instance:sendPM_DecomposeHoshigamisReq(hoshigamiIds_i32_Ary)
	end
end

function HoshigamiresolveView:showRightView()
	local allList = HoshigamiModel.instance:getResolveHoshigamiMos()

	self._tableviewBag:reloadData(allList)
	GameUtil.SetActive(self.imgEmptyRight, allList == nil or #allList == 0)
end

function HoshigamiresolveView:showLeftView()
	self._tableviewLeft:reloadData(self._leftList)
	GameUtil.SetActive(self.imgEmptyLeft, self._leftList == nil or #self._leftList == 0)
	self:showMaterial()
end

function HoshigamiresolveView:showMaterial()
	self.txtCount.text = langPara("已经选中：(%s/%s)", #self._leftList, LIMIT)

	local toMats = {}

	for k, v in pairs(self._leftList) do
		local fromMats = v:getResolveMats()

		GameUtil.addSameAttrs(fromMats, toMats)
	end

	local list = {}

	for k, v in pairs(toMats) do
		if v > 0 then
			table.insert(list, string.format("%s:%s", k, v))
		end
	end

	self._tableviewDown:reloadData(list)
end

function HoshigamiresolveView:_resolveRes()
	self._leftList = {}

	self:_refresh()
end

return HoshigamiresolveView
