-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/TravelGoAttrComp.lua

module("modules.logic.versionactivity3_7.travelgo.view.TravelGoAttrComp", package.seeall)

local TravelGoAttrComp = class("TravelGoAttrComp", LuaCompBase)

function TravelGoAttrComp:init(viewGO)
	self.viewGO = viewGO
	self.btncloseattrtip = gohelper.findChildClick(viewGO, "#btn_closeAttr")
	self.gocloseattrtipbtn = self.btncloseattrtip.gameObject

	local goexp = gohelper.findChild(viewGO, "exp")

	self.expanimator = goexp:GetComponent(gohelper.Type_Animator)
	self.textLevel = gohelper.findChildTextMesh(viewGO, "exp/#txt_Value")
	self.txtExp = gohelper.findChildTextMesh(viewGO, "exp/#txt_exp")
	self.expImage = gohelper.findChildImage(viewGO, "exp/image_SliderFG")
	self.AttrType = TravelGoBattleEnum.AttrType

	local goattack = gohelper.findChild(viewGO, "attack")

	self.attackanimator = goattack:GetComponent(gohelper.Type_Animator)
	self.textAttack = gohelper.findChildTextMesh(viewGO, "attack/#txt_Value")
	self.btnattack = gohelper.findChildClickWithDefaultAudio(viewGO, "attack/#btn_click")

	local goattackTip = gohelper.findChild(viewGO, "attack/#go_Tips")

	self:initAttrTip(self.AttrType.Attack, goattackTip)

	local godefence = gohelper.findChild(viewGO, "defence")

	self.defenceanimator = godefence:GetComponent(gohelper.Type_Animator)
	self.textDefence = gohelper.findChildTextMesh(viewGO, "defence/#txt_Value")
	self.btndefence = gohelper.findChildClickWithDefaultAudio(viewGO, "defence/#btn_click")

	local godefenceTip = gohelper.findChild(viewGO, "defence/#go_Tips")

	self:initAttrTip(self.AttrType.Defence, godefenceTip)

	local gohp = gohelper.findChild(viewGO, "hp")

	self.hpanimator = gohp:GetComponent(gohelper.Type_Animator)
	self.textHp = gohelper.findChildTextMesh(viewGO, "hp/#txt_Value")
	self.hpImage = gohelper.findChildImage(viewGO, "hp/image_SliderFG")
	self.btnhp = gohelper.findChildClickWithDefaultAudio(viewGO, "hp/#btn_click")

	local gohpTip = gohelper.findChild(viewGO, "hp/#go_Tips")

	self:initAttrTip(self.AttrType.Hp, gohpTip)
end

function TravelGoAttrComp:initAttrTip(attrId, goTip)
	local attrCfg = attrId and lua_activity220_attribute.configDict[attrId]

	if not attrCfg or gohelper.isNil(goTip) then
		return
	end

	self._attrTipItemDict = self._attrTipItemDict or {}

	local tipItem = self:getUserDataTb_()

	tipItem.go = goTip
	tipItem.txtValue = gohelper.findChildTextMesh(goTip, "#txt_Name/#txt_Value")

	local txtDesc = gohelper.findChildTextMesh(goTip, "#txt_Name")

	txtDesc.text = attrCfg.desc
	self._attrTipItemDict[attrId] = tipItem
end

function TravelGoAttrComp:addEventListeners()
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnAttrChange, self.onAttrChange, self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnExpChange, self.onExpChange, self)
	self.btnattack:AddClickListener(self._onAttrBtnClick, self, self.AttrType.Attack)
	self.btndefence:AddClickListener(self._onAttrBtnClick, self, self.AttrType.Defence)
	self.btnhp:AddClickListener(self._onAttrBtnClick, self, self.AttrType.Hp)
	self.btncloseattrtip:AddClickListener(self.setAttrTipShow, self)
end

function TravelGoAttrComp:removeEventListeners()
	self.btnattack:RemoveClickListener()
	self.btndefence:RemoveClickListener()
	self.btnhp:RemoveClickListener()
	self.btncloseattrtip:RemoveClickListener()
end

function TravelGoAttrComp:_onAttrBtnClick(attrId)
	if not attrId then
		return
	end

	if self._curShowAttrTipId == attrId then
		self:setAttrTipShow()
	else
		self:setAttrTipShow(attrId)
	end
end

function TravelGoAttrComp:setAttrTipShow(attrId)
	if not self._attrTipItemDict then
		return
	end

	if self._curShowAttrTipId then
		local curShowTipItem = self._attrTipItemDict[self._curShowAttrTipId]

		if curShowTipItem then
			gohelper.setActive(curShowTipItem.go, false)
		end

		local showTipItem = attrId and self._attrTipItemDict[attrId]

		if showTipItem then
			self:refreshAttrTip(attrId)
			gohelper.setActive(showTipItem.go, true)

			self._curShowAttrTipId = attrId
		else
			self._curShowAttrTipId = nil
		end

		gohelper.setActive(self.gocloseattrtipbtn, self._curShowAttrTipId)
	end
end

function TravelGoAttrComp:onOpen()
	self.attrAnim = {
		[self.AttrType.Defence] = {
			value = 0,
			animator = self.defenceanimator,
			txt = self.textDefence
		},
		[self.AttrType.Attack] = {
			value = 0,
			animator = self.attackanimator,
			txt = self.textAttack
		}
	}
	self.entity = TravelGoController.instance.travelGoEntityMgr.playerEntity

	local attributes = self.entity.attributes

	for attrId, v in pairs(self.attrAnim) do
		local value = attributes:getAttr(attrId)

		v.value = TravelGoController.instance:formatNumber(value)
		v.txt.text = v.value
	end

	self:setExpValue(TravelGoModel.instance.exp)
	self:refreshHp()
	self:setAttrTipShow()
end

function TravelGoAttrComp:onStart()
	return
end

function TravelGoAttrComp:onAttrChange(param)
	local entity = param.entity

	if entity.uid ~= self.entity.uid then
		return
	end

	local attrId = param.attrId
	local value = param.value

	if attrId == self.AttrType.Defence or attrId == self.AttrType.Attack then
		local flow = self.attrAnim[attrId].flow

		if flow then
			flow:destroy()
		end

		local flowSequence = FlowSequence.New()
		local formatValue = TravelGoController.instance:formatNumber(value)

		flowSequence:addWork(TweenWork.New({
			type = "DOTweenFloat",
			t = 1,
			from = self.attrAnim[attrId].value,
			to = formatValue,
			frameCb = self.setValue,
			cbObj = self,
			param = attrId,
			ease = EaseType.OutQuart
		}))

		self.attrAnim[attrId].flow = flowSequence

		flowSequence:start()

		if value > self.attrAnim[attrId].value then
			self.attrAnim[attrId].animator:Play("up", 0, 0)
			AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_tangren_ding)
		end
	elseif attrId == self.AttrType.Hp or attrId == self.AttrType.MaxHp then
		self:refreshHp()
	end

	self:refreshAttrTip(attrId)
end

function TravelGoAttrComp:refreshAttrTip(argsAttrId)
	if not argsAttrId then
		return
	end

	local attrId = argsAttrId

	if argsAttrId == self.AttrType.MaxHp then
		attrId = self.AttrType.Hp
	end

	if self._attrTipItemDict then
		local tipItem = self._attrTipItemDict[attrId]

		if not tipItem then
			return
		end

		local attributes = TravelGoController.instance.travelGoEntityMgr.playerEntity.attributes

		if attrId == self.AttrType.Hp then
			local hp = attributes:getHp()
			local hpStr = TravelGoController.instance:formatNumber(hp)
			local maxHp = attributes:getMaxHp()
			local maxHpStr = TravelGoController.instance:formatNumber(maxHp)

			tipItem.txtValue.text = string.format("%s/%s", hpStr, maxHpStr)
		else
			local value = attributes:getAttr(attrId)

			tipItem.txtValue.text = TravelGoController.instance:formatNumber(value)
		end
	end
end

function TravelGoAttrComp:refreshHp()
	local hp = TravelGoController.instance.travelGoEntityMgr.playerEntity.attributes:getHp()
	local maxHp = TravelGoController.instance.travelGoEntityMgr.playerEntity.attributes:getMaxHp()
	local hpStr = TravelGoController.instance:formatNumber(hp)
	local maxHpStr = TravelGoController.instance:formatNumber(maxHp)
	local hpArr = string.splitToNumber(self.textHp.text, "/")
	local oldHp, oldMaxHp = hpArr[1], hpArr[2]

	if oldHp and oldHp < hpStr or oldMaxHp and oldMaxHp < maxHpStr then
		self.hpanimator:Play("up", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_tangren_ding)
	end

	self.textHp.text = string.format("%s/%s", hpStr, maxHpStr)
	self.hpImage.fillAmount = hp / maxHp
end

function TravelGoAttrComp:setValue(num, attrId)
	local formatNum = TravelGoController.instance:formatNumber(num)

	self.attrAnim[attrId].value = formatNum
	self.attrAnim[attrId].txt.text = formatNum
end

function TravelGoAttrComp:onExpChange()
	if self.expFlow then
		self.expFlow:destroy()

		self.expFlow = nil
	end

	local animName
	local newExp = TravelGoModel.instance.exp
	local oldLevel = tonumber(self.textLevel.text)
	local oldFillAmount = self.expImage.fillAmount
	local newLevel = math.floor(newExp / TravelGoModel.instance.levelUpNeed) + 1
	local levelExp = newExp - TravelGoModel.instance.levelUpNeed * (newLevel - 1)
	local newFillAmount = levelExp / TravelGoModel.instance.levelUpNeed

	if oldLevel and oldLevel < newLevel then
		animName = "levelup"
	elseif oldFillAmount < newFillAmount then
		animName = "add"
	end

	self.expFlow = FlowSequence.New()

	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_qiutu_progress_loop)
	self.expFlow:addWork(TweenWork.New({
		type = "DOTweenFloat",
		t = 1.5,
		from = self.curExp,
		to = newExp,
		frameCb = self.setExpValue,
		cbObj = self,
		ease = EaseType.Linear
	}))
	self.expFlow:addWork(FunctionWork.New(self.stopAudio, self))
	self.expFlow:start()

	if not string.nilorempty(animName) then
		self.expanimator:Play(animName, 0, 0)
	end
end

function TravelGoAttrComp:setExpValue(num)
	local level = math.floor(num / TravelGoModel.instance.levelUpNeed) + 1
	local exp = num - TravelGoModel.instance.levelUpNeed * (level - 1)

	self.txtExp.text = string.format("%s/%s", math.floor(exp), TravelGoModel.instance.levelUpNeed)
	self.textLevel.text = level
	self.expImage.fillAmount = exp / TravelGoModel.instance.levelUpNeed
	self.curExp = num
end

function TravelGoAttrComp:stopAudio()
	AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.stop_ui_qiutu_progress_loop)
end

function TravelGoAttrComp:onDestroy()
	for i, v in ipairs(self.attrAnim) do
		if v.flow then
			v.flow:destroy()
		end
	end

	if self.expFlow then
		self.expFlow:destroy()

		self.expFlow = nil
	end
end

return TravelGoAttrComp
