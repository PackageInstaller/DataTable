-- chunkname: @modules/logic/battlepass/view/BpEnterView.lua

module("modules.logic.battlepass.view.BpEnterView", package.seeall)

local BpEnterView = class("BpEnterView", StoreRecommendBaseSubView)

function BpEnterView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagecover = gohelper.findChildSingleImage(self.viewGO, "cover/#simage_cover")
	self._transName = gohelper.findChildComponent(self.viewGO, "cover/skinname", typeof(UnityEngine.Transform))
	self._txtenname = gohelper.findChildText(self.viewGO, "cover/skinname/name/#txt_enname")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "cover/skinname/#btn_detail")
	self._simagedetail = gohelper.findChildSingleImage(self.viewGO, "cover/skinname/#btn_detail")
	self._headicon = gohelper.findChild(self.viewGO, "stamp/icon")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_enter", AudioEnum.UI.play_ui_role_pieces_open)
	self._txthead = gohelper.findChildTextMesh(self.viewGO, "stamp/txt")
	self._txtheadname = gohelper.findChildTextMesh(self.viewGO, "stamp/name")
	self._addReward = gohelper.findChild(self.viewGO, "#go_addreward")
	self._gostyle1 = gohelper.findChild(self.viewGO, "#go_style1")
	self._gostyle2 = gohelper.findChild(self.viewGO, "#go_style2")
	self._gostyle3 = gohelper.findChild(self.viewGO, "#go_style3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpEnterView:addEvents()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
end

function BpEnterView:removeEvents()
	self._btndetail:RemoveClickListener()
	self._btnenter:RemoveClickListener()
end

function BpEnterView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	local co = BpConfig.instance:getBpCO(BpModel.instance.id)

	if co then
		local skinname = gohelper.findChildTextMesh(self.viewGO, "cover/skinname")
		local name = gohelper.findChildTextMesh(self.viewGO, "cover/skinname/name")
		local nameEn = gohelper.findChildTextMesh(self.viewGO, "cover/skinname/#txt_enname")

		skinname.text = co.bpSkinDesc
		name.text = co.bpSkinNametxt
		nameEn.text = co.bpSkinEnNametxt
	end

	local headName, headId = BpConfig.instance:getCurHeadItemName(BpModel.instance.id)

	self._txtheadname.text = string.format("「%s」", headName)

	local liveIcon = IconMgr.instance:getCommonLiveHeadIcon(self._headicon)

	liveIcon:setLiveHead(headId)

	local newItems = BpConfig.instance:getNewItems(BpModel.instance.id)
	local len = #newItems

	if len > 3 then
		logError("BP 新增道具数量错误" .. #newItems)
	elseif len == 0 then
		gohelper.setActive(self._addReward, false)
	else
		gohelper.setActive(self._addReward, true)

		for i = 1, 3 do
			local node = gohelper.findChild(self._addReward, tostring(i))

			if len < i then
				gohelper.setActive(node, false)
			else
				local data = newItems[i]
				local config, icon = ItemModel.instance:getItemConfigAndIcon(data[1], data[2])
				local image = gohelper.findChildSingleImage(node, "#simage_icon" .. i)

				image:LoadImage(icon)
			end
		end
	end

	self.stamp2 = gohelper.findChild(self.viewGO, "stamp2")
	self.special_item = gohelper.findChild(self.stamp2, "#special_item")
	self.haveSpecialBonus = BpModel.instance:haveSpecialBonus()

	gohelper.setActive(self.stamp2, self.haveSpecialBonus)

	if self.haveSpecialBonus then
		self.specialItem = self.specialItem or IconMgr.instance:getCommonPropItemIcon(self.special_item)

		local bonus = BpModel.instance:getSpecialBonus()[1]

		self.specialItem:onUpdateMO({
			materilType = bonus[1],
			materilId = bonus[2],
			quantity = bonus[3]
		})
		self.specialItem:isShowCount(false)
	end
end

function BpEnterView:_btndetailOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function BpEnterView:_btnenterOnClick()
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "714",
		[StatEnum.EventProperties.RecommendPageName] = "吼吼点唱机",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex(714)
	})
	BpController.instance:openBattlePassView()
end

function BpEnterView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagecover:UnLoadImage()
	self._simagedetail:UnLoadImage()
end

return BpEnterView
