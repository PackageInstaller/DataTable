-- chunkname: @modules/logic/survival/view/map/SurvivalDropSelectView.lua

module("modules.logic.survival.view.map.SurvivalDropSelectView", package.seeall)

local SurvivalDropSelectView = class("SurvivalDropSelectView", BaseView)

function SurvivalDropSelectView:onInitView()
	self._txtTitle = gohelper.findChildTextMesh(self.viewGO, "titlebg/#txt_title")
	self._goreward = gohelper.findChild(self.viewGO, "#go_View/Reward/Viewport/Content/go_rewarditem")
	self._txtnum = gohelper.findChildTextMesh(self.viewGO, "titlebg/numbg/#txt_num")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#btn_confirm")
end

function SurvivalDropSelectView:addEvents()
	self._btnget:AddClickListener(self.onClickGetReward, self)
end

function SurvivalDropSelectView:removeEvents()
	self._btnget:RemoveClickListener()
end

function SurvivalDropSelectView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_finish)
	self:_refreshView()
end

function SurvivalDropSelectView:onUpdateParam()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_finish)
	self:_refreshView()
end

function SurvivalDropSelectView:_refreshView()
	self._selectIndex = {}
	self._panel = self.viewParam.panel
	self._selectObjs = self:getUserDataTb_()
	self._items = self._panel.items

	gohelper.CreateObjList(self, self._createRewardItem, self._items, nil, self._goreward)
	self:_refreshNum()

	self._txtTitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_reward_select_title"), self._panel.canSelectNum)
end

function SurvivalDropSelectView:_createRewardItem(obj, data, index)
	local select = gohelper.findChild(obj, "go_select")
	local btn = gohelper.findChildClickWithDefaultAudio(obj, "go_card")

	gohelper.setActive(select, false)

	self._selectObjs[index] = select

	self.addClickCb(self, btn, self._onBtnClick, self, index)

	local instGo = gohelper.findChild(obj, "go_card/inst")

	if not instGo then
		local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView

		instGo = self:getResInst(infoViewRes, gohelper.findChild(obj, "go_card"), "inst")
	end

	local infoView = MonoHelper.addNoUpdateLuaComOnceToGo(instGo, SurvivalBagInfoPart)

	infoView:updateMo(data)
	infoView:setClickDescCallback(self._onBtnClick, self, index)
end

function SurvivalDropSelectView:_onBtnClick(index)
	local key = tabletool.indexOf(self._selectIndex, index - 1)

	if key then
		table.remove(self._selectIndex, key)
		gohelper.setActive(self._selectObjs[index], false)
	else
		if self._panel.canSelectNum == tabletool.len(self._selectIndex) then
			if self._panel.canSelectNum ~= 1 then
				return
			else
				gohelper.setActive(self._selectObjs[self._selectIndex[1] + 1], false)

				self._selectIndex[1] = nil
			end
		end

		table.insert(self._selectIndex, index - 1)
		gohelper.setActive(self._selectObjs[index], true)
	end

	self:_refreshNum()
end

function SurvivalDropSelectView:_refreshNum()
	local selectNum = tabletool.len(self._selectIndex)

	self._txtnum.text = selectNum < self._panel.canSelectNum and string.format("<#D64241>%d</color>/%d", selectNum, self._panel.canSelectNum) or string.format("%d/%d", selectNum, self._panel.canSelectNum)
end

function SurvivalDropSelectView:onClickGetReward()
	local selectNum = tabletool.len(self._selectIndex)

	if selectNum < self._panel.canSelectNum then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalDropSelect, MsgBoxEnum.BoxType.Yes_No, self._realGetItems, nil, nil, self, nil, nil)
	else
		self:_realGetItems()
	end
end

function SurvivalDropSelectView:_realGetItems()
	SurvivalWeekRpc.instance:sendSurvivalPanelOperationRequest(self._panel.uid, table.concat(self._selectIndex, ","), self._onRecvMsg, self)
end

function SurvivalDropSelectView:_onRecvMsg(cmd, resultCode, msg)
	self:closeThis()
end

return SurvivalDropSelectView
