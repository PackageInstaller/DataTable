-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_TalentTreeView.lua

module("modules.logic.rouge2.outside.view.Rouge2_TalentTreeView", package.seeall)

local Rouge2_TalentTreeView = class("Rouge2_TalentTreeView", BaseView)

function Rouge2_TalentTreeView:onInitView()
	self._gobg0 = gohelper.findChild(self.viewGO, "BG/#go_bg0")
	self._gobg1 = gohelper.findChild(self.viewGO, "BG/#go_bg1")
	self._gotalenttree = gohelper.findChild(self.viewGO, "#go_talenttree")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_talenttree/#simage_bg")
	self._simagebglight = gohelper.findChildSingleImage(self.viewGO, "#go_talenttree/light/#simage_bg_light")
	self._btnoverview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_talenttree/#btn_overview")
	self._gotalentdec = gohelper.findChild(self.viewGO, "#go_talentdec")
	self._txttalentname = gohelper.findChildText(self.viewGO, "#go_talentdec/bg/#txt_talentname")
	self._txttalentdec = gohelper.findChildText(self.viewGO, "#go_talentdec/#txt_talentdec")
	self._godetail = gohelper.findChild(self.viewGO, "#go_detail")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_topright/#txt_num")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_click")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_topright/tips/#txt_tips")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnempty = gohelper.findChildButton(self.viewGO, "#btn_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_TalentTreeView:addEvents()
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectCommonTalent, self.onSelectTalent, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnDetailItemClickClose, self.onDetailItemClickClose, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateCommonTalent, self.onTalentActive, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateRougeTalentInfo, self.refreshUI, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateRougeInfoTalentPoint, self.refreshUI, self)
	self._btnoverview:AddClickListener(self._btnoverviewOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnempty:AddClickListener(self._btnemptyOnClick, self)
end

function Rouge2_TalentTreeView:removeEvents()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectCommonTalent, self.onSelectTalent, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnDetailItemClickClose, self.onDetailItemClickClose, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateCommonTalent, self.onTalentActive, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateRougeTalentInfo, self.refreshUI, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateRougeInfoTalentPoint, self.refreshUI, self)
	self._btnoverview:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnempty:RemoveClickListener()
end

function Rouge2_TalentTreeView:_btnemptyOnClick()
	self._isShowTip = false

	gohelper.setActive(self._goTips, self._isShowTip)
	gohelper.setActive(self._btnempty, self._isShowTip)
end

function Rouge2_TalentTreeView:_btnclickOnClick()
	self._isShowTip = true

	gohelper.setActive(self._goTips, self._isShowTip)
	gohelper.setActive(self._btnempty, self._isShowTip)
end

function Rouge2_TalentTreeView:_btnoverviewOnClick()
	Rouge2_ViewHelper.openTalentTreeOverView()
end

function Rouge2_TalentTreeView:onDetailItemClickClose()
	self._detailItem:setActive(false)
	self:onSelectTalent(nil)
end

function Rouge2_TalentTreeView:onTalentActive(geniusId)
	if geniusId == Rouge2_TalentModel.instance:getCurTalentId() then
		self._detailItem:setActive(false)
	end

	Rouge2_TalentModel.instance:setCurSelectId(nil)
	self:playActive(geniusId)
end

function Rouge2_TalentTreeView:playActive(geniusId)
	self:refreshTalentPoint()
	self:refreshTreeNode(false)
	Rouge2_OutsideController.instance:lockScreen(true, Rouge2_OutsideEnum.TalentLightAnimTime)
	TaskDispatcher.runDelay(self.onLightAnimPlayFinish, self, Rouge2_OutsideEnum.TalentLightAnimTime)

	local nextGeniusId = Rouge2_TalentModel.instance:getNextOrderTalentId(geniusId)

	self.nextGeniusId = nextGeniusId

	local lastIndex = #self._useItemNodeList

	for index, item in ipairs(self._useItemNodeList) do
		if item.id == geniusId then
			AudioMgr.instance:trigger(AudioEnum.Rouge2.TalentActive)
			item:playLight()

			if index < lastIndex then
				local lineIndex, linePos = self:getItemLinePos(index)
				local posDic = Rouge2_OutsideEnum.TalentLinePos[lineIndex]

				if posDic and posDic[linePos + 1] then
					if not posDic[linePos + 1] then
						local value = 0

						if posDic and posDic[linePos] then
							if not posDic[linePos] then
								local previousValue = 1

								self:talentLineBgTween(lineIndex, previousValue, value)
							end
						end
					end
				end
			end
		elseif item.id == nextGeniusId then
			TaskDispatcher.runDelay(self.onRefreshAnimPlayFinish, self, Rouge2_OutsideEnum.TalentRefreshAnimTime)
			item:playRefresh(true)
		end
	end

	self._curGeniusId = geniusId
	self._curNextGeniusId = nextGeniusId
end

function Rouge2_TalentTreeView:talentLineBgTween(lineIndex, previousValue, targetValue)
	if self._lineTweenId then
		ZProj.TweenHelper.KillById(self._lineTweenId)
	end

	local param = lineIndex
	local lineItem = self._bgLineItemList[lineIndex]

	if not lineItem then
		return
	end

	gohelper.setActive(lineItem.itemGo, true)

	self._lineTweenId = ZProj.TweenHelper.DOTweenFloat(previousValue, targetValue, Rouge2_OutsideEnum.TalentLineAnimTime, self.setBgLineMaterialValue, self.setBgLineMaterialValueFinish, self, param, EaseType.Linear)
end

function Rouge2_TalentTreeView:setBgLineMaterialValueFinish()
	ZProj.TweenHelper.KillById(self._lineTweenId)

	self._lineTweenId = nil
end

function Rouge2_TalentTreeView:setBgLineMaterialValue(value, param)
	local lineItem = self._bgLineItemList[param]

	if not lineItem then
		logError("lineItem is nil" .. " value " .. value .. "param " .. param)

		return
	end

	local material = lineItem.material

	self._vec4.x = value

	material:SetVector("_DissolveControl", self._vec4)
end

function Rouge2_TalentTreeView:refreshLineState()
	self._lineParamState = {}

	for index, item in ipairs(self._useItemNodeList) do
		local lineIndex, linePos = self:getItemLinePos(index)
		local posDic = Rouge2_OutsideEnum.TalentLinePos[lineIndex]
		local isActive = Rouge2_TalentModel.instance:isTalentActive(item.id)

		if isActive then
			if posDic then
				if not posDic[linePos + 1] then
					self._lineParamState[lineIndex] = 0
				end
			end
		end
	end

	for index, lineItem in ipairs(self._bgLineItemList) do
		if not self._lineParamState[index] then
			gohelper.setActive(lineItem.itemGo, false)
		else
			gohelper.setActive(lineItem.itemGo, true)

			local material = lineItem.material

			if not self._lineParamState[index] then
				local value = 1

				self._vec4.x = value

				logNormal("matrerialCtrl index:" .. index .. " Value: " .. value)
				material:SetVector("_DissolveControl", self._vec4)
			end
		end
	end
end

function Rouge2_TalentTreeView:getItemLinePos(index)
	local perLineCount = 5
	local linePos = (index - 1) % perLineCount
	local lineIndex = (math.floor((index - 1) / perLineCount) + 1) * 2

	if linePos == 0 then
		linePos = 1
		lineIndex = lineIndex - 1
	end

	return lineIndex, linePos
end

function Rouge2_TalentTreeView:onLightAnimPlayFinish()
	for _, item in ipairs(self._useItemNodeList) do
		if item.id == self._curGeniusId then
			item:refreshUI()
			item:playRefresh(false)
		end
	end

	Rouge2_OutsideController.instance:lockScreen(false)
	self:refreshLineState()
	TaskDispatcher.cancelTask(self.onLightAnimPlayFinish, self)
end

function Rouge2_TalentTreeView:onRefreshAnimPlayFinish()
	for _, item in ipairs(self._useItemNodeList) do
		if item.id == self.nextGeniusId then
			item:refreshUI()
			item:playRefresh(false)
		end
	end

	TaskDispatcher.cancelTask(self.onRefreshAnimPlayFinish, self)
end

function Rouge2_TalentTreeView:_editableInitView()
	self._isShowTip = false
	self._goTips = gohelper.findChild(self.viewGO, "#go_topright/tips")

	gohelper.setActive(self._goTips, false)
	gohelper.setActive(self._btnempty, false)
	self:initNodeDetailItem()
	self:initNodeItem()
	self:initIcon()
	self:initLineFxItem()

	self._vec4 = Vector4(0, 0.01, 0, 0)
end

function Rouge2_TalentTreeView:onUpdateParam()
	return
end

function Rouge2_TalentTreeView:onOpen()
	self:refreshUI()
end

function Rouge2_TalentTreeView:refreshUI()
	self:refreshTreeNode(true)
	self:refreshTalentPoint()
	self:refreshLineState()
end

function Rouge2_TalentTreeView:initIcon()
	self.imageUpdatePoint = gohelper.findChildImage(self.viewGO, "#go_topright/icon2/icon")

	local constConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.TalentPointId)
	local itemId = tonumber(constConfig.value)
	local itemConfig = CurrencyConfig.instance:getCurrencyCo(itemId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageUpdatePoint, tostring(itemConfig.icon) .. "_1")
end

function Rouge2_TalentTreeView:initNodeItem()
	self._itemNodeList = {}
	self._useItemNodeList = {}

	local nodeParent = gohelper.findChild(self.viewGO, "#go_talenttree/item").transform
	local nodeCount = nodeParent.childCount
	local resPath = self.viewContainer._viewSetting.otherRes[1]

	for i = nodeCount, 1, -1 do
		local itemParent = nodeParent:GetChild(i - 1)
		local itemGo = self:getResInst(resPath, itemParent.gameObject)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, Rouge2_TalentTreeNodeItem)

		table.insert(self._itemNodeList, item)
	end
end

function Rouge2_TalentTreeView:initNodeDetailItem()
	self._detailItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._godetail, Rouge2_TalentTreeNodeDetailItem)

	self._detailItem:setActive(false)
end

function Rouge2_TalentTreeView:initLineFxItem()
	self._bgLineItemList = {}

	local parent = gohelper.findChild(self.viewGO, "#go_talenttree/light")
	local childCount = parent.transform.childCount

	for i = 2, childCount do
		local itemGo = parent.transform:GetChild(i - 1)
		local material = gohelper.findChildComponent(itemGo.gameObject, "line" .. tostring(i - 1), typeof(UnityEngine.UI.Graphic)).material
		local item = self:getUserDataTb_()

		item.itemGo = itemGo
		item.material = material

		table.insert(self._bgLineItemList, item)
	end
end

function Rouge2_TalentTreeView:onSelectTalent(selectId)
	for _, item in ipairs(self._useItemNodeList) do
		item:setSelect(selectId)
	end

	self._detailItem:setActive(selectId ~= nil)

	if selectId ~= nil then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.TalentSelect)
		self._detailItem:setInfo(selectId)
	end

	Rouge2_TalentModel.instance:setCurSelectId(selectId)
end

function Rouge2_TalentTreeView.sortTalent(a, b)
	if a.order ~= b.order then
		return a.order < b.order
	end

	return a.geniusId < b.geniusId
end

function Rouge2_TalentTreeView:refreshTreeNode(playAnim)
	tabletool.clear(self._useItemNodeList)

	local commonTalentConfigList = Rouge2_OutSideConfig.instance:getTalentConfigListByType(Rouge2_Enum.TalentType.Common)
	local talentConfigList = {}
	local talentCount = 0

	for _, config in ipairs(commonTalentConfigList) do
		talentCount = talentCount + 1

		table.insert(talentConfigList, config)
	end

	table.sort(talentConfigList, self.sortTalent)

	local itemCount = #self._itemNodeList
	local activeCount = 0

	for i = 1, talentCount do
		local typeConfig = talentConfigList[i]

		if itemCount < i then
			logError("talentNode out of index: " .. tostring(i))
		else
			local talentItem = self._itemNodeList[i]

			table.insert(self._useItemNodeList, talentItem)
			talentItem:setActive(true)
			talentItem:setInfo(typeConfig.geniusId, i)

			if playAnim then
				talentItem:playRefresh(false)
			end

			local isActive = Rouge2_TalentModel.instance:isTalentActive(typeConfig.geniusId)

			if isActive then
				activeCount = activeCount + 1
			end
		end
	end

	local allActive = talentCount <= activeCount

	gohelper.setActive(self._gobg0, not allActive)
	gohelper.setActive(self._gobg1, allActive)

	if talentCount < itemCount then
		for i = talentCount + 1, itemCount do
			local item = self._itemNodeList[i]

			item:setActive(false)
		end
	end
end

function Rouge2_TalentTreeView:refreshTalentPoint()
	self._txtnum.text = tostring(Rouge2_TalentModel.instance:getTalentPoint())

	local maxtalentpointConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.TalentPointMaxCount)
	local maxtalentpoint = tonumber(maxtalentpointConfig.value)
	local getAllPoint = math.min(Rouge2_TalentModel.instance:getHadAllTalentPoint(), maxtalentpoint)
	local param = {
		getAllPoint,
		maxtalentpoint
	}

	self._txttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_rouge2talentreeview_txt_dec3"), param)
end

function Rouge2_TalentTreeView:onClose()
	if self._lineTweenId then
		ZProj.TweenHelper.KillById(self._lineTweenId)
	end

	TaskDispatcher.cancelTask(self.onLightAnimPlayFinish, self)
	TaskDispatcher.cancelTask(self.onRefreshAnimPlayFinish, self)
	Rouge2_TalentModel.instance:setCurSelectId(nil)
end

function Rouge2_TalentTreeView:onDestroyView()
	return
end

return Rouge2_TalentTreeView
