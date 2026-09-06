-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeCimeliaInfoView.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeCimeliaInfoView", package.seeall)

local SunWuKongChallengeCimeliaInfoView = class("SunWuKongChallengeCimeliaInfoView", ViewComponent)

function SunWuKongChallengeCimeliaInfoView:ctor()
	SunWuKongChallengeCimeliaInfoView.super.ctor(self)
end

function SunWuKongChallengeCimeliaInfoView:buildUI()
	SunWuKongChallengeCimeliaInfoView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnLevelUp = self:getBtn("btnLevelUp")
	self._btnReset = self:getBtn("btnReset")
	self._txtName = self:getTxt("txtName")
	self._imgCon = goutil.findChildComponent(self.mainGO, "cimeliaCon/icon", "UIImageSpriteChange")
	self._tableView = self:getGo("buffInfos/buffScrollerview")
	self._tableCell = self:getGo("buffInfos/buffScrollercell")
	self._itemCost = self:getGo("itemCost")
	self._txtCostNum = self:getTxt("itemCost/txtNum")
	self._costCon = self:getGo("itemCost/txtNum/icon")
end

function SunWuKongChallengeCimeliaInfoView:bindEvents()
	SunWuKongChallengeCimeliaInfoView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function SunWuKongChallengeCimeliaInfoView:unbindEvents()
	SunWuKongChallengeCimeliaInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._btnReset)
end

function SunWuKongChallengeCimeliaInfoView:onEnter()
	SunWuKongChallengeCimeliaInfoView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SunWuKongChallengeGetCimeliaInfoRes, self.refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SunWuKongChallengeUpgradeCimeliaRes, self._PM_SunWuKongChallengeUpgradeCimeliaRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SunWuKongChallengeResetCimeliaRes, self._PM_SunWuKongChallengeResetCimeliaRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._cimeliaId = params[2]

	SunWuKongChallengeModel.instance:saveNewCimelia(self._activityId, self._cimeliaId)

	self._actCfg = SunWuKongChallengeConfig.instance:getActivityCfg(self._activityId)
	self._cimeliaCfg = SunWuKongChallengeConfig.instance:getCimeliaCfg(self._actCfg.cimeliaPlanId, self._cimeliaId)
	self._buffCfg = SunWuKongChallengeConfig.instance:getCimeliaBuffCfg(self._cimeliaCfg.cimeliaBuffPlanId)
	self._levelCfg = SunWuKongChallengeConfig.instance:getCimeliaLevelCfg(self._cimeliaCfg.cimeliaLevelPlanId)
	self._buffList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._imgCon:ChangeSprite(self._cimeliaCfg.resName)
	self:refreshView()
end

function SunWuKongChallengeCimeliaInfoView:onExit()
	SunWuKongChallengeCimeliaInfoView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SunWuKongChallengeGetCimeliaInfoRes, self.refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SunWuKongChallengeUpgradeCimeliaRes, self._PM_SunWuKongChallengeUpgradeCimeliaRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SunWuKongChallengeResetCimeliaRes, self._PM_SunWuKongChallengeResetCimeliaRes, self)
	self._buffList:dispose()
	MaterialMgr.resetAll(self._costCon)
end

function SunWuKongChallengeCimeliaInfoView:refreshView()
	self._level = SunWuKongChallengeModel.instance:getCimeliaData(self._cimeliaId)
	self._txtName.text = langPara("%s%d级", self._cimeliaCfg.name, self._level)

	if self._levelCfg[self._level + 1] then
		local costCfgStr = self._levelCfg[self._level + 1].cost
		local matType, matId, num = MaterialMgr.getMatParams(costCfgStr)

		self._txtCostNum.text = num

		MaterialMgr.setIcon(self._costCon, matType, matId)
		GameUtil.SetActive(self._itemCost, true)
		GameUtil.SetActive(self._btnLevelUp, true)
	else
		GameUtil.SetActive(self._itemCost, false)
		GameUtil.SetActive(self._btnLevelUp, false)
	end

	GameUtil.SetActive(self._btnReset, self._level > 1)
	self._buffList:reloadData(self._buffCfg)
end

function SunWuKongChallengeCimeliaInfoView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local buffInfo = goutil.findChild(go, "buffInfo")
	local buffIcon = goutil.findChild(go, "buffInfo/buffIcon/con")
	local txtBuffDesc = goutil.findChildTextComponent(go, "buffInfo/txtDesc")
	local lockTip = goutil.findChild(go, "lockTip")
	local txtLockTip = goutil.findChildTextComponent(go, "lockTip/txt")

	GameUtil.SetActive(buffInfo, self._level >= data.cimeliaLevel)
	GameUtil.SetActive(lockTip, self._level < data.cimeliaLevel)

	txtLockTip.text = langPara("%s达到%d级解锁", self._cimeliaCfg.name, data.cimeliaLevel)
	txtBuffDesc.text = data.desc

	uGuiUtil.setSpriteToImage(buffIcon, nil, GameUrl.getExpEventUrl(data.icon))
end

function SunWuKongChallengeCimeliaInfoView:_clearCell(cell)
	local go = cell.gameObject
	local buffIcon = goutil.findChild(go, "buffInfo/buffIcon/con")

	uGuiUtil.clearImage(buffIcon)
end

function SunWuKongChallengeCimeliaInfoView:_onClickLevelUp()
	if self._levelCfg[self._level + 1] then
		local matType, matId, num = MaterialMgr.getMatParams(self._levelCfg[self._level + 1].cost)

		if MaterialModel.instance:IsEnough(matType, matId, num) == true then
			SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeUpgradeCimeliaReq(self._activityId, self._cimeliaId)
		else
			FloatWordMgr.instance:show(lang("升级所需数量不足"))
		end
	end
end

function SunWuKongChallengeCimeliaInfoView:_onClickReset()
	if self._level <= 1 then
		return
	end

	local title = lang("重置宝物")
	local content = lang("重置宝物将使宝物重置回1级，返回全部升级资源，且已激活的效果将失效，是否继续")

	local function okFunc()
		SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeResetCimeliaReq(self._activityId, self._cimeliaId)
	end

	TipsFacade.instance:openPopupWindow(title, content, okFunc)
end

function SunWuKongChallengeCimeliaInfoView:_PM_SunWuKongChallengeUpgradeCimeliaRes()
	FloatWordMgr.instance:show(lang("升级成功"))
	SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeGetCimeliaInfoReq(self._activityId)
end

function SunWuKongChallengeCimeliaInfoView:_PM_SunWuKongChallengeResetCimeliaRes()
	SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeGetCimeliaInfoReq(self._activityId)
end

return SunWuKongChallengeCimeliaInfoView
