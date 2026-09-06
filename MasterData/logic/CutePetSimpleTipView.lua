-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetSimpleTipView.lua

module("logic.extensions.cutepet.view.CutePetSimpleTipView", package.seeall)

local CutePetSimpleTipView = class("CutePetSimpleTipView", ViewComponent)

function CutePetSimpleTipView:ctor()
	CutePetSimpleTipView.super.ctor(self)

	self._clearGo = {}
end

function CutePetSimpleTipView:buildUI()
	CutePetSimpleTipView.super.buildUI()

	self._Nego_Content = self:getGo("Nego_Content")
	self._txtName = self:getTxt("Nego_Content/Nego_Top/TxtC_Name")
	self._txtLv = self:getTxt("Nego_Content/Nego_Top/TxtC_Level")
	self._itemGo = self:getGo("Nego_Content/Nego_Top/ImgC_Con")
	self._starList = {}

	for i = 1, 6 do
		table.insert(self._starList, {
			star = self:getGo("Nego_Content/Nego_Top/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "Nego_Content/Nego_Top/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._txtAssist = self:getTxt("Nego_Content/Nego_Assist/txtDesc")
	self._txtTalent = self:getTxt("Nego_Content/Nego_Talent/txtDesc")
	self._skillTableView = self:getGo("Nego_Content/Nego_Skill/ScrollView")
	self._skillCell = self:getGo("Nego_Content/Nego_Skill/cell")
	self._skillList = ScrollerList.create(self._skillTableView, self._skillCell, GameUtil.handler(self._updateSkillCell, self), GameUtil.handler(self._clearSkillCell, self))
	self._skillSizeImmediate = goutil.findChildComponent(self._skillCell, "descbg", "ContentSizeImmediate")

	self._skillList:regGetCellSize(GameUtil.handler(self._skillCellSize, self))

	self._btnDiscard = self:getGo("Nego_Content/Nego_Top/btnDiscard")
	self._btnLock = self:getGo("Nego_Content/Nego_Top/btnLock")
	self._discardBtnGroup = goutil.findChildComponent(self.mainGO, "Nego_Content/Nego_Top/btnDiscard", "UIChangeGroup")
	self._lockBtnGroup = goutil.findChildComponent(self.mainGO, "Nego_Content/Nego_Top/btnLock", "UIChangeGroup")
	self._adjustPosition = goutil.findChildComponent(self.mainGO, "Nego_Content", "UIAdjustPosition")
	self._customInput = UICustomInput.Get(self:getGo("Nego_Content"))
end

function CutePetSimpleTipView:destroyUI()
	CutePetSimpleTipView.super.destroyUI(self)
	self._skillList:dispose()
end

function CutePetSimpleTipView:bindEvents()
	CutePetSimpleTipView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self._btnDiscard, self._onClickDiscard, self)
	GameUtil.addClickHandler(self._btnLock, self._onClickLock, self)
end

function CutePetSimpleTipView:unbindEvents()
	CutePetSimpleTipView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnDiscard)
	GameUtil.rmClickHandler(self._btnLock)
end

function CutePetSimpleTipView:onEnter()
	CutePetSimpleTipView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_SetCutePetLockStateResp, self._refreshOperateBtns, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetChangeReadyToDiscardRes, self._refreshOperateBtns, self)
	self.addGEvent(self, GlobalNotify.handlePM_SetCutePetLockStateResp, self._onLockStateChanged, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetChangeReadyToDiscardRes, self._onDiscardStateChanged, self)

	local params = self:getOpenParam()
	local data = params[1]
	local pos = params[2]
	local sizeDelta = params[3]
	local lv = checknumber(data.lv)

	self.star = checknumber(data.star)

	local raceCfg = CutePetConfig.instance:getCutePetById(data.raceId)
	local quality = checknumber(data.quality)

	if quality <= 0 then
		quality = #CutePetConfig.instance:getQualityUpPlan(raceCfg.qualityUpPlan)
	end

	if self.star <= 0 then
		CutePetConfig.instance:getMaxStar(raceCfg.planId, quality)

		self.star = 1
	end

	local talentId = checknumber(data.talentId)
	local mo = data.mo

	self._mo = nil

	if mo and mo.__cname == "CutePetMo" then
		self._mo = mo
		self.star = mo.curStar
		quality = mo.curQuality
		lv = mo.curLvl
		talentId = mo.initialTalent
	end

	self._pendingLockTips = nil
	self._pendingDiscardTips = nil

	local proxy = MaterialMgr.setCell(MatType.CutePet, raceCfg.raceId, self._itemGo)

	if proxy then
		proxy.binder:setQuality(quality)
	end

	self._txtName.text = raceCfg.name
	self._txtLv.text = lv > 0 and "Lv." .. lv or ""
	self._maxStar = CutePetConfig.instance:getMaxStar(raceCfg.starUpPlan, quality)

	for i = 1, #self._starList do
		if i <= self.star then
			self._starList[i].starChange:SetState(0)
		else
			self._starList[i].starChange:SetState(1)
		end

		if i <= self._maxStar then
			GameUtil.SetActive(self._starList[i].star, true)
		else
			GameUtil.SetActive(self._starList[i].star, false)
		end
	end

	local assistCfg = CutePetConfig.instance:getAssistanceCfg(raceCfg.type, quality)

	self._txtAssist.text = assistCfg.desc

	local skillListCfgs = CutePetConfig.instance:getStarSkillCfgs(raceCfg.raceId)

	self:_recordHeight(skillListCfgs)
	self._skillList:reloadData(skillListCfgs)

	if pos then
		self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	end

	if pos then
		GameUtil.SetActive(self.mainGO, false)
		settimer(0.1, function()
			GameUtil.SetActive(self.mainGO, true)
			Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
			self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
		end, nil, false)
	else
		Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
	end

	local talentCfg = CutePetConfig.instance:getTalentCfg(talentId)

	self._txtTalent.text = talentCfg and lang(talentCfg.desc) or lang("天赋将在获取宠物时随机激活效果")

	self:_refreshOperateBtns()
end

function CutePetSimpleTipView:onExit()
	CutePetSimpleTipView.super.onExit(self)
	MaterialMgr.resetAll(self._itemGo)

	self._mo = nil
	self._pendingLockTips = nil
	self._pendingDiscardTips = nil
end

function CutePetSimpleTipView:_updateSkillCell(view, cell, data, tag)
	local go = cell.gameObject
	local lock = goutil.findChild(go, "lock")
	local txtDesc = goutil.findChildTextComponent(go, "descbg/txtDesc")
	local txtColorChange = goutil.findChildComponent(go, "descbg/txtDesc", "UITextColorChange")
	local txtStar = goutil.findChildTextComponent(go, "star/txt")

	for i = 1, 6 do
		local star = goutil.findChild(go, "starLv/star_" .. i)

		if i <= data.star then
			GameUtil.SetActive(star, true)
		else
			GameUtil.SetActive(star, false)
		end
	end

	if data.star <= self.star then
		txtColorChange:SetState(0)
		GameUtil.SetActive(lock, false)
	else
		txtColorChange:SetState(1)
		GameUtil.SetActive(lock, true)
	end

	txtDesc.text = data.starBuffsDesc
	txtStar.text = data.star
end

function CutePetSimpleTipView:_clearSkillCell(cell)
	return
end

function CutePetSimpleTipView:_skillCellSize(view, index)
	local height = self.heightList[index + 1]

	return 326, height
end

function CutePetSimpleTipView:_recordHeight(skillList)
	goutil.setActive(self._skillCell, true)

	self.heightList = {}

	for k, data in ipairs(skillList) do
		self:_updateSkillCell(nil, self._skillCell, data)

		local size = self._skillSizeImmediate:GetPreferredSize()

		table.insert(self.heightList, math.max(25, size.y))
	end

	goutil.setActive(self._skillCell, false)
end

function CutePetSimpleTipView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function CutePetSimpleTipView:_refreshOperateBtns()
	if self._mo then
		local hasMo = self._mo.__cname == "CutePetMo"

		if not hasMo then
			GameUtil.SetActive(self._btnDiscard, false)
			GameUtil.SetActive(self._btnLock, false)

			return
		end

		GameUtil.SetActive(self._btnDiscard, true)
		GameUtil.SetActive(self._btnLock, true)

		local isLock = self._mo:getState(CutePetMo.LOCKED)
		local isDiscard = self._mo:getIsReadyToDiscard()

		self._discardBtnGroup:SetState(isDiscard and 1 or 0)
		self._lockBtnGroup:SetState(isLock and 1 or 0)
	end
end

function CutePetSimpleTipView:_onClickDiscard()
	if not self._mo then
		return
	end

	if self._mo:getState(CutePetMo.LOCKED) then
		FloatWordMgr.instance:show(lang("请先解除锁定标记"))

		return
	end

	local isDiscard = self._mo:getIsReadyToDiscard()

	self._pendingDiscardTips = isDiscard and lang("已取消弃置") or lang("已标记弃置")

	CutePetController.instance:sendPM_CutePetChangeReadyToDiscardReq(self._mo, not isDiscard)
end

function CutePetSimpleTipView:_onClickLock()
	if not self._mo then
		return
	end

	if PasswordLockController.instance:checkNeedOpenVerifyView() then
		return
	end

	local isLock = self._mo:getState(CutePetMo.LOCKED)

	if not isLock and self._mo:getIsReadyToDiscard() then
		FloatWordMgr.instance:show(lang("请先解除弃置标记"))

		return
	end

	self._pendingLockTips = isLock and lang("已解锁") or lang("已上锁")

	CutePetController.instance:sendPM_SetCutePetLockStateReq(self._mo, not isLock)
end

function CutePetSimpleTipView:_onLockStateChanged()
	if self._pendingLockTips then
		FloatWordMgr.instance:show(self._pendingLockTips)

		self._pendingLockTips = nil
	end
end

function CutePetSimpleTipView:_onDiscardStateChanged()
	if self._pendingDiscardTips then
		FloatWordMgr.instance:show(self._pendingDiscardTips)

		self._pendingDiscardTips = nil
	end
end

return CutePetSimpleTipView
