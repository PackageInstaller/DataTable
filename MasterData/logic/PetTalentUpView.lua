-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetTalentUpView.lua

module("logic.extensions.bag.view.stack.PetTalentUpView", package.seeall)

local PetTalentUpView = class("PetTalentUpView", ViewComponent)

function PetTalentUpView:ctor()
	PetTalentUpView.super.ctor(self)
end

function PetTalentUpView:destroyUI()
	PetTalentUpView.super.destroyUI(self)
end

function PetTalentUpView:onExitFinished()
	PetTalentUpView.super.onExitFinished(self)
end

function PetTalentUpView:onEnterFinished()
	PetTalentUpView.super.onEnterFinished(self)
end

function PetTalentUpView:unbindEvents()
	PetTalentUpView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
end

function PetTalentUpView:bindEvents()
	PetTalentUpView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
end

function PetTalentUpView:onExit()
	PetTalentUpView.super.onExit(self)
end

function PetTalentUpView:buildUI()
	PetTalentUpView.super.buildUI(self)

	self._closeButton = self:getBtn("btn_Close")
	self._container = self:getGo("container")
	self._txtTitle = goutil.findChildTextComponent(self._container, "top/title")
	self._txtTalentDes = goutil.findChildTextComponent(self._container, "attr/talentDes")
	self._txtSkillDes = goutil.findChildTextComponent(self._container, "skill/skillDes")
	self._cost = self:getGo("container/bottom/cost")

	local mats = goutil.findChild(self._cost, "mats")

	self._mats = ItemMatsGrid.New(mats, function()
		self:close()
	end)
	self._adjustPosition = self._container:GetComponent("UIAdjustPosition")
	self._btnUpgrade = Framework.ButtonAdapter.GetFrom(self._cost, "btn_uplv")
	self._costMoney = goutil.findChild(self._cost, "costMoney")
	self._txtCost = goutil.findChildTextComponent(self._cost, "costMoney/txt_money")
	self._txtTips = goutil.findChildTextComponent(self._cost, "txtTips")
	self._activated = self:getGo("container/bottom/activated")
	self._txtLvLimit = goutil.findChildTextComponent(self._container, "attr/txtLvLimit")
end

function PetTalentUpView:onEnter()
	PetTalentUpView.super.onEnter(self)

	self._mo = BagPetsController.instance:GetCurPetMo()

	local params = self:getOpenParam()
	local level = params[1]
	local raceId = self._mo.raceId

	self._txtTalentDes.text = "永久提升精灵所有基础属性"

	local t = CharacterConfig.instance:getPetTalentSkillAddDes(raceId, level, self._mo.curFaceId)

	self._txtSkillDes.text = ""

	for k, v in ipairs(t) do
		self._txtSkillDes.text = k == 1 and v or string.format("%s\n%s", self._txtSkillDes.text, v)
	end

	local curCfg = CharacterConfig.instance:getPetTalentCfg(raceId, math.max(0, level - 1))

	self._isGoldEnough = true
	self._isMatsEnough = true

	if curCfg ~= nil then
		if not string.nilorempty(curCfg.materialCost) then
			self._mats:onSetMo(curCfg.materialCost)
			MopupModel.instance:setPetTalentUpCostStr(curCfg.materialCost)

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

	if self._isGoldEnough then
		self._txtTitle.text = CharacterConfig.instance:getTalentName(raceId, level) .. "·天赋加成"

		local activated = level <= self._mo.talentLevel

		goutil.setActive(self._cost, not activated)
		goutil.setActive(self._activated, activated)

		self._isPowerCrystalFollower = BagModel.instance:isPowerCrystalFollower(self._mo.petId)

		if not activated then
			local showUp = level == self._mo.talentLevel + 1

			if showUp then
				showUp = not self._isPowerCrystalFollower

				if not not self._isPowerCrystalFollower then
					self._txtTips.text = "精灵已进驻力量之核，无法升级"
				end
			else
				self._txtTips.text = "当前天赋等级太低，暂无法升级"
			end

			goutil.setActive(self._costMoney, showUp)
			goutil.setActive(self._btnUpgrade.gameObject, showUp)
			goutil.setActive(self._txtTips.gameObject, not showUp)
		end

		uGuiUtil.setGoGrayState(self._btnUpgrade.gameObject, self._isPowerCrystalFollower)

		local preMaxLv = CharacterConfig.instance:getMaxLvByTalentLv(level - 1)
		local maxLv = CharacterConfig.instance:getMaxLvByTalentLv(level)

		self._txtLvLimit.text = "精灵等级上限提升至" .. maxLv

		goutil.setActive(self._txtLvLimit.gameObject, preMaxLv ~= maxLv)
	end
end

function PetTalentUpView:_onClickUpgrade()
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

function PetTalentUpView:_onUpgradeSuccess()
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.OnPetSelect)
	UIStateManager.instance:open(ViewName.PetTalentLvup, self._mo, self._preMo)
end

function PetTalentUpView:_onClickClose()
	self:close()
end

return PetTalentUpView
