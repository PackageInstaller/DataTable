-- chunkname: @modules/logic/equip/view/EquipRefineView.lua

module("modules.logic.equip.view.EquipRefineView", package.seeall)

local EquipRefineView = class("EquipRefineView", BaseView)

function EquipRefineView:onInitView()
	self._imagelock = gohelper.findChildImage(self.viewGO, "#go_effect/#go_progress/#image_lock")
	self._txtattributelv = gohelper.findChildText(self.viewGO, "#go_effect/#go_progress/#txt_attributelv")
	self._gorefinedescViewPort = gohelper.findChild(self.viewGO, "#go_effect/scroll_refinedesc/Viewport/")
	self._gosuiteffect = gohelper.findChild(self.viewGO, "#go_effect/scroll_refinedesc/Viewport/#go_suiteffect")
	self._txtsuiteffect2 = gohelper.findChildText(self.viewGO, "#go_effect/scroll_refinedesc/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	self._gocost = gohelper.findChild(self.viewGO, "#go_effect/#go_cost")
	self._gobreakcount = gohelper.findChild(self.viewGO, "#go_effect/#go_cost/title/#go_breakcount")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_effect/#go_cost/#go_btns")
	self._btnrefine = gohelper.findChildButtonWithAudio(self.viewGO, "#go_effect/#go_cost/#go_btns/#btn_refine")
	self._goimprove = gohelper.findChild(self.viewGO, "#go_effect/#go_improve")
	self._animimprove = self._goimprove:GetComponent(typeof(UnityEngine.Animator))
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "#go_effect/#go_improve/#btn_back")
	self._golackequip = gohelper.findChild(self.viewGO, "#go_effect/#go_improve/#go_lackequip")
	self._gofullgrade = gohelper.findChild(self.viewGO, "#go_effect/#go_fullgrade")
	self._gobaseskill = gohelper.findChild(self.viewGO, "#go_effect/scroll_refinedesc/Viewport/#go_suiteffect/#go_baseskill")
	self._goeffect = gohelper.findChild(self.viewGO, "#go_effect")
	self._gonoteffect = gohelper.findChild(self.viewGO, "#go_noteffect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipRefineView:addEvents()
	self._btnrefine:AddClickListener(self._btnrefineOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
end

function EquipRefineView:removeEvents()
	self._btnrefine:RemoveClickListener()
	self._btnback:RemoveClickListener()
end

function EquipRefineView:onShowLeftBackpackContainer(isShow)
	self.show_state = isShow
end

function EquipRefineView:_btnbackOnClick(isClickRefine)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, false, isClickRefine)
end

function EquipRefineView:_btnrefineOnClick()
	local selectedEquipMoList = EquipRefineListModel.instance:getSelectedEquipMoList()

	if #selectedEquipMoList <= 0 then
		if self.show_state then
			GameFacade.showToast(ToastEnum.EquipRefineShow)
		else
			EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, true)
		end

		return
	end

	self.last_refine_lv = self._equip_mo.refineLv

	local show_content, out_level, out_refine, out_refine_lv, aim_lv
	local show_tips = false
	local show_cost_gluttony_tip = false
	local cost_gluttony_name
	local equip_level_condition = TimeUtil.getDayFirstLoginRed("EquipHighLevelNotice")
	local equip_refine_condition = TimeUtil.getDayFirstLoginRed("EquipRefineHighLevelNotice")
	local level_refine_both = TimeUtil.getDayFirstLoginRed("EquipHighLevelAndRefineHighLevelNotice")
	local equip_out_max_refine_lv_condition = TimeUtil.getDayFirstLoginRed("EquipOutMaxRefineLvCondition")

	aim_lv = self._equip_mo.refineLv + EquipRefineListModel.instance:getAddRefineLv()

	if aim_lv > EquipConfig.instance:getEquipRefineLvMax() then
		aim_lv = EquipConfig.instance:getEquipRefineLvMax()

		if equip_out_max_refine_lv_condition then
			out_refine_lv = true
			show_tips = true
			show_content = MessageBoxConfig.instance:getMessage(64)
		end
	end

	if not show_tips then
		for _, equipMO in ipairs(selectedEquipMoList) do
			out_level = equipMO.level > 1
			out_refine = equipMO.refineLv > 1

			if self._equip_mo.config.rare == 4 and equipMO.equipId == 1000 then
				show_cost_gluttony_tip = true
				cost_gluttony_name = equipMO.config.name
			end

			if out_refine and out_level and level_refine_both and not show_tips then
				show_tips = true
				show_content = string.format(MessageBoxConfig.instance:getMessage(34), aim_lv)
			end

			if out_level and equip_level_condition and not show_tips then
				show_tips = true
				show_content = MessageBoxConfig.instance:getMessage(32)
			end

			if out_refine and equip_refine_condition and not show_tips then
				show_tips = true
				show_content = string.format(MessageBoxConfig.instance:getMessage(33), aim_lv)
			end
		end
	end

	local function checkShowTip()
		if show_tips then
			EquipController.instance:openEquipStrengthenAlertView({
				callback = function(notPrompt)
					if notPrompt then
						if out_refine_lv then
							TimeUtil.setDayFirstLoginRed("EquipOutMaxRefineLvCondition")
						end

						if out_level and out_refine then
							TimeUtil.setDayFirstLoginRed("EquipHighLevelNotice")
							TimeUtil.setDayFirstLoginRed("EquipRefineHighLevelNotice")
							TimeUtil.setDayFirstLoginRed("EquipHighLevelAndRefineHighLevelNotice")
						elseif out_level then
							TimeUtil.setDayFirstLoginRed("EquipHighLevelNotice")
						else
							TimeUtil.setDayFirstLoginRed("EquipRefineHighLevelNotice")
						end
					end

					self:_sendEquipRefineRequest()
				end,
				content = show_content
			})
		else
			self:_sendEquipRefineRequest()
		end
	end

	if show_cost_gluttony_tip then
		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.EquipRefineCost, MsgBoxEnum.BoxType.Yes_No, checkShowTip, nil, nil, self, nil, nil, cost_gluttony_name)

		return
	end

	checkShowTip()
end

function EquipRefineView:_showCostGluttonyTip(callback)
	return
end

function EquipRefineView:_sendEquipRefineRequest()
	EquipRpc.instance:sendEquipRefineRequest(self._equip_mo.uid, EquipRefineListModel.instance:getSelectedEquipUidList())
end

function EquipRefineView:_editableInitView()
	self.addEventCb(self, EquipController.instance, EquipEvent.onEquipRefineReply, self._onEquipRefineReply, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onCloseEquipLevelUpView, self._onCloseEquipLevelUpView, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onChangeRefineScrollState, self.onShowLeftBackpackContainer, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.OnRefineSelectedEquipChange, self.refreshEquipDesc, self)
	gohelper.addUIClickAudio(self._btnrefine.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)

	self.refineDescClick = gohelper.getClick(self._gorefinedescViewPort)

	self.refineDescClick:AddClickListener(self._btnbackOnClick, self)

	self._hyperLinkClick2 = self._txtsuiteffect2.gameObject:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick2:SetClickListener(self._onHyperLinkClick, self)
	gohelper.setActive(self._txtsuiteffect2.gameObject, false)

	self._txtDescList = self:getUserDataTb_()

	self:setBtnBackWidth()
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.setBtnBackWidth, self)

	self._viewAnim = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function EquipRefineView:setBtnBackWidth()
	local improveWidth = recthelper.getWidth(self._goimprove.transform)

	recthelper.setWidth(self._btnback.gameObject.transform, 0.45 * improveWidth)
end

function EquipRefineView:_onHyperLinkClick()
	EquipController.instance:openEquipSkillTipView({
		self._equip_mo,
		self._equip_mo.equipId,
		true
	})
end

function EquipRefineView:onUpdateParam()
	return
end

function EquipRefineView:_onEquipRefineReply()
	if not self.canRefine then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_refine)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, false, true)
	EquipRefineListModel.instance:clearSelectedEquipList()
	UIBlockMgr.instance:startBlock(self.viewName .. "ViewOpenAnim")
	TaskDispatcher.cancelTask(self._openEquipSkillLevelUpView, self)
	TaskDispatcher.runDelay(self._openEquipSkillLevelUpView, self, 1.45)
end

function EquipRefineView:_openEquipSkillLevelUpView()
	UIBlockMgr.instance:endBlock(self.viewName .. "ViewOpenAnim")
	EquipController.instance:openEquipSkillLevelUpView({
		self._equip_mo,
		self.last_refine_lv
	})
	self:_refreshList()
	self:refreshUI()
end

function EquipRefineView:_refreshList()
	EquipRefineListModel.instance:initData(self._equip_mo)
	EquipRefineListModel.instance:sortData()
	EquipRefineListModel.instance:refreshData()
	self.viewContainer.equipView:refreshRefineEquipList()
end

function EquipRefineView:refreshEquipDesc()
	if not self.canRefine then
		return
	end

	local aimRefineLv = self._equip_mo.refineLv + EquipRefineListModel.instance:getAddRefineLv()
	local maxRefineLv = EquipConfig.instance:getEquipRefineLvMax()

	self:_setEquipSkillDesc(maxRefineLv < aimRefineLv and maxRefineLv or aimRefineLv)
end

function EquipRefineView:onOpen()
	self._equip_mo = self.viewContainer.viewParam.equipMO
	self.canRefine = self._equip_mo.config.rare > EquipConfig.instance:getNotShowRefineRare()

	self:refreshUI()
	EquipRefineListModel.instance:initData(self._equip_mo)
	EquipRefineListModel.instance:sortData()
	EquipRefineSelectedListModel.instance:initList()
	self._viewAnim:Play(UIAnimationName.Open)
end

function EquipRefineView:refreshUI()
	gohelper.setActive(self._goeffect, self.canRefine)
	gohelper.setActive(self._gonoteffect, not self.canRefine)

	if self.viewContainer:getIsOpenLeftBackpack() then
		if not self.canRefine then
			self.viewContainer.equipView:changeStrengthenScrollVisibleState(false)
		else
			self.viewContainer.equipView:hideStrengthenScrollAndShowRefineScroll()
		end
	else
		gohelper.setActive(self._goimprove, false)
	end

	if not self.canRefine then
		return
	end

	self.is_max_lv = self._equip_mo.refineLv >= EquipConfig.instance:getEquipRefineLvMax()

	gohelper.setActive(self._gocost, not self.is_max_lv)
	self:_setEquipSkillDesc(self._equip_mo.refineLv)
	gohelper.setActive(self._gofullgrade, self.is_max_lv)

	if self.is_max_lv then
		self.viewContainer:setIsOpenLeftBackpack(false)
	end
end

function EquipRefineView:_setEquipSkillDesc(refineLv)
	if not self.canRefine then
		return
	end

	self._txtattributelv.text = refineLv

	self:_showSkillBaseDes(refineLv)
end

function EquipRefineView:_showSkillBaseDes(refine_lv)
	local skillBaseDesList = EquipHelper.getEquipSkillDescList(self._equip_mo.equipId, refine_lv, "#D9A06F")

	if #skillBaseDesList == 0 then
		gohelper.setActive(self._gobaseskill.gameObject, false)
	else
		gohelper.setActive(self._gobaseskill.gameObject, true)

		local cell, iteminfo, itemGo

		for index, desc in ipairs(skillBaseDesList) do
			cell = self._txtDescList[index]

			if not self._txtDescList[index] then
				iteminfo = {}
				itemGo = gohelper.cloneInPlace(self._txtsuiteffect2.gameObject, "item_" .. index)
				iteminfo.itemGo = itemGo
				iteminfo.imagebasedesicon = gohelper.findChildImage(itemGo, "#image_basedesicon")
				iteminfo.txt = itemGo:GetComponent(gohelper.Type_TextMesh)
				cell = iteminfo

				table.insert(self._txtDescList, iteminfo)
			end

			cell.txt.text = desc

			gohelper.setActive(cell.itemGo, true)
		end

		for i = #skillBaseDesList + 1, #self._txtDescList do
			gohelper.setActive(self._txtDescList[i].itemGo, false)
		end
	end
end

function EquipRefineView:_onShowEquipGroupBg(visible)
	if visible then
		self:showScrollerContainer()
		self._animimprove:Play("go_improve2")
	else
		self._animimprove:Play("go_improve2_out")
		TaskDispatcher.runDelay(self._hideScrollContainer, self, 0.167)
	end
end

function EquipRefineView:showScrollContainer()
	EquipRefineListModel.instance:refreshData()
	gohelper.setActive(self._golackequip, #EquipRefineListModel.instance.data == 0)
	gohelper.setActive(self._goimprove, true)
	self._animimprove:Play("go_improve2")
end

function EquipRefineView:hideScrollContainer()
	self._animimprove:Play("go_improve2_out")
	TaskDispatcher.runDelay(self._hideScrollContainer, self, 0.167)
end

function EquipRefineView:_hideScrollContainer()
	gohelper.setActive(self._goimprove, false)
end

function EquipRefineView:_onCloseEquipLevelUpView()
	if not self.is_max_lv then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, true)
	end
end

function EquipRefineView:onClose()
	TaskDispatcher.cancelTask(self._openEquipSkillLevelUpView, self)
	EquipRefineListModel.instance:clearData()
	EquipRefineSelectedListModel.instance:clearData()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	self:playCloseAnimation()
end

function EquipRefineView:playCloseAnimation()
	self._viewAnim:Play(UIAnimationName.Close)
end

function EquipRefineView:onDestroyView()
	self.refineDescClick:RemoveClickListener()
	UIBlockMgr.instance:endBlock(self.viewName .. "ViewOpenAnim")
end

return EquipRefineView
