-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_TalentTreeNodeDetailItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_TalentTreeNodeDetailItem", package.seeall)

local Rouge2_TalentTreeNodeDetailItem = class("Rouge2_TalentTreeNodeDetailItem", LuaCompBase)

function Rouge2_TalentTreeNodeDetailItem:init(go)
	self.go = go
	self._txttalentname = gohelper.findChildText(self.go, "#txt_talentname")
	self._txttalentdec = gohelper.findChildText(self.go, "#txt_talentdec")
	self._btnlocked = gohelper.findChildButtonWithAudio(self.go, "#btn_locked")
	self._txtlocked = gohelper.findChildText(self.go, "#btn_locked/#txt_locked")
	self._btnlack = gohelper.findChildButtonWithAudio(self.go, "#btn_lack")
	self._txtlack = gohelper.findChildText(self.go, "#btn_lack/#txt_lack")
	self._btncancel = gohelper.findChildButtonWithAudio(self.go, "#btn_cancel")
	self._btncloseDetail = gohelper.findChildButton(self.go, "#btn_closeDetail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_TalentTreeNodeDetailItem:addEventListeners()
	self._btnlocked:AddClickListener(self._btnlockedOnClick, self)
	self._btnlack:AddClickListener(self._btnlackOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btncloseDetail:AddClickListener(self._btncancelOnClick, self)
end

function Rouge2_TalentTreeNodeDetailItem:removeEventListeners()
	self._btnlocked:RemoveClickListener()
	self._btnlack:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btncloseDetail:RemoveClickListener()
end

function Rouge2_TalentTreeNodeDetailItem:_editableInitView()
	self.imageUpdatePoint = gohelper.findChildImage(self.go, "#btn_lack/#txt_lack/icon")

	local constConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.TalentPointId)
	local itemId = tonumber(constConfig.value)
	local itemConfig = CurrencyConfig.instance:getCurrencyCo(itemId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageUpdatePoint, tostring(itemConfig.id) .. "_1")

	self._goreddot = gohelper.findChild(self.go, "#btn_lack/#go_reddot")
	self.animator = gohelper.findChildComponent(self.go, "", gohelper.Type_Animator)
	self.canvas = gohelper.findChildComponent(self.go, "", gohelper.Type_CanvasGroup)
end

function Rouge2_TalentTreeNodeDetailItem:_btnlockedOnClick()
	local talentId = self.id

	if not Rouge2_TalentModel.instance:isTalentUnlock(talentId) then
		GameFacade.showToast(ToastEnum.Rouge2TalentPreNodeLocked)

		return
	end

	if not Rouge2_TalentModel.instance:isTalentCanActive(talentId) then
		GameFacade.showToast(ToastEnum.Rouge2TalentUpdatePointLimit)

		return
	end
end

function Rouge2_TalentTreeNodeDetailItem:_btnlackOnClick()
	if Rouge2_Model.instance:isFinishedDifficulty() or Rouge2_Model.instance:isStarted() then
		GameFacade.showToast(ToastEnum.Rouge2GameStartTalentTip)

		return
	end

	local talentId = self.id

	if Rouge2_TalentModel.instance:isTalentActive(talentId) then
		return
	end

	if not Rouge2_TalentModel.instance:isTalentUnlock(talentId) then
		return
	end

	if not Rouge2_TalentModel.instance:isTalentCanActive(talentId) then
		GameFacade.showToast(ToastEnum.Rouge2UpdatePointNoEnough)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_add)
	Rouge2_OutsideController.instance:activeTalent(self.id)
end

function Rouge2_TalentTreeNodeDetailItem:_btncancelOnClick()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.TalentCancelChoice)
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnDetailItemClickClose)
end

function Rouge2_TalentTreeNodeDetailItem:setInfo(id)
	self.id = id
	self.config = Rouge2_OutSideConfig.instance:getTalentConfigById(id)
	self.typeConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigById(Rouge2_Enum.TalentType.Common, id)

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V3a2_Rouge_Talent_Button, id)
	self:refreshUI()
end

function Rouge2_TalentTreeNodeDetailItem:refreshUI()
	self._txttalentname.text = self.config.name
	self._txttalentdec.text = self.config.desc

	local id = self.id
	local isActive = Rouge2_TalentModel.instance:isTalentActive(id)

	if isActive then
		gohelper.setActive(self._btncancel, false)
		gohelper.setActive(self._btnlack, false)
		gohelper.setActive(self._btnlocked, false)
	else
		local isUnLock = Rouge2_TalentModel.instance:isTalentUnlock(id)

		gohelper.setActive(self._btncancel, true)
		gohelper.setActive(self._btnlocked, not isUnLock)
		gohelper.setActive(self._btnlack, isUnLock)

		if isUnLock then
			local canActive = Rouge2_TalentModel.instance:isTalentCanActive(id)
			local colorStr = canActive and "#F48C37" or "#FE5858"

			self._txtlack.text = string.format("<color=%s>%s</color>", colorStr, tostring(-self.typeConfig.pointCost))
		else
			self._txtlocked.text = luaLang("rouge2_talent_prenode_locked")
		end
	end
end

function Rouge2_TalentTreeNodeDetailItem:setActive(active)
	local anim = active and "open" or "close"

	self.animator:Play(anim, 0, 0)

	local canvas = self.canvas

	canvas.blocksRaycasts = active
end

function Rouge2_TalentTreeNodeDetailItem:clear()
	self.id = nil
	self.config = nil
	self.typeConfig = nil
end

return Rouge2_TalentTreeNodeDetailItem
