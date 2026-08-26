-- chunkname: @modules/logic/versionactivity2_3/act174/view/info/Act174ItemTipView.lua

module("modules.logic.versionactivity2_3.act174.view.info.Act174ItemTipView", package.seeall)

local Act174ItemTipView = class("Act174ItemTipView", BaseView)

function Act174ItemTipView:onInitView()
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gobuff = gohelper.findChild(self.viewGO, "#go_buff")
	self._gocollection = gohelper.findChild(self.viewGO, "#go_collection")
	self._gobuynode1 = gohelper.findChild(self.viewGO, "#go_collection/#go_buynode")
	self._btnunequip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_collection/#btn_unequip")
	self._gocharacterinfo = gohelper.findChild(self.viewGO, "#go_characterinfo")
	self._gocharacterinfo2 = gohelper.findChild(self.viewGO, "#go_characterinfo2")
	self._gobuynode2 = gohelper.findChild(self.viewGO, "#go_characterinfo2/#go_buynode")
	self._btnBuy = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn_buy")
	self.txtCost = gohelper.findChildText(self.viewGO, "btn_buy/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174ItemTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnBuy:AddClickListener(self.clickBuy, self)
	self._btnunequip:AddClickListener(self.clickUnEquip, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.UpdateGameInfo, self.refreshCost, self)
end

function Act174ItemTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnunequip:RemoveClickListener()
	self.removeEventCb(self, Activity174Controller.instance, Activity174Event.UpdateGameInfo, self.refreshCost, self)
end

function Act174ItemTipView:_btncloseOnClick()
	self:closeThis()
end

function Act174ItemTipView:clickBuy()
	if self.viewParam then
		if not self.viewParam then
			return
		end

		if self.viewParam.finish then
			return
		end

		local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

		if self.viewParam.buyCost > gameInfo.coin then
			GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

			return
		end

		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("Act174ItemTipViewBuy")

		self.expectCoin = gameInfo.coin - self.viewParam.buyCost

		local actId = Activity174Model.instance:getCurActId()

		Activity174Rpc.instance:sendBuyIn174ShopRequest(actId, self.viewParam.index, self.buyReply, self)
	end
end

function Act174ItemTipView:buyReply(cmd, resultCode, msg)
	UIBlockMgr.instance:endBlock("Act174ItemTipViewBuy")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if resultCode == 0 then
		local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

		if self.expectCoin and self.expectCoin ~= gameInfo.coin then
			GameFacade.showToast(ToastEnum.Act174BuyReturnCoin)
		end

		self:closeThis()
	end
end

function Act174ItemTipView:clickUnEquip()
	Activity174Controller.instance:dispatchEvent(Activity174Event.UnEquipCollection, self.viewParam.index)
	self:closeThis()
end

function Act174ItemTipView:_editableInitView()
	self.cIcon = gohelper.findChildSingleImage(self._gocollection, "simage_collection")
	self.cName = gohelper.findChildText(self._gocollection, "txt_name")
	self.cDesc = gohelper.findChildText(self._gocollection, "scroll_desc/Viewport/go_desccontent/txt_desc")
	self.bIcon = gohelper.findChildSingleImage(self._gobuff, "simage_bufficon")
	self.bName = gohelper.findChildText(self._gobuff, "txt_name")
	self.bDesc = gohelper.findChildText(self._gobuff, "scroll_desc/Viewport/go_desccontent/txt_desc")
	self._animBuff = self._gobuff:GetComponent(gohelper.Type_Animator)
	self._animCollection = self._gocollection:GetComponent(gohelper.Type_Animator)
	self._animCharacter = self._gocharacterinfo:GetComponent(gohelper.Type_Animator)
end

function Act174ItemTipView:onUpdateParam()
	self:refreshUI()
end

function Act174ItemTipView:onOpen()
	if self.viewParam then
		gohelper.setActive(self._btnclose, self.viewParam)

		if self.viewParam then
			if not self.viewGO.transform then
				local parent = self._goleft.transform

				self._gobuff.transform:SetParent(parent)
				self._gocollection.transform:SetParent(parent)
				self._gocharacterinfo.transform:SetParent(parent)
				self:refreshUI()
				AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_mln_page_turn)
			end
		end
	end
end

function Act174ItemTipView:refreshUI()
	self.type = self.viewParam.type

	if not self.viewParam.pos then
		local pos = Vector2.New(0, 0)

		gohelper.setActive(self._gobuff, self.type == Activity174Enum.ItemTipType.Buff)
		gohelper.setActive(self._gocollection, self.type == Activity174Enum.ItemTipType.Collection or self.type == Activity174Enum.ItemTipType.Character2)
		gohelper.setActive(self._gocharacterinfo, self.type == Activity174Enum.ItemTipType.Character)
		gohelper.setActive(self._gocharacterinfo2, self.type == Activity174Enum.ItemTipType.Character1 or self.type == Activity174Enum.ItemTipType.Character3)

		if self.type == Activity174Enum.ItemTipType.Character then
			recthelper.setAnchor(self._gocharacterinfo.transform, pos.x, pos.y)

			self.characterItem = self.characterItem or MonoHelper.addNoUpdateLuaComOnceToGo(self._gocharacterinfo, Act174CharacterInfo)

			self.characterItem:setData(self.viewParam.co)
		elseif self.type == Activity174Enum.ItemTipType.Collection or self.type == Activity174Enum.ItemTipType.Character2 then
			recthelper.setAnchor(self._gocollection.transform, pos.x, pos.y)
			self:refreshSimpleInfo(self.viewParam.co)
		elseif self.type == Activity174Enum.ItemTipType.Buff then
			recthelper.setAnchor(self._gobuff.transform, pos.x, pos.y)
			self:refreshBuffInfo(self.viewParam.co)
		else
			recthelper.setAnchor(self._gocharacterinfo2.transform, pos.x, pos.y)

			self.characterItem = self.characterItem or MonoHelper.addNoUpdateLuaComOnceToGo(self._gocharacterinfo2, Act174CharacterInfo)

			self:refreshCharacterInfo2(self.viewParam.co)
		end

		self:refreshBuy()
		gohelper.setActive(self._btnunequip, self.viewParam.index)
	end
end

function Act174ItemTipView:refreshBuy()
	if self.viewParam then
		if self.viewParam then
			local parent

			if self.type == Activity174Enum.ItemTipType.Collection or self.type == Activity174Enum.ItemTipType.Character2 then
				parent = self._gobuynode1.transform
			elseif self.type == Activity174Enum.ItemTipType.Character1 then
				parent = self._gobuynode2.transform
			end

			if parent then
				self._btnBuy.transform:SetParent(parent, false)
			end
		end

		self:refreshCost()
		gohelper.setActive(self._btnBuy, self.viewParam)
	end
end

function Act174ItemTipView:refreshCost()
	local cost = ""
	local color = "#211F1F"

	if self.viewParam then
		local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

		if self.viewParam and gameInfo then
			cost = self.viewParam.buyCost

			if self.viewParam.buyCost > gameInfo.coin then
				color = "#be4343"
			end
		end

		SLFramework.UGUI.GuiHelper.SetColor(self.txtCost, color)

		self.txtCost.text = cost
	end
end

function Act174ItemTipView:refreshSimpleInfo(co)
	local icon, name, desc

	if self.type == Activity174Enum.ItemTipType.Collection then
		icon = co.icon

		do
			local rareColor = Activity174Enum.CollectionColor[co.rare]

			name = string.format("<#%s>%s</color>", rareColor, co.title)
			desc = SkillHelper.buildDesc(co.desc)
		end
	elseif self.type == Activity174Enum.ItemTipType.Character2 then
		if self.viewParam then
			do
				local goodInfo = self.viewParam.goodInfo

				if goodInfo then
					local bagInfo = goodInfo.bagInfo

					icon = Activity174Enum.heroBagIcon[#bagInfo.heroId]
				end

				name = co.bagTitle
				desc = co.bagDesc
			end

			if icon then
				self.cIcon:LoadImage(ResUrl.getRougeSingleBgCollection(icon))
			end
		end
	end

	self.cName.text = name or ""
	self.cDesc.text = desc or ""

	SkillHelper.addHyperLinkClick(self.cDesc)
end

function Act174ItemTipView:refreshBuffInfo(buffCo)
	self.bIcon:LoadImage(ResUrl.getAct174BuffIcon(buffCo.icon))

	self.bName.text = buffCo.title
	self.bDesc.text = buffCo.desc
end

function Act174ItemTipView:refreshCharacterInfo2(roleIdList)
	self.roleIdList = roleIdList
	self.characterItemList = {}

	for i = 1, 3 do
		local characterItem = self:getUserDataTb_()

		characterItem.frame = gohelper.findChild(self._gocharacterinfo2, "selectframe/selectframe" .. i)
		characterItem.go = gohelper.findChild(self._gocharacterinfo2, "character" .. i)

		local roleId = self.roleIdList[i]

		if roleId then
			::label_16_0::

			local roleCo = Activity174Config.instance:getRoleCo(roleId)

			if roleCo then
				characterItem.rare = gohelper.findChildImage(characterItem.go, "rare")
				characterItem.heroIcon = gohelper.findChildSingleImage(characterItem.go, "heroicon")
				characterItem.career = gohelper.findChildImage(characterItem.go, "career")

				local btnClick = gohelper.findButtonWithAudio(characterItem.go)

				self.addClickCb(self, btnClick, self.clickRole, self, i)
				UISpriteSetMgr.instance:setCommonSprite(characterItem.rare, "bgequip" .. tostring(CharacterEnum.Color[roleCo.rare]))
				UISpriteSetMgr.instance:setCommonSprite(characterItem.career, "lssx_" .. roleCo.career)

				if roleCo.type == Activity174Enum.CharacterType.Hero then
					local path = ResUrl.getHeadIconSmall(roleCo.skinId)

					characterItem.heroIcon:LoadImage(path)
				else
					local path = ResUrl.monsterHeadIcon(roleCo.skinId)

					characterItem.heroIcon:LoadImage(path)
				end
			else
				gohelper.setActive(characterItem.go, false)
			end

			table.insert(self.characterItemList, characterItem)
		end
	end

	self:clickRole(1)
end

function Act174ItemTipView:clickRole(index)
	if index == self.selectedIndex then
		return
	end

	local characterItem = self.characterItemList[index]
	local frame = characterItem and characterItem.frame

	if not gohelper.isNil(frame) then
		gohelper.setAsLastSibling(frame)
	end

	self.selectedIndex = index

	local roleId = self.roleIdList[index]
	local roleCo = Activity174Config.instance:getRoleCo(roleId)

	self.characterItem:setData(roleCo)
end

function Act174ItemTipView:onClose()
	return
end

function Act174ItemTipView:playCloseAnim()
	if self._gocharacterinfo.activeInHierarchy then
		self._animCharacter:Play(UIAnimationName.Close)
	end

	if self._gocollection.activeInHierarchy then
		self._animCollection:Play(UIAnimationName.Close)
	end

	if self._gobuff.activeInHierarchy then
		self._animBuff:Play(UIAnimationName.Close)
	end
end

function Act174ItemTipView:onDestroyView()
	self.cIcon:UnLoadImage()
	self.bIcon:UnLoadImage()
end

return Act174ItemTipView
