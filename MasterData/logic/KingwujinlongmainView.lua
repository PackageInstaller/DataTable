-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlongmainView.lua

module("logic.extensions.kingwujinlong.view.KingwujinlongmainView", package.seeall)

local KingwujinlongmainView = class("KingwujinlongmainView", ViewComponent)

function KingwujinlongmainView:buildUI()
	KingwujinlongmainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("txtTime/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnJump5 = self:getGo("jumpBtnCol/btnJump5")
	self._btnClg1 = self:getGo("clgBtnCol/btnClg1/btn")
	self._redClg1 = self:getGo("clgBtnCol/btnClg1/btn/redPoint")
	self._passClg1 = self:getGo("clgBtnCol/btnClg1/btn/imgPass")
	self._btnClg2 = self:getGo("clgBtnCol/btnClg2/btn")
	self._redClg2 = self:getGo("clgBtnCol/btnClg2/btn/redPoint")
	self._passClg2 = self:getGo("clgBtnCol/btnClg2/btn/imgPass")
	self._itemcellGo = self:getGo("clgBtnCol/bubble/itemcell")
	self._imgHasGainGo = self:getGo("clgBtnCol/bubble/imgHasGain")
	self._btnAttr = self:getGo("btnAttr")
	self._imgAttr = self:getGo("btnAttr/img")
	self._redpointAttr = self:getGo("btnAttr/redPoint")
	self._impressionStickerRoot = self:getGo("impressionStickerRoot")
end

function KingwujinlongmainView:bindEvents()
	KingwujinlongmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnJump5, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFive"))
	GameUtil.addClickHandler(self._btnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickBtnClg2, self)
	GameUtil.addClickHandler(self._btnAttr, self._onClickbtnAttr, self)
end

function KingwujinlongmainView:unbindEvents()
	KingwujinlongmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
	GameUtil.rmClickHandler(self._btnAttr)
end

function KingwujinlongmainView:onExit()
	KingwujinlongmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
	MaterialMgr.clearIcon(self._imgAttr)
end

function KingwujinlongmainView:onEnter()
	KingwujinlongmainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = KingWujinlongController.instance:getActivityId()
	end

	self._actCfg = KingWujinlongConfig.instance:getActivityCfgById(self._activityId) or {}

	self:_setActTime()
	self:_setRole()
	self:_setImpressionStickerBubble()
	self.addGEvent(self, GlobalNotify.KING_WUJINLONG_CLG_INFO_UPDATE, self._updateUI, self)
	KingWujinlongController.instance:sendGetInfo(self._activityId)
	self:_updateUI()
	KingWujinlongController.instance:tryShowChangeSet()
end

function KingwujinlongmainView:_getSkinId()
	return checknumber(self._actCfg.skinId)
end

function KingwujinlongmainView:_upateRed()
	return
end

function KingwujinlongmainView:_setActTime()
	if self._actCfg and not string.nilorempty(self._actCfg.limitStartTime) and not string.nilorempty(self._actCfg.limitEndTime) then
		local timeTxt = GameUtil.getTimeTxtByStr(self._actCfg.limitStartTime, self._actCfg.limitEndTime, GameEnum.TimeTxt.M_D_H)

		self._txtTime.text = "活动时间：" .. timeTxt
	else
		self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	end
end

function KingwujinlongmainView:_setRole()
	local skinId = self:_getSkinId()

	if skinId > 0 then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)

		self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

		MaterialMgr.setIcon(self._imgAttr, MatType.PET_SKIN, skinId)
	end
end

function KingwujinlongmainView:_setImpressionStickerBubble()
	local skinId = self:_getSkinId()
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)

	MainUIController.instance:showImpressionStickerNumBubble(self._impressionStickerRoot, self._viewPresentor, raceId)
end

function KingwujinlongmainView:_updateUI()
	self._info = KingWujinlongModel.instance:getInfo(self._activityId) or {}

	if not self._info.clgInfo then
		local clgInfo = {}
		local list = KingWujinlongConfig.instance:getStageCfgListById(self._activityId) or {}

		GameUtil.SetActive(self._passClg1, checknumber(clgInfo.curPassStageId) >= #list)
		self:_updateSuperBubble()
		self:_upateRed()
	end
end

function KingwujinlongmainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function KingwujinlongmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function KingwujinlongmainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function KingwujinlongmainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	if enableDebug and string.nilorempty(jumpToStr) then
		TipsFacade.instance:openCommonTips("缺少配置( 看清楚！)： " .. key)
	end

	GotoMgr.gotoByString(jumpToStr)
end

function KingwujinlongmainView:_onClickBtnClg1()
	if self._actCfg and not string.nilorempty(self._actCfg.limitStartTime) and not string.nilorempty(self._actCfg.limitEndTime) and not GameUtil.checkIsInTimePeriod(self._actCfg.limitStartTime, self._actCfg.limitEndTime) then
		local startDate = GameUtil.string2date(self._actCfg.limitStartTime)
		local timeStr = string.format("%02d.%02d %d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min)

		TipsFacade.instance:openCommonTips(langPara("%s后开启", timeStr))

		return
	end

	self._info = KingWujinlongModel.instance:getInfo(self._activityId) or {}

	if not self._info.clgInfo then
		local clgInfo = {}
		local list = KingWujinlongConfig.instance:getStageCfgListById(self._activityId) or {}

		if checknumber(clgInfo.curPassStageId) >= #list then
			TipsFacade.instance:openCommonTips("已全部通关")
		else
			UIStateManager.instance:push(ViewName.KingwujinlonglevelView, self._activityId)
		end
	end
end

function KingwujinlongmainView:_onClickBtnClg2()
	return
end

function KingwujinlongmainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("kingwujinlongmainview_rule")
end

function KingwujinlongmainView:_updateSuperBubble()
	MaterialMgr.resetAll(self._itemcellGo)

	if self._actCfg then
		MaterialMgr.setCellByCfg(self._actCfg.bubbleItem, self._itemcellGo)
	end
end

function KingwujinlongmainView:_onClickbtnAttr()
	return
end

return KingwujinlongmainView
