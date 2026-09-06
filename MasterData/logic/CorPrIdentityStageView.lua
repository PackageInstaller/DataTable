-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/view/CorPrIdentityStageView.lua

module("logic.extensions.corpr.view.CorPrIdentityStageView", package.seeall)

local CorPrIdentityStageView = class("CorPrIdentityStageView", ViewComponent)

function CorPrIdentityStageView:buildUI()
	CorPrIdentityStageView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._stageCol = goutil.findChild(self.mainGO, "stageCol")
	self._stageScrollerview = goutil.findChild(self.mainGO, "stageCol/stageScrollerview")
	self._stageScrollercell = goutil.findChild(self.mainGO, "stageCol/stageScrollercell")
	self._stageScrollList = ScrollerList.create(self._stageScrollerview, self._stageScrollercell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._imgTitleSpriteChange = goutil.findChild(self.mainGO, "imgTitle/imgIdentity"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "imgTitle/txtDesc")
	self._tips = goutil.findChild(self.mainGO, "tips")
	self._clickMask = goutil.findChild(self.mainGO, "clickMask")
end

function CorPrIdentityStageView:bindEvents()
	CorPrIdentityStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._clickMask, self.close, self)
end

function CorPrIdentityStageView:unbindEvents()
	CorPrIdentityStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._clickMask)
end

function CorPrIdentityStageView:onEnter()
	CorPrIdentityStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._challengeId = checknumber(params[1])

	if self._challengeId == 0 then
		printError("缺失挑战id")
	end

	self._identityId = checknumber(params[2])

	if self._identityId == 0 then
		printError("缺失身份id")
	end

	GlobalDispatcher:addListener(GlobalNotify.CorPrChallengeGetInfoRes, self._onUpdate, self)
	self:_onUpdate()
	GameUtil.SetActive(self._tips, self._identityId == 1)
end

function CorPrIdentityStageView:onExit()
	CorPrIdentityStageView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CorPrChallengeGetInfoRes, self._onUpdate, self)
	self._stageScrollList:dispose()
end

function CorPrIdentityStageView:_onUpdate()
	self:_onUpdateStageColData()
	self:_onUpdateStageColUI()
end

function CorPrIdentityStageView:_onUpdateStageColData()
	self._stageInfoList = {}

	local cfg = CorPrChallengeConfig.instance:getcpMonsterCfg(self._identityId)

	for idx, data in ipairs(cfg) do
		local info = {}

		info.data = data
		info.isUnlock = CorPrChallengeController.instance:isUnlockAsStage(self._identityId, data.stageId)
		info.isPass = CorPrChallengeController.instance:isPassAsStage(self._identityId, data.stageId)
		self._stageInfoList[idx] = info
	end
end

function CorPrIdentityStageView:_onUpdateStageColUI()
	local identityData = CorPrChallengeConfig.instance:getCpIdentityData(self._challengeId, self._identityId)

	self._stageScrollList:reloadData(self._stageInfoList)

	local unlockStageId = 0

	for _, info in ipairs(self._stageInfoList) do
		if info.isUnlock and not info.isPass then
			unlockStageId = info.data.stageId

			break
		end
	end

	self._stageScrollList:MoveCellInView(unlockStageId, true)
	self._imgTitleSpriteChange:SetState(self._identityId - 1)

	self._txtDesc.text = identityData.desc
end

function CorPrIdentityStageView:_updateStageCell(view, cell, info, tag)
	local data = info.data
	local index = cell.index + 1
	local mainGo = cell.gameObject
	local txtStageName = goutil.findChildTextComponent(mainGo, "txtStageName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtReward = MaterialMgr.findGraphicText(mainGo, "txtReward")
	local imgLock = goutil.findChild(mainGo, "imgLock")
	local pass = goutil.findChild(mainGo, "pass")
	local con = goutil.findChild(mainGo, "mask/con")

	txtStageName.text = string.format("第%s关", index)
	txtDesc.text = data.stageDesc

	local rewardStr = "未配置"

	if not string.nilorempty(data.prize) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)
		local itemStr = string.format("<quad name=%s:%s| size=40 width=1 offsetY=-8/>", matType, matId)

		rewardStr = string.format("可获得：%s x %s", itemStr, matNum)
	end

	txtReward.text = rewardStr

	local creepsCfg = CorPrChallengeConfig.instance:getCpCreepsCfg(self._identityId, data.stageId)
	local creepsData = creepsCfg[1]
	local modelCo = CharacterConfig.instance:getModelCo((not string.nilorempty(creepsData.faceId) or nil) and checknumber(creepsData.faceId))

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	GameUtil.SetActive(imgLock, not info.isUnlock)
	GameUtil.SetActive(pass, info.isPass)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickStageCell, self, info))
end

function CorPrIdentityStageView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(mainGo)
end

function CorPrIdentityStageView:_onClickStageCell(info)
	local result, tips = CorPrChallengeController.instance:getTryChallengeStageResultAndTips(self._challengeId, self._identityId, info.data.stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	CorPrChallengeController.instance:enterBattleAsCorPr(self._challengeId, self._identityId, info.data.stageId)
end

return CorPrIdentityStageView
