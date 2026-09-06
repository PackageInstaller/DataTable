-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionKnockOutView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionKnockOutView", package.seeall)

local GoddessCompetitionKnockOutView = class("GoddessCompetitionKnockOutView", ViewComponent)
local SORT_NONE = 0
local SORT_POPULARITY_UP = 2

function GoddessCompetitionKnockOutView:ctor()
	GoddessCompetitionKnockOutView.super.ctor(self)

	self._currSearching = nil
end

function GoddessCompetitionKnockOutView:unbindEvents()
	GoddessCompetitionKnockOutView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSort)
	GameUtil.rmClickHandler(self._btnFilter)
	self._inputSearch:RemoveOnValueChanged()
	self._InputC_Search_Clear:RemoveClickListener()
end

function GoddessCompetitionKnockOutView:bindEvents()
	GoddessCompetitionKnockOutView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
	self._InputC_Search_Clear:AddClickListener(self._onClearSearchClick, self)
end

function GoddessCompetitionKnockOutView:buildUI()
	GoddessCompetitionKnockOutView.super.buildUI(self)

	local petCellGo = self:getGo("petCom/petCell")
	local tabGo = self:getGo("petCom/tableview")

	self._tableview = ScrollerList.create(tabGo, petCellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnSort = self:getGo("btnSort")
	self._imgChangeSort = self:getGo("btnSort/ImgSort"):GetComponent(ComponentType.UIImageSpriteChange)
	self._btnFilter = self:getGo("btnFilter")
	self._inputSearch = self:getInput("InputC_Search")
	self._InputC_Search_Clear = self:getBtn("InputC_Search/BtnClear")
end

function GoddessCompetitionKnockOutView:onExit()
	GoddessCompetitionKnockOutView.super.onExit(self)
	self._tableview:dispose()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PET_FILES)
end

function GoddessCompetitionKnockOutView:onEnter()
	GoddessCompetitionKnockOutView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetBaseInfoRes, self._updateUIByInfo, self)
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PET_FILES)

	self._activityId = GoddessCompetitionModel.instance:getCurActId()
	self._curShowStepId = checknumber(self:getFirstParam())
	self._sortType = SORT_NONE

	self:_randomSort()
	GoddessCompetitionController.instance:getInfo(self._activityId)
end

function GoddessCompetitionKnockOutView:_updateUIByInfo()
	local baseInfo = GoddessCompetitionModel.instance:getCurActBaseInfo()
	local curStepId = baseInfo.curStepId

	self._curShowInfoList = GoddessCompetitionModel.instance:getCurGoddessList(self._curShowStepId)
	self._isShowStepMatchTime = self._curShowStepId == curStepId
	self._isShowStepPass = curStepId > self._curShowStepId

	if self._isShowStepPass then
		self._curNextStepInfoList = GoddessCompetitionModel.instance:getCurGoddessList(self._curShowStepId + 1)
	end

	self:_updateList()
end

function GoddessCompetitionKnockOutView:_updateList()
	local datalist = {}

	for i, v in ipairs(self._curShowInfoList) do
		if self:_onFilter(v.faceId) == true then
			table.insert(datalist, v)
		end
	end

	if self._sortType == SORT_NONE then
		local randSortMap = GoddessCompetitionModel.instance:getRandSortMap()

		randSortMap = randSortMap or GoddessCompetitionModel.instance:setRandSortMap(self._activityId)

		ArraySort.sortOn(datalist, {
			function(a)
				if self:_getIsMoreLike(a.faceId) then
					return (GoddessCompetitionConfig.instance:getGoddessSortId(self._activityId, a.faceId))
				else
					return 1000
				end
			end,
			function(a)
				if self:_getIsPass(a.faceId) then
					return 0
				end

				return 1
			end,
			function(a)
				return randSortMap[a.faceId] or 0
			end,
			function(a)
				return a.faceId
			end
		})
	else
		ArraySort.sortOn(datalist, {
			function(a)
				if self:_getIsMoreLike(a.faceId) then
					return (GoddessCompetitionConfig.instance:getGoddessSortId(self._activityId, a.faceId))
				else
					return 1000
				end
			end,
			function(a)
				if self._sortType == SORT_POPULARITY_UP then
					return checknumber(a.popularity)
				else
					return -checknumber(a.popularity)
				end
			end,
			function(a)
				return checknumber(a.timestamp)
			end
		})
	end

	self._imgChangeSort:SetState(self._sortType)
	self._tableview:reloadData(datalist)
end

function GoddessCompetitionKnockOutView:_updateCell(view, cell, data)
	local petIcon = goutil.findChild(cell, "pet/petIcon")
	local txtName = goutil.findChildTextComponent(cell, "name/txt")
	local txtVoteNum = goutil.findChildTextComponent(cell, "voteNum/txt")
	local btnVote = goutil.findChild(cell, "btnVote")

	GameUtil.addClickHandler(btnVote, GameUtil.handler(self._onClickVote, self, data))

	local faceId = checknumber(data.faceId)
	local modelCo = CharacterConfig.instance:getModelCo(faceId)

	uGuiUtil.setSpriteToImage(petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	txtName.text = PetSkinConfig.instance:getPetSkinName(faceId)
	txtVoteNum.text = langPara("人气：%s", data.popularity)

	goutil.setActive(btnVote, self._isShowStepMatchTime)

	local pass = goutil.findChild(cell, "pass")
	local btnMoreLike = goutil.findChild(cell, "btnMoreLike")
	local btnInfo = goutil.findChild(cell, "btnInfo")

	GameUtil.addClickHandler(btnInfo, GameUtil.handler(self._onClickInfo, self, data))
	GameUtil.addClickHandler(btnMoreLike, GameUtil.handler(self._onClickMoreLike, self, data))

	local isMoreLike = self:_getIsMoreLike(faceId)

	GameUtil.setUIImageSpriteIdx(btnMoreLike, isMoreLike and 1 or 0)
	goutil.setActive(pass, self:_getIsPass(faceId))
end

function GoddessCompetitionKnockOutView:_clearCell(cell)
	local btnVote = goutil.findChild(cell, "btnVote")
	local petIcon = goutil.findChild(cell, "pet/petIcon")

	GameUtil.rmClickHandler(btnVote)
	uGuiUtil.clearImage(petIcon)

	local btnMoreLike = goutil.findChild(cell, "btnMoreLike")
	local btnInfo = goutil.findChild(cell, "btnInfo")

	GameUtil.rmClickHandler(btnMoreLike)
	GameUtil.rmClickHandler(btnInfo)
end

function GoddessCompetitionKnockOutView:_onClickVote(data)
	UIStateManager.instance:push(ViewName.GoddessCompetitionVoteView, data.faceId)
end

function GoddessCompetitionKnockOutView:_onClickInfo(data)
	local faceId = checknumber(data.faceId)
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(faceId)
	local raceId = petSkinCfg and petSkinCfg.raceId

	if faceId == raceId then
		PetbookController.instance:openPetinfoView(raceId)
	else
		PetbookController.instance:gotoSkinView({
			faceId
		})
	end
end

function GoddessCompetitionKnockOutView:_onClickMoreLike(data)
	local userDataKey = string.format("%s_%s_%s_%s", ViewName.GoddessCompetitionKnockOutView, self._activityId, self._curShowStepId, checknumber(data.faceId))
	local keepValue = checknumber(GameUtil.getUserData(userDataKey))
	local saveValue = keepValue > 0 and 0 or 1

	GameUtil.saveUserData(userDataKey, saveValue)
	self:_updateList()
end

function GoddessCompetitionKnockOutView:_getIsMoreLike(faceId)
	local userDataKey = string.format("%s_%s_%s_%s", ViewName.GoddessCompetitionKnockOutView, self._activityId, self._curShowStepId, checknumber(faceId))

	return checknumber(GameUtil.getUserData(userDataKey)) > 0
end

function GoddessCompetitionKnockOutView:_getIsPass(faceId)
	local faceId = checknumber(faceId)

	if self._isShowStepPass then
		local nextStepId = self._curShowStepId + 1
		local stepType = GoddessCompetitionConfig.instance:getStepTypeByStepId(self._activityId, self._curShowStepId)
		local nextStepType = GoddessCompetitionConfig.instance:getStepTypeByStepId(self._activityId, nextStepId)
		local nextStepInfoList = GoddessCompetitionModel.instance:getCurGoddessList(nextStepId)

		if nextStepType == GoddessCompetitionController.instance.Step_Resurrection then
			for _, info in ipairs(nextStepInfoList) do
				if checknumber(info.faceId) == faceId then
					return false
				end
			end

			return true
		elseif nextStepType == GoddessCompetitionController.instance.Step_Group then
			for _, info in ipairs(nextStepInfoList) do
				if checknumber(info.faceId) == faceId then
					return true
				end
			end

			return false
		else
			return true
		end
	else
		return false
	end
end

function GoddessCompetitionKnockOutView:_onClickSort()
	self._sortType = self._sortType + 1

	if self._sortType > SORT_POPULARITY_UP then
		self._sortType = SORT_NONE
	end

	self:_updateList()
end

function GoddessCompetitionKnockOutView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._currSearching then
		self._currSearching = text

		self:_updateList()
	end
end

function GoddessCompetitionKnockOutView:_onClearSearchClick()
	self._inputSearch.input.text = ""
end

function GoddessCompetitionKnockOutView:_onClickFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PET_FILES, pos, sizeDelta, GameUtil.handler(self._updateFilterData, self))
end

function GoddessCompetitionKnockOutView:_updateFilterData(starList, jobList, rareList)
	self:_updateList()
end

function GoddessCompetitionKnockOutView:_onFilter(faceId)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(faceId)
	local cfg = MaterialMgr.getMatCfg(MatType.Pet, skinCfg.raceId)
	local isHit = false

	isHit = PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PET_FILES, cfg)

	local skinName = PetSkinConfig.instance:getPetSkinName(faceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(skinName, str)

		if not count then
			return false
		end
	end

	return isHit
end

function GoddessCompetitionKnockOutView:_randomSort()
	self._randSortMap = {}

	local goddessCfgs = GoddessCompetitionConfig.instance:getGoddessCfgs(self._activityId)
	local goddessList = {}

	for i, v in ipairs(goddessCfgs) do
		table.insert(goddessList, v.goddessFaceId)
	end

	goddessList = GameUtil.permuteArray(goddessList)

	for i, v in ipairs(goddessList) do
		self._randSortMap[v] = i
	end
end

return GoddessCompetitionKnockOutView
