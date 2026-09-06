-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengeunitpopView.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengeunitpopView", package.seeall)

local KingciyuanchallengeunitpopView = class("KingciyuanchallengeunitpopView", ViewComponent)

function KingciyuanchallengeunitpopView:ctor()
	KingciyuanchallengeunitpopView.super.ctor(self)
end

function KingciyuanchallengeunitpopView:unbindEvents()
	KingciyuanchallengeunitpopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function KingciyuanchallengeunitpopView:bindEvents()
	KingciyuanchallengeunitpopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function KingciyuanchallengeunitpopView:buildUI()
	KingciyuanchallengeunitpopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
	self._itemCol = goutil.findChild(self.mainGO, "itemCol")

	local scrollerGo = self:getGo("itemCol/itemView")
	local cellGo = self:getGo("itemCol/itemCell")

	GameUtil.SetActive(cellGo, false)

	self._scrollList = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function KingciyuanchallengeunitpopView:onExit()
	KingciyuanchallengeunitpopView.super.onExit(self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanResultConfirmRes, self._handleConfirmRes, self)
	self._scrollList:dispose()
end

function KingciyuanchallengeunitpopView:onEnter()
	KingciyuanchallengeunitpopView.super.onEnter(self)
	self:_onUpdate()
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanResultConfirmRes, self._handleConfirmRes, self)
end

function KingciyuanchallengeunitpopView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local petMo = data.petMo
	local hpRatio = data.hpRatio

	MaterialMgr.setCell(MatType.Pet, petMo.curFaceId, item)

	local str = ""

	if hpRatio == 0 then
		str = "<color=#FF4300FF>0%</color>"
	else
		local value = hpRatio / 100

		str = string.format("%d", math.max(1, value)) .. "%"
	end

	txtNum.text = str
end

function KingciyuanchallengeunitpopView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function KingciyuanchallengeunitpopView:_handleConfirmRes()
	self:close()
end

function KingciyuanchallengeunitpopView:_onUpdate()
	self:_onUpdatePlaneUI()
	self:_onUpdateItemColUI()
end

function KingciyuanchallengeunitpopView:_onUpdatePlaneUI()
	self._txtTip.text = lang("恭喜成功通关，当前精灵存活情况如下")
end

function KingciyuanchallengeunitpopView:_onUpdateItemColUI()
	local infoList = {}
	local customFmtMo = KingCiYuanChallengeModel.instance.limitFmtMo
	local hpMap = KingCiYuanChallengeModel.instance:getJXPetHpMapMerge() or {}

	for petId, hpRatio in pairs(hpMap) do
		local info = {
			petId = petId,
			hpRatio = hpRatio,
			petMo = customFmtMo:getPetMoById(petId)
		}

		table.insert(infoList, info)
	end

	self._itemInfoList = infoList

	self._scrollList:reloadData(self._itemInfoList)
	self._scrollList:refresh()
end

function KingciyuanchallengeunitpopView:_onClickBtnSure()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.KING_CI_YUAN_CHALLENGE)
	local activityConfig = KingCiYuanChallengeConfig.instance:getActivityConfig(activityId)
	local maxStage = KingCiYuanChallengeConfig.instance:getMaxStage(activityConfig.extPlanId)
	local passStageId = KingCiYuanChallengeModel.instance:getJxPassStageId()
	local stageId = math.min(passStageId + 1, maxStage)

	KingCiYuanChallengeAgent.instance:sendPM_KingCiYuanFightResultConfirmReq(activityId, stageId)
end

return KingciyuanchallengeunitpopView
