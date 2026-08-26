-- chunkname: @modules/logic/fight/view/preview/SkillEditorBuffSelectItem.lua

module("modules.logic.fight.view.preview.SkillEditorBuffSelectItem", package.seeall)

local SkillEditorBuffSelectItem = class("SkillEditorBuffSelectItem", ListScrollCell)

function SkillEditorBuffSelectItem:init(go)
	self.go = go
	self._text = gohelper.findChildText(go, "Text")
	self._text1 = gohelper.findChildText(go, "imgSelect/Text")
	self._click = SLFramework.UGUI.UIClickListener.Get(go)
	self._selectGO = gohelper.findChild(go, "imgSelect")
	self._textAddLayer1 = nil
	self._textAddLayer10 = nil
end

function SkillEditorBuffSelectItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
end

function SkillEditorBuffSelectItem:removeEventListeners()
	self._click:RemoveClickListener()

	if self._clickLayer1 then
		self._clickLayer1:RemoveClickListener()
		self._clickLayer10:RemoveClickListener()
	end
end

function SkillEditorBuffSelectItem:onUpdateMO(mo)
	self._mo = mo

	local co = mo.co
	local attacker = SkillEditorBuffSelectModel.instance.attacker

	self._text.text = co.id .. "\n" .. co.name
	self._text1.text = co.id .. "\n" .. co.name

	local hasBuff = self:_getEntityBuffMO(attacker, co.id) ~= nil

	gohelper.setActive(self._text.gameObject, not hasBuff)
	gohelper.setActive(self._selectGO, hasBuff)

	self._canShowLayer = false

	if hasBuff then
		for _, fbleCO in ipairs(lua_fight_buff_layer_effect.configList) do
			if fbleCO.id == co.id then
				self._canShowLayer = true

				break
			end
		end
	end

	if self._canShowLayer and not self._textAddLayer1 then
		local cloneLayer1 = gohelper.cloneInPlace(self._text.gameObject, "layer1")
		local cloneLayer10 = gohelper.cloneInPlace(self._text.gameObject, "layer10")

		self._textAddLayer1 = gohelper.findChildText(self.go, "layer1")
		self._textAddLayer10 = gohelper.findChildText(self.go, "layer10")
		self._textAddLayer1.text = "<color=white>+1层</color>"
		self._textAddLayer10.text = "<color=white>+10层</color>"
		self._textAddLayer1.raycastTarget = true
		self._textAddLayer10.raycastTarget = true
		self._clickLayer1 = gohelper.getClick(cloneLayer1)
		self._clickLayer10 = gohelper.getClick(cloneLayer10)

		self._clickLayer1:AddClickListener(self._onClickAddLayer1, self)
		self._clickLayer10:AddClickListener(self._onClickAddLayer10, self)
		recthelper.setAnchor(self._textAddLayer1.transform, 100, 25)
		recthelper.setAnchor(self._textAddLayer10.transform, 100, -10)
	end

	if self._textAddLayer1 then
		gohelper.setActive(self._textAddLayer1.gameObject, self._canShowLayer)
		gohelper.setActive(self._textAddLayer10.gameObject, self._canShowLayer)
	end
end

function SkillEditorBuffSelectItem:_onClickAddLayer1()
	local attacker = SkillEditorBuffSelectModel.instance.attacker
	local existBuffMO = self:_getEntityBuffMO(attacker, self._mo.co.id)

	if existBuffMO.layer then
		existBuffMO.layer = existBuffMO.layer + 1 or 1
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, attacker.id, FightEnum.EffectType.BUFFUPDATE, self._mo.co.id, existBuffMO.uid, 0)
	FightController.instance:dispatchEvent(FightEvent.SkillEditorRefreshBuff, self._mo.co.id)
end

function SkillEditorBuffSelectItem:_onClickAddLayer10()
	local attacker = SkillEditorBuffSelectModel.instance.attacker
	local existBuffMO = self:_getEntityBuffMO(attacker, self._mo.co.id)

	if existBuffMO.layer then
		existBuffMO.layer = existBuffMO.layer + 10 or 10
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, attacker.id, FightEnum.EffectType.BUFFUPDATE, self._mo.co.id, existBuffMO.uid, 0)
	FightController.instance:dispatchEvent(FightEvent.SkillEditorRefreshBuff, self._mo.co.id)
end

function SkillEditorBuffSelectItem:_onClickThis()
	local attacker = SkillEditorBuffSelectModel.instance.attacker
	local buffCO = self._mo.co
	local existBuffMO = self:_getEntityBuffMO(attacker, buffCO.id)

	if existBuffMO == nil then
		local buffProto = FightDef_pb.BuffInfo()

		buffProto.buffId = buffCO.id
		buffProto.duration = 1
		buffProto.count = 1
		buffProto.uid = SkillEditorBuffSelectView.genBuffUid()

		local buffMO = FightBuffInfoData.New(buffProto, attacker.id)

		attacker:getMO():addBuff(buffMO)
		attacker.buff:addBuff(buffMO)

		if SkillEditorBuffSelectView._show_frame then
			FightController.instance:dispatchEvent(FightEvent.OnEditorPlayBuffStart)
		end

		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, attacker.id, FightEnum.EffectType.BUFFADD, buffCO.id, buffMO.uid)
	else
		attacker:getMO():delBuff(existBuffMO.uid)
		attacker.buff:delBuff(existBuffMO.uid)
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, attacker.id, FightEnum.EffectType.BUFFDEL, buffCO.id, existBuffMO.uid)
	end

	if buffCO.typeId == 5001 then
		attacker.nameUI:setShield(math.floor(attacker.nameUI:getHp() * 0.1 + 0.5))
	end

	FightController.instance:dispatchEvent(FightEvent.SkillEditorRefreshBuff, buffCO.id)
	self:onUpdateMO(self._mo)
end

function SkillEditorBuffSelectItem:_getEntityBuffMO(entity, buffId)
	local buffDic = entity:getMO():getBuffDic()

	for _, buffMO in pairs(buffDic) do
		if buffMO.buffId == buffId then
			return buffMO
		end
	end

	return nil
end

return SkillEditorBuffSelectItem
