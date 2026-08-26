-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191EnhancePickView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191EnhancePickView", package.seeall)

local Act191EnhancePickView = class("Act191EnhancePickView", BaseView)

function Act191EnhancePickView:onInitView()
	self._goSelectItem = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content/#go_SelectItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191EnhancePickView:_onEscBtnClick()
	return
end

function Act191EnhancePickView:_editableInitView()
	gohelper.setActive(self._goSelectItem, false)

	self.actId = Activity191Model.instance:getCurActId()
	self.maxFreshNum = tonumber(lua_activity191_const.configDict[Activity191Enum.ConstKey.MaxFreshNum].value)
end

function Act191EnhancePickView:onOpen()
	self.nodeDetailMo = self.viewParam
	self.enhanceItemList = {}

	self:refreshUI()
end

function Act191EnhancePickView:refreshUI()
	self.freshIndex = nil

	for k, enhanceId in ipairs(self.nodeDetailMo.enhanceList) do
		local item = self.enhanceItemList[k]

		item = item or self:creatEnhanceItem(k)

		local enhanceCo = Activity191Config.instance:getEnhanceCo(self.actId, enhanceId)

		item.buffIcon:LoadImage(ResUrl.getAct174BuffIcon(enhanceCo.icon))

		item.txtName.text = enhanceCo.title

		local desc = SkillHelper.addLink(enhanceCo.desc)
		local effectId = string.splitToNumber(enhanceCo.effects, "|")[1]
		local effectCo = lua_activity191_effect.configDict[effectId]

		if effectCo then
			if effectCo.type == Activity191Enum.EffectType.EnhanceHero then
				item.txtDesc.text = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.EnhanceDestiny, effectCo.typeParam)

				SkillHelper.addHyperLinkClick(item.txtDesc, Activity191Helper.clickHyperLinkDestiny)
			elseif effectCo.type == Activity191Enum.EffectType.Item then
				item.txtDesc.text = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.EnhanceItem, effectCo.typeParam .. "#")

				SkillHelper.addHyperLinkClick(item.txtDesc, Activity191Helper.clickHyperLinkItem)
			elseif effectCo.type == Activity191Enum.EffectType.Hero then
				item.txtDesc.text = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.Hero, effectCo.typeParam)

				SkillHelper.addHyperLinkClick(item.txtDesc, Activity191Helper.clickHyperLinkRole)
			else
				item.txtDesc.text = desc
			end
		else
			item.txtDesc.text = desc
		end

		local num = self.nodeDetailMo.enhanceNumList[k]

		num = num or 0

		gohelper.setActive(item.btnFresh, num < self.maxFreshNum)
	end
end

function Act191EnhancePickView:creatEnhanceItem(i)
	local item = self:getUserDataTb_()
	local go = gohelper.cloneInPlace(self._goSelectItem, "enhanceItem" .. i)

	item.anim = go:GetComponent(gohelper.Type_Animator)
	item.buffIcon = gohelper.findChildSingleImage(go, "simage_bufficon")
	item.txtName = gohelper.findChildText(go, "txt_name")
	item.txtDesc = gohelper.findChildText(go, "scroll_desc/Viewport/go_desccontent/txt_desc")

	local btnBuy = gohelper.findChildButtonWithAudio(go, "btn_select")

	self.addClickCb(self, btnBuy, self.clickBuy, self, i)

	item.btnFresh = gohelper.findChildButtonWithAudio(go, "btn_Fresh")

	self.addClickCb(self, item.btnFresh, self.clickFresh, self, i)

	self.enhanceItemList[i] = item

	gohelper.setActive(go, true)

	return item
end

function Act191EnhancePickView:clickBuy(index)
	if self.selectIndex then
		return
	end

	self.selectIndex = index

	Activity191Rpc.instance:sendSelect191EnhanceRequest(self.actId, index, self.onSelectEnhance, self)
end

function Act191EnhancePickView:clickFresh(index)
	if self.freshIndex then
		return
	end

	self.freshIndex = index

	Activity191Rpc.instance:sendFresh191EnhanceRequest(self.actId, index, self.onFreshEnhance, self)
end

function Act191EnhancePickView:onSelectEnhance(_, resultCode)
	if resultCode == 0 then
		local enhanceItem = self.enhanceItemList[self.selectIndex]

		if enhanceItem then
			enhanceItem.anim:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(self.delayClose, self, 0.67)
	end
end

function Act191EnhancePickView:delayClose()
	self.selectIndex = nil

	local needOpen = Activity191Controller.instance:checkOpenGetView()

	if needOpen then
		ViewMgr.instance:openView(ViewName.Act191GetView)
	else
		Activity191Controller.instance:nextStep()
	end

	self:closeThis()
end

function Act191EnhancePickView:onFreshEnhance(_, resultCode)
	if resultCode == 0 then
		if self.freshIndex then
			self.enhanceItemList[self.freshIndex].anim:Play("switch", 0, 0)
		end

		local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

		self.nodeDetailMo = gameInfo:getNodeDetailMo()

		TaskDispatcher.runDelay(self.refreshUI, self, 0.16)
	end
end

function Act191EnhancePickView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayClose, self)
end

return Act191EnhancePickView
