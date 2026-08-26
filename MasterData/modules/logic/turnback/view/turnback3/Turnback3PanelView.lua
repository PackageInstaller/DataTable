-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3PanelView.lua

module("modules.logic.turnback.view.turnback3.Turnback3PanelView", package.seeall)

local Turnback3PanelView = class("Turnback3PanelView", BaseView)

function Turnback3PanelView:onInitView()
	self._btnclosefullArea = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closefullArea")
	self._btnclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closefullArea/#btn_closebtn")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/#simage_title")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "root/go_time/#txt_remainTime")
	self._txttis = gohelper.findChildText(self.viewGO, "root/bottom/desctips/#txt_tis")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "root/bottom/#scroll_reward")
	self._gorewarditemcontent = gohelper.findChild(self.viewGO, "root/bottom/#scroll_reward/viewport/content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/bottom/#scroll_reward/viewport/content/#go_rewarditem")
	self._btngobtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom/#btn_gobtn")
	self._btnallreward = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom/desctips/#btn_allreward")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3PanelView:addEvents()
	self._btnclosefullArea:AddClickListener(self._btnclosefullAreaOnClick, self)
	self._btnclosebtn:AddClickListener(self._btnclosebtnOnClick, self)
	self._btngobtn:AddClickListener(self._btngobtnOnClick, self)
	self._btnallreward:AddClickListener(self._btnallrewardOnClick, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, self._refreshOnceBonusGetState, self)
end

function Turnback3PanelView:removeEvents()
	self._btnclosefullArea:RemoveClickListener()
	self._btnclosebtn:RemoveClickListener()
	self._btngobtn:RemoveClickListener()
	self._btnallreward:RemoveClickListener()
end

function Turnback3PanelView:_btnclosefullAreaOnClick()
	self:closeThis()
end

function Turnback3PanelView:_btnclosebtnOnClick()
	self:closeThis()
end

function Turnback3PanelView:_btngobtnOnClick()
	self:closeThis()

	if not self.hasGet then
		TurnbackRpc.instance:sendTurnbackOnceBonusRequest(self._turnbackId, self._receiveCallBack, self)
	else
		self:_receiveCallBack()
	end
end

function Turnback3PanelView:_btnallrewardOnClick()
	ViewMgr.instance:openView(ViewName.Turnback3RewardDetailView)
end

function Turnback3PanelView:_editableInitView()
	return
end

function Turnback3PanelView:onUpdateParam()
	return
end

function Turnback3PanelView:onOpen()
	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self.config = TurnbackConfig.instance:getTurnbackCo(self._turnbackId)

	self:_refreshTop()
	self:_refreshBottom()
	self:_refreshOnceBonusGetState()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_get)
end

function Turnback3PanelView:_refreshTop()
	self.topRewardList = {}

	local var_11_0 = self.config

	if self.config then
		var_11_0 = self.config.bonusList

		if self.config.bonusList then
			local bonusList = GameUtil.splitString2(self.config.bonusList)

			for i = 1, 4 do
				local rewardItem = self.topRewardList[i]
				local bonusCo = bonusList[i]
				local config, icon = ItemModel.instance:getItemConfigAndIcon(bonusCo[1], bonusCo[2], true)

				if not rewardItem then
					rewardItem = self:getUserDataTb_()

					local parentGO = gohelper.findChild(self.viewGO, "root/rewardPos/Pos" .. i)

					rewardItem.go = gohelper.findChild(parentGO, "root")
					rewardItem.txtname = gohelper.findChildText(rewardItem.go, "#txt_rewardname")
				end

				if i < 3 then
					rewardItem.txtname.text = config.name
					rewardItem.txtnum = gohelper.findChildText(rewardItem.go, "#txt_num")
					rewardItem.txtnum.text = "×" .. bonusCo[3]
				elseif config.effect and not string.nilorempty(config.effect) then
					local coList = GameUtil.splitString2(config.effect)

					for j = 2, 4 do
						local effectCo = coList[j]
						local img = gohelper.findChildSingleImage(rewardItem.go, "#simage_defaulticon" .. j - 1)

						img:LoadImage(ResUrl.getHeroDefaultEquipIcon(effectCo[2]))
					end
				end
			end
		end
	end
end

function Turnback3PanelView:_refreshBottom()
	self.rewardList = {}
	self._txtremainTime.text = TurnbackController.instance:refreshRemainTime()

	local bonusCo = GameUtil.splitString2(self.config.onceBonus, true)
	local count = #bonusCo

	for i = 1, count do
		local rewardItem = self.rewardList[i]

		if not rewardItem then
			rewardItem = self:getUserDataTb_()
			rewardItem.go = gohelper.clone(self._gorewarditem, self._gorewarditemcontent, "item" .. i)
			rewardItem.goIcon = gohelper.findChild(rewardItem.go, "itemicon")
			rewardItem.goCanGet = gohelper.findChild(rewardItem.go, "go_canget")
			rewardItem.goHasGet = gohelper.findChild(rewardItem.go, "finished")
			rewardItem.btnclick = gohelper.findChildButton(rewardItem.go, "go_canget/#btn_click")

			rewardItem.btnclick:AddClickListener(self._btnclickitem, self)

			local co = bonusCo[i]
			local type, id, num = co[1], co[2], co[3]
			local config, icon = ItemModel.instance:getItemConfigAndIcon(type, id, true)

			if icon then
				rewardItem.itemIcon = IconMgr.instance:getCommonPropItemIcon(rewardItem.goIcon)

				rewardItem.itemIcon:setMOValue(type, id, num, nil, true)
			end

			gohelper.setActive(rewardItem.go, true)
			table.insert(self.rewardList, rewardItem)
		end
	end
end

function Turnback3PanelView:_btnclickitem()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRpc.instance:sendTurnbackOnceBonusRequest(turnbackId)
end

function Turnback3PanelView:_refreshOnceBonusGetState()
	self.hasGet = TurnbackModel.instance:getOnceBonusGetState()

	for index, rewardItem in ipairs(self.rewardList) do
		gohelper.setActive(rewardItem.goCanGet, not self.hasGet)
		gohelper.setActive(rewardItem.goHasGet, self.hasGet)
	end
end

function Turnback3PanelView:_receiveCallBack()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local param = {
		turnbackId = turnbackId
	}

	TurnbackController.instance:openTurnbackBeginnerView(param)
end

function Turnback3PanelView:onClose()
	for index, rewardItem in ipairs(self.rewardList) do
		rewardItem.btnclick:RemoveClickListener()
	end
end

function Turnback3PanelView:onDestroyView()
	return
end

return Turnback3PanelView
