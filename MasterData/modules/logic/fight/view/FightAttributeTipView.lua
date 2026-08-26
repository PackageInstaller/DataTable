-- chunkname: @modules/logic/fight/view/FightAttributeTipView.lua

module("modules.logic.fight.view.FightAttributeTipView", package.seeall)

local FightAttributeTipView = class("FightAttributeTipView", BaseView)

function FightAttributeTipView:onInitView()
	self._goattributetipcontent = gohelper.findChild(self.viewGO, "main/bg/content")
	self.attrList = {
		"attack",
		"technic",
		"defense",
		"mdefense"
	}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightAttributeTipView:addEvents()
	return
end

function FightAttributeTipView:removeEvents()
	return
end

function FightAttributeTipView:_editableInitView()
	return
end

function FightAttributeTipView:onClickModalMask()
	self:closeThis()
end

function FightAttributeTipView:_onReceiveEntityInfoReply(proto)
	self._proto = proto

	if not self._proto.entityInfo then
		self:closeThis()

		return
	end

	local data = self.viewParam.data

	self.isCharacter = self.viewParam.isCharacter
	self.attrMO = self.viewParam.mo

	if self.isCharacter then
		gohelper.CreateObjList(self, self._onAttributeTipShow, data, self._goattributetipcontent)
	else
		gohelper.CreateObjList(self, self._onMonsterAttrItemShow, data, self._goattributetipcontent)
	end
end

function FightAttributeTipView:onOpen()
	self.addEventCb(self, FightController.instance, FightEvent.onReceiveEntityInfoReply, self._onReceiveEntityInfoReply, self)
	FightRpc.instance:sendEntityInfoRequest(self.viewParam.entityMO.id)
end

function FightAttributeTipView:_onAttributeTipShow(obj, data, index)
	local transform = obj.transform
	local icon = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local name = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local config = HeroConfig.instance:getHeroAttributeCO(data.id)

	UISpriteSetMgr.instance:setCommonSprite(icon, "icon_att_" .. config.id)

	local num = transform:Find("num"):GetComponent(gohelper.Type_TextMesh)

	gohelper.setActive(num.gameObject, true)

	local baseValue = self._proto.entityInfo.baseAttr[self.attrList[index]]

	num.text = baseValue
	name.text = config.name

	local addNum = transform:Find("add"):GetComponent(gohelper.Type_TextMesh)

	addNum.text = self:_getAddValueStr(baseValue, self._proto.entityInfo.attr[self.attrList[index]])
end

function FightAttributeTipView:_getAddValueStr(baseValue, value)
	local offset = value - baseValue

	if offset >= 0 then
		return "+" .. offset
	end

	return offset
end

function FightAttributeTipView:_onMonsterAttrItemShow(obj, data, index)
	local transform = obj.transform
	local icon = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local name = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local config = HeroConfig.instance:getHeroAttributeCO(data.id)

	name.text = config.name

	UISpriteSetMgr.instance:setCommonSprite(icon, "icon_att_" .. config.id)

	local num = transform:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local addNum = transform:Find("add"):GetComponent(gohelper.Type_TextMesh)
	local rate = transform:Find("rate"):GetComponent(gohelper.Type_Image)

	if self.isCharacter then
		gohelper.setActive(num.gameObject, true)
		gohelper.setActive(addNum.gameObject, true)
		gohelper.setActive(rate.gameObject, false)

		local baseValue = self._proto.entityInfo.baseAttr[self.attrList[index]]

		num.text = self.attrMo[self.attrList[index]]
		addNum.text = self:_getAddValueStr(baseValue, self._proto.entityInfo.attr[self.attrList[index]])
	else
		gohelper.setActive(num.gameObject, false)
		gohelper.setActive(addNum.gameObject, false)
		gohelper.setActive(rate.gameObject, true)
		UISpriteSetMgr.instance:setCommonSprite(rate, "sx_" .. data.value, true)
	end
end

return FightAttributeTipView
