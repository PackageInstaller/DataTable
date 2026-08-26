-- chunkname: @modules/logic/survival/view/map/SurvivalGetRewardView.lua

module("modules.logic.survival.view.map.SurvivalGetRewardView", package.seeall)

local SurvivalGetRewardView = class("SurvivalGetRewardView", BaseView)

function SurvivalGetRewardView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtTitle = gohelper.findChildTextMesh(self.viewGO, "titlebg/#txt_title")
	self._goreward = gohelper.findChild(self.viewGO, "#go_View/Reward/Viewport/Content/go_rewarditem")
	self._gonum = gohelper.findChild(self.viewGO, "titlebg/numbg")
	self._gotips = gohelper.findChild(self.viewGO, "Bottom/txt_tips")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#btn_confirm")
end

function SurvivalGetRewardView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function SurvivalGetRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function SurvivalGetRewardView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_finish)
	gohelper.setActive(self._btnget, false)
	gohelper.setActive(self._gonum, false)
	gohelper.setActive(self._gotips, true)
	self:_refreshView()
end

function SurvivalGetRewardView:onUpdateParam()
	self:_refreshView()
end

function SurvivalGetRewardView:_refreshView()
	self._items = self.viewParam.items

	SurvivalBagSortHelper.sortItems(self._items, SurvivalEnum.ItemSortType.ItemReward, true)
	gohelper.CreateObjList(self, self._createRewardItem, self._items, nil, self._goreward)

	self._txtTitle.text = self.viewParam.title or luaLang("survival_reward_title")
end

function SurvivalGetRewardView:_createRewardItem(obj, data, index)
	local select = gohelper.findChild(obj, "go_select")

	gohelper.setActive(select, false)

	local click = gohelper.findChild(obj, "#btn_click")

	gohelper.setActive(click, false)

	local instGo = gohelper.findChild(obj, "go_card/inst")

	if not instGo then
		local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView

		instGo = self:getResInst(infoViewRes, gohelper.findChild(obj, "go_card"), "inst")
	end

	local infoView = MonoHelper.addNoUpdateLuaComOnceToGo(instGo, SurvivalBagInfoPart)

	infoView:updateMo(data)
end

function SurvivalGetRewardView:onClickModalMask()
	self:closeThis()
end

return SurvivalGetRewardView
