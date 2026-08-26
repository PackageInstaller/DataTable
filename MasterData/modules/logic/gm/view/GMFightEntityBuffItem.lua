-- chunkname: @modules/logic/gm/view/GMFightEntityBuffItem.lua

module("modules.logic.gm.view.GMFightEntityBuffItem", package.seeall)

local GMFightEntityBuffItem = class("GMFightEntityBuffItem", ListScrollCell)

function GMFightEntityBuffItem:init(go)
	self._go = go
	self._id = gohelper.findChildTextMeshInputField(go, "id")
	self._name = gohelper.findChildText(go, "name")
	self._type = gohelper.findChildText(go, "type")
	self._set = gohelper.findChildText(go, "set")
	self._duration = gohelper.findChildTextMeshInputField(go, "duration")
	self._count = gohelper.findChildTextMeshInputField(go, "count")
	self._layer = gohelper.findChildTextMeshInputField(go, "layer")
	self._btnDel = gohelper.findChildButtonWithAudio(go, "btnDel")
end

function GMFightEntityBuffItem:addEventListeners()
	self._btnDel:AddClickListener(self._onClickDel, self)
	self._duration:AddOnEndEdit(self._onAddEditDuration, self)
	self._count:AddOnEndEdit(self._onAddEditCount, self)
	self._layer:AddOnEndEdit(self._onAddEditLayer, self)
end

function GMFightEntityBuffItem:removeEventListeners()
	self._btnDel:RemoveClickListener()
	self._duration:RemoveOnEndEdit()
	self._count:RemoveOnEndEdit()
	self._layer:RemoveOnEndEdit()
end

function GMFightEntityBuffItem:onUpdateMO(mo)
	self._mo = mo

	local buffCO = lua_skill_buff.configDict[self._mo.buffId]
	local buffTypeCO = buffCO and lua_skill_bufftype.configDict[buffCO.typeId]

	self._id:SetText(tostring(self._mo.buffId))

	if buffCO then
		self._name.text = buffCO.name or ""
	end

	self._type.text = buffCO and tostring(buffCO.typeId) or ""
	self._set.text = buffTypeCO and tostring(buffTypeCO.type) or ""

	self._duration:SetText(tostring(self._mo.duration) or "")
	self._count:SetText(tostring(self._mo.count) or "")
	self._layer:SetText(tostring(self._mo.layer) or "")
end

function GMFightEntityBuffItem:_onClickDel()
	local buffCO = lua_skill_buff.configDict[self._mo.buffId]

	if buffCO then
		GameFacade.showToast(ToastEnum.IconId, "del buff " .. buffCO.name)
	else
		GameFacade.showToast(ToastEnum.IconId, "buff config not exist")
	end

	local entityMO = GMFightEntityModel.instance.entityMO

	GMRpc.instance:sendGMRequest(string.format("fightDelBuff %s %s", tostring(entityMO.id), tostring(self._mo.uid)))
	entityMO:delBuff(self._mo.uid)

	local entity = FightHelper.getEntity(entityMO.id)

	if entity and entity.buff then
		entity.buff:delBuff(self._mo.uid)
	end

	local localData = FightLocalDataMgr.instance.entityMgr:getById(entityMO.id)

	if localData then
		localData:delBuff(self._mo.uid)
	end

	FightMsgMgr.sendMsg(FightMsgId.OnUpdateBuff, self._mo)
	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, entityMO.id, FightEnum.EffectType.BUFFDEL, self._mo.buffId, self._mo.uid, 0, self._mo)
	FightRpc.instance:sendEntityInfoRequest(entityMO.id)
end

function GMFightEntityBuffItem:_onAddEditDuration(inputStr)
	local targetDuration = tonumber(inputStr)

	if targetDuration and (targetDuration == -1 or targetDuration > 0) then
		local entityMO = GMFightEntityModel.instance.entityMO

		self._mo.duration = targetDuration

		local localData = FightLocalDataMgr.instance.entityMgr:getById(entityMO.id)

		if localData then
			local buffMO = localData:getBuffMO(self._mo.uid)

			if buffMO then
				buffMO.duration = targetDuration
			end
		end

		GMRpc.instance:sendGMRequest(string.format("fightChangeBuff %s %s %d %d %d", entityMO.id, self._mo.id, self._mo.count, targetDuration, self._mo.layer))
		FightMsgMgr.sendMsg(FightMsgId.OnUpdateBuff, self._mo)
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, entityMO.id, FightEnum.EffectType.BUFFUPDATE, self._mo.buffId, self._mo.uid, 0)
	else
		self._duration:SetText(tostring(self._mo.duration) or "")
		GameFacade.showToast(ToastEnum.IconId, "修正数值错误")
	end
end

function GMFightEntityBuffItem:_onAddEditCount(inputStr)
	local targetCount = tonumber(inputStr)

	if targetCount and targetCount > 0 then
		local entityMO = GMFightEntityModel.instance.entityMO

		self._mo.count = targetCount

		local localData = FightLocalDataMgr.instance.entityMgr:getById(entityMO.id)

		if localData then
			local buffMO = localData:getBuffMO(self._mo.uid)

			if buffMO then
				buffMO.count = targetCount
			end
		end

		GMRpc.instance:sendGMRequest(string.format("fightChangeBuff %s %s %d %d %d", entityMO.id, self._mo.id, targetCount, self._mo.duration, self._mo.layer))
		FightMsgMgr.sendMsg(FightMsgId.OnUpdateBuff, self._mo)
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, entityMO.id, FightEnum.EffectType.BUFFUPDATE, self._mo.buffId, self._mo.uid, 0)
	else
		self._count:SetText(tostring(self._mo.count) or "")
		GameFacade.showToast(ToastEnum.IconId, "修正数值错误")
	end
end

function GMFightEntityBuffItem:_onAddEditLayer(inputStr)
	local targetLayer = tonumber(inputStr)

	if targetLayer and targetLayer > 0 then
		local entityMO = GMFightEntityModel.instance.entityMO

		self._mo.layer = targetLayer

		local localData = FightLocalDataMgr.instance.entityMgr:getById(entityMO.id)

		if localData then
			local buffMO = localData:getBuffMO(self._mo.uid)

			if buffMO then
				buffMO.layer = targetLayer
			end
		end

		GMRpc.instance:sendGMRequest(string.format("fightChangeBuff %s %s %d %d %d", entityMO.id, self._mo.id, self._mo.count, self._mo.duration, targetLayer))
		FightMsgMgr.sendMsg(FightMsgId.OnUpdateBuff, self._mo)
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, entityMO.id, FightEnum.EffectType.BUFFUPDATE, self._mo.buffId, self._mo.uid, 0)
	else
		self._layer:SetText(tostring(self._mo.layer) or "")
		GameFacade.showToast(ToastEnum.IconId, "修正数值错误")
	end
end

return GMFightEntityBuffItem
