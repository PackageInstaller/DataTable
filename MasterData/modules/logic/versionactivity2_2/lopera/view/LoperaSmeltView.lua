-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaSmeltView.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaSmeltView", package.seeall)

local LoperaSmeltView = class("LoperaSmeltView", BaseView)
local actId = VersionActivity2_2Enum.ActivityId.Lopera
local materialNumColorFormat = "<color=#21631a>%s</color>"
local materialNum = 4
local productNum = 5
local tabChangeAniTime = 0.3

function LoperaSmeltView:onInitView()
	self._btnType1 = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Tab/Tab1")
	self._btnType2 = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Tab/Tab2")
	self._btnType3 = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Tab/Tab3")
	self._goReddot1 = gohelper.findChild(self.viewGO, "Right/Tab/Tab1/#go_reddot")
	self._goReddot2 = gohelper.findChild(self.viewGO, "Right/Tab/Tab2/#go_reddot")
	self._goReddot3 = gohelper.findChild(self.viewGO, "Right/Tab/Tab3/#go_reddot")
	self._btnSmelt = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Smelt")
	self._goItem = gohelper.findChild(self.viewGO, "Left/#scroll_List/Viewport/Content/#go_Item")
	self._goItemRoot = gohelper.findChild(self.viewGO, "Left/#scroll_List/Viewport/Content")
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goItem, false)

	self._tipsGo = gohelper.findChild(self.viewGO, "Left/#go_Tips")
	self._tipsItemIcon = gohelper.findChildImage(self._tipsGo, "image_TipsBG/#image_Icon")
	self._tipsValueText = gohelper.findChildText(self._tipsGo, "image_TipsBG/#txt_PropDescr")
	self._tipsTypeText = gohelper.findChildText(self._tipsGo, "image_TipsBG/#txt_PropType")
	self._tipsNameText = gohelper.findChildText(self._tipsGo, "image_TipsBG/#txt_Prop")
	self._goFullCloseBg = gohelper.findChild(self.viewGO, "#btn_TipsClose")
	self._fullCloseBg = gohelper.findChildButton(self.viewGO, "#btn_TipsClose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LoperaSmeltView:addEvents()
	self._btnSmelt:AddClickListener(self._onClickSmelt, self)
	self._btnType1:AddClickListener(self._onTabChange, self, 1)
	self._btnType2:AddClickListener(self._onTabChange, self, 2)
	self._btnType3:AddClickListener(self._onTabChange, self, 3)
	self._fullCloseBg:AddClickListener(self._closeTipsBtnClick, self)
	self.addEventCb(self, LoperaController.instance, LoperaEvent.GoodItemClick, self._onClickItem, self)
	self.addEventCb(self, LoperaController.instance, LoperaEvent.ComposeDone, self._onSmeltResult, self)

	self._redDot1Comp = RedDotController.instance:addNotEventRedDot(self._goReddot1, self._showRedDot1, self)
	self._redDot2Comp = RedDotController.instance:addNotEventRedDot(self._goReddot2, self._showRedDot2, self)
	self._redDot3Comp = RedDotController.instance:addNotEventRedDot(self._goReddot3, self._showRedDot3, self)
end

function LoperaSmeltView:removeEvents()
	self._btnSmelt:RemoveClickListener()
	self._btnType1:RemoveClickListener()
	self._btnType2:RemoveClickListener()
	self._btnType3:RemoveClickListener()
	self._fullCloseBg:RemoveClickListener()
end

function LoperaSmeltView:_onClickSmelt()
	local ableToCompose = LoperaController.instance:checkCanCompose(self._selectTabIdx)

	if ableToCompose then
		LoperaController.instance:composeItem(self._selectTabIdx)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_youyu_alchemy_success)
	else
		GameFacade.showToast(ToastEnum.CharacterExSkill)
	end
end

function LoperaSmeltView:_onTabChange(tabIdx, noAnimation)
	if self._selectTabIdx == tabIdx then
		return
	end

	self._selectTabIdx = tabIdx

	if not noAnimation then
		self._viewAnimator:Play(UIAnimationName.Switch, 0, 0)
	end

	TaskDispatcher.runDelay(self._doTabChangeRefresh, self, tabChangeAniTime)
end

function LoperaSmeltView:_doTabChangeRefresh()
	self:refreshTabItems(self._selectTabIdx)
	self:refreshTabMaterials(self._selectTabIdx)
	self:refreshTabProducts(self._selectTabIdx)
	self:_refreshBtnState()
end

function LoperaSmeltView:_closeTipsBtnClick()
	gohelper.setActive(self._tipsGo, false)
	gohelper.setActive(self._goFullCloseBg, false)
end

function LoperaSmeltView:_editableInitView()
	self._tabStateGroup = {}

	for i = 1, 3 do
		self._tabStateGroup[i] = self:getUserDataTb_()
		self._tabStateGroup[i].unSelect = gohelper.findChild(self.viewGO, string.format("Right/Tab/Tab%s/#go_UnSelect", i))
		self._tabStateGroup[i].select = gohelper.findChild(self.viewGO, string.format("Right/Tab/Tab%s/#go_Selected", i))
		self._tabStateGroup[i].txtUnSelect = gohelper.findChildText(self.viewGO, string.format("Right/Tab/Tab%s/#go_UnSelect/#txt_Tab", i))
		self._tabStateGroup[i].txtSelected = gohelper.findChildText(self.viewGO, string.format("Right/Tab/Tab%s/#go_Selected/#txt_Tab", i))
	end
end

function LoperaSmeltView:onOpen()
	self._selectTabIdx = -1
	self._defaultTab = 1

	self:_onTabChange(self._defaultTab, true)
	self:_refreshTabsTtile()
	self:refreshAllItems()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_uimIn_details_open)
end

function LoperaSmeltView:onExitGame()
	self:closeThis()
end

function LoperaSmeltView:refreshView()
	self:refreshTabItems(self._selectTabIdx)
	self:refreshTabMaterials(self._selectTabIdx)
	self:refreshTabProducts(self._selectTabIdx)
	self:refreshAllItems()
	self:_refreshRedDot()
end

function LoperaSmeltView:refreshAllItems()
	self._itemCfgList = Activity168Config.instance:getGameItemListCfg(actId)

	table.sort(self._itemCfgList, self._itemListSort)
	gohelper.CreateObjList(self, self._createItem, self._itemCfgList, self._goItemRoot, self._goItem, LoperaGoodsItem)
end

function LoperaSmeltView._itemListSort(aCfg, bCfg)
	local aItemCount = Activity168Model.instance:getItemCount(aCfg.itemId)
	local bItemCount = Activity168Model.instance:getItemCount(bCfg.itemId)

	if aItemCount == 0 and bItemCount == 0 then
		return aCfg.itemId < bCfg.itemId
	elseif aItemCount > 0 and bItemCount == 0 then
		return true
	elseif aItemCount == 0 and bItemCount > 0 then
		return false
	elseif aItemCount > 0 and bItemCount > 0 then
		local aNewFlag = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. aCfg.itemId, 0)
		local bNewFlag = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. bCfg.itemId, 0)

		if aNewFlag == 1 and bNewFlag == 0 then
			return false
		end

		if aNewFlag == 0 and bNewFlag == 1 then
			return true
		end

		if aNewFlag == bNewFlag then
			return aCfg.itemId < bCfg.itemId
		end
	end
end

function LoperaSmeltView:_refreshTabsTtile()
	local typeCfgList = Activity168Config.instance:getComposeTypeList(VersionActivity2_2Enum.ActivityId.Lopera)

	for idx, composeTypeData in ipairs(typeCfgList) do
		local typeText = self._tabStateGroup[idx].txtUnSelect

		typeText.text = composeTypeData.name

		local typeText = self._tabStateGroup[idx].txtSelected

		typeText.text = composeTypeData.name
	end
end

function LoperaSmeltView:refreshTabItems(tabIdx)
	local curComposeTypeCfg
	local typeCfgList = Activity168Config.instance:getComposeTypeList(actId)

	for idx, composeTypeData in ipairs(typeCfgList) do
		if composeTypeData.composeType == tabIdx then
			curComposeTypeCfg = composeTypeData

			break
		end
	end
end

function LoperaSmeltView:refreshTabMaterials(tabIdx)
	local curComposeTypeCfg
	local typeCfgList = Activity168Config.instance:getComposeTypeList(actId)

	for idx, composeTypeData in ipairs(typeCfgList) do
		if composeTypeData.composeType == tabIdx then
			curComposeTypeCfg = composeTypeData

			break
		end
	end

	local materialInfos = string.split(curComposeTypeCfg.costItems, "|")

	for i = 1, materialNum do
		local materialGo = gohelper.findChild(self.viewGO, string.format("Right/Prop/Prop%s/#go_Have", i))
		local emptyGo = gohelper.findChild(self.viewGO, string.format("Right/Prop/Prop%s/#go_Empty", i))

		if i <= #materialInfos then
			if not materialInfos[i] then
				local materialInfo

				if materialInfo then
					local materialInfoArray = string.splitToNumber(materialInfo, "#")
					local materialId = materialInfoArray[1]
					local materialNum = materialInfoArray[2]
					local itemCfg = Activity168Config.instance:getGameItemCfg(actId, materialId)
					local materialIcon = gohelper.findChildImage(materialGo, "#image_Icon")

					UISpriteSetMgr.instance:setLoperaItemSprite(materialIcon, itemCfg.icon, false)

					local materialNameText = gohelper.findChildText(materialGo, "#txt_PropName")
					local materialNeedCountText = gohelper.findChildText(materialGo, "#txt_Num")
					local count = Activity168Model.instance:getItemCount(materialId)

					materialNameText.text = itemCfg.name

					local countNumStr = string.format(materialNumColorFormat, count)

					materialNeedCountText.text = countNumStr .. "/" .. materialNum
				end

				gohelper.setActive(emptyGo, materialInfo == nil)
				gohelper.setActive(materialGo, materialInfo ~= nil)
			end
		end
	end
end

function LoperaSmeltView:refreshTabProducts(tabIdx)
	local curComposeTypeCfg
	local typeCfgList = Activity168Config.instance:getComposeTypeList(actId)

	for idx, composeTypeData in ipairs(typeCfgList) do
		if composeTypeData.composeType == tabIdx then
			curComposeTypeCfg = composeTypeData

			break
		end
	end

	local itemList = Activity168Config.instance:getGameItemListCfg(actId, tabIdx)

	for i = 1, productNum do
		local materialGo = gohelper.findChild(self.viewGO, string.format("Right/Output/Prop%s/#go_Have", i))
		local emptyGo = gohelper.findChild(self.viewGO, string.format("Right/Output/Prop%s/#go_Empty", i))

		if i <= #itemList then
			if not itemList[i] then
				local itemCfg

				if itemCfg then
					local materialIcon = gohelper.findChildImage(materialGo, "#image_Icon")

					UISpriteSetMgr.instance:setLoperaItemSprite(materialIcon, itemCfg.icon, false)

					local productNameText = gohelper.findChildText(materialGo, "#txt_PropName")

					productNameText.text = itemCfg.name
				end

				gohelper.setActive(emptyGo, itemCfg == nil)
				gohelper.setActive(materialGo, itemCfg ~= nil)
			end
		end
	end
end

function LoperaSmeltView:_refreshGoodItemTips(idx)
	local itemCfg = self._itemCfgList[idx]

	self._tipsValueText.text = itemCfg.desc

	local composeTypeCfg = Activity168Config.instance:getComposeTypeCfg(actId, itemCfg.compostType)

	if composeTypeCfg then
		self._tipsTypeText.text = composeTypeCfg.name
	end

	gohelper.setActive(self._tipsTypeText.gameObject, composeTypeCfg ~= nil)

	self._tipsNameText.text = itemCfg.name

	UISpriteSetMgr.instance:setLoperaItemSprite(self._tipsItemIcon, itemCfg.icon, false)
end

function LoperaSmeltView:_refreshBtnState()
	local ableToCompose = LoperaController.instance:checkCanCompose(self._selectTabIdx)

	ZProj.UGUIHelper.SetGrayscale(self._btnSmelt.gameObject, not ableToCompose)

	for i, tabState in ipairs(self._tabStateGroup) do
		gohelper.setActive(tabState.select, i == self._selectTabIdx)
		gohelper.setActive(tabState.unSelect, i ~= self._selectTabIdx)
	end
end

function LoperaSmeltView:_createItem(itemComp, itemCfg, index)
	local itemId = itemCfg.itemId
	local itemCount = Activity168Model.instance:getItemCount(itemId)
	local params = {}

	params.showNewFlag = true

	itemComp:onUpdateData(itemCfg, itemCount and itemCount or 0, index, params)
end

function LoperaSmeltView:_onClickItem(index)
	gohelper.setActive(self._tipsGo, true)
	gohelper.setActive(self._goFullCloseBg, true)

	local goodItemGo = gohelper.findChild(self._goItemRoot, index)
	local tipsTrans = self._tipsGo.transform

	tipsTrans:SetParent(goodItemGo.transform, true)
	recthelper.setAnchorX(tipsTrans, 130)
	recthelper.setAnchorY(tipsTrans, -30)
	tipsTrans:SetParent(self.viewGO.transform, true)
	self:_refreshGoodItemTips(index)
end

function LoperaSmeltView:_onSmeltResult()
	LoperaController.instance:openSmeltResultView()
	self:refreshView()
	self:_refreshBtnState()
	self:_refreshRedDot()
end

function LoperaSmeltView:_showRedDot1()
	return self:_checkShowRedDot(1)
end

function LoperaSmeltView:_showRedDot2()
	return self:_checkShowRedDot(2)
end

function LoperaSmeltView:_showRedDot3()
	return self:_checkShowRedDot(3)
end

function LoperaSmeltView:_checkShowRedDot(TabId)
	return LoperaController.instance:checkCanCompose(TabId)
end

function LoperaSmeltView:_refreshRedDot()
	if self._redDot1Comp then
		self._redDot1Comp:refreshRedDot()
	end

	if self._redDot2Comp then
		self._redDot2Comp:refreshRedDot()
	end

	if self._redDot3Comp then
		self._redDot3Comp:refreshRedDot()
	end
end

function LoperaSmeltView:onDestroyView()
	TaskDispatcher.cancelTask(self._doTabChangeRefresh, self)
end

return LoperaSmeltView
