-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameHeroEntity.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameHeroEntity", package.seeall)

local AssassinStealthGameHeroEntity = class("AssassinStealthGameHeroEntity", LuaCompBase)

function AssassinStealthGameHeroEntity:ctor(uid)
	self.uid = uid
end

function AssassinStealthGameHeroEntity:init(go)
	self.go = go
	self.trans = self.go.transform
	self.transParent = self.trans.parent
	self._imagehead1 = gohelper.findChildImage(self.go, "#simage_head")
	self._gonormal = gohelper.findChild(self.go, "#go_normal")
	self._imagehp1 = gohelper.findChildImage(self.go, "#go_normal/#image_hp")
	self._gohl = gohelper.findChild(self.go, "#go_normal/image_light")
	self._goapLayout = gohelper.findChild(self.go, "#go_apLayout")
	self._goexpose = gohelper.findChild(self.go, "#go_expose")
	self._imagehp2 = gohelper.findChildImage(self.go, "#go_expose/#image_hp")
	self._gohide = gohelper.findChild(self.go, "#go_hide")
	self._godead = gohelper.findChild(self.go, "#go_dead")
	self._imagehead2 = gohelper.findChildImage(self.go, "#go_dead/#simage_head")
	self._goselected = gohelper.findChild(self.go, "#go_selected")
	self._btnclick = gohelper.findChildClickWithAudio(self.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.go, AssassinStealthGameEffectComp)
	self._apComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goapLayout, AssassinStealthGameAPComp)

	self._apComp:setHeroUid(self.uid)

	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(self.uid, true)
	local assassinHeroId = gameHeroMo:getHeroId()

	self.go.name = string.format("%s", assassinHeroId)

	local headIcon = AssassinConfig.instance:getAssassinHeroEntityIcon(assassinHeroId)

	UISpriteSetMgr.instance:setSp01AssassinSprite(self._imagehead1, headIcon)
	UISpriteSetMgr.instance:setSp01AssassinSprite(self._imagehead2, headIcon)

	self._showStatus = nil
	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))

	self:refresh()
end

function AssassinStealthGameHeroEntity:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AssassinStealthGameHeroEntity:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function AssassinStealthGameHeroEntity:_btnclickOnClick()
	AssassinStealthGameController.instance:clickHeroEntity(self.uid)
end

function AssassinStealthGameHeroEntity:changeParent(parentTrans)
	if gohelper.isNil(parentTrans) then
		return
	end

	self.trans:SetParent(parentTrans)

	self.transParent = parentTrans

	self:refreshPos()
end

function AssassinStealthGameHeroEntity:refresh(effectId)
	self:refreshStatus()
	self:refreshHp()
	self:refreshPos()
	self:refreshSelected()
	self:refreshHighlight()
	self:playEffect(effectId)
end

function AssassinStealthGameHeroEntity:refreshStatus()
	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(self.uid, true)
	local newStatus = gameHeroMo:getStatus()

	if self._showStatus and self._showStatus == newStatus then
		return
	end

	local newStatusIsHide = newStatus == AssassinEnum.HeroStatus.Hide
	local newStatusIsExpose = newStatus == AssassinEnum.HeroStatus.Expose
	local newStatusIsStealth = newStatus == AssassinEnum.HeroStatus.Stealth

	if self._showStatus == AssassinEnum.HeroStatus.Expose and newStatusIsStealth then
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_inhidden)
	end

	gohelper.setActive(self._goexpose, newStatusIsExpose)
	gohelper.setActive(self._gohide, newStatusIsHide)
	gohelper.setActive(self._gonormal, newStatusIsStealth)
	gohelper.setActive(self._godead, newStatus == AssassinEnum.HeroStatus.Dead)

	if newStatusIsExpose then
		self._animator:Play("expose", 0, 0)
	elseif newStatusIsHide then
		self._animator:Play("hide", 0, 0)
	else
		self._animator:Play("empty", 0, 0)
	end

	self._showStatus = newStatus
end

function AssassinStealthGameHeroEntity:refreshHp()
	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(self.uid, true)
	local hp = gameHeroMo:getHp() / AssassinEnum.StealthConst.HpRatePoint

	self._imagehp1.fillAmount = hp
	self._imagehp2.fillAmount = hp
end

function AssassinStealthGameHeroEntity:refreshPos()
	local heroMo = AssassinStealthGameModel.instance:getHeroMo(self.uid, true)
	local gridId, pointIndex = heroMo:getPos()
	local pos = AssassinStealthGameEntityMgr.instance:getGridPointGoPosInEntityLayer(gridId, pointIndex, self.transParent)

	transformhelper.setLocalPosXY(self.trans, pos.x, pos.y)
end

function AssassinStealthGameHeroEntity:refreshSelected()
	local isCanSelect = AssassinStealthGameHelper.isCanSelectHero(self.uid)

	gohelper.setActive(self._goselected, (isCanSelect or nil) and AssassinStealthGameModel.instance:isSelectedHero(self.uid))
end

function AssassinStealthGameHeroEntity:refreshHighlight()
	local isShowHL = AssassinStealthGameModel.instance:getIsShowHeroHighlight()

	gohelper.setActive(self._gohl, isShowHL)
end

function AssassinStealthGameHeroEntity:playEffect(effectId)
	if self._effectComp then
		self._effectComp:playEffect(effectId)
	end
end

function AssassinStealthGameHeroEntity:destroy()
	self.go:DestroyImmediate()
end

function AssassinStealthGameHeroEntity:onDestroy()
	self.uid = nil
	self._showStatus = nil
end

return AssassinStealthGameHeroEntity
