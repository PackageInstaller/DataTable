-- chunkname: @modules/logic/sodache/view/inside/SodacheAltarView.lua

module("modules.logic.sodache.view.inside.SodacheAltarView", package.seeall)

local SodacheAltarView = class("SodacheAltarView", BaseView)

function SodacheAltarView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "Left/#txt_title")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "Left/#scroll_descview/Viewport/Content/#txt_desc")
	self._txtlv = gohelper.findChildTextMesh(self.viewGO, "Left/#go_evil/evil/#txt_level")
	self._btnCheck = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_bottom/#btn_reveal")
	self._gorevealed = gohelper.findChild(self.viewGO, "Right/#go_bottom/#go_revealed")
	self._goevent = gohelper.findChild(self.viewGO, "Right/simage_page/event/go_eventitem")
	self._goeffectitem = gohelper.findChild(self.viewGO, "Right/simage_page/#scroll_taskview/Viewport/Content/#go_effectitem")
	self._goscroll = gohelper.findChild(self.viewGO, "Right/simage_page/#scroll_taskview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheAltarView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnCheck:AddClickListener(self.checkHandle, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnAttrUpdate, self._refreshView, self)
end

function SodacheAltarView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnCheck:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnAttrUpdate, self._refreshView, self)
end

function SodacheAltarView:_editableInitView()
	gohelper.setActive(self._goevent, false)

	self._lines = {}

	for i = 1, 4 do
		local line = gohelper.findChild(self.viewGO, "Right/simage_page/event/go_line/go_line" .. i)
		local lineInfo = self:getUserDataTb_()

		self._lines[i] = lineInfo
		lineInfo.dark = gohelper.findChild(line, "dark")
		lineInfo.light = gohelper.findChild(line, "light")
	end

	self._eventItems = {}

	for i = 1, 5 do
		local pos = gohelper.findChild(self.viewGO, "Right/simage_page/event/pos" .. i)
		local newGo = gohelper.clone(self._goevent, pos)
		local eventInfo = self:getUserDataTb_()

		self._eventItems[i] = eventInfo
		eventInfo.cur = gohelper.findChild(newGo, "cur")
		eventInfo.dark = gohelper.findChild(newGo, "dark")
		eventInfo.light = gohelper.findChild(newGo, "light")
		eventInfo.lightAnim = gohelper.findComponentAnim(eventInfo.light)

		gohelper.setActive(newGo, true)
	end
end

function SodacheAltarView:onOpen()
	self._unitMo = self.viewParam and self.viewParam.unitMo

	if self._unitMo then
		local eventCo = self._unitMo.eventCo

		if not eventCo then
			local copyCo = SodacheModel.instance:getInsideMo().copyCo

			eventCo = lua_sodache_event.configDict[copyCo.faith]
		end

		self._txttitle.text = eventCo.name
		self._txtdesc.text = eventCo.desc

		self:_refreshView()
	end
end

function SodacheAltarView:_refreshView()
	local evilVal = SodacheUtil.getAttr(SodacheEnum.AttrId.EvilValue)
	local isActive = false

	if not self._curEvilVal then
		self._curEvilVal = evilVal
	elseif self._curEvilVal ~= evilVal then
		isActive = true
		self._curEvilVal = evilVal
	end

	self._txtlv.text = evilVal

	for i = 1, 4 do
		local lineInfo = self._lines[i]

		gohelper.setActive(lineInfo.light, i < evilVal)
		gohelper.setActive(lineInfo.dark, evilVal <= i)
	end

	for i = 1, 5 do
		local eventInfo = self._eventItems[i]
		local isCur = false

		if self._unitMo then
			isCur = self:isUnitChecked() and evilVal == i or evilVal + 1 == i
		end

		gohelper.setActive(eventInfo.cur, isCur)
		gohelper.setActive(eventInfo.light, i <= evilVal)
		gohelper.setActive(eventInfo.dark, evilVal < i)

		if isCur and isActive then
			eventInfo.lightAnim:Play("activate")
		end
	end

	local effects = {}
	local insideMo = SodacheModel.instance:getInsideMo()

	for i, v in ipairs(insideMo.prop.altarSkillIds) do
		local skillCo = lua_sodache_skill.configDict[v]
		local isCur = false

		if self._unitMo then
			isCur = self:isUnitChecked() and evilVal == i or evilVal + 1 == i
		end

		table.insert(effects, {
			isActive = true,
			desc = skillCo.desc,
			isCur = isCur
		})
	end

	for i = #effects + 1, 5 do
		local isCur = false

		if self._unitMo then
			isCur = self:isUnitChecked() and evilVal == i or evilVal + 1 == i
		end

		table.insert(effects, {
			isActive = false,
			desc = luaLang("sodache_altarview_lockdesc"),
			isCur = isCur
		})
	end

	self._animTxt = self._animTxt or self:getUserDataTb_()

	gohelper.CreateObjList(self, self._createDesc, effects, nil, self._goeffectitem)
	gohelper.setActive(self._btnCheck, self._unitMo and not self:isUnitChecked())
	gohelper.setActive(self._gorevealed, self._unitMo and self:isUnitChecked())

	if not self._unitMo then
		recthelper.setHeight(self._goscroll.transform, 608)
		recthelper.setAnchorY(self._goscroll.transform, -128.5)
	end

	if isActive and self._animTxt[evilVal] then
		self._animTxt[evilVal]:Play("unlock")
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.altar_lvup)
	end
end

function SodacheAltarView:_createDesc(obj, data, index)
	local unlock = gohelper.findChild(obj, "go_unlock")
	local locked = gohelper.findChild(obj, "go_locked")

	gohelper.setActive(unlock, data.isActive)
	gohelper.setActive(locked, not data.isActive)

	local go = data.isActive and unlock or locked
	local txt = gohelper.findChildTextMesh(go, "#txt_effect")
	local arrow = gohelper.findChild(go, "#txt_effect/go_curArrow")

	gohelper.setActive(arrow, data.isCur)

	txt.text = index .. "." .. SodacheUtil.changeDescColor(data.desc)

	local anim = gohelper.findComponentAnim(obj)

	anim:Play(data.isActive and "unlock_idle" or "lock_idle")

	self._animTxt[index] = anim
end

function SodacheAltarView:checkHandle()
	SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.Interaction, tostring(self._unitMo.uid))
end

function SodacheAltarView:isUnitChecked()
	local insideMo = SodacheModel.instance:getInsideMo()

	if insideMo.copyCo.adoLv <= SodacheUtil.getAttr(SodacheEnum.AttrId.EvilValue) then
		return true
	end

	if not self._unitMo then
		logError("理论上不会执行这里!!!!")

		return true
	end

	return self._unitMo.status == SodacheEnum.UnitStatus.Finish
end

return SodacheAltarView
