-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191HeroTipView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191HeroTipView", package.seeall)

local Act191HeroTipView = class("Act191HeroTipView", BaseView)

function Act191HeroTipView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goTagItem = gohelper.findChild(self.viewGO, "#go_Root/#go_TagItem")
	self._goSingleHero = gohelper.findChild(self.viewGO, "#go_Root/#go_SingleHero")
	self._goSingleTagContent = gohelper.findChild(self.viewGO, "#go_Root/#go_SingleHero/#go_SingleTagContent")
	self._goMultiHero = gohelper.findChild(self.viewGO, "#go_Root/#go_MultiHero")
	self._goMultiTagContent = gohelper.findChild(self.viewGO, "#go_Root/#go_MultiHero/#go_MultiTagContent")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Buy")
	self._txtBuyCost = gohelper.findChildText(self.viewGO, "#go_Root/#btn_Buy/#txt_BuyCost")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191HeroTipView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
end

function Act191HeroTipView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function Act191HeroTipView:_btnCloseOnClick()
	self:closeThis()
end

function Act191HeroTipView:_btnBuyOnClick()
	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if gameInfo.coin < self.viewParam.cost then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	Activity191Rpc.instance:sendBuyIn191ShopRequest(self.actId, self.viewParam.index, self._buyReply, self)
end

function Act191HeroTipView:_buyReply(_, resultCode)
	if resultCode == 0 then
		GameFacade.showToast(self.viewParam.toastId, self.roleCoList[1].name)
		self:closeThis()
	end
end

function Act191HeroTipView:_editableInitView()
	self.actId = Activity191Model.instance:getCurActId()
	self.characterInfo = MonoHelper.addNoUpdateLuaComOnceToGo(self._goRoot, Act191CharacterInfo)
	self.fetterIconItemList = {}
end

function Act191HeroTipView:onUpdateParam()
	self:refreshUI()
end

function Act191HeroTipView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)

	if self.viewParam.pos then
		local anchorPos = recthelper.rectToRelativeAnchorPos(self.viewParam.pos, self.viewGO.transform)

		recthelper.setAnchor(self._goRoot.transform, anchorPos.x - 100, 8)
	end

	self:refreshUI()
end

function Act191HeroTipView:onClose()
	local manual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, manual, self.roleCoList[1].name)
end

function Act191HeroTipView:refreshUI()
	gohelper.setActive(self._btnClose, not self.viewParam.notShowBg)

	if self.viewParam.showBuy then
		self:refreshCost()
		gohelper.setActive(self._btnBuy, true)
	else
		gohelper.setActive(self._btnBuy, false)
	end

	self.heroCnt = #self.viewParam.heroList
	self.roleCoList = {}
	self.roleCoList[1] = Activity191Config.instance:getRoleCo(self.viewParam.heroList[1])

	do
		local roleCo = self.roleCoList[1]
		local imageRare = gohelper.findChildImage(self._goSingleHero, "character/rare")
		local heroIcon = gohelper.findChildSingleImage(self._goSingleHero, "character/heroicon")
		local imageCareer = gohelper.findChildImage(self._goSingleHero, "character/career")
		local imageDmgType = gohelper.findChildImage(self._goSingleHero, "image_dmgtype")
		local txtName = gohelper.findChildText(self._goSingleHero, "name/txt_name")
		local iconPath = Activity191Helper.getHeadIconSmall(roleCo)

		heroIcon:LoadImage(iconPath)
		UISpriteSetMgr.instance:setAct174Sprite(imageRare, "act174_roleframe_" .. tostring(roleCo.quality))
		UISpriteSetMgr.instance:setCommonSprite(imageCareer, "lssx_" .. roleCo.career)
		UISpriteSetMgr.instance:setCommonSprite(imageDmgType, "dmgtype" .. tostring(roleCo.dmgType))

		txtName.text = roleCo.name

		self:refreshFetter(roleCo)
		self.characterInfo:setData(roleCo)
		gohelper.setActive(self._goSingleHero, true)
		gohelper.setActive(self._goMultiHero, false)
	end

	gohelper.setActive(self._goTagItem, false)
end

function Act191HeroTipView:onClickRole(index)
	if index == self.selectedIndex then
		return
	end

	local characterItem = self.characterItemList[index]
	local frame = characterItem and characterItem.frame

	if not gohelper.isNil(frame) then
		gohelper.setAsLastSibling(frame)
	end

	self.selectedIndex = index

	local id = self.viewParam.heroList[index]
	local roleCo = Activity191Config.instance:getRoleCo(id)

	self:refreshFetter(roleCo, true)
	self.characterInfo:setData(roleCo)
end

function Act191HeroTipView:refreshCost()
	local cost = self.viewParam.cost
	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if cost > gameInfo.coin then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtBuyCost, "#be4343")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtBuyCost, "#211f1f")
	end

	self._txtBuyCost.text = cost
end

function Act191HeroTipView:refreshFetter(roleCo, isMulti)
	for _, item in ipairs(self.fetterIconItemList) do
		gohelper.setActive(item.go, false)
	end

	local tagArr = string.split(roleCo.tag, "#")

	for k, tag in ipairs(tagArr) do
		local item = self.fetterIconItemList[k]

		if not item then
			local go = gohelper.clone(self._goTagItem, self._goSingleTagContent)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191FetterIconItem)
			self.fetterIconItemList[k] = item
		end

		item:setData(tag)
		item:setExtraParam({
			fromView = self.viewName
		})

		if self.viewParam.preview then
			item:setPreview()
		end

		if isMulti then
			if not self._goMultiTagContent then
				local parent = self._goSingleTagContent

				gohelper.addChild(parent, item.go)
				gohelper.setActive(item.go, true)
			end
		end
	end
end

return Act191HeroTipView
