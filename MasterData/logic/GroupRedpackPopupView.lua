-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupRedpackPopupView.lua

module("logic.extensions.groupredpack.view.GroupRedpackPopupView", package.seeall)

local GroupRedpackPopupView = class("GroupRedpackPopupView", ViewComponent)
local PopUpType = {
	Close = 1,
	Open = 2
}
local EffectPath = {
	OpenEffect = "20230303/hongbao/fx_ui_hongbao_dakai.prefab",
	CloseEffect = "20230303/hongbao/fx_ui_hongbao_lingqu.prefab"
}

function GroupRedpackPopupView:ctor()
	GroupRedpackPopupView.super.ctor(self)
end

function GroupRedpackPopupView:unbindEvents()
	GroupRedpackPopupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._cGoClose)
	GameUtil.rmClickHandler(self._btnClose)
end

function GroupRedpackPopupView:bindEvents()
	GroupRedpackPopupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._cGoClose, self._onClickOpen, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function GroupRedpackPopupView:buildUI()
	GroupRedpackPopupView.super.buildUI(self)

	self._btnClose = self:getBtn("clickBtn")
	self._cGoClose = self:getGo("closeGo")
	self._cGoHead = goutil.findChild(self._cGoClose, "headGo")
	self._cGoPetHead = goutil.findChild(self._cGoClose, "goddessHeadGo/headIcon")
	self._cTxtName = goutil.findChildTextComponent(self._cGoClose, "nameGo/nameTxt")
	self._cTxtPrize = goutil.findChildTextComponent(self._cGoClose, "prize/descTxt")
	self._oGoOpenCol = self:getGo("openCol")
	self._oGoOpen = self:getGo("openCol/openGo")
	self._oGoHead = goutil.findChild(self._oGoOpen, "headGo")
	self._oTxtName = goutil.findChildTextComponent(self._oGoOpen, "nameGo/nameTxt")
	self._oTxtDesc = goutil.findChildTextComponent(self._oGoOpen, "descGo/descTxt")
	self._oBtnVote = goutil.findChildButtonComponent(self._oGoOpen, "btnVote")
	self._petCon = self:getGo("openCol/petCard/pet/petIcon")
	self._effShowGo = self:getGo("effShowGo")
	self._goContinue = self:getGo("continue")
	self._tableview = self:getGo("openCol/openGo/itemListSR")
	self._tablecell = self:getGo("openCol/openGo/recordItem")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GroupRedpackPopupView:onExit()
	GroupRedpackPopupView.super.onExit(self)
	self._scrollList:dispose()
	MaterialMgr.resetAll(self._cGoPetHead)
	uGuiUtil.clearImage(self._petCon)
	uGuiUtil.clearImage(self._cGoClose)
	uGuiUtil.clearImage(self._oGoOpen)
	HeadItemController.instance:resetHeadCell(self._cGoHead)
	HeadItemController.instance:resetHeadCell(self._oGoHead)
	GameUtil.SetActive(self._cGoClose, false)
	GameUtil.SetActive(self._oGoOpenCol, false)
	GameUtil.SetActive(self._goContinue, false)
	self:_removeCellEff(self._effShowGo)
	self:_removeCellEff(self._effShowGo)
	GlobalDispatcher:removeListener(GlobalNotify.GroupRedPackGrapRes, self._initData, self)
	GlobalDispatcher:removeListener(GlobalNotify.GroupRedPackGetInfoRes, self._checkRedpackState, self)
end

function GroupRedpackPopupView:onEnter()
	GroupRedpackPopupView.super.onEnter(self)

	local param = self:getOpenParam()

	self._redPackInfo = param[1]
	self._activityId = GroupRedpackModel.instance:getActivityId()
	self._cfgs = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(self._activityId)
	self._changeSetId = 0
	self._userId = tostring(RoleModel.instance:getUserId())
	self._groupId = GroupRedpackModel.instance:getGroupId()
	self._checkData = false

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.Goddess_Contest)

	if actCfg then
		self._goddessContestActId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.GroupRedPackGrapRes, self._initData, self)
	GlobalDispatcher:addListener(GlobalNotify.GroupRedPackGetInfoRes, self._checkRedpackState, self)
	GroupRedpackController.instance:sendGroupRedPackGetInfoReq(self._activityId)
end

function GroupRedpackPopupView:_checkRedpackState()
	if self._checkData then
		self:_refreshView()

		return
	end

	local realRedpackInfo = GroupRedpackModel.instance:getRedpackById(self._redPackInfo.redPackId)

	if not realRedpackInfo then
		TipsFacade.instance:openCommonTips("该红包不存在")
		self:close()
	end

	local isExpire = GroupRedpackController.instance:isExpire(realRedpackInfo)
	local isTodayGainLimit = GroupRedpackController.instance:isTodayGainLimit(realRedpackInfo)
	local popularValue = GroupRedpackModel.instance:getPopularValue()
	local grabLimitValue = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(self._activityId).gainParam

	if checknumber(popularValue) < checknumber(grabLimitValue) then
		TipsFacade.instance:openCommonTips(string.format("人气值需达到%s才能抢红包", grabLimitValue))
		self:close()
	end

	if isExpire then
		TipsFacade.instance:openCommonTips("该红包已过期")
		self:close()
	elseif isTodayGainLimit then
		TipsFacade.instance:openCommonTips("当日领取该类型红包已达上限")
		self:close()
	elseif realRedpackInfo.state == 1 then
		TipsFacade.instance:openCommonTips("该红包已领取")
		self:close()
	elseif realRedpackInfo.remainCount <= 0 then
		TipsFacade.instance:openCommonTips("该红包已领完")
		self:close()
	end

	self._checkData = true

	GroupRedpackController.instance:sendGroupRedPackGrapReq(self._activityId, self._redPackInfo.redPackId, self._redPackInfo.type)
end

function GroupRedpackPopupView:_initData(grabSuc, changeSetId, prizeStrList)
	self._grabSuc = grabSuc

	if grabSuc then
		self._popupType = PopUpType.Close or PopUpType.Open
	end

	self._changeSetId = changeSetId

	if not self._grabSuc then
		TipsFacade.instance:openCommonTips("该红包已领完")
		self:close()
	end

	local cfg = GroupRedpackConfig.instance:getGroupRedpackPlanCfgsById(self._cfgs.redPackPlanId, self._redPackInfo.type)
	local imgPath = string.split(cfg.imgPath, "#")
	local imgClose, imgOpen = imgPath[4], imgPath[5]

	uGuiUtil.setSpriteToImage(self._cGoClose, uGuiUtil.SpriteType.BigBg, GameUrl.getGoddessRedpackUrl(imgClose))
	uGuiUtil.setSpriteToImage(self._oGoOpen, uGuiUtil.SpriteType.BigBg, GameUrl.getGoddessRedpackUrl(imgOpen))
end

function GroupRedpackPopupView:_refreshView()
	GameUtil.SetActive(self._cGoClose, self._popupType == PopUpType.Close)
	GameUtil.SetActive(self._oGoOpenCol, self._popupType == PopUpType.Open)
	GameUtil.SetActive(self._goContinue, self._popupType == PopUpType.Open)

	local redpackCfg = GroupRedpackConfig.instance:getGroupRedpackPlanCfgsById(self._cfgs.redPackPlanId, self._redPackInfo.type)

	if self._popupType == PopUpType.Close then
		local proxy = MaterialMgr.setIcon(self._cGoPetHead, MatType.PET_SKIN, self._redPackInfo.coverId)

		if proxy then
			proxy.binder:setAutoTips(false)
		end

		HeadItemController.instance:setHeadCellByInfo(self._cGoHead, self._redPackInfo.headInfo)

		self._cTxtName.text = string.format("%s-%s", self._redPackInfo.areaId, self._redPackInfo.headInfo.userName)

		local type, id, num = MaterialMgr.getMatParams(redpackCfg.sendItem)

		self._cTxtPrize.text = num

		local isRed = redpackCfg.type <= 3

		GameUtil.setUITextColorIdx(self._cTxtPrize, isRed and 0 or 1)
		self:_playCellEff(self._effShowGo, EffectPath.CloseEffect, 0, 0, true, nil)
	else
		local petId = self._redPackInfo.coverId
		local petCo = CharacterConfig.instance:getModelCo(checknumber(petId))

		uGuiUtil.setSpriteToImage(self._petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(petCo.cardName))

		local realRedpackInfo = GroupRedpackModel.instance:getRedpackById(self._redPackInfo.redPackId)

		if realRedpackInfo.state == 2 and GroupRedpackController.instance:isTodayCoinGainLimit(realRedpackInfo) then
			TipsFacade.instance:openCommonTips("金币领取达到上限")
			self:close()
		end

		HeadItemController.instance:setHeadCellByInfo(self._oGoHead, realRedpackInfo.headInfo)

		self._oTxtName.text = self._redPackInfo.headInfo.userName

		local getedCount = redpackCfg.redPackCount - checknumber(realRedpackInfo.remainCount)
		local content = string.format("当前领取情况：%s/%s个", getedCount, redpackCfg.redPackCount)

		if realRedpackInfo.state == 2 then
			content = content .. "/n手慢啦，没抢上哦"
		end

		self._oTxtDesc.text = content

		local realAccountList = realRedpackInfo.accountList
		local myRedpackRecord

		for i, v in ipairs(realAccountList) do
			if v.headInfo.userId == self._userId then
				myRedpackRecord = v

				break
			end
		end

		if myRedpackRecord then
			table.removebyvalue(realAccountList, myRedpackRecord)
			table.insert(realAccountList, 1, myRedpackRecord)
		end

		local canVote = GroupRedpackController.instance:getIsTime(self._goddessContestActId, "CAMPAIGN_VOTE_TIME") and not string.nilorempty(realRedpackInfo.otherMsg)

		GameUtil.SetActive(self._oBtnVote, canVote)
		GameUtil.addClickHandler(self._oBtnVote, GameUtil.handler(self._onClickVote, self, realRedpackInfo))
		self._scrollList:reloadData(realAccountList)
		self:_removeCellEff(self._effShowGo)
		self:_playCellEff(self._effShowGo, EffectPath.OpenEffect, 0, 0, true, nil)
	end
end

function GroupRedpackPopupView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)

	HeadItemController.instance:setHeadCellByInfo(cell.goHead, data.headInfo)

	cell.txtName.text = data.headInfo.userName
	cell.txtGet.text = data.amount

	GameUtil.SetActive(cell.goKing, data.isBestLuck)
	GameUtil.setUIImageColorIdx(cell.imgName, data.headInfo.userId == self._userId and 1 or 0)
end

function GroupRedpackPopupView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.goHead = goutil.findChild(goCell, "userGo")
	cell.goKing = goutil.findChild(goCell, "kingGo")
	cell.txtName = goutil.findChildTextComponent(goCell, "name/nameTxt")
	cell.txtGet = goutil.findChildTextComponent(goCell, "getTxt")
	cell.imgName = goutil.findChild(goCell, "name")

	HeadItemController.instance:resetHeadCell(cell.goHead)

	return cell
end

function GroupRedpackPopupView:_playCellEff(go, path, x, y, isLoop, callback)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local function loadCallBack(view, uiEffect)
		uiEffect:setParent(go.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(x, y, 0)

		uiEffect.hideEffWhileNotOnTop = true
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, path, nil, x, y, isLoop, nil, callback, loadCallBack)
end

function GroupRedpackPopupView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function GroupRedpackPopupView:_onClickOpen()
	self._popupType = PopUpType.Open

	GroupRedpackController.instance:sendGroupRedPackGetInfoReq(self._activityId)
end

function GroupRedpackPopupView:_onClickClose()
	if self._popupType == PopUpType.Open then
		self:close()

		if self._grabSuc then
			MaterialController.instance:showChangeSetInTemp(self._changeSetId)
		end

		GroupRedpackController.instance:sendGroupRedPackGetInfoReq(self._activityId)
	end
end

function GroupRedpackPopupView:_onClickVote(redpackInfo)
	local directorVoteItemId = GoddessContestConfig.instance:getActCfgByActId(self._goddessContestActId).directorVoteItemId
	local costParms = string.splitToNumber(directorVoteItemId, ":")
	local costType = costParms[1]
	local costId = costParms[2]
	local costNum = 1
	local content = langPara("确定花费%s%s进行1次投票吗？", costNum, MaterialMgr.getMaterialsName(costType, costId))

	TipsFacade.instance:openPopupCostMatViewNew(costType, costId, costNum, content, function()
		FloatWordMgr.instance:show("投票成功")
		GoddessContestController.instance:voteToDirector(redpackInfo.headInfo.userId, nil, self._goddessContestActId)
	end)
end

return GroupRedpackPopupView
