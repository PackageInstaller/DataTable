-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestGroupVoteView.lua

module("logic.extensions.goddesscontest.view.GoddessContestGroupVoteView", package.seeall)

local GoddessContestGroupVoteView = class("GoddessContestGroupVoteView", ViewComponent)

function GoddessContestGroupVoteView:buildUI()
	GoddessContestGroupVoteView.super.buildUI(self)

	self._goddessCell = self:getGo("petCom/petCell")
	self._goddessView = self:getGo("petCom/petview")

	goutil.setActive(self._goddessCell, false)

	self._iconGroup = self:getGo("info/group/icon"):GetComponent("UIImageSpriteChange")
	self._txtTitle = self:getTxt("info/group/txtTitle")
	self._txtGroup = self:getTxt("info/group/txtGroup")
	self._txtDesc1 = self:getTxt("info/desc/desc1/Viewport/Content")
	self._txtDesc2 = self:getTxt("info/desc/desc2/Viewport/Content")
	self._txtVoteNum = self:getTxt("info/desc/txtVoteNum")
	self._txtMemberNum = self:getTxt("info/desc/txtMemberNum")
end

function GoddessContestGroupVoteView:bindEvents()
	GoddessContestGroupVoteView.super.bindEvents(self)
end

function GoddessContestGroupVoteView:unbindEvents()
	GoddessContestGroupVoteView.super.unbindEvents(self)
end

function GoddessContestGroupVoteView:onEnter()
	GoddessContestGroupVoteView.super.onEnter(self)

	self._curActId = GoddessContestModel.instance:getCurActId()
	self._actCfg = GoddessContestConfig.instance:getActCfgByActId(self._curActId)
	self._groupCfg = GoddessContestConfig.instance:getFanGroupCfgsByActIdAndGroupId(self._curActId, GoddessContestModel.instance:getCurGroupId())

	local costParms = string.splitToNumber(self._actCfg.goddessVoteItemId, ":")

	self._costVoteType = costParms[1]
	self._costVoteId = costParms[2]

	self._iconGroup:SetState(self._groupCfg.fansGroupId - 1)

	self._txtTitle.text = self._groupCfg.fansGroupName
	self._txtGroup.text = self._groupCfg.fansGroupName
	self._txtDesc1.text = GoddessContestConfig.instance:getCommondValueByKey("VOTE_DESC_1")
	self._txtDesc2.text = GoddessContestConfig.instance:getCommondValueByKey("VOTE_DESC_2")

	self:_refreshView()
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestGetGroupInfo, self._refreshGoddessCellList, self)
	GlobalDispatcher:addListener(GlobalNotify.GoddessContestVoteToGoddess, self._onSucVote, self)
end

function GoddessContestGroupVoteView:onExit()
	GoddessContestGroupVoteView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestGetGroupInfo, self._refreshGoddessCellList, self)
	GlobalDispatcher:removeListener(GlobalNotify.GoddessContestVoteToGoddess, self._onSucVote, self)
end

function GoddessContestGroupVoteView:_onError(status)
	return
end

function GoddessContestGroupVoteView:_refreshGoddessCellList()
	self._curGroupInfo = GoddessContestModel.instance:getCurFansGroupInfo()

	for id, cell in ipairs(self._cellList) do
		cell.data = self._curGroupInfo.voteDataHash[cell.skinId]

		if cell.data then
			cell.txtVoteNum.text = langPara("人气值：%s", cell.data.popularityValue)
		end
	end

	self._txtVoteNum.text = GoddessContestModel.instance:getCurGoddessVoteNums()
	self._txtMemberNum.text = GoddessContestModel.instance:getVotePower()
end

function GoddessContestGroupVoteView:_refreshView()
	self:_createCellList()
	self:_refreshGoddessCellList()
end

function GoddessContestGroupVoteView:_createCell(id, skinId)
	local cell = {}

	cell.go = goutil.findChild(self._goddessView, "cell_" .. id) or goutil.cloneAndSetParent(self._goddessCell, self._goddessView.transform, "cell_" .. id)
	cell.skinId = skinId
	cell.data = nil
	cell.iconSkin = goutil.findChild(cell.go, "pet/petIcon")
	cell.txtName = goutil.findChildTextComponent(cell.go, "name/txt")
	cell.txtVoteNum = goutil.findChildTextComponent(cell.go, "voteNum/txt")
	cell.txtCost = goutil.findChildTextComponent(cell.go, "txtCost")
	cell.iconCost = goutil.findChild(cell.go, "txtCost/icon")
	cell.btnVote = goutil.findChild(cell.go, "btnVote")

	uGuiUtil.clearImage(cell.iconSkin)

	local faceId = checknumber(skinId)
	local modelCo = CharacterConfig.instance:getModelCo(faceId)

	uGuiUtil.setSpriteToImage(cell.iconSkin, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	cell.txtName.text = PetSkinConfig.instance:getPetSkinName(faceId)
	cell.txtCost.text = 1
	cell.txtVoteNum.text = langPara("人气值：%s", 0)

	MaterialMgr.resetAll(cell.iconCost)
	MaterialMgr.setIcon(cell.iconCost, self._costVoteType, self._costVoteId)
	GameUtil.rmClickHandler(cell.btnVote)
	GameUtil.rmClickHandler(cell.iconSkin)
	GameUtil.addClickHandler(cell.btnVote, GameUtil.handler(self._onClickVote, self, faceId))
	GameUtil.addClickHandler(cell.iconSkin, GameUtil.handler(self._onClickCheck, self, faceId))
	goutil.setActive(cell.go, true)

	return cell
end

function GoddessContestGroupVoteView:_createCellList()
	self._cellList = {}

	if self._groupCfg then
		if not self._groupCfg.fansGroupGoddess then
			local skinIds = {}

			for id, skinId in ipairs(skinIds) do
				self._cellList[id] = self:_createCell(id, skinId)
			end
		end
	end
end

function GoddessContestGroupVoteView:_onClickVote(faceId)
	if GoddessContestModel.instance:getIsTime("GODDESS_VOTE_TIME") then
		local content = langPara("每消耗1个%s可进行1次投票，请选择投票数量", MaterialMgr.getMaterialsName(self._costVoteType, self._costVoteId))
		local matNum = MaterialModel.instance:getMaterialsNumber(self._costVoteType, self._costVoteId)

		TipsFacade.instance:openPopupCostAdjustView(self._costVoteType, self._costVoteId, matNum, content, function(num)
			GoddessContestController.instance:voteToGoddess(faceId, num)
		end)
	else
		FloatWordMgr.instance:show("投票活动未开始或已结束")
	end
end

function GoddessContestGroupVoteView:_onSucVote()
	FloatWordMgr.instance:show(langPara("投票成功,给女神增加了%s点人气值！", GoddessContestModel.instance:getCurAddPower()))
	self:_refreshGoddessCellList()
end

function GoddessContestGroupVoteView:_onClickCheck(faceId)
	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, faceId)
end

return GoddessContestGroupVoteView
