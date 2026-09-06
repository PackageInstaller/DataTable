-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetTalentView.lua

module("logic.extensions.bag.view.stack.PetTalentView", package.seeall)

local PetTalentView = class("PetTalentView", ViewComponent)

function PetTalentView:getBigBgList()
	return {}
end

function PetTalentView:ctor()
	PetTalentView.super.ctor(self)
end

function PetTalentView:destroyUI()
	PetTalentView.super.destroyUI(self)
end

function PetTalentView:onExitFinished()
	PetTalentView.super.onExitFinished(self)
end

function PetTalentView:onEnterFinished()
	PetTalentView.super.onEnterFinished(self)
end

function PetTalentView:unbindEvents()
	PetTalentView.super.unbindEvents(self)
	self._btnUpgrade:RemoveClickListener()
	self._btnTips:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSweep:RemoveClickListener()
end

function PetTalentView:bindEvents()
	PetTalentView.super.bindEvents(self)
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
	self._btnTips:AddClickListener(self._onClickTips, self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnSweep:AddClickListener(self._onClickSweep, self)
end

function PetTalentView:onExit()
	PetTalentView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self._updateUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.SweepUpdate, self._updateUI, self)
end

function PetTalentView:buildUI()
	PetTalentView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "title")
	self._mid = self:getGo("mid")
	self._txtLeftTitle = goutil.findChildTextComponent(self._mid, "title/txt_left_val")
	self._txtRightTitle = goutil.findChildTextComponent(self._mid, "title/txt_right_val")
	self._txtLeftLv = goutil.findChildTextComponent(self._mid, "level/txt_left_val")
	self._txtRightLv = goutil.findChildTextComponent(self._mid, "level/txt_right_val")
	self._txtSkillDes = goutil.findChildTextComponent(self._mid, "skill/txt_val")
	self._cost = self:getGo("bom")
	self._mats = ItemMatsGrid.New(goutil.findChild(self._cost, "mats"))
	self._btnUpgrade = Framework.ButtonAdapter.GetFrom(self._cost, "btn_uplv")
	self._costMoney = goutil.findChild(self._cost, "costMoney")
	self._txtCost = goutil.findChildTextComponent(self._costMoney, "txt_money")
	self._redPoint = goutil.findChild(self._btnUpgrade.gameObject, "redPoint")
	self._btnTips = self:getBtn("mid/attr/btnTips")
	self._btnClose = self:getBtn("btnClose")
	self._bom = self:getGo("bom")
	self._btnSweep = self:getBtn("bom/btnSweep")
	self._tipPos = self:getGo("tipPos")
end

function PetTalentView:onEnter()
	PetTalentView.super.onEnter(self)
	self:_updateUI()
	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self._updateUI, self)
	GlobalDispatcher:addListener(GlobalNotify.SweepUpdate, self._updateUI, self)
end

function PetTalentView:_updateUI()
	self._mo = BagPetsController.instance:GetCurPetMo()

	local cfg = CharacterConfig.instance:getPetCo(self._mo.raceId)
	local talentLevel = self._mo.talentLevel
	local targetLevel = math.min(CharacterConfig.instance:getMaxTalentLv(), talentLevel + 1)
	local raceId = self._mo.raceId
	local isMax = self._mo:isMaxTalent()

	if not isMax then
		self._txtRightTitle.text = CharacterConfig.instance:getTalentName(self._mo.raceId, targetLevel)
		self._txtRightLv.text = CharacterConfig.instance:getMaxLvByTalentLv(targetLevel)
	end

	self._txtTitle.text = CharacterConfig.instance:getTalentName(raceId, talentLevel)
	self._txtLeftTitle.text = self._txtTitle.text
	self._txtLeftLv.text = CharacterConfig.instance:getMaxLvByTalentLv(talentLevel)
	self._attrsContent = ""

	local curCfg = CharacterConfig.instance:getPetTalentCfg(raceId, math.max(0, talentLevel))

	self._isGoldEnough = true
	self._isMatsEnough = true

	if curCfg ~= nil then
		if not string.nilorempty(curCfg.materialCost) then
			self._mats:onSetMo(curCfg.materialCost)
			MopupModel.instance:setPetTalentUpCostStr(curCfg.materialCost)

			self._curMatarialCost = curCfg.materialCost
			self._isMatsEnough = self._mats:getMatsIsEnough()
		end

		local curNum = MaterialFacade.instance:getMatNumber(MatType.Coin, 1)
		local needNum = checknumber(curCfg.upgradeCoinCost)

		self._txtCost.text = string.format("%s", needNum)
		self._isGoldEnough = needNum <= curNum

		if not self._isGoldEnough then
			self._txtCost.text = string.format("<color=#C54949FF>%s</color>", self._txtCost.text)
		end
	end

	local targetCfg = CharacterConfig.instance:getPetTalentCfg(raceId, math.max(0, targetLevel))

	if targetCfg then
		self._attrsContent = ""

		local curMap = self:getAttrMap(curCfg.levelProps)
		local targetMap = self:getAttrMap(targetCfg.levelProps)
		local isFirst = true

		for k, v in pairs(targetMap) do
			local val = v

			if curMap[k] then
				val = targetMap[k] - curMap[k]
			end

			val = math.max(0, val)

			if isFirst then
				isFirst = false
				self._attrsContent = k .. "+" .. val
			else
				self._attrsContent = self._attrsContent .. "#" .. k .. "+" .. val
			end
		end
	end

	self._isPowerCrystalFollower = BagModel.instance:isPowerCrystalFollower(self._mo.petId)

	uGuiUtil.setGoGrayState(self._btnUpgrade.gameObject, self._isPowerCrystalFollower)

	if self._isGoldEnough then
		local canUpgrade = self._isMatsEnough

		goutil.setActive(self._redPoint, canUpgrade and not self._isPowerCrystalFollower)
		self:_updateMaxStatus(isMax)
		self:_updateButtonActive(self._isMatsEnough, self._mats:isOneGainWayAtLeast())
	end
end

function PetTalentView:_updateButtonActive(isMatEnough, isExistGainWay)
	goutil.setActive(self._btnUpgrade.gameObject, isMatEnough or not isExistGainWay)
	goutil.setActive(self._costMoney, isMatEnough or not isExistGainWay)
	goutil.setActive(self._btnSweep.gameObject, not isMatEnough and isExistGainWay)
end

function PetTalentView:getAttrMap(str)
	local t = string.split(str, "#")
	local map = {}

	for _, v in ipairs(t) do
		local attr = string.split(v, "+")
		local key = attr[1]

		map[key] = attr[2]
	end

	return map
end

function PetTalentView:_updateMaxStatus(isMax)
	goutil.setActive(self._btnTips.gameObject, not isMax)
	goutil.setActive(self._bom, not isMax)

	if isMax then
		self._txtLeftLv.text = "等级已达上限"
		self._txtLeftTitle.text = "已达最高天赋"
		self._txtSkillDes.text = "所有等级已满"
	end
end

function PetTalentView:_updatePos(left, right, isCenter)
	left = left:GetComponent("RectTransform")
	right = right:GetComponent("RectTransform")

	local x, y = Framework.TransformUtil.GetAnchoredPos(left, 0, 0)

	if isCenter then
		Framework.TransformUtil.SetAnchoredPos(left, 0, y)
		goutil.setActive(right.gameObject, false)
	else
		Framework.TransformUtil.SetAnchoredPos(right, -x, y)
		goutil.setActive(right.gameObject, true)
	end
end

function PetTalentView:_onClickUpgrade()
	if self._isPowerCrystalFollower then
		FloatWordMgr.instance:show("该精灵进驻在力量之核中，无法提升天赋等级")

		return
	elseif not self._mats:getMatsIsEnough() then
		FloatWordMgr.instance:show("当前材料不足")
	elseif not self._isGoldEnough then
		FloatWordMgr.instance:show("当前金币不足")
	else
		self._preMo = self._mo:GetClone()

		PetAgent.instance:sendPM_UpgradeTalentReq(self._mo.petId, self._onUpgradeSuccess, self)
	end
end

function PetTalentView:_onUpgradeSuccess()
	self:_updateUI()
	UIStateManager.instance:open(ViewName.PetTalentLvup, self._mo, self._preMo)
	self:close()
end

function PetTalentView:_onClickClose()
	self:close()
end

function PetTalentView:_onClickDetail()
	UIStateManager.instance:open(ViewName.PetTalentDetail)
end

function PetTalentView:_onClickTalent(i)
	UIStateManager.instance:open(ViewName.PetTalentUp, i)
end

function PetTalentView:_onClickTips()
	local rect = self._tipPos:GetComponent("RectTransform")
	local pos = self._tipPos.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	UIStateManager.instance:open(ViewName.PetAttrPopUpView, pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}, self._attrsContent)
end

function PetTalentView:_onClickSweep()
	printInfo("test 打开扫荡界面")

	if not string.nilorempty(self._curMatarialCost) then
		MopupModel.instance:clickOneKeySweep(self._curMatarialCost)
	end
end

return PetTalentView
