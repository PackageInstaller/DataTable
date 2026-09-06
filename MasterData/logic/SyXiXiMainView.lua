-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syxixi/view/SyXiXiMainView.lua

module("logic.extensions.SyXiXi.view.SyXiXiMainView", package.seeall)

local SyXiXiMainView = class("SyXiXiMainView", ViewComponent)
local challengeId = 208
local curActId1 = 126002
local curActId2 = 128002
local curActId3 = 123016
local actIdList = {
	curActId1,
	curActId2,
	curActId3
}
local viewMap = {
	[curActId1] = ViewName.SyXiXi1View,
	[curActId2] = ViewName.SyXiXi2View,
	[curActId3] = ViewName.SyXiXi3View
}

function SyXiXiMainView:buildUI()
	SyXiXiMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("txtTime/txt")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._redJump4 = self:getGo("jumpBtnCol/btnJump4/redPoint")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnPetSkill = self:getGo("petInfo/btnSkill")
	self._btnPetIntro = self:getGo("petInfo/btnIntroduce")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._btnChallenge = {}

	for i = 1, 3 do
		self._btnChallenge[i] = self:getGo("clgBtnCol/btnClg" .. i)
	end
end

function SyXiXiMainView:bindEvents()
	SyXiXiMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTipBtn, self)
	GameUtil.addClickHandler(self._btnPetSkill, self._onClickPetSkillBtn, self)
	GameUtil.addClickHandler(self._btnPetIntro, self._onClickPetIntroBtn, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickJumpBtn1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickJumpBtn2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickJumpBtn3, self)
	GameUtil.addClickHandler(self._btnJump4, self._onClickJumpBtn4, self)

	for i, v in ipairs(self._btnChallenge) do
		local actId = actIdList[i]

		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickClgBtn, self, actId), self)
	end
end

function SyXiXiMainView:unbindEvents()
	SyXiXiMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPetSkill)
	GameUtil.rmClickHandler(self._btnPetIntro)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)

	for i, v in ipairs(self._btnChallenge) do
		GameUtil.rmClickHandler(v)
	end
end

function SyXiXiMainView:onExit()
	SyXiXiMainView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	MaterialMgr.resetAll(self._pointRare)
end

function SyXiXiMainView:onEnter()
	SyXiXiMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)
	self.addGEvent(self, GlobalNotify.PM_SKL_GETINFORES, self.onRefreshUI, self)
	self.addGEvent(self, GlobalNotify.PM_ZXL_GETSIGN, self.onRefreshUI, self)

	self.curActId = curActId1
	self._actCfg = InfinitefutureConfig.instance:getPlanCfg(curActId3)
	self._txtTime.text = TimeGateController.instance:getActTimeShowByChallengeId(challengeId)

	self:_loadPetInfo()
	self:_showUIEff()

	for i, actId in ipairs(actIdList) do
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(actId)

		if isInTime then
			if i == 1 then
				XingJiangController.instance:sendInfoReq(curActId1)
			elseif i == 2 then
				XingJiangController.instance:sendInfo2Req(curActId2)
			elseif i == 3 then
				InfinitefutureController.instance:sendInfoReq(curActId3)
			end
		end
	end

	self:onRefreshUI()
end

function SyXiXiMainView:onRefreshUI()
	for i = 1, 3 do
		local curAct = actIdList[i]
		local actType = math.floor(curAct / 1000)
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, curAct)
		local cfg = ActivityDefineConfig.instance:getCfgById(actType, curAct)
		local startTime = GameUtil.string2date(cfg.startTime)
		local lock = self:getGo("clgBtnCol/btnClg" .. i .. "/lock")
		local txtOpenTime = goutil.findChildTextComponent(lock, "txtOpenTime")

		goutil.setActive(lock, not isInTime)

		txtOpenTime.text = startTime.month .. "月" .. startTime.day .. "日开启"

		local pass = self:getGo("clgBtnCol/btnClg" .. i .. "/imgPass")
		local isPass = self:_checkPass(curAct)

		goutil.setActive(pass, isPass)
	end
end

function SyXiXiMainView:_showUIEff()
	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function SyXiXiMainView:_onClickTipBtn()
	UIStateManager.instance:push(ViewName.RulesView, "syxiximainview_rule")
end

function SyXiXiMainView:_checkPass(actId)
	local isPass = false

	if actId == curActId1 then
		isPass = XingJiangModel.instance:checkIsPassById(actId)
	elseif actId == curActId2 then
		isPass = XingJiangModel.instance:checkIsPassExById(actId)
	elseif actId == curActId3 then
		isPass = InfinitefutureModel.instance:checkIsPassExById(actId)
	end

	return isPass
end

function SyXiXiMainView:_onClickClgBtn(actId)
	local isPass = self:_checkPass(actId)

	if isPass then
		FloatWordMgr.instance:show("已通过所有关卡")

		return
	end

	local actType = math.floor(actId / 1000)
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, actId)

	if not isInTime then
		FloatWordMgr.instance:show("当前关卡不在活动时间内")

		return
	end

	local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)

	UIStateManager.instance:push(viewMap[actId], actId, cfg.name)
end

function SyXiXiMainView:_onClickJumpBtn1()
	local gotoStr = self._actCfg.jumpTo1

	GotoMgr.gotoByString(gotoStr)
end

function SyXiXiMainView:_onClickJumpBtn2()
	local gotoStr = self._actCfg.jumpTo2

	GotoMgr.gotoByString(gotoStr)
end

function SyXiXiMainView:_onClickJumpBtn3()
	local gotoStr = self._actCfg.jumpTo3

	GotoMgr.gotoByString(gotoStr)
end

function SyXiXiMainView:_onClickJumpBtn4()
	local gotoStr = self._actCfg.jumpTo4

	GotoMgr.gotoByString(gotoStr)
end

function SyXiXiMainView:_onClickPetIntroBtn()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function SyXiXiMainView:_onClickPetSkillBtn()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function SyXiXiMainView:_loadPetInfo()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetName.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function SyXiXiMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function SyXiXiMainView:_getSkinId()
	return self._actCfg.skinId
end

return SyXiXiMainView
