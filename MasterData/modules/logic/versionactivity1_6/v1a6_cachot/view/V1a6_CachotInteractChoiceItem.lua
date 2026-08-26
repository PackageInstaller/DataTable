-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotInteractChoiceItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotInteractChoiceItem", package.seeall)

local V1a6_CachotInteractChoiceItem = class("V1a6_CachotInteractChoiceItem", LuaCompBase)

function V1a6_CachotInteractChoiceItem:init(go)
	self._gonormal = gohelper.findChild(go, "normal")
	self._goselect = gohelper.findChild(go, "select")
	self._golock = gohelper.findChild(go, "locked")
	self._clickNormal = gohelper.findChildButtonWithAudio(go, "normal/click")
	self._clickSelect = gohelper.findChildButtonWithAudio(go, "select/click")
	self._clickLock = gohelper.findChildButtonWithAudio(go, "locked/click")
	self._txtnormaltitle = gohelper.findChildTextMesh(go, "normal/layout/#txt_info1")
	self._txtnormaldesc = gohelper.findChildTextMesh(go, "normal/layout/#txt_info2")
	self._txtnormalinfo = gohelper.findChildTextMesh(go, "normal/layout/tipsbg/#txt_tips")
	self._gonormallockIcon = gohelper.findChild(go, "normal/#txt_tips/icon")
	self._txtselecttitle = gohelper.findChildTextMesh(go, "select/layout/info1")
	self._txtselectdesc = gohelper.findChildTextMesh(go, "select/layout/info2")
	self._txtselectinfo = gohelper.findChildTextMesh(go, "select/layout/tips")
	self._txtlocktitle = gohelper.findChildTextMesh(go, "locked/layout/#txt_info1")
	self._txtlockdesc = gohelper.findChildTextMesh(go, "locked/layout/#txt_info2")
	self._txtlockinfo = gohelper.findChildTextMesh(go, "locked/layout/tipsbg/#txt_tips")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
end

function V1a6_CachotInteractChoiceItem:addEventListeners()
	self._clickNormal:AddClickListener(self._selectThis, self)
	self._clickSelect:AddClickListener(self._selectChoice, self)
	self._clickLock:AddClickListener(self._selectThis, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectChoice, self._onChoiceSelect, self)
end

function V1a6_CachotInteractChoiceItem:removeEventListeners()
	self._clickNormal:RemoveClickListener()
	self._clickSelect:RemoveClickListener()
	self._clickLock:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.SelectChoice, self._onChoiceSelect, self)
end

function V1a6_CachotInteractChoiceItem:_playOpenAnim()
	self._anim:Play("open")
	UIBlockMgr.instance:endBlock("V1a6_CachotInteractChoiceItem_close")
end

function V1a6_CachotInteractChoiceItem:updateMo(mo, index)
	if self._co then
		self._anim:Play("unselect", 0, 1)
		self._anim:Update(0)
	end

	if V1a6_CachotRoomModel.instance.isFromDramaToDrama then
		UIBlockMgr.instance:startBlock("V1a6_CachotInteractChoiceItem_close")
		self._anim:Play("close")
		TaskDispatcher.runDelay(self._playOpenAnim, self, 0.167)
	end

	self._co = mo
	self._index = index
	self._txtnormaltitle.text = self._co.title
	self._txtselecttitle.text = self._co.title
	self._txtlocktitle.text = self._co.title
	self._txtnormaldesc.text = self._co.desc
	self._txtselectdesc.text = self._co.desc
	self._txtlockdesc.text = self._co.desc
	self._txtnormalinfo.text = ""
	self._txtselectinfo.text = ""
	self._txtlockinfo.text = ""

	self:_setIsSelect(false, true)

	self._lockDesInfo = nil

	if not string.nilorempty(mo.condition) then
		local arr = string.splitToNumber(mo.condition, "#")

		self._lockDesInfo = {
			V1a6_CachotChoiceConditionHelper.getConditionToast(unpack(arr))
		}

		if not self._lockDesInfo[1] then
			self._lockDesInfo = nil
		end
	end

	if self._lockDesInfo then
		self._txtlockinfo.text = self:_formatStr(lua_toast.configDict[self._lockDesInfo[1]].tips, unpack(self._lockDesInfo, 2))

		gohelper.setActive(self._golock, true)
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._goselect, false)

		return
	end

	gohelper.setActive(self._golock, false)
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._goselect, true)

	if mo.collection > 0 then
		local creatorCo = lua_rogue_collection.configDict[mo.collection]

		if creatorCo then
			self._txtselectinfo.text = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(creatorCo)
		else
			logError("没有藏品配置" .. mo.collection)
		end
	else
		local eventCo = lua_rogue_event.configDict[mo.event]

		if eventCo and eventCo.type == V1a6_CachotEnum.EventType.CharacterRebirth then
			local info = V1a6_CachotModel.instance:getTeamInfo()
			local deathCount = 0

			if info then
				for i, heroLifeMo in ipairs(info.lifes) do
					if heroLifeMo.lifePercent <= 0 then
						deathCount = deathCount + 1
					end
				end
			end

			local desc = formatLuaLang("cachot_death_count", deathCount)

			self._txtnormalinfo.text = desc
			self._txtselectinfo.text = desc
		end
	end
end

function V1a6_CachotInteractChoiceItem:_formatStr(str, ...)
	if not ... then
		return str
	end

	local t = {
		...
	}

	for k, v in ipairs(t) do
		str = str:gsub("▩" .. k .. "%%s", v)
	end

	return str
end

function V1a6_CachotInteractChoiceItem:_selectThis()
	if self._lockDesInfo then
		GameFacade.showToast(unpack(self._lockDesInfo))

		return
	end

	self:_setIsSelect(true)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectChoice, self._index)
end

function V1a6_CachotInteractChoiceItem:_setIsSelect(isSelect, isFirst)
	gohelper.setActive(self._clickNormal, not isSelect)
	gohelper.setActive(self._clickSelect, isSelect)

	if not isFirst and not self._lockDesInfo and self._isSelect ~= isSelect then
		if isSelect then
			self._anim:Play("select")
		else
			self._anim:Play("unselect")
		end
	end

	self._isSelect = isSelect
end

function V1a6_CachotInteractChoiceItem:_onChoiceSelect(index)
	if index ~= self._index then
		self:_setIsSelect(false)
	end
end

function V1a6_CachotInteractChoiceItem:_selectChoice()
	local topEventMo = V1a6_CachotRoomModel.instance:getNowTopEventMo()

	if not topEventMo then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayChoiceDialog, self._co.dialogId)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, false)
		logError("没有进行中的事件？？？？？")

		return
	end

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, topEventMo.eventId, self._co.id, self._onSelectEnd, self)
end

function V1a6_CachotInteractChoiceItem:_onSelectEnd()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayChoiceDialog, self._co.dialogId)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, false)
end

function V1a6_CachotInteractChoiceItem:onDestroy()
	UIBlockMgr.instance:endBlock("V1a6_CachotInteractChoiceItem_close")
	TaskDispatcher.cancelTask(self._playOpenAnim, self)
end

return V1a6_CachotInteractChoiceItem
