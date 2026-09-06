-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleselectteamView.lua

module("logic.extensions.glorybattle.view.GlorybattleselectteamView", package.seeall)

local GlorybattleselectteamView = class("GlorybattleselectteamView", ViewComponent)

function GlorybattleselectteamView:ctor()
	GlorybattleselectteamView.super.ctor(self)
end

function GlorybattleselectteamView:unbindEvents()
	GlorybattleselectteamView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function GlorybattleselectteamView:bindEvents()
	GlorybattleselectteamView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function GlorybattleselectteamView:buildUI()
	GlorybattleselectteamView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollList = {}
end

function GlorybattleselectteamView:onExit()
	GlorybattleselectteamView.super.onExit(self)
	self._scrollerList:dispose()
end

function GlorybattleselectteamView:onEnter()
	GlorybattleselectteamView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GloryBattleDrawGenreRes, self._onGloryBattleDrawGenreRes, self)
	self.addGEvent(self, GlobalNotify.GloryBattleSelectGenreRes, self._onGloryBattleSelectGenreRes, self)

	self._activityId = self:getFirstParam()
	self._info = GlorybattleModel.instance:getInfo(self._activityId)
	self._selectGenreId = 0
	self._randomGenreId = -1

	local drawGenreIds = self._info.challengeInfo.drawGenreIds

	if self._info.challengeInfo.genreId == 0 and drawGenreIds and #drawGenreIds > 0 then
		self:_initGenreIds(self._info.challengeInfo.drawGenreIds)
		self:_updateUI()
	else
		GloryBattleAgent.instance:sendPM_GloryBattleDrawGenreReq(self._activityId)
	end
end

function GlorybattleselectteamView:_updateUI()
	if not self._genreIds then
		return
	end

	if self._selectGenreId <= 0 then
		local idx = math.random(1, #self._genreIds)

		self._selectGenreId = self._genreIds[idx]
	end

	self._scrollerList:reloadData(self._genreIds)
end

function GlorybattleselectteamView:_initGenreIds(genreIds)
	self._genreIds = {}

	for i, v in ipairs(genreIds) do
		table.insert(self._genreIds, v)
	end

	table.insert(self._genreIds, self._randomGenreId)
end

function GlorybattleselectteamView:_onGloryBattleDrawGenreRes(genreIds)
	self:_initGenreIds(genreIds)
	self:_updateUI()
end

function GlorybattleselectteamView:_onGloryBattleSelectGenreRes()
	UIStateManager.instance:push(ViewName.GlorybattleshopView, self._activityId)
	self:close()
end

function GlorybattleselectteamView:_onClickbtnSure()
	if self._selectGenreId == 0 then
		FloatWordMgr.instance:show("请选择阵容")

		return
	end

	local isRandom = self._randomGenreId == self._selectGenreId
	local selectGenreId = isRandom and 0 or self._selectGenreId

	GloryBattleAgent.instance:sendPM_GloryBattleSelectGenreReq(self._activityId, isRandom, selectGenreId)
end

function GlorybattleselectteamView:_updateCell(view, cell, genreId, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local btnTip = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnTip")
	local goHead = goutil.findChild(cell.gameObject, "head")
	local goHeadEmpty = goutil.findChild(cell.gameObject, "headEmpty")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtTeamName = goutil.findChildTextComponent(cell.gameObject, "txtTeamName")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local isRandomGenre = self._randomGenreId == genreId

	HeadItemController.instance:resetHeadCell(goHead)
	goutil.setActive(goSelect, self._selectGenreId == genreId)
	goutil.setActive(btnTip.gameObject, not isRandomGenre)
	goutil.setActive(goHeadEmpty, isRandomGenre)

	if isRandomGenre then
		txtTeamName.text = "随机队"
		txtDesc.text = "随机阵容，风险大收益大"
		txtName.text = "未知"
	else
		local cfg = GlorybattleConfig.instance:getGenreCfg(self._activityId, genreId)
		local raceId = GlorybattleConfig.instance:getCutePetRaceId(cfg.cutePetId)
		local cutepetCfg = CutePetConfig.instance:getCutePetById(raceId)
		local proxy = MaterialMgr.setCell(MatType.CutePet, raceId, goHead)

		proxy.binder:setAutoTips(false)

		txtTeamName.text = cfg.teamName
		txtDesc.text = cfg.desc
		txtName.text = cutepetCfg.name
	end

	btn:AddClickListener(function()
		self._selectGenreId = genreId

		self._scrollerList:refresh()
	end)
	btnTip:AddClickListener(function()
		local genreCfg = GlorybattleConfig.instance:getGenreCfg(self._activityId, genreId)

		UIStateManager.instance:push(ViewName.GlorycutepetsimpletipView, genreCfg.cutePetId)
	end)
	self:_handleSubCell(genreId, goTableview, goTablecell)
end

function GlorybattleselectteamView:_handleSubCell(genreId, goTableview, goTablecell)
	local scroll = self:_getScroll(goTableview, goTablecell)
	local list = {}
	local isRandom = genreId == self._randomGenreId
	local currency = 0
	local daiBiMatStr = GlorybattleConfig.instance:getCommonValue("SHOP_COST_MAT")
	local daiBiMatArr = string.split(daiBiMatStr, ":")

	if isRandom then
		for i = 1, 3 do
			table.insert(list, {
				isRandom = true
			})
		end

		currency = GlorybattleConfig.instance:getCommonValue("RANDOM_GENRE_CURRENCY_NUM")
	else
		local genreCfg = GlorybattleConfig.instance:getGenreCfg(self._activityId, genreId)

		for i, v in ipairs(genreCfg.petList) do
			local petMo = GlorybattleModel.instance:getPetMo(self._activityId, v)

			table.insert(list, {
				isPet = true,
				petMo = petMo
			})
		end

		currency = GlorybattleConfig.instance:getCommonValue("FIXED_GENRE_CURRENCY_NUM")
	end

	table.insert(list, {
		isMat = true,
		matStr = string.format("%s:%s:%s", daiBiMatArr[1], daiBiMatArr[2], currency)
	})
	scroll:reloadData(list)
end

function GlorybattleselectteamView:_clearCell(cell)
	local goHead = goutil.findChild(cell.gameObject, "head")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local goHead = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHead)
	MaterialMgr.resetAll(goHead)

	if self._scrollList[goTableview] then
		self._scrollList[goTableview]:dispose()
	end
end

function GlorybattleselectteamView:_getScroll(goTableview, goTablecell)
	local scrollList = self._scrollList[goTableview]

	if not scrollList then
		scrollList = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateSubCell, self), GameUtil.handler(self._clearSubCell, self))
		self._scrollList[goTableview] = scrollList
	end

	return scrollList
end

function GlorybattleselectteamView:_updateSubCell(view, cell, data, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goEmpty = goutil.findChild(cell.gameObject, "empty")

	goutil.setActive(goEmpty, data.isRandom)
	goutil.setActive(goCon, not data.isRandom)

	if data.isPet then
		local proxy = MaterialMgr.setCellByMo(data.petMo, goCon)

		proxy.binder:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(data.petMo)
		end)
	elseif data.isMat then
		MaterialMgr.setCellByCfg(data.matStr, goCon)
	end
end

function GlorybattleselectteamView:_clearSubCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

return GlorybattleselectteamView
