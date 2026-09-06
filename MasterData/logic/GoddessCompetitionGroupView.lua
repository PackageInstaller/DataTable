-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionGroupView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionGroupView", package.seeall)

local GoddessCompetitionGroupView = class("GoddessCompetitionGroupView", ViewComponent)

function GoddessCompetitionGroupView:ctor()
	GoddessCompetitionGroupView.super.ctor(self)
end

function GoddessCompetitionGroupView:unbindEvents()
	GoddessCompetitionGroupView.super.unbindEvents(self)

	for i, cell in ipairs(self._curGoddessList) do
		GameUtil.rmClickHandler(cell.btnVote)
		GameUtil.rmClickHandler(cell.btnInfo)
	end

	for i, cell in ipairs(self._curWinnerList) do
		GameUtil.rmClickHandler(cell.btnInfo)
	end
end

function GoddessCompetitionGroupView:bindEvents()
	GoddessCompetitionGroupView.super.bindEvents(self)

	for i, cell in ipairs(self._curGoddessList) do
		GameUtil.addClickHandler(cell.btnVote, GameUtil.handler(self._onClickVote, self, i))
		GameUtil.addClickHandler(cell.btnInfo, GameUtil.handler(self._onClickInfo, self, i))
	end

	for i, cell in ipairs(self._curWinnerList) do
		GameUtil.addClickHandler(cell.btnInfo, GameUtil.handler(self._onClickWinnerInfo, self, i))
	end
end

function GoddessCompetitionGroupView:buildUI()
	GoddessCompetitionGroupView.super.buildUI(self)

	self._petcell = self:getGo("petcell")
	self._winnercell = self:getGo("winnercell")

	goutil.setActive(self._petcell, false)
	goutil.setActive(self._winnercell, false)

	self._curGoddessList = {}
	self._showLineList = {}

	for i = 1, 8 do
		local name = "pet_1_" .. i
		local parentGo = self:getGo("posList/pos_1_" .. i)
		local parent = parentGo.transform

		self._curGoddessList[i] = self:buildPetCell(parent, name)
		self._showLineList[i] = self:getGo("bg/line/line" .. i)
	end

	self._curWinnerList = {}

	for i = 1, 4 do
		local name = "pet_2_" .. i
		local parentGo = self:getGo("posList/pos_2_" .. i)
		local parent = parentGo.transform

		self._curWinnerList[i] = self:buildWinnerCell(parent, name)
	end
end

function GoddessCompetitionGroupView:buildPetCell(parent, name)
	local cell = {}
	local petGo = goutil.cloneAndSetParent(self._petcell, parent, name)

	GameUtil.setAnchoredPos(petGo, 0, 0)

	cell.txtName = goutil.findChildTextComponent(petGo, "name/txt")
	cell.iconPet = goutil.findChild(petGo, "pet/icon")
	cell.btnVote = goutil.findChild(petGo, "btnVote")
	cell.txtVote = goutil.findChildTextComponent(petGo, "txtVote")
	cell.knockout = goutil.findChild(petGo, "knockout")
	cell.btnInfo = goutil.findChild(petGo, "btnInfo")

	goutil.setActive(petGo, true)

	cell.go = petGo

	return cell
end

function GoddessCompetitionGroupView:buildWinnerCell(parent, name)
	local cell = {}
	local petGo = goutil.cloneAndSetParent(self._winnercell, parent, name)

	GameUtil.setAnchoredPos(petGo, 0, 0)

	cell.txtName = goutil.findChildTextComponent(petGo, "pet/name/txt")
	cell.pet = goutil.findChild(petGo, "pet")
	cell.iconPet = goutil.findChild(petGo, "pet/icon")
	cell.empty = goutil.findChild(petGo, "empty")
	cell.btnVote = goutil.findChild(petGo, "pet/btnVote")
	cell.txtVote = goutil.findChildTextComponent(petGo, "pet/txtVote")

	goutil.setActive(petGo, true)

	cell.go = petGo

	return cell
end

function GoddessCompetitionGroupView:onExit()
	GoddessCompetitionGroupView.super.onExit(self)

	for i, cell in ipairs(self._curGoddessList) do
		MaterialMgr.clearIcon(cell.iconPet)
	end
end

function GoddessCompetitionGroupView:onEnter()
	GoddessCompetitionGroupView.super.onEnter(self)

	self._activityId = GoddessCompetitionModel.instance:getCurActId()
	self._curShowStepId = GoddessCompetitionConfig.instance:getStepIdByStepType(self._activityId, GoddessCompetitionController.Step_Group)

	GoddessCompetitionController.instance:getInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionGetBaseInfoRes, self._updateUIByInfo, self)
end

function GoddessCompetitionGroupView:_updateUIByInfo()
	local baseInfo = GoddessCompetitionModel.instance:getCurActBaseInfo()
	local curStepId = baseInfo.curStepId

	self._curShowInfoList = GoddessCompetitionModel.instance:getCurGoddessList(self._curShowStepId)
	self._isExistResult = curStepId > self._curShowStepId

	for i, cell in ipairs(self._curGoddessList) do
		local info = self._curShowInfoList[i]

		if info then
			MaterialMgr.setIcon(cell.iconPet, MatType.PET_SKIN, info.faceId)

			cell.txtName.text = PetSkinConfig.instance:getPetSkinName(info.faceId)
			cell.txtVote.text = info.popularity

			goutil.setActive(cell.btnVote, not self._isExistResult)

			local isKnockOut = self:_getIsKnockout(i)

			goutil.setActive(cell.knockout, isKnockOut)
			goutil.setActive(self._showLineList[i], self._isExistResult and not isKnockOut)
		else
			MaterialMgr.clearIcon(cell.iconPet)

			cell.txtName.text = "无"
			cell.txtVote.text = 0

			goutil.setActive(cell.btnVote, false)
			goutil.setActive(cell.knockout, false)
			goutil.setActive(self._showLineList[i], false)
		end
	end

	if self._isExistResult then
		local finalStepId = GoddessCompetitionConfig.instance:getStepIdByStepType(self._activityId, GoddessCompetitionController.Step_finals)
		local winnerInfoList = GoddessCompetitionModel.instance:getCurGoddessList(finalStepId)

		for i, cell in ipairs(self._curWinnerList) do
			local info = winnerInfoList[i]

			if info then
				goutil.setActive(cell.pet, true)
				goutil.setActive(cell.empty, false)
				MaterialMgr.setIcon(cell.iconPet, MatType.PET_SKIN, info.faceId)

				cell.txtName.text = PetSkinConfig.instance:getPetSkinName(info.faceId)
				cell.txtVote.text = info.popularity
			else
				goutil.setActive(cell.pet, false)
				MaterialMgr.clearIcon(cell.iconPet)
				goutil.setActive(cell.empty, true)

				cell.txtName.text = "无"
				cell.txtVote.text = 0
			end
		end
	else
		for i, cell in ipairs(self._curWinnerList) do
			goutil.setActive(cell.pet, false)
			goutil.setActive(cell.empty, true)
		end
	end
end

function GoddessCompetitionGroupView:_onClickVote(id)
	local info = self._curShowInfoList[id]

	if not info then
		return
	end

	UIStateManager.instance:push(ViewName.GoddessCompetitionVoteView, info.faceId)
end

function GoddessCompetitionGroupView:_onClickInfo(id)
	local info = self._curShowInfoList[id]

	if not info then
		return
	end

	local faceId = checknumber(info.faceId)
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

function GoddessCompetitionGroupView:_onClickWinnerInfo(id)
	local finalStepId = GoddessCompetitionConfig.instance:getStepIdByStepType(self._activityId, GoddessCompetitionController.Step_finals)
	local winnerInfoList = GoddessCompetitionModel.instance:getCurGoddessList(finalStepId)
	local info = winnerInfoList[id]

	if not info then
		return
	end

	local faceId = checknumber(info.faceId)
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

function GoddessCompetitionGroupView:_getIsKnockout(id)
	if self._isExistResult then
		local info = self._curShowInfoList[id]

		if not info then
			return false
		end

		local checkFaceId = checknumber(info.faceId)
		local finalStepId = GoddessCompetitionConfig.instance:getStepIdByStepType(self._activityId, GoddessCompetitionController.Step_finals)
		local winnerInfoList = GoddessCompetitionModel.instance:getCurGoddessList(finalStepId)

		for i, winerInfo in ipairs(winnerInfoList) do
			if checknumber(winerInfo.faceId) == checkFaceId then
				return false
			end
		end

		return true
	end

	return false
end

return GoddessCompetitionGroupView
