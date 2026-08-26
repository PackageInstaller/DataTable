-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookTalentNodeItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookTalentNodeItem", package.seeall)

local Rouge2_CareerHandBookTalentNodeItem = class("Rouge2_CareerHandBookTalentNodeItem", LuaCompBase)

function Rouge2_CareerHandBookTalentNodeItem:init(go)
	self.go = go
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._gonormal = gohelper.findChild(self.go, "#go_normal")
	self._simageicon = gohelper.findChildSingleImage(self.go, "#go_normal/#image_icon")
	self._txtprogress = gohelper.findChildText(self.go, "#go_normal/#txt_progress")
	self._txtindex = gohelper.findChildText(self.go, "#go_normal/#txt_index")
	self._golock = gohelper.findChild(self.go, "#go_lock")
	self._simagelockIcon = gohelper.findChildSingleImage(self.go, "#go_lock/#image_lockIcon")
	self._txtlockProgress = gohelper.findChildText(self.go, "#go_lock/#txt_lockProgress")
	self._txtlockIndex = gohelper.findChildText(self.go, "#go_lock/#txt_lockIndex")
	self._gocanget = gohelper.findChild(self.go, "#go_canget")
	self._goreceive = gohelper.findChild(self.go, "#go_receive")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerHandBookTalentNodeItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function Rouge2_CareerHandBookTalentNodeItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function Rouge2_CareerHandBookTalentNodeItem:_btnclickOnClick()
	if not self.isActive and self.canUnlock then
		if Rouge2_Model.instance:isFinishedDifficulty() or Rouge2_Model.instance:isStarted() then
			GameFacade.showToast(ToastEnum.Rouge2GameStartTalentTip)

			return
		end

		if not Rouge2_TalentModel.instance:isTalentUnlock(self._talentId) then
			GameFacade.showToast(ToastEnum.Rouge2TalentPreNodeLocked)

			return
		end

		Rouge2_OutsideController.instance:activeTalent(self._talentId)

		return
	end

	if self.isSelect then
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnSelectHandBookTalent, nil)

		return
	end

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnSelectHandBookTalent, self._talentId)
end

function Rouge2_CareerHandBookTalentNodeItem:_editableInitView()
	return
end

function Rouge2_CareerHandBookTalentNodeItem:setActive(active)
	gohelper.setActive(self.go, active)
end

function Rouge2_CareerHandBookTalentNodeItem:setSelect(talentId)
	self.isSelect = self._talentId == talentId

	gohelper.setActive(self._goselect, self.isSelect)
end

function Rouge2_CareerHandBookTalentNodeItem:setInfo(index, talentId, displayType)
	self._index = index
	self._talentId = talentId
	self._displayType = displayType
	self.config = Rouge2_OutSideConfig.instance:getTalentConfigById(talentId)
	self.typeConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(talentId)

	self:refreshUI()
end

function Rouge2_CareerHandBookTalentNodeItem:refreshUI()
	local isActive, canUnlock

	if self._displayType == Rouge2_OutsideEnum.CareerTalentDisplayType.DisplayOnly then
		isActive = true
		canUnlock = false
	else
		isActive = Rouge2_TalentModel.instance:isTalentActive(self._talentId)
		canUnlock = not isActive and Rouge2_TalentModel.instance:isTalentUnlock(self._talentId) and Rouge2_TalentModel.instance:canActiveCareerTalent(self._talentId)
	end

	self.isActive = isActive
	self.canUnlock = canUnlock

	gohelper.setActive(self._golock, not isActive)
	gohelper.setActive(self._gonormal, isActive)
	gohelper.setActive(self._goreceive, isActive)
	gohelper.setActive(self._gocanget, not isActive and canUnlock)

	if isActive then
		if not self._simageicon then
			local imageComp = self._simagelockIcon

			if isActive then
				if not self._txtindex then
					local txtIndexComp = self._txtlockIndex

					if isActive then
						if not self._txtprogress then
							local txtProgressComp = self._txtlockProgress

							Rouge2_IconHelper.setTalentIcon(self._talentId, imageComp)

							txtProgressComp.text = tostring(self.typeConfig.careerExp)
							txtIndexComp.text = self._index >= 10 and tostring(self._index) or "0" .. tostring(self._index)
						end
					end
				end
			end
		end
	end
end

function Rouge2_CareerHandBookTalentNodeItem:onDestroy()
	return
end

return Rouge2_CareerHandBookTalentNodeItem
