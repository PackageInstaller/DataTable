-- chunkname: @modules/logic/teaching/view/TeachingPopView.lua

module("modules.logic.teaching.view.TeachingPopView", package.seeall)

local TeachingPopView = class("TeachingPopView", BaseView)

function TeachingPopView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_bg")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "root/bg/image_rolemask/Hero/#simage_hero")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/txt_new/#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "root/txt_new/#txt_name")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_view")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#scroll_view/Viewport/Content/go_desc/#txt_desc")
	self._btnlearn = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_learn")
	self._gorewards = gohelper.findChild(self.viewGO, "root/#go_rewards")
	self._gorewarddetailItem = gohelper.findChild(self.viewGO, "root/#go_rewards/#go_rewarddetailItem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TeachingPopView:addEvents()
	self._btnlearn:AddClickListener(self._btnlearnOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function TeachingPopView:removeEvents()
	self._btnlearn:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function TeachingPopView:_btncloseOnClick()
	self:closeThis()
end

function TeachingPopView:_btnlearnOnClick()
	if self._teachingConfig == nil or self._isClick then
		return
	end

	self._isClick = true

	TeachingRpc.instance:sendGetTeachingInfo(function()
		ViewMgr.instance:openView(ViewName.TeachingMainView)

		self._isClick = false

		self:closeThis()
	end, self)
end

function TeachingPopView:_editableInitView()
	return
end

function TeachingPopView:onUpdateParam()
	return
end

function TeachingPopView:onOpen()
	self._isClick = false

	local heroId = self.viewParam.heroId
	local teachingId = self.viewParam.teachingId
	local heroCO = HeroConfig.instance:getHeroCO(heroId)

	self._skinConfig = SkinConfig.instance:getSkinCo(heroCO.skinId)
	self._teachingConfig = TeachingConfig.instance:getTeachingConfig(teachingId)

	self._simagehero:LoadImage(ResUrl.getHeadIconImg(self._skinConfig.drawing), self._onImageLoaded, self)

	self._txtdesc.text = self._teachingConfig.detail
	self._txtname.text = self._teachingConfig.name

	if self._teachingConfig.icon then
		UISpriteSetMgr.instance:setV3a7TeachingSystemSprite(self._imageicon, self._teachingConfig.icon)
	end

	if self._allRewards == nil then
		self._allRewards = self:getUserDataTb_()

		local reward = self._teachingConfig.bonus
		local rewards = string.split(reward, "|")

		gohelper.CreateObjList(self, self._onRecordRewardItem, rewards, self._gorewards, self._gorewarddetailItem, TeachingRewardItem)
	else
		for _, rewardItem in ipairs(self._allRewards) do
			rewardItem:refreshItem(self._status, self._config)
		end
	end
end

function TeachingPopView:_onImageLoaded()
	ZProj.UGUIHelper.SetImageSize(self._simagehero.gameObject)

	local offsets = SkinConfig.instance:getSkinOffset(self._skinConfig.skinViewImgOffset)

	recthelper.setAnchor(self._simagehero.transform, offsets[1], offsets[2])
	transformhelper.setLocalScale(self._simagehero.transform, offsets[3], offsets[3], offsets[3])
end

function TeachingPopView:_onRecordRewardItem(cell_component, data, index)
	cell_component:refreshItem(self._status, self._teachingConfig)
	table.insert(self._allRewards, cell_component)
end

function TeachingPopView:onClose()
	return
end

function TeachingPopView:onDestroyView()
	return
end

return TeachingPopView
