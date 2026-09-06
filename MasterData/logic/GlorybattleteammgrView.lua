-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleteammgrView.lua

module("logic.extensions.glorybattle.view.GlorybattleteammgrView", package.seeall)

local GlorybattleteammgrView = class("GlorybattleteammgrView", ViewComponent)

GlorybattleteammgrView.TabType = {
	HolyStripe = 1,
	PetSell = 2
}
GlorybattleteammgrView.TabConfig = {
	[GlorybattleteammgrView.TabType.HolyStripe] = {
		tabName = "灵纹装配",
		tabType = GlorybattleteammgrView.TabType.HolyStripe
	},
	[GlorybattleteammgrView.TabType.PetSell] = {
		tabName = "精灵出售",
		tabType = GlorybattleteammgrView.TabType.PetSell
	}
}

function GlorybattleteammgrView:ctor()
	GlorybattleteammgrView.super.ctor(self)

	self._cacheV2 = Vector2.New(0, 0)
end

function GlorybattleteammgrView:unbindEvents()
	GlorybattleteammgrView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GlorybattleteammgrView:bindEvents()
	GlorybattleteammgrView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function GlorybattleteammgrView:buildUI()
	GlorybattleteammgrView.super.buildUI(self)

	self._tablecelltabGo = self:getGo("tablecelltab")
	self._tableviewtabGo = self:getGo("tableviewtab")
	self._tablecellpetSellGo = self:getGo("tablecellpetSell")
	self._tablecellpetLingwenGo = self:getGo("tablecellpetLingwen")
	self._tableviewGo = self:getGo("tableview")
	self._tableviewlingwenGo = self:getGo("tableviewlingwen")
	self._tablecelllingwenGo = self:getGo("tablecelllingwen")
	self._btnClose = self:getBtn("btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tableviewlingwenGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerListLw = ScrollerList.create(self._tableviewlingwenGo, self._tablecelllingwenGo, GameUtil.handler(self._updateLwCell, self), GameUtil.handler(self._clearLwCell, self))
	self._scrollerListTab = ScrollerList.create(self._tableviewtabGo, self._tablecelltabGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._scrollerList:setTagCell(self._tablecellpetLingwenGo, GlorybattleteammgrView.TabType.HolyStripe)
	self._scrollerList:setTagCell(self._tablecellpetSellGo, GlorybattleteammgrView.TabType.PetSell)
	self._scrollerList:regGetTagByIdx(function(data)
		return self:_getTagByIdx(data)
	end)

	self._emptyGo = self:getGo("empty")
	self._lwempty = self:getGo("lwempty")
	self._lwIconGo = self:getGo("lwtip/lwIcon")
	self._lwtipGo = self:getGo("lwtip")
	self._txtDesc = self:getTxt("lwtip/txtDesc")
	self._lwViewportTr = self:getGo("tableviewlingwen/viewport").transform
	self._lwBgGo = self:getGo("lwBg")
end

function GlorybattleteammgrView:onExit()
	GlorybattleteammgrView.super.onExit(self)
	self._scrollerList:dispose()
	self._scrollerListLw:dispose()
	self._scrollerListTab:dispose()
	uGuiUtil.clearImage(self._lwIconGo)
end

function GlorybattleteammgrView:onEnter()
	GlorybattleteammgrView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GloryBattleSalePetRes, self._forceClickTab, self)
	self.addGEvent(self, GlobalNotify.GloryBattleOperateHolyStripeRes, self._forceClickTab, self)
	self.addGEvent(self, GlobalNotify.GloryBattleInfoRes, self._forceClickTab, self)

	self._activityId = self:getFirstParam()
	self._selectTabType = GlorybattleteammgrView.TabType.HolyStripe
	self._selectHolyStripeId = 0

	self:_updateUI()
	self:_onClickTabCell(self._selectTabType)
end

function GlorybattleteammgrView:_onClickbtnClose()
	self:close()
end

function GlorybattleteammgrView:_updateCell(view, cell, data, tag)
	if self:_isHolyStripe() then
		self:_updateHolyStripeWearCell(cell, data)
	else
		self:_updateSellPetCell(cell, data)
	end
end

function GlorybattleteammgrView:_updateHolyStripeWearCell(cell, creepsInfo)
	local btnAdd = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnAdd")
	local btnReplace = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReplace")
	local btnDelete = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnDelete")
	local goItempet = goutil.findChild(cell.gameObject, "itempet")
	local goIconLw = goutil.findChild(cell.gameObject, "iconLw")
	local btnIconLw = Framework.ButtonAdapter.Get(goIconLw)
	local petMo = GlorybattleModel.instance:getPetMo(self._activityId, creepsInfo.creepsId)
	local holyStripeInfo = GlorybattleModel.instance:getHolyStripeInfo(self._activityId, creepsInfo.creepsId)
	local isSame = false

	if holyStripeInfo then
		local cfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(holyStripeInfo.holyStripeId)

		isSame = holyStripeInfo.holyStripeId == self._selectHolyStripeId

		local iconUrl = string.format("%s.png", cfg.iconUrl)

		uGuiUtil.setSpriteToImage(goIconLw, uGuiUtil.SpriteType.BigBg, iconUrl)
	end

	goutil.setActive(btnAdd.gameObject, not holyStripeInfo)
	goutil.setActive(btnDelete.gameObject, holyStripeInfo and (isSame or self._selectHolyStripeId == 0))
	goutil.setActive(btnReplace.gameObject, holyStripeInfo and not isSame and self._selectHolyStripeId > 0)
	goutil.setActive(goIconLw, holyStripeInfo)

	local proxy = MaterialMgr.setCellByMo(petMo, goItempet)

	proxy.binder:showStarByCustom(petMo.awakeLevel)
	btnAdd:AddClickListener(function()
		if self._selectHolyStripeId <= 0 then
			FloatWordMgr.instance:show("选择穿戴的灵纹")

			return
		end

		GloryBattleAgent.instance:sendPM_GloryBattleOperateHolyStripeReq(self._activityId, creepsInfo.creepsId, self._selectHolyStripeId, GlorybattleController.OperateType.Add)
	end)
	btnDelete:AddClickListener(function()
		GloryBattleAgent.instance:sendPM_GloryBattleOperateHolyStripeReq(self._activityId, creepsInfo.creepsId, holyStripeInfo.holyStripeId, GlorybattleController.OperateType.Delete)
	end)
	btnReplace:AddClickListener(function()
		GlorybattleController.instance:sendPM_GloryBattleReplaceHolyStripeReq(self._activityId, creepsInfo.creepsId, holyStripeInfo.holyStripeId, self._selectHolyStripeId)
	end)
	btnIconLw:AddClickListener(function()
		UIStateManager.instance:push(ViewName.GlorybattlelwtipsView, holyStripeInfo.holyStripeId)
	end)
end

function GlorybattleteammgrView:_updateSellPetCell(cell, creepsInfo)
	local goItempet = goutil.findChild(cell.gameObject, "itempet")
	local txtPrice = goutil.findChildTextComponent(cell.gameObject, "btnSell/txtPrice")
	local btnSell = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSell")
	local petMo = GlorybattleModel.instance:getPetMo(self._activityId, creepsInfo.creepsId)
	local base = GlorybattleConfig.instance:getCommonValue("SALE_PET_GAIN_CURRENCY_PERCENT", true)

	txtPrice.text = base * (creepsInfo.awakenLevel + 1)

	local proxy = MaterialMgr.setCellByMo(petMo, goItempet)

	proxy.binder:showStarByCustom(petMo.awakeLevel)
	proxy.binder:setClickCallBack(function()
		local petMo = GlorybattleModel.instance:getPetMo(self._activityId, creepsInfo.creepsId)

		CommonTipsMgr.instance:showPetTips(petMo)
	end)
	btnSell:AddClickListener(function()
		local battleNum = GlorybattleModel.instance:getPetNum(self._activityId)

		if battleNum <= 1 then
			FloatWordMgr.instance:show("必须拥有一只以上精灵才可进入匹配，此精灵不可售卖")

			return
		end

		local num = GlorybattleConfig.instance:getCommonValue("FORMATION_LIMIT_NUM", true)

		if num >= GlorybattleModel.instance:getPetNum(self._activityId) then
			local text = string.format("您的精灵少于%s只将影响作战是否继续", num)

			TipsFacade.instance:openPopupWindow("提示", text, function()
				GloryBattleAgent.instance:sendPM_GloryBattleSalePetReq(self._activityId, creepsInfo.creepsId)
			end)
		else
			GloryBattleAgent.instance:sendPM_GloryBattleSalePetReq(self._activityId, creepsInfo.creepsId)
		end
	end)
end

function GlorybattleteammgrView:_clearCell(cell)
	local goIconLw = goutil.findChild(cell.gameObject, "iconLw")

	if goIconLw then
		uGuiUtil.clearImage(goIconLw)
	end
end

function GlorybattleteammgrView:_updateLwCell(view, cell, data, tag)
	local holyStripeInfo = data.holyStripeInfo
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local selectGo = goutil.findChild(cell.gameObject, "select")
	local btn = Framework.ButtonAdapter.Get(goIcon)
	local cfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(holyStripeInfo.holyStripeId)
	local iconUrl = string.format("%s.png", cfg.iconUrl)

	uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, iconUrl)
	goutil.setActive(selectGo, self._selectHolyStripeId == holyStripeInfo.holyStripeId and self._selectHolyStripeIdx == data.idx)
	btn:AddClickListener(function()
		if holyStripeInfo.holyStripeId == self._selectHolyStripeId then
			self._selectHolyStripeId = 0
		else
			self._selectHolyStripeId = holyStripeInfo.holyStripeId
			self._selectHolyStripeIdx = data.idx
		end

		self._scrollerList:refresh()
		self._scrollerListLw:refresh()
		self:_updateLWTips()
	end)
end

function GlorybattleteammgrView:_clearLwCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(goIcon)
end

function GlorybattleteammgrView:_updateTabCell(view, cell, data, tag)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local bgChange = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local txt = goutil.findChildTextComponent(cell.gameObject, "txt")

	txt.text = data.tabName

	bgChange:SetState(self._selectTabType == data.tabType and 0 or 1)
	btn:AddClickListener(function()
		self:_onClickTabCell(data.tabType)
	end)
end

function GlorybattleteammgrView:_onClickTabCell(tabType)
	self._selectHolyStripeId = 0
	self._selectTabType = tabType

	self._scrollerListTab:refresh()
	self:_updateDetail()
end

function GlorybattleteammgrView:_clearTabCell(cell)
	return
end

function GlorybattleteammgrView:_updateUI()
	self._scrollerListTab:reloadData(GlorybattleteammgrView.TabConfig)
	self:_updateLWTips()
end

function GlorybattleteammgrView:_updateDetail()
	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local tableview = self._scrollerList:getView()

	if self:_isHolyStripe() then
		tableview.numRowsOrCols = 4
		self._cacheV2.x = 177.3
		self._cacheV2.y = -81.8
		tableview.cellOffset = self._cacheV2
		tableview.gridWidth = 262.7
		tableview.gridHeight = 152

		self:_updateBottomHolyStripe(info.challengeInfo.holyStripeInfos)
	else
		tableview.numRowsOrCols = 6
		self._cacheV2.x = 76.4
		self._cacheV2.y = -96
		tableview.cellOffset = self._cacheV2
		tableview.gridWidth = 175.6
		tableview.gridHeight = 181.6

		goutil.setActive(self._lwempty, false)
	end

	local infos = info.challengeInfo.creepsInfos

	self._scrollerList:reloadData(infos)
	goutil.setActive(self._emptyGo, not infos or #infos <= 0)

	local lwTableview = self._scrollerListLw:getView()

	goutil.setActive(lwTableview.gameObject, self:_isHolyStripe())
	goutil.setActive(_lwBgGo, self:_isHolyStripe())
end

function GlorybattleteammgrView:_updateBottomHolyStripe(holyStripeInfos)
	local list = {}
	local zdlMap = {}
	local idx = 1

	for i, v in ipairs(holyStripeInfos) do
		zdlMap[v.holyStripeId] = GlorybattleModel.instance:calHolyStripeZdl(v.holyStripeId)

		for j = 1, v.num - #v.bindCreepsId do
			table.insert(list, {
				idx = idx,
				holyStripeInfo = v
			})

			idx = idx + 1
		end
	end

	local cnt = #list

	table.sort(list, function(a, b)
		return zdlMap[a.holyStripeInfo.holyStripeId] > zdlMap[b.holyStripeInfo.holyStripeId]
	end)
	self._scrollerListLw:reloadData(list)

	local scrollView = self._scrollerListLw:getView()

	goutil.setActive(self._lwempty, cnt <= 0)

	local offsetX = scrollView.cellOffset.x
	local cellWidth = scrollView.gridWidth
	local xMax = 1054
	local posx = xMax - cnt * cellWidth - offsetX

	posx = math.max(posx, 0)

	Framework.TransformUtil.SetAnchoredPos(self._lwViewportTr, posx, 0)
	GameUtil.setWidth(self._lwViewportTr, xMax - posx)
end

function GlorybattleteammgrView:_isHolyStripe()
	return self._selectTabType == GlorybattleteammgrView.TabType.HolyStripe
end

function GlorybattleteammgrView:_getTagByIdx(data)
	return self._selectTabType
end

function GlorybattleteammgrView:_forceClickTab()
	self:_onClickTabCell(self._selectTabType)
end

function GlorybattleteammgrView:_updateLWTips()
	local isShow = self:_isHolyStripe() and self._selectHolyStripeId > 0

	goutil.setActive(self._lwtipGo, isShow)

	if isShow then
		local suitCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(self._selectHolyStripeId)

		self._txtDesc.text = suitCfg.suitDesc

		local url = string.format("%s.png", suitCfg.iconUrl)

		uGuiUtil.setSpriteToImage(self._lwIconGo, uGuiUtil.SpriteType.BigBg, url)
	end
end

return GlorybattleteammgrView
