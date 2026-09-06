-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetShowView.lua

module("logic.extensions.cutepet.view.CutePetShowView", package.seeall)

local CutePetShowView = class("CutePetShowView", ViewComponent)
local TabConst = {
	InteractView = 6,
	QualityUp = 5,
	StarUp = 4,
	LevelUp = 3,
	ShowInfo = 1,
	InitProp = 2
}
local fixShowList = {
	"生命",
	"攻击",
	"物防",
	"魔防"
}
local STACK_LIST = {
	[TabConst.ShowInfo] = ViewName.CutePetShowInfoView,
	[TabConst.InitProp] = ViewName.CutePetInitPropView,
	[TabConst.LevelUp] = ViewName.CutePetLevelUpView,
	[TabConst.StarUp] = ViewName.CutePetStarUpView,
	[TabConst.QualityUp] = ViewName.CutePetQualityUpView,
	[TabConst.InteractView] = ViewName.CutePetInteractView
}

function CutePetShowView:ctor()
	CutePetShowView.super.ctor(self)

	self._fixShowAttrMap = {}

	for i, v in ipairs(fixShowList) do
		self._fixShowAttrMap[FightingPowerFormula.instance:getAttrTypeByName(v)] = true
	end
end

function CutePetShowView:buildUI()
	CutePetShowView.super.buildUI(self)

	self._btnClose = self:getBtn("Left/btn_close")
	self._tabs = {}

	local btn

	for i = 1, 6 do
		btn = self:getBtn(string.format("Left/yeqian/tab_%s", i))

		btn:AddClickListener(function()
			self:_onClickTab(i)
		end)

		self._tabs[i] = {}
		self._tabs[i].btn = btn.gameObject:GetComponent("Button")
		self._tabs[i].changeGroup = btn.gameObject:GetComponent(typeof(UIChangeGroup))
	end

	self._Container = self:getGo("container")
	self._btnShow = self:getGo("Left/btnShow")
	self._txtShow = self:getTxt("Left/btnShow/txt")
	self._btnHide = self:getGo("Left/btnHide")
	self._txtHide = self:getTxt("Left/btnHide/txt")
	self._btnFree = self:getGo("Middle/btnFree")
	self._btnFollow = self:getGo("Middle/btnFollow")
	self._txtFollow = self:getTxt("Middle/btnFollow/txt")
	self._txtScore = self:getTxt("Middle/score/txt")
	self._lock = self:getGo("Middle/lock")
	self._lockMidTxt = self:getTxt("Middle/lock/txt")
	self._lockMidImgChange = goutil.findChildComponent(self.mainGO, "Middle/lock/img", ComponentType.UIImageSpriteChange)
	self._btnLeft = self:getGo("Middle/btn_left")
	self._btnRight = self:getGo("Middle/btn_right")
	self._btnLock = self:getGo("Left/btnLock")
	self._lockIconChange = goutil.findChildComponent(self.mainGO, "Left/btnLock/icon", "UIImageSpriteChange")
	self._lockTxt = self:getTxt("Left/btnLock/txt")
	self._btnDiscard = self:getGo("Left/btnDiscard")
	self._discardIconChange = goutil.findChildComponent(self.mainGO, "Left/btnDiscard/icon", "UIImageSpriteChange")
	self._discardTxt = self:getTxt("Left/btnDiscard/txt")
	self._con = self:getGo("Middle/petCon")
	self._drag = Framework.UIDragTrigger.Get(self:getGo("Middle/drag"))
	self._content = self:getGo("content")
end

function CutePetShowView:bindEvents()
	CutePetShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnFree, self._onClickFree, self)
	GameUtil.addClickHandler(self._btnFollow, self._onClickFollow, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
	GameUtil.addClickHandler(self._btnLock, self._onClickLock, self)
	GameUtil.addClickHandler(self._btnDiscard, self._onClickDiscard, self)
	self._drag:AddDragListener(self._onDrag, self)
end

function CutePetShowView:unbindEvents()
	CutePetShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShow)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnFree)
	GameUtil.rmClickHandler(self._btnFollow)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnLock)
	GameUtil.rmClickHandler(self._btnDiscard)
	self._drag:RemoveDragListener()
end

function CutePetShowView:onExit()
	CutePetShowView.super.onExit(self)
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)

	self._pendingLockTips = nil
	self._pendingDiscardTips = nil
end

function CutePetShowView:destroyUI()
	CutePetShowView.super.destroyUI(self)
end

function CutePetShowView:onEnter()
	self.addGEvent(self, GlobalNotify.handlePM_SetCutePetGardenShowStateResp, self._refreshMiddle, self)
	self.addGEvent(self, GlobalNotify.handlePM_SetCutePetFollowStateResp, self._refreshMiddle, self)
	self.addGEvent(self, GlobalNotify.handlePM_SetCutePetLockStateResp, self._refreshMiddle, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetChangeReadyToDiscardRes, self._refreshMiddle, self)
	self.addGEvent(self, GlobalNotify.handlePM_SetCutePetLockStateResp, self._onLockStateChanged, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetChangeReadyToDiscardRes, self._onDiscardStateChanged, self)
	self.addGEvent(self, GlobalNotify.handlePM_StrengthInitialPropResp, self._refreshScore, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetLvlUpResp, self._refreshScore, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetStarUpResp, self._refreshScore, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetQualityUpResp, self._refreshScore, self)
	self.addGEvent(self, GlobalNotify.handlePM_ReleaseCutePetResp, self._PM_ReleaseCutePetResp, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifyCutePetChangedResp, self._PM_NotifyCutePetChangedResp, self)
	self.addGEvent(self, GlobalNotify.CutePetAvatarLoaded, self._onAvatarLoaded, self)
	self.addGEvent(self, GlobalNotify.ShowCutePetAttrDetail, self._showDetail, self)
	CutePetModelMgr.instance:pushViewWithModel(self._con, self._viewPresentor.viewName, 1, 1, 180)

	self._pendingLockTips = nil
	self._pendingDiscardTips = nil
	self.curTabIdx = 1
	self.curIndex = 0

	local params = self._viewPresentor:getOpenParam()

	if params ~= nil then
		local idx = params[1]

		if idx ~= nil then
			if checknumber(idx) > 0 then
				self.curTabIdx = idx
			else
				for k, v in pairs(STACK_LIST) do
					if v == idx then
						self.curTabIdx = k

						break
					end
				end
			end
		end

		local raceId = params[2]

		if raceId ~= nil and type(raceId) == "number" then
			self._firstRaceId = raceId
		end

		local petList = params[3]

		if petList ~= nil and type(petList) == "table" then
			self._petList = petList

			for i, v in ipairs(self._petList) do
				if v.id == CutePetModel.instance:GetCurPetId() then
					self.curIndex = i
				end
			end
		end
	else
		self._firstRaceId = nil
	end

	if self.curIndex == 0 then
		self._petList = CutePetModel.instance:getAllCutePetsList()

		for i, v in ipairs(self._petList) do
			if v.id == CutePetModel.instance:GetCurPetId() then
				self.curIndex = i
			end
		end
	end

	for i, v in ipairs(self._tabs) do
		v.changeGroup:SetState(0)
	end

	self:_onClickTab(self.curTabIdx)

	self._needShowIdle = true

	self:_refreshMiddle()
end

function CutePetShowView:_refreshMiddle()
	self._cutePetId = CutePetModel.instance:GetCurPetId()
	self._cutePetMo = CutePetModel.instance:getCutePeMo(self._cutePetId)

	if not self._cutePetMo then
		self:close()
		FloatWordMgr.instance:show(lang("无可显示萌宠"))
	end

	CutePetModelMgr.instance:resetModel(1, self._cutePetMo.config.modelId)
	CutePetModelMgr.instance:setOffset(1, CutePetConfig.instance:getPetOffsetInDefaultView(self._cutePetMo.config.raceId))

	local isShow = self._cutePetMo:getState(CutePetMo.STATE_GARDEN_SHOW)

	GameUtil.SetActive(self._btnShow, not isShow)

	self._txtShow.text = lang("隐藏")

	GameUtil.SetActive(self._btnHide, isShow)

	self._txtHide.text = langPara("显示 %d/%d", CutePetModel.instance:getShowCount(), CutePetConfig.instance:getCommonValue("CutePetInGardenSceneMaxCount", true))

	local isFollow = self._cutePetMo:getState(CutePetMo.STATE_SCENE_FOLLOW)

	self._txtFollow.text = isFollow and "取消跟随" or "跟随"

	self:_refreshScore()

	local isLock = self._cutePetMo:getState(CutePetMo.LOCKED)
	local isDiscard = self._cutePetMo:getIsReadyToDiscard()

	GameUtil.SetActive(self._btnLock, true)
	GameUtil.SetActive(self._btnDiscard, true)

	local showLock = isLock or isDiscard

	GameUtil.SetActive(self._lock, showLock)

	if showLock then
		if isLock then
			self._lockMidTxt.text = lang("已上锁")

			self._lockMidImgChange:SetState(0)
		else
			self._lockMidTxt.text = lang("已弃置")

			self._lockMidImgChange:SetState(1)
		end
	end

	self._lockIconChange:SetState(isLock and 1 or 0)

	self._lockTxt.text = isLock and lang("已上锁") or lang("未上锁")

	self._discardIconChange:SetState(isDiscard and 1 or 0)

	self._discardTxt.text = isDiscard and lang("已弃置") or lang("未弃置")
end

function CutePetShowView:_refreshScore()
	self._txtScore.text = langPara("宠物评分：%d", self._cutePetMo.score)
end

function CutePetShowView:_onAvatarLoaded()
	if self._needShowIdle == true then
		if self._cutePetMo.config.enterIdleId == 1 then
			CutePetModelMgr.instance:playEatAnim(1)
		elseif self._cutePetMo.config.enterIdleId == 2 then
			CutePetModelMgr.instance:playTouchAnim(1)
		else
			CutePetModelMgr.instance:playEatAnim(1)
		end

		self._needShowIdle = false
	end
end

function CutePetShowView:_onDrag(eventData)
	CutePetModelMgr.instance:onModelTrun(eventData.delta.x, 1)
end

function CutePetShowView:_onClickTab(idx)
	local name = STACK_LIST[idx]

	if name == nil then
		FloatWordMgr.instance:show(ConstString.NotRelease)

		return
	end

	if self._tabs[idx] then
		for i = 1, #self._tabs do
			local btn = self._tabs[i].btn

			btn.interactable = i ~= idx
		end
	end

	self._tabs[self.curTabIdx].changeGroup:SetState(0)

	self.curTabIdx = idx

	self._tabs[self.curTabIdx].changeGroup:SetState(1)

	local params = self._viewPresentor:getOpenParam()

	if params then
		params[1] = idx

		UIStateManager.instance:updateParms(self._viewPresentor.viewName, params)
	end

	self:showTabAt(self._Container, name)
end

function CutePetShowView:_onClickShow()
	if CutePetModel.instance:getShowCount() < CutePetConfig.instance:getCommonValue("CutePetInGardenSceneMaxCount", true) then
		CutePetController.instance:sendPM_SetCutePetGardenShowStateReq(self._cutePetMo, true)
	else
		FloatWordMgr.instance:show(lang("已达显示上限"))
	end
end

function CutePetShowView:_onClickHide()
	CutePetController.instance:sendPM_SetCutePetGardenShowStateReq(self._cutePetMo, false)
end

function CutePetShowView:_onClickFree()
	if checknumber(self._cutePetMo.equippedPetId) > 0 then
		FloatWordMgr.instance:show(lang("萌宠处于庇护状态，不可放生"))

		return
	end

	if self._cutePetMo:getState(CutePetMo.STATE_IN_ADVENTURE) == true then
		FloatWordMgr.instance:show(lang("萌宠处于冒险状态，不可放生"))

		return
	end

	if self._cutePetMo:getState(CutePetMo.LOCKED) == true then
		FloatWordMgr.instance:show(lang("萌宠上锁中，不可放生"))

		return
	end

	if PasswordLockController.instance:checkNeedOpenVerifyView() then
		return
	end

	UIStateManager.instance:push(ViewName.CutePetReleaseView, self._cutePetMo)
end

function CutePetShowView:_onClickLock()
	if PasswordLockController.instance:checkNeedOpenVerifyView() then
		return
	end

	local isLock = self._cutePetMo:getState(CutePetMo.LOCKED)

	if not isLock and self._cutePetMo:getIsReadyToDiscard() then
		FloatWordMgr.instance:show(lang("请先解除弃置标记"))

		return
	end

	self._lockMidImgChange:SetState(0)

	self._pendingLockTips = isLock and lang("已解锁") or lang("已上锁")

	CutePetController.instance:sendPM_SetCutePetLockStateReq(self._cutePetMo, not isLock)
end

function CutePetShowView:_onClickDiscard()
	if self._cutePetMo:getState(CutePetMo.LOCKED) == true then
		FloatWordMgr.instance:show(lang("请先解除锁定标记"))

		return
	end

	local isDiscard = self._cutePetMo:getIsReadyToDiscard()

	if not isDiscard then
		GameUtil.SetActive(self._lock, true)

		self._lockMidTxt.text = lang("已弃置")

		self._lockMidImgChange:SetState(1)
	end

	self._pendingDiscardTips = isDiscard and lang("已取消弃置") or lang("已弃置")

	CutePetController.instance:sendPM_CutePetChangeReadyToDiscardReq(self._cutePetMo, not isDiscard)
end

function CutePetShowView:_onLockStateChanged()
	if self._pendingLockTips then
		FloatWordMgr.instance:show(self._pendingLockTips)

		self._pendingLockTips = nil
	end
end

function CutePetShowView:_onDiscardStateChanged()
	if self._pendingDiscardTips then
		FloatWordMgr.instance:show(self._pendingDiscardTips)

		self._pendingDiscardTips = nil
	end
end

function CutePetShowView:_onClickLeft()
	self.curIndex = self.curIndex - 1 <= 0 and #self._petList or self.curIndex - 1

	CutePetModel.instance:SetCurPetId(self._petList[self.curIndex].id)

	self._needShowIdle = true

	self:_refreshMiddle()
	self:_onClickTab(self.curTabIdx)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetShowPetChange)
end

function CutePetShowView:_onClickRight()
	self.curIndex = self.curIndex + 1 > #self._petList and 1 or self.curIndex + 1

	CutePetModel.instance:SetCurPetId(self._petList[self.curIndex].id)

	self._needShowIdle = true

	self:_refreshMiddle()
	self:_onClickTab(self.curTabIdx)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetShowPetChange)
end

function CutePetShowView:_onClickFollow()
	local state = CutePetMo.STATE_SCENE_FOLLOW
	local isFollow = self._cutePetMo:getState(state)

	CutePetController.instance:sendPM_SetCutePetFollowStateReq(self._cutePetMo, not isFollow)
end

function CutePetShowView:_onClickClose()
	self:close()
end

function CutePetShowView:_PM_ReleaseCutePetResp(ids)
	local id = ids[1]

	if self._petList[self.curIndex] and self._petList[self.curIndex].id == id then
		table.remove(self._petList, self.curIndex)
	end

	if #self._petList <= 0 then
		self:close()

		return
	end

	if self.curIndex > #self._petList then
		self.curIndex = 1
	end

	CutePetModel.instance:SetCurPetId(self._petList[self.curIndex].id)
	self:_refreshMiddle()
	self:_onClickTab(self.curTabIdx)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetShowPetChange)
end

function CutePetShowView:_PM_NotifyCutePetChangedResp()
	local maxCount = #self._petList
	local insertIndex = 1

	for i = 1, maxCount do
		if not self._petList[i] or checknumber(self._petList[i].id) <= 0 or CutePetModel.instance:getCutePeMo(self._petList[i].id) == nil then
			self._petList[i] = nil
		elseif insertIndex ~= i then
			self._petList[insertIndex] = self._petList[i]
			insertIndex = insertIndex + 1
		else
			insertIndex = insertIndex + 1
		end
	end

	for i, v in ipairs(self._petList) do
		if v.id == CutePetModel.instance:GetCurPetId() then
			self.curIndex = i
		end
	end
end

function CutePetShowView:_showDetail(petId)
	local goOrPos = self._content
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	UIStateManager.instance:open(ViewName.CutePetAttrPopUpView, pos, sizeDelta, self._viewPresentor, petId, self._fixShowAttrMap)
end

return CutePetShowView
