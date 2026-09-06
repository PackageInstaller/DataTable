-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/view/ShenyaolongzunshengzhumainView.lua

module("logic.extensions.shenyaolongzunshengzhu.view.ShenyaolongzunshengzhumainView", package.seeall)

local ShenyaolongzunshengzhumainView = class("ShenyaolongzunshengzhumainView", ViewComponent)

function ShenyaolongzunshengzhumainView:buildUI()
	ShenyaolongzunshengzhumainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txt")
	self._btnRank = self:getGo("btnRank")
	self._btnRankExt = self:getGo("btnRankExt")
	self._redBtnRank = self:getGo("btnRank/redPoint")
	self._btnStore = self:getGo("btnStore")
	self._btnH5 = self:getGo("btnH5")
	self._btnStoreBubble = self:getGo("btnStore/bubble")
	self._txtDescBubble = self:getTxt("btnStore/bubble/txtDesc")
	self._redBtnStore = self:getGo("btnStore/redPoint")
	self._btnEnter = self:getGo("btnEnter/btn")
	self._redBtnEnter = self:getGo("btnEnter/btn/redPoint")
	self._txtDescBtnEnter = self:getTxt("btnEnter/desc/txt")
	self._txtOpenTime = self:getTxt("time/txt")
	self._con = self:getGo("con")
end

function ShenyaolongzunshengzhumainView:bindEvents()
	ShenyaolongzunshengzhumainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnJumpRank, self)
	GameUtil.addClickHandler(self._btnRankExt, self._onClickBtnExtJumpRank, self)
	GameUtil.addClickHandler(self._btnStore, self._onClickBtnJumpStore, self)
	GameUtil.addClickHandler(self._btnH5, self._onClickBtnJumpH5, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
end

function ShenyaolongzunshengzhumainView:unbindEvents()
	ShenyaolongzunshengzhumainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnRankExt)
	GameUtil.rmClickHandler(self._btnStore)
	GameUtil.rmClickHandler(self._btnH5)
	GameUtil.rmClickHandler(self._btnEnter)
end

function ShenyaolongzunshengzhumainView:onExit()
	ShenyaolongzunshengzhumainView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	RedPointController.instance:unregRedPoint(self._redBtnRank)
	RedPointController.instance:unregRedPoint(self._redBtnEnter)
end

function ShenyaolongzunshengzhumainView:onEnter()
	ShenyaolongzunshengzhumainView.super.onEnter(self)

	self._activityId = ShenyaolongzunshengzhuController.instance:getCurrActivity()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	local displayBagOffset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)

	local effParent = self.mainGO
	local pathName = "20230303/shenglongtiaozhan/fx_ui_sltz_jiemian"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	self:_refreshUI()
	self.addGEvent(self, GlobalNotify.ShenyaolongzunshengzhuInfoUpdate, self._refreshUI, self)

	if self:_checkAndAlert() then
		ShenyaolongzunshengzhuController.instance:sendGetInfo(self._activityId)
	end
end

function ShenyaolongzunshengzhumainView:_getSkinId()
	return (checknumber(ShenyaolongzunshengzhuConfig.instance:getCommonValue("SKIN_ID")))
end

function ShenyaolongzunshengzhumainView:_refreshUI()
	local cfg = ShenyaolongzunshengzhuConfig.instance:getActivityCfgById(self._activityId) or {}
	local isOpen = string.nilorempty(cfg.dailyRankStartTime) or string.nilorempty(cfg.dailyRankEndTime) or GameUtil.checkIsInTimePeriod(cfg.dailyRankStartTime, cfg.dailyRankEndTime)

	GameUtil.SetActive(self._btnRank, isOpen)

	local str = ShenyaolongzunshengzhuConfig.instance:getCommonValue("BUBBLE_DESC")

	GameUtil.SetActive(self._btnStoreBubble, false)

	if not string.nilorempty(str) then
		GameUtil.SetActive(self._btnStoreBubble, true)

		self._txtDescBubble.text = str
	end
end

function ShenyaolongzunshengzhumainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	PetbookController.instance:previewBattle(raceId, skinId)
end

function ShenyaolongzunshengzhumainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function ShenyaolongzunshengzhumainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function ShenyaolongzunshengzhumainView:_onClickBtnJumpRank()
	if self:_checkAndAlert() then
		UIStateManager.instance:push(ViewName.ShenyaolongzunshengzhurankView, self._activityId, 2)
	end
end

function ShenyaolongzunshengzhumainView:_onClickBtnExtJumpRank()
	if self:_checkAndAlert() then
		UIStateManager.instance:push(ViewName.ShenyaolongzunshengzhurankView, self._activityId, 1)
	end
end

function ShenyaolongzunshengzhumainView:_onClickBtnJumpStore()
	self:_gotoByString("LZ_JUMP_SHOP")
end

function ShenyaolongzunshengzhumainView:_onClickBtnJumpH5()
	self:_gotoByString("LZ_JUMP_JINHUA")
end

function ShenyaolongzunshengzhumainView:_gotoByString(key)
	local value = ShenyaolongzunshengzhuConfig.instance:getCommonValue(key)

	GotoMgr.gotoByString(value)
end

function ShenyaolongzunshengzhumainView:_checkAndAlert()
	local cfg = ShenyaolongzunshengzhuConfig.instance:getActivityCfgById(self._activityId) or {}
	local arr = string.split(cfg.challengeClosedTimeRange or "", "-")
	local isClose = GameUtil.checkIsInTimePeriod(arr[1], arr[2], true)

	if isClose and #arr >= 2 then
		TipsFacade.instance:openCommonTips(langPara("每日%s开启活动", arr[2]))
	end

	return not isClose
end

function ShenyaolongzunshengzhumainView:_onClickBtnEnter()
	if self:_checkAndAlert() then
		UIStateManager.instance:push(ViewName.ShenyaolongzunshengzhustageView)
	end
end

function ShenyaolongzunshengzhumainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("shenyaolongzunshengzhumainview_rules")
end

return ShenyaolongzunshengzhumainView
