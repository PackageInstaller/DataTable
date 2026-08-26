-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186GiftView.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186GiftView", package.seeall)

local Activity186GiftView = class("Activity186GiftView", BaseView)

function Activity186GiftView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageItem = gohelper.findChildSingleImage(self.viewGO, "Item/#simage_Item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186GiftView:addEvents()
	self._clickbg:AddClickListener(self._onBgClick, self)
end

function Activity186GiftView:removeEvents()
	self._clickbg:RemoveClickListener()
end

function Activity186GiftView:_editableInitView()
	self._clickbg = gohelper.getClickWithAudio(self._simageFullBG.gameObject)
end

function Activity186GiftView:_onBgClick()
	self:closeThis()
end

function Activity186GiftView:onClickModalMask()
	self:closeThis()
end

function Activity186GiftView:onOpen()
	self.actId = self.viewParam and self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_popup)
	self:_refreshUI()
end

function Activity186GiftView:_refreshUI()
	self._simageItem:LoadImage(ResUrl.getAntiqueIcon("v2a5_antique_icon_1"))
end

function Activity186GiftView:onClose()
	local str = Activity186Config.instance:getConstStr(self.actId, Activity186Enum.ConstId.AvgReward)
	local bonus = GameUtil.splitString2(str, true)
	local list = {}

	for i, v in ipairs(bonus) do
		local o = MaterialDataMO.New()

		o:initValue(v[1], v[2], v[3])
		table.insert(list, o)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, list)
end

function Activity186GiftView:onDestroyView()
	self._simageItem:UnLoadImage()
end

return Activity186GiftView
