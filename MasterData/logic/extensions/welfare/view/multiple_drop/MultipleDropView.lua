-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/multiple_drop/MultipleDropView.lua

module("logic.extensions.welfare.view.multiple_drop.MultipleDropView", package.seeall)

local M = class("MultipleDropView", DynamicFragmentView)

function M:buildUI()
	self._leftTimeTxt = self._registry:getText("replica_rewards_panel_1115975598")
	self._rewardMore = self._registry:getGo("replica_rewards_panel_1349388026")
	self._rewwardOne = self._registry:getGo("replica_rewards_panel_-1652675284")
	self._icon1 = self._registry:getImage("replica_rewards_panel_-501369628")
	self._icon2 = self._registry:getImage("replica_rewards_panel_-606310510")
	self._icon3 = self._registry:getImage("replica_rewards_panel_-274242992")
	self._icon4 = self._registry:getImage("replica_rewards_panel_-1608238593")
	self._times = self._registry:getText("replica_rewards_panel_1408009534")
	self._describeTxt = self._registry:getText("replica_rewards_panel_-1769388707")
	self._explainTxt = self._registry:getText("replica_rewards_panel_946103315")
	self._txtDec = self._registry:getText("replica_rewards_panel_760637068")
	self._btnGo = self._registry:getBtn("0&btn_middle_-31477526")
	self._scrollRect = self._registry:getGo("replica_rewards_panel_1994054194")
	self._loopContentList = self._registry:getGo("replica_rewards_panel_1141192975")
	self._prefab = self._registry:getGo("replica_rewards_panel_-594844761")

	goutil.setActive(self._prefab.gameObject, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnGo:AddClickListener(self._onClickGo, self)
end

function M:unbindEvents()
	self._btnGo:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	WelfareUtil.playWelfareViewAnim(self.mainGO, "open")

	self._dungeonList = MultipleDropController.instance:getShowList()

	if #self._dungeonList == 0 then
		self._leftTimeTxt.text = lang("tip_left_time") .. " 0"
		self._explainTxt.text = lang("tip_multipleDrop_over")

		goutil.setActive(self._txtDec.gameObject, false)
		goutil.setActive(self._btnGo.gameObject, false)
		goutil.setActive(self._rewardMore.gameObject, false)
		goutil.setActive(self._rewwardOne.gameObject, false)
		goutil.setActive(self._scrollRect.gameObject, false)
		goutil.setActive(self._describeTxt.gameObject, false)
		goutil.setActive(self._times.gameObject, false)
	else
		goutil.setActive(self._describeTxt.gameObject, true)
		goutil.setActive(self._times.gameObject, true)
		goutil.setActive(self._scrollRect.gameObject, true)

		self._defaultSelect = 1
		self._currentSelect = 0

		self:_onInitList()
	end
end

function M:onExit()
	self:setEvent(false)
	WelfareUtil.playWelfareViewAnim(self.mainGO, "close")
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onInitList()
	self:_clearList()
	self:_setList()
end

function M:_clearList()
	local childCount = self._loopContentList.transform.childCount

	if childCount > 1 then
		for i = 1, childCount - 1 do
			goutil.destroy(self._loopContentList.transform:GetChild(i).gameObject, true)
		end
	end
end

function M:_setList()
	self._cellList = {}

	for k, v in ipairs(self._dungeonList) do
		local obj = goutil.cloneAndSetParent(self._prefab, self._loopContentList.transform)

		obj:SetActive(true)

		local objBeh = Astral.LuaComponentContainer.Add(obj, MultipleDropItemCell)
		local data = v
		local table = {
			data = v,
			index = k
		}

		objBeh:updateMultipleDate(table)
		objBeh:setHandler(self)

		local select = self._defaultSelect

		if k == select then
			self:refreshPanel(objBeh)
		end

		objBeh:setSelect(k == select)

		self._cellList[k] = objBeh
	end
end

function M:setSelectList()
	for k, v in ipairs(self._cellList) do
		v:setSelect(k == self._currentSelect)
	end
end

function M:refreshPanel(moItem)
	if moItem and self._currentSelect == moItem:getIndex() then
		return
	end

	if moItem then
		self._currentSelect = moItem:getIndex()

		self:setSelectList()

		self._leftTimeTxt.text = moItem:getLeftTime()

		local iconList = moItem:getIconLst()

		if iconList and #iconList ~= 4 or not iconList then
			goutil.setActive(self._rewardMore.gameObject, false)
			goutil.setActive(self._rewwardOne.gameObject, true)
		else
			goutil.setActive(self._rewardMore.gameObject, true)
			goutil.setActive(self._rewwardOne.gameObject, false)
			IconLoader.setSprite(self._icon1, IconType.ItemIcon, iconList[1])
			IconLoader.setSprite(self._icon2, IconType.ItemIcon, iconList[2])
			IconLoader.setSprite(self._icon3, IconType.ItemIcon, iconList[3])
			IconLoader.setSprite(self._icon4, IconType.ItemIcon, iconList[4])
		end

		self._times.text = moItem:getTimes()
		self._describeTxt.text = moItem:getDescribeTxt()
		self._explainTxt.text = moItem:getExplain()

		if moItem:getIsOpen() then
			if moItem:isLimitTime() then
				if moItem:getLeftNumber() > 0 then
					goutil.setActive(self._btnGo.gameObject, true)
					goutil.setActive(self._txtDec.gameObject, false)
				else
					goutil.setActive(self._txtDec.gameObject, true)
					goutil.setActive(self._btnGo.gameObject, false)

					self._txtDec.text = lang("tip_multipleDrop_left_not")
				end
			else
				goutil.setActive(self._btnGo.gameObject, true)
				goutil.setActive(self._txtDec.gameObject, false)
			end
		else
			goutil.setActive(self._txtDec.gameObject, true)
			goutil.setActive(self._btnGo.gameObject, false)

			self._txtDec.text = lang("tip_multipleDrop_lock")
		end
	end

	self._currentMo = moItem
end

function M:_onClickGo()
	local txtBtn = goutil.findChildTextComponent(self._btnGo.gameObject, "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")

	if self._currentMo then
		local jumpId = self._currentMo:getJumpId()

		if not SystemJumpController.instance:canJump(jumpId, true) then
			return
		end

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
	else
		print("AAAAAAAAAA当前数据不存在")
	end
end

return M
