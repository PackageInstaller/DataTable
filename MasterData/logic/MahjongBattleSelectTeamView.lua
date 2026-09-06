-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleSelectTeamView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleSelectTeamView", package.seeall)

local MahjongBattleSelectTeamView = class("MahjongBattleSelectTeamView", ViewComponent)

function MahjongBattleSelectTeamView:ctor()
	MahjongBattleSelectTeamView.super.ctor(self)
end

function MahjongBattleSelectTeamView:unbindEvents()
	MahjongBattleSelectTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function MahjongBattleSelectTeamView:bindEvents()
	MahjongBattleSelectTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function MahjongBattleSelectTeamView:buildUI()
	MahjongBattleSelectTeamView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnSure = self:getGo("btnSure")
	self._subtablecell = self:getGo("subtablecell")

	local goTab = self:getGo("tableview")
	local goCell = self:getGo("tablecell")

	self._tableview = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._subTableviewDic = {}
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
end

function MahjongBattleSelectTeamView:onExit()
	MahjongBattleSelectTeamView.super.onExit(self)
	self._tableview:dispose()
end

function MahjongBattleSelectTeamView:onEnter()
	MahjongBattleSelectTeamView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleSelectGenreRes, self._handleSelectGenreRes, self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleGetInfoRes, self._handleGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.MahjongBattleTeachDataChange, self._handleChangeTeachStage, self)

	self._curSelectId = -1
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 571001
	end

	if not self:_checkState() then
		self:close()
		MahjongBattleController.instance:continueGame(self._activityId)

		return
	end

	self._actCfg = MahjongBattleConfig.instance:getActivityCfg(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_updateUIByInfo()
end

function MahjongBattleSelectTeamView:_updateUIByInfo()
	self._curGenreIds = MahjongBattleModel.instance:getCurGenreIdsByActId(self._activityId)

	table.insert(self._curGenreIds, 0)

	self._teamPetIdsMap = {}
	self._sortIdMap = {}

	for i, genreId in ipairs(self._curGenreIds) do
		self._sortIdMap[genreId] = i

		local petDataList = {}

		if genreId == 0 then
			petDataList = {}

			for i = 1, 3 do
				table.insert(petDataList, {
					petId = 0,
					genreId = genreId
				})
			end
		else
			local genreCfg = MahjongBattleConfig.instance:getGenreCfg(self._activityId, genreId)

			if genreCfg then
				if not genreCfg.petList then
					for i, petId in ipairs(genreCfg.petList) do
						table.insert(petDataList, {
							genreId = genreId,
							petId = petId
						})
					end
				end
			end
		end

		self._teamPetIdsMap[genreId] = petDataList
	end

	self._tableview:reloadData(self._curGenreIds)
	self:_refreshBtnState()
end

function MahjongBattleSelectTeamView:_refreshBtnState()
	self._isSelected = false

	for i, genreId in ipairs(self._curGenreIds) do
		if genreId == self._curSelectId then
			self._isSelected = true

			break
		end
	end

	GameUtil.SetGray(self._btnSure, not self._isSelected)
end

function MahjongBattleSelectTeamView:_onClickBtnSure()
	if not self._isSelected then
		FloatWordMgr.instance:show("请选择阵容")

		return
	end

	local isRandom = self._curSelectId == 0
	local selectGenreId = isRandom and 0 or self._curSelectId

	if MahjongBattleController.instance:getIsTeachMode() then
		MahjongBattleController.instance:enterNextTeachStage(self._activityId)

		return
	end

	MahjongBattleController.instance:selectGenre(self._activityId, isRandom, selectGenreId)
end

function MahjongBattleSelectTeamView:_handleSelectGenreRes()
	MahjongBattleController.instance:getInfo(self._activityId)
end

function MahjongBattleSelectTeamView:_handleGetInfoRes()
	if not self:_checkState() then
		self:close()
		MahjongBattleController.instance:continueGame(self._activityId)
	end
end

function MahjongBattleSelectTeamView:_checkState()
	local curState = MahjongBattleModel.instance:getCurStateByActId(self._activityId)

	if curState == MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_TEAM then
		return true
	end

	return false
end

function MahjongBattleSelectTeamView:_updateCell(view, cell, data, tag)
	local genreId = checknumber(data)

	if not self._sortIdMap[genreId] then
		local genreCfg = MahjongBattleConfig.instance:getGenreCfg(self._activityId, genreId)
		local go = cell.gameObject
		local goSubTab = goutil.findChild(go, "subtable")
		local goSelect = goutil.findChild(go, "select")
		local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local btn = goutil.findChild(go, "btn")

		go.name = "cell_" .. self._sortIdMap[genreId]

		if genreId == 0 then
			txtName.text = lang("随机队")
			txtDesc.text = lang("随机阵容，风险大收益大")
		elseif genreCfg then
			txtName.text = genreCfg.teamName or ""
			txtDesc.text = genreCfg.desc or ""
		else
			txtName.text = ""
			txtDesc.text = ""
		end

		goutil.setActive(goSelect, self._curSelectId == genreId)
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickSelectGenre, self, genreId))

		local subTableview = self._subTableviewDic[go]

		if not subTableview then
			subTableview = ScrollerList.create(goSubTab, self._subtablecell, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
			self._subTableviewDic[go] = subTableview
		end

		if not self._teamPetIdsMap[genreId] then
			local petDataList = {}

			subTableview:setCenterMode(true)
			subTableview:dragNotifyParent()
			subTableview:reloadData(petDataList)
		end
	end
end

function MahjongBattleSelectTeamView:_clearCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)

	local subTableview = self._subTableviewDic[go]

	if subTableview then
		subTableview:dispose()

		self._subTableviewDic[go] = nil
	end
end

function MahjongBattleSelectTeamView:_updateCellPet(view, cell, data)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local emptyGo = goutil.findChild(go, "empty")

	GameUtil.SetActive(emptyGo, true)

	local btn = goutil.findChild(go, "empty/btn")
	local creepId = checknumber(data.petId)

	if creepId > 0 then
		local petMo = MahjongBattleModel.instance:getPetMo(self._activityId, creepId, 0)

		if petMo then
			GameUtil.SetActive(emptyGo, false)

			local proxy = MaterialMgr.setCellByMo(petMo, con)

			proxy.binder:setCallBack(function()
				CommonTipsMgr.instance:showPetTips(petMo)
				self:_onClickSelectGenre(data.genreId)
			end)
		end
	else
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickSelectGenre, self, data.genreId))
	end
end

function MahjongBattleSelectTeamView:_clearCellPet(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)

	local btn = goutil.findChild(go, "empty/btn")

	GameUtil.rmClickHandler(btn)
end

function MahjongBattleSelectTeamView:_onClickSelectGenre(genreId)
	if self._curSelectId == genreId then
		return
	end

	self._curSelectId = genreId

	self._tableview:reloadData(self._curGenreIds)
	self:_refreshBtnState()
end

function MahjongBattleSelectTeamView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function MahjongBattleSelectTeamView:_handleChangeTeachStage()
	self:_handleGetInfoRes()
end

return MahjongBattleSelectTeamView
