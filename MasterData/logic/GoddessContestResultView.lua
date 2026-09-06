-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestResultView.lua

module("logic.extensions.goddesscontest.view.GoddessContestResultView", package.seeall)

local GoddessContestResultView = class("GoddessContestResultView", ViewComponent)

function GoddessContestResultView:buildUI()
	GoddessContestResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._groupCom = self:getGo("groupCom")
	self._layoutComGroup = goutil.findChild(self._groupCom, "layoutCom")
	self._cellGroup = goutil.findChild(self._groupCom, "cell")

	goutil.setActive(self._cellGroup, false)

	self._txtDescGroup = goutil.findChildTextComponent(self._groupCom, "txtDesc")
	self._btnSureGroup = goutil.findChild(self._groupCom, "btnSure")
	self._goddessCom = self:getGo("goddessCom")
	self._txtDescGoddess = goutil.findChildTextComponent(self._goddessCom, "txtDesc")
	self._txtVoteNum = goutil.findChildTextComponent(self._goddessCom, "petCell/voteNum/txt")
	self._txtGoddessName = goutil.findChildTextComponent(self._goddessCom, "petCell/name/txt")
	self._petIconGoddess = goutil.findChild(self._goddessCom, "petCell/pet/petIcon")
	self._btnSureGoddess = goutil.findChild(self._goddessCom, "btnSure")
end

function GoddessContestResultView:bindEvents()
	GoddessContestResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSureGroup, self._onClickBtnSureGroup, self)
	GameUtil.addClickHandler(self._btnSureGoddess, self._onClickBtnSureGoddess, self)
end

function GoddessContestResultView:unbindEvents()
	GoddessContestResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSureGroup)
	GameUtil.rmClickHandler(self._btnSureGoddess)
end

function GoddessContestResultView:onEnter()
	GoddessContestResultView.super.onEnter(self)

	self._curActId = GoddessContestModel.instance:getCurActId()
	self._groupCfgs = GoddessContestConfig.instance:getFanGroupCfgsByActId(self._curActId)
	self._groupInfosByRank = GoddessContestModel.instance:getGroupInfosByRank()
	self._winGoddessInfo = GoddessContestModel.instance:getWinGoddessInfo()

	self:_refreshView()
	goutil.setActive(self._groupCom, true)
	goutil.setActive(self._goddessCom, false)
end

function GoddessContestResultView:onExit()
	GoddessContestResultView.super.onExit(self)
	uGuiUtil.clearImage(self._petIconGoddess)
end

function GoddessContestResultView:_refreshView()
	self._cellList = {}

	for rank, info in ipairs(self._groupInfosByRank) do
		self._cellList[rank] = self:_refreshCell(rank)
	end

	local faceId = checknumber(self._winGoddessInfo.faceId)
	local modelCo = CharacterConfig.instance:getModelCo(faceId)

	uGuiUtil.clearImage(self._petIconGoddess)
	uGuiUtil.setSpriteToImage(self._petIconGoddess, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	self._txtGoddessName.text = PetSkinConfig.instance:getPetSkinName(faceId)
	self._txtDescGoddess.text = PetSkinConfig.instance:getPetSkinName(faceId)
	self._txtVoteNum.text = langPara("人气值：%s", self._winGoddessInfo.popularityValue)
end

function GoddessContestResultView:_refreshCell(rank)
	local cell = {}

	cell.go = goutil.findChild(self._layoutComGroup, "cell_" .. rank) or goutil.cloneAndSetParent(self._cellGroup, self._layoutComGroup.transform, "cell_" .. rank)
	cell.txtVoteNum = goutil.findChildTextComponent(cell.go, "voteNum/txt")
	cell.iconTitle = goutil.findChildComponent(cell.go, "title/icon", "UIImageSpriteChange")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "title/txt")
	cell.txtGroup = goutil.findChildTextComponent(cell.go, "group/txt")
	cell.imgRank = goutil.findChildComponent(cell.go, "imgRank", "UIImageSpriteChange")

	local data = self._groupInfosByRank[rank]
	local cfg = self._groupCfgs[data.groupId]

	cell.imgRank:SetState(rank - 1)
	cell.iconTitle:SetState(data.groupId - 1)

	cell.txtVoteNum.text = langPara("人气值：%s", data.totalPower)
	cell.txtTitle.text = cfg.fansGroupName
	cell.txtGroup.text = cfg.fansGroupName

	goutil.setActive(cell.go, true)

	if rank == 1 then
		self._txtDescGroup.text = cfg.fansGroupName
	end

	return cell
end

function GoddessContestResultView:_onClickBtnSureGroup()
	goutil.setActive(self._groupCom, false)
	goutil.setActive(self._goddessCom, true)
end

function GoddessContestResultView:_onClickBtnSureGoddess()
	self:close()
	GoddessContestModel.instance:setUserIsFirstOpen(GoddessContestModel.GoddessResultTipKey)
	UIStateManager.instance:push(ViewName.GoddessContestWinnerView)
end

return GoddessContestResultView
