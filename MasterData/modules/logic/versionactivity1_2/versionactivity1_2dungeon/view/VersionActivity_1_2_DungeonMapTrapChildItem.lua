-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_DungeonMapTrapChildItem.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapTrapChildItem", package.seeall)

local VersionActivity_1_2_DungeonMapTrapChildItem = class("VersionActivity_1_2_DungeonMapTrapChildItem", BaseViewExtended)

function VersionActivity_1_2_DungeonMapTrapChildItem:onInitView()
	self._goselectbg = gohelper.findChild(self.viewGO, "#go_selectbg")
	self._gounselectbg = gohelper.findChild(self.viewGO, "#go_unselectbg")
	self._gocost = gohelper.findChild(self.viewGO, "bottom/#go_cost")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "content/iconbg/icon")
	self._simageicon = gohelper.findChildImage(self.viewGO, "bottom/#go_cost/iconnode/icon")
	self._txtcost = gohelper.findChildText(self.viewGO, "bottom/#go_cost/#txt_cost")
	self._gopalcing = gohelper.findChild(self.viewGO, "bottom/#go_palcing")
	self._btnremove = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_remove", AudioEnum.UI.play_ui_pkls_role_disappear)
	self._btnmake = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_make")
	self._btnreplace = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_replace", AudioEnum.UI.play_ui_lvhu_trap_replace)
	self._btnplace = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_place", AudioEnum.UI.play_ui_lvhu_trap_replace)
	self._txtname = gohelper.findChildText(self.viewGO, "content/#txt_name")
	self._txtinfo = gohelper.findChildText(self.viewGO, "content/#txt_info")
	self._vx_make = gohelper.findChild(self.viewGO, "vx_make")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_DungeonMapTrapChildItem:addEvents()
	self._btnremove:AddClickListener(self._btnremoveOnClick, self)
	self._btnmake:AddClickListener(self._btnmakeOnClick, self)
	self._btnreplace:AddClickListener(self._btnreplaceOnClick, self)
	self._btnplace:AddClickListener(self._btnplaceOnClick, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceivePutTrapReply, self._onReceivePutTrapReply, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveBuildTrapReply, self._onReceiveBuildTrapReply, self)
end

function VersionActivity_1_2_DungeonMapTrapChildItem:removeEvents()
	self._btnremove:RemoveClickListener()
	self._btnmake:RemoveClickListener()
	self._btnreplace:RemoveClickListener()
	self._btnplace:RemoveClickListener()
end

function VersionActivity_1_2_DungeonMapTrapChildItem:_editableInitView()
	gohelper.setActive(self._vx_make, false)
end

function VersionActivity_1_2_DungeonMapTrapChildItem:_btnremoveOnClick()
	Activity116Rpc.instance:sendPutTrapRequest(0)
end

function VersionActivity_1_2_DungeonMapTrapChildItem:_btnmakeOnClick()
	if #self._costData > 0 then
		local enough = ItemModel.instance:goodsIsEnough(self._costData[1], self._costData[2], self._costData[3])

		if not enough then
			GameFacade.showToast(ToastEnum.Acticity1_2MaterialNotEnough)

			return
		end
	end

	StatController.instance:track(StatEnum.EventName.FacilityMutually, {
		[StatEnum.EventProperties.FacilityName] = self._config.name,
		[StatEnum.EventProperties.PlotProgress2] = tostring(VersionActivity1_2DungeonController.instance:getNowEpisodeId())
	})
	Activity116Rpc.instance:sendBuildTrapRequest(self._config.id)
end

function VersionActivity_1_2_DungeonMapTrapChildItem:_btnreplaceOnClick()
	Activity116Rpc.instance:sendPutTrapRequest(self._config.id)
end

function VersionActivity_1_2_DungeonMapTrapChildItem:_btnplaceOnClick()
	Activity116Rpc.instance:sendPutTrapRequest(self._config.id)
end

function VersionActivity_1_2_DungeonMapTrapChildItem:_onReceivePutTrapReply()
	self:onOpen()
end

function VersionActivity_1_2_DungeonMapTrapChildItem:_onReceiveBuildTrapReply(trapId)
	self:onOpen()

	if trapId == self._config.id then
		gohelper.setActive(self._vx_make, false)
		gohelper.setActive(self._vx_make, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_prop_pick)
	end
end

function VersionActivity_1_2_DungeonMapTrapChildItem:onRefreshViewParam(config)
	self._config = config
end

function VersionActivity_1_2_DungeonMapTrapChildItem:onOpen()
	self._trapIds = VersionActivity1_2DungeonModel.instance.trapIds
	self._putTrap = VersionActivity1_2DungeonModel.instance.putTrap

	gohelper.setActive(self._goselectbg, self._putTrap == self._config.id)
	gohelper.setActive(self._gounselectbg, self._putTrap ~= self._config.id)

	self._makeDone = self._trapIds[self._config.id]
	self._putting = self._putTrap == self._config.id

	gohelper.setActive(self._btnmake.gameObject, not self._makeDone)
	gohelper.setActive(self._gopalcing, self._putting)
	gohelper.setActive(self._btnremove.gameObject, self._putting)
	gohelper.setActive(self._btnreplace.gameObject, (false or nil) and true)
	gohelper.setActive(self._btnplace.gameObject, self._putTrap == 0 and self._makeDone)

	self._txtname.text = self._config.name
	self._txtinfo.text = string.gsub(self._config.desc, "\\n", "\n")

	self:_showCost()
	UISpriteSetMgr.instance:setVersionActivityDungeon_1_2Sprite(self._imageIcon, self._config.icon)
end

function VersionActivity_1_2_DungeonMapTrapChildItem:_showCost()
	gohelper.setActive(self._gocost, not self._makeDone)

	if not self._makeDone then
		self._costData = string.splitToNumber(self._config.cost, "#")

		if #self._costData > 0 then
			local currencyname = CurrencyConfig.instance:getCurrencyCo(self._costData[2]).icon

			UISpriteSetMgr.instance:setCurrencyItemSprite(self._simageicon, currencyname .. "_1")

			self._txtcost.text = self._costData[3]
			self._costIconClick = gohelper.getClick(self._simageicon.gameObject)

			self._costIconClick:AddClickListener(self._onBtnCostIcon, self)

			local enough = ItemModel.instance:goodsIsEnough(self._costData[1], self._costData[2], self._costData[3])

			if enough then
				SLFramework.UGUI.GuiHelper.SetColor(self._txtcost, "#ACCB8A")
			else
				SLFramework.UGUI.GuiHelper.SetColor(self._txtcost, "#D97373")
			end
		else
			gohelper.setActive(self._gocost, false)
		end
	end
end

function VersionActivity_1_2_DungeonMapTrapChildItem:_onBtnCostIcon()
	MaterialTipController.instance:showMaterialInfo(self._costData[1], self._costData[2])
end

function VersionActivity_1_2_DungeonMapTrapChildItem:onClose()
	if self._costIconClick then
		self._costIconClick:RemoveClickListener()
	end
end

function VersionActivity_1_2_DungeonMapTrapChildItem:onDestroyView()
	return
end

return VersionActivity_1_2_DungeonMapTrapChildItem
