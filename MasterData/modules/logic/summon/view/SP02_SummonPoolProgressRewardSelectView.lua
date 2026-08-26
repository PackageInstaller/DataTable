-- chunkname: @modules/logic/summon/view/SP02_SummonPoolProgressRewardSelectView.lua

module("modules.logic.summon.view.SP02_SummonPoolProgressRewardSelectView", package.seeall)

local SP02_SummonPoolProgressRewardSelectView = class("SP02_SummonPoolProgressRewardSelectView", BaseView)

function SP02_SummonPoolProgressRewardSelectView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SP02_SummonPoolProgressRewardSelectView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonOptionalProgressRewards, self.closeThis, self)
end

function SP02_SummonPoolProgressRewardSelectView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonOptionalProgressRewards, self.closeThis, self)
end

function SP02_SummonPoolProgressRewardSelectView:_btncloseOnClick()
	self:closeThis()
end

function SP02_SummonPoolProgressRewardSelectView:_btnconfirmOnClick()
	if not self._curSelectIndex or self._curSelectIndex == 0 then
		return
	end

	local curPoolInfo = SummonMainModel.instance:getPoolServerMO(self.poolId)

	if not curPoolInfo or not curPoolInfo.customPickMO or curPoolInfo.customPickMO:isOptionalRewardGet(self.progressId) then
		return
	end

	local rewardParam = self.rewardDataList[self._curSelectIndex]
	local itemConfig = ItemConfig.instance:getItemConfig(rewardParam[1], rewardParam[2])

	SummonController.instance:trySelectOptionalProgressReward(self.poolId, self.progressId, self._curSelectIndex, itemConfig.name)
end

function SP02_SummonPoolProgressRewardSelectView:_editableInitView()
	self.rewardItemList = {}
	self.imageButton = gohelper.findChildImage(self.viewGO, "#btn_confirm")
end

function SP02_SummonPoolProgressRewardSelectView:onUpdateParam()
	return
end

function SP02_SummonPoolProgressRewardSelectView:onOpen()
	self:checkParam()
	self:refreshReward()
	self:selectReward(0)
end

function SP02_SummonPoolProgressRewardSelectView:checkParam()
	if not self.viewParam then
		return
	end

	local groupId = self.viewParam.groupId
	local progressId = self.viewParam.progressId

	self._curSelectIndex = nil
	self.rewardConfig = SummonConfig.instance:getProgressChooseConfig(groupId, progressId)
	self.groupId = groupId
	self.progressId = progressId
	self.poolId = SummonMainModel.instance:getCurId()
	self.rewardDataList = GameUtil.splitString2(self.rewardConfig.chooseRewards, true)
end

function SP02_SummonPoolProgressRewardSelectView:refreshReward()
	if self.rewardDataList and next(self.rewardDataList) then
		for index, rewardData in ipairs(self.rewardDataList) do
			local item = self:getRewardItem(index)
			local itemConfig = ItemConfig.instance:getItemConfig(rewardData[1], rewardData[2])
			local desc = itemConfig.name .. "×" .. tostring(rewardData[3])

			item.txtSelectName.text = desc
			item.txtUnSelectName.text = desc
		end
	end
end

function SP02_SummonPoolProgressRewardSelectView:getRewardItem(index)
	if not self.rewardItemList[index] then
		local itemGo = gohelper.findChild(self.viewGO, "reward/#go_reward" .. tostring(index))
		local item = self:getUserDataTb_()

		item.itemGo = itemGo
		item.goSelect = gohelper.findChild(itemGo, "#go_select")
		item.goSelectTag = gohelper.findChild(itemGo, "#go_select/#go_select")
		item.goUnSelect = gohelper.findChild(itemGo, "#go_unselect")
		item.txtSelectName = gohelper.findChildTextMesh(item.goSelect, "txt_name")
		item.txtUnSelectName = gohelper.findChildTextMesh(item.goUnSelect, "txt_name")
		item.btnCheckSelect = gohelper.findChildButton(item.goSelect, "#btn_check")
		item.btnCheckUnSelect = gohelper.findChildButton(item.goUnSelect, "#btn_check")
		item.btnClick = SLFramework.UGUI.UIClickListener.Get(itemGo)

		local param = {}

		param.index = index
		param.target = self

		item.btnClick:AddClickListener(self.clickSelectBtn, param)
		gohelper.addUIClickAudio(item.btnClick.gameObject, AudioEnum.UI.UI_Common_Click)
		item.btnCheckSelect:AddClickListener(self.clickCheckBtn, param)
		item.btnCheckUnSelect:AddClickListener(self.clickCheckBtn, param)

		self.rewardItemList[index] = item
	end

	return self.rewardItemList[index]
end

function SP02_SummonPoolProgressRewardSelectView.clickCheckBtn(param)
	local target = param.target
	local index = param.index

	target:checkReward(index)
end

function SP02_SummonPoolProgressRewardSelectView:checkReward(index)
	local rewardParam = self.rewardDataList[index]
	local type = rewardParam[1]
	local id = rewardParam[2]
	local config = ItemConfig.instance:getItemConfig(type, id)

	if config.subType == ItemEnum.SubType.InspirationBox then
		GiftController.instance:GiftMultipleInspirationHeroPreviewView({
			itemId = id
		})
	else
		AudioMgr.instance:trigger(AudioEnum3_10.SummonProgress.play_ui_langchao_role_open)
		MaterialTipController.instance:showMaterialInfo(type, id)
	end
end

function SP02_SummonPoolProgressRewardSelectView.clickSelectBtn(param)
	local target = param.target
	local index = param.index

	target:selectReward(index)
end

function SP02_SummonPoolProgressRewardSelectView:selectReward(index)
	if index == self._curSelectIndex then
		return
	end

	local isSelect = index ~= nil and index ~= 0

	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, not isSelect)

	self._curSelectIndex = index

	self:_refreshSelect()
end

function SP02_SummonPoolProgressRewardSelectView:_refreshSelect()
	for index, item in ipairs(self.rewardItemList) do
		local isSelect = index == self._curSelectIndex

		gohelper.setActive(item.goSelect, isSelect or self._curSelectIndex == 0)
		gohelper.setActive(item.goSelectTag, isSelect)
		gohelper.setActive(item.goUnSelect, not isSelect and self._curSelectIndex ~= 0)
	end
end

function SP02_SummonPoolProgressRewardSelectView:onClose()
	for index, item in ipairs(self.rewardItemList) do
		item.btnClick:RemoveClickListener()
		item.btnCheckSelect:RemoveClickListener()
		item.btnCheckUnSelect:RemoveClickListener()
	end
end

function SP02_SummonPoolProgressRewardSelectView:onDestroyView()
	return
end

return SP02_SummonPoolProgressRewardSelectView
