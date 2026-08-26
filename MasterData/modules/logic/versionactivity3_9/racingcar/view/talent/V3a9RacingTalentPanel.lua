-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/talent/V3a9RacingTalentPanel.lua

module("modules.logic.versionactivity3_9.racingcar.view.talent.V3a9RacingTalentPanel", package.seeall)

local V3a9RacingTalentPanel = class("V3a9RacingTalentPanel", BaseView)

function V3a9RacingTalentPanel:onInitView()
	self._goitem = gohelper.findChild(self.viewGO, "skilltree/#go_item")
	self._gotips = gohelper.findChild(self.viewGO, "skilltree/#go_tips")
	self._txttipinfo = gohelper.findChildText(self.viewGO, "skilltree/#go_tips/#txt_tipinfo")
	self._imageskillicon = gohelper.findChildImage(self.viewGO, "panel/title/#image_skillicon")
	self._txtskillname = gohelper.findChildText(self.viewGO, "panel/title/#txt_skillname")
	self._txtskilltype = gohelper.findChildText(self.viewGO, "panel/title/#txt_skilltype")
	self._golevel = gohelper.findChild(self.viewGO, "panel/title/#go_level")
	self._golockbg = gohelper.findChild(self.viewGO, "panel/title/#go_level/#go_lockbg")
	self._gonormalbg = gohelper.findChild(self.viewGO, "panel/title/#go_level/#go_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "panel/title/#go_level/#txt_num")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "panel/title/#go_level/#txt_num_2")
	self._goattribute = gohelper.findChild(self.viewGO, "panel/content/#go_attribute")
	self._txtleveluptxt = gohelper.findChildText(self.viewGO, "panel/content/#go_attribute/#txt_leveluptxt")
	self._godetailitemlayout = gohelper.findChild(self.viewGO, "panel/content/#go_attribute/attributelayout")
	self._godetailitem = gohelper.findChild(self.viewGO, "panel/content/#go_attribute/attributelayout/#go_item")
	self._txtdesc = gohelper.findChildText(self.viewGO, "panel/content/#go_scrolldesc/viewport/#txt_desc")
	self._btnupbtn = gohelper.findChildButtonWithAudio(self.viewGO, "panel/#btn_upbtn")
	self._gobtnlockbg = gohelper.findChild(self.viewGO, "panel/#btn_upbtn/#go_lockbg")
	self._gobtnnormalbg = gohelper.findChild(self.viewGO, "panel/#btn_upbtn/#go_normalbg")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "panel/#btn_upbtn/#txt_currency")
	self._txtbtn = gohelper.findChildText(self.viewGO, "panel/#btn_upbtn/#txt_btn")
	self._imagecurrency = gohelper.findChildImage(self.viewGO, "panel/#btn_upbtn/#txt_currency/icon")
	self._golock = gohelper.findChild(self.viewGO, "panel/#go_lock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingTalentPanel:addEvents()
	self._btnupbtn:AddClickListener(self._btnupbtnOnClick, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.onSelectTalentItem, self._onSelectTalentItem, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.onLevelUpTalent, self._onLevelUpTalent, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function V3a9RacingTalentPanel:removeEvents()
	self._btnupbtn:RemoveClickListener()
	self.removeEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.onSelectTalentItem, self._onSelectTalentItem, self)
	self.removeEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.onLevelUpTalent, self._onLevelUpTalent, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function V3a9RacingTalentPanel:_onSelectTalentItem(id)
	if self._selectTalentMo and self._selectTalentMo:getId() == id then
		return
	end

	self._selectTalentMo = V3a9RacingTalentModel.instance:getTalentMoById(self._actId, id)

	for i, item in ipairs(self._groupItems) do
		item:refreshSelectById(id)
	end

	self:_refreshTalentDetail(id)
end

function V3a9RacingTalentPanel:_onLevelUpTalent(info)
	self:_levelUpCb()

	local level = info.level

	if level == 1 then
		local talentId = info.giftPoint
		local mo = V3a9RacingTalentModel.instance:getTalentMoById(self._actId, talentId)

		if mo then
			local group = mo:getGroup()
			local index = self._groupDict[group]

			if index then
				local groupItem = self._groupItems[index]

				if groupItem then
					local item = groupItem:getTalentItem(mo:getOrder())

					if item then
						item:playActivateAnim()
						AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayBulaochuanLeak)
					end
				end
			end
		end
	end
end

function V3a9RacingTalentPanel:_onCurrencyChange()
	self:_refreshDetailBtn()
end

function V3a9RacingTalentPanel:_btnupbtnOnClick()
	if not self._selectTalentMo then
		return
	end

	if not self._selectTalentMo:isCanLevelUp() then
		return
	end

	local cost = self._selectTalentMo:getLevelUpCost()
	local currencyId = V3a9RacingTalentModel.instance:getCurrencyId(self._actId)

	if currencyId then
		local consume = {}
		local item = {}

		item.type = MaterialEnum.MaterialType.Currency
		item.id = currencyId
		item.quantity = cost
		item.rare = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Currency, currencyId).rare

		table.insert(consume, item)

		local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(consume)

		if not enough then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)

			return
		end
	end

	V3a9RacingCarRpc.instance:sendAct243UpgradeGiftRequest(self._actId, self._selectTalentMo:getId())
end

function V3a9RacingTalentPanel:_levelUpCb()
	self:_refreshTalentDetail()

	for i, item in ipairs(self._groupItems) do
		item:refreshMo()
	end
end

function V3a9RacingTalentPanel:_editableInitView()
	self._detailAttrItems = self:getUserDataTb_()

	self:_initTalentGroups()
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._godetailitemlayout, false)
	gohelper.setActive(self._godetailitem, false)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.onUnlockRole, self._onUnlockRole, self)
end

function V3a9RacingTalentPanel:_onUnlockRole()
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayCikexiaLinkReceiveAward)
end

function V3a9RacingTalentPanel:onOpen()
	self._actId = self.viewParam.actId
end

function V3a9RacingTalentPanel:_initTalentGroups()
	if self.viewParam then
		self._actId = self.viewParam.actId or VersionActivity3_9Enum.ActivityId.Racing
	end

	local groupMoList = V3a9RacingTalentModel.instance:getTalentGroupMoList(self._actId)

	gohelper.setActive(self._goitem, false)

	self._groupItems = self:getUserDataTb_()
	self._groupDict = {}

	local firtId = 0

	if groupMoList then
		for i, mo in ipairs(groupMoList) do
			local item = self:_getTalentGroups(i)

			item:onUpdateMO(mo)

			if i == 1 then
				local talentMos = mo:getTalentMos()
				local firstMo = talentMos and talentMos[1]

				if firstMo then
					firtId = firstMo:getId()
				end
			end

			self._groupDict[mo:getGroup()] = i
		end

		self:_onSelectTalentItem(firtId)
	end

	if not #self._groupItems then
		local count = 0

		for i = 1, #self._groupItems do
			gohelper.setActive(self._groupItems[i].viewGO, i <= count)
		end
	end
end

function V3a9RacingTalentPanel:_getTalentGroups(i)
	local item = self._groupItems[i]

	if not item then
		local go = gohelper.cloneInPlace(self._goitem, "group_" .. i)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a9RacingTalentGroupItem)
		self._groupItems[i] = item
	end

	return item
end

function V3a9RacingTalentPanel:_refreshTalentDetail()
	if not self._selectTalentMo then
		return
	end

	local curCo = self._selectTalentMo:getCurLevelCo()
	local nextCo = self._selectTalentMo:getNextLevelCo()
	local co = curCo or nextCo

	if co then
		self._txtskillname.text = co.name
		self._txtleveluptxt.text = co.desc

		local btnStr = curCo and "p_sodache_upgradeview_txt_up" or "p_odysseytalenttreeview_txt_LvUpLock"

		self._txtbtn.text = luaLang(btnStr)
	end

	local group = self._selectTalentMo:getGroup()
	local groupMo = V3a9RacingTalentModel.instance:getTalentGroupMoByGroup(self._actId, group)

	if groupMo then
		local groupCo = groupMo:getConfig()

		self._txtskilltype.text = groupCo.name
	end

	local isLock = self._selectTalentMo:isLock()
	local cosList = self._selectTalentMo:getLevelCos()
	local isSpecial = cosList and #cosList > 1

	if isSpecial then
		self._txtnum.text = self._selectTalentMo:getCurLevel()
		self._txtnum2.text = self._selectTalentMo:getMaxLevel()

		local curLevel = self._selectTalentMo:getCurLevel()

		for i, _co in ipairs(cosList) do
			local item = self:_getTalentDetailAttr(i)
			local level = _co.level

			item.txtdesc.text = _co.shortDesc
			item.txtatttxt.text = level

			gohelper.setActive(item.golockbg, curLevel < level)
			gohelper.setActive(item.gounlockbg, level <= curLevel)
		end
	end

	if cosList then
		if not #cosList then
			local count = 0

			for i, item in ipairs(self._detailAttrItems) do
				gohelper.setActive(item.go, i <= count)
			end

			gohelper.setActive(self._golockbg, isSpecial)
			gohelper.setActive(self._gonormalbg, isSpecial and not isLock)
			gohelper.setActive(self._godetailitemlayout, isSpecial)
			gohelper.setActive(self._golevel, isSpecial)
			self:_refreshDetailBtn()
		end
	end
end

function V3a9RacingTalentPanel:_refreshDetailBtn()
	local isCanLevelUp = self._selectTalentMo:isCanLevelUp()
	local islock = self._selectTalentMo:isLock()

	if isCanLevelUp then
		local cost = self._selectTalentMo:getLevelUpCost()

		self._txtcurrency.text = cost

		local currency = V3a9RacingTalentModel.instance:getCurrencyNum(self._actId).quantity or 0
		local isEnough = cost <= currency

		if isEnough then
			if not Color.white then
				self._txtcurrency.color = GameUtil.parseColor("#FF8059")

				gohelper.setActive(self._gobtnlockbg.gameObject, not isEnough)
				gohelper.setActive(self._gobtnnormalbg.gameObject, isEnough)
			end
		end
	end

	gohelper.setActive(self._btnupbtn.gameObject, isCanLevelUp)
	gohelper.setActive(self._golock, islock and not isCanLevelUp)
end

function V3a9RacingTalentPanel:_getTalentDetailAttr(index)
	local item = self._detailAttrItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._godetailitem)
		item.golockbg = gohelper.findChild(item.go, "#go_lockbg")
		item.gounlockbg = gohelper.findChild(item.go, "#go_unlockbg")
		item.gocurrent = gohelper.findChild(item.go, "#go_unlockbg/#go_current")
		item.txtdesc = gohelper.findChildText(item.go, "#txt_desc")
		item.txtattnum = gohelper.findChildText(item.go, "#txt_attnum")
		item.txtatttxt = gohelper.findChildText(item.go, "#txt_atttxt")
		self._detailAttrItems[index] = item
	end

	return item
end

function V3a9RacingTalentPanel:onClose()
	return
end

function V3a9RacingTalentPanel:onDestroyView()
	return
end

return V3a9RacingTalentPanel
