-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglipetuseView.lua

module("logic.extensions.mimengli.view.MimenglipetuseView", package.seeall)

local MimenglipetuseView = class("MimenglipetuseView", ViewComponent)

function MimenglipetuseView:ctor()
	MimenglipetuseView.super.ctor(self)
end

function MimenglipetuseView:unbindEvents()
	MimenglipetuseView.super.unbindEvents(self)
end

function MimenglipetuseView:bindEvents()
	MimenglipetuseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOk, self)
end

function MimenglipetuseView:buildUI()
	MimenglipetuseView.super.buildUI(self)

	self._btnOk = self:getGo("btnOk")
	self._btnClose = self:getGo("btnClose")
	self._empty = self:getGo("empty")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._txtTitle = self:getTxt("txtTitle")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)
end

function MimenglipetuseView:onExit()
	MimenglipetuseView.super.onExit(self)
	self._scrollList:dispose()
end

function MimenglipetuseView:onEnter()
	MimenglipetuseView.super.onEnter(self)

	self._data = self:getFirstParam() or {}
	self._activityId = checknumber(self._data.activityId)
	self._selectPetId = -1

	self:_onRefreshUI()

	if self._data.goodsUsedClazz == "DeadPetFullHp" then
		self._txtTitle.text = "精灵复活"
	elseif self._data.goodsUsedClazz == "PetFullHp" then
		self._txtTitle.text = "精灵回复"
	end
end

function MimenglipetuseView:_onRefreshUI()
	self._actCfg = MiMengLiConfig.instance:getActivityCfgById(self._activityId) or {}

	local info = MiMengLiModel.instance:getInfo(self._activityId) or {}

	if not info.clgInfo then
		local clgInfo = {}

		if not clgInfo.selectedPetHpInfo then
			local selectedPetHpInfo = {}

			self._hpMap = {}

			local list = {}

			for i, v in ipairs(selectedPetHpInfo) do
				local petMo = BagPetsController.instance:getPet(v.left)

				if petMo then
					if self._data.goodsUsedClazz == "DeadPetFullHp" then
						if v.right == 0 then
							table.insert(list, petMo)
						end
					elseif self._data.goodsUsedClazz == "PetFullHp" and v.right ~= -1 and v.right < petMo._maxHp and v.right > 0 then
						table.insert(list, petMo)
					end
				end

				self._hpMap[v.left] = v.right
			end

			if self._data.goodsUsedClazz == "PetFullHp" then
				ArraySort.sortOn(list, {
					function(a)
						return checknumber(self._hpMap[a.petId])
					end,
					"petId"
				}, {
					ArraySort.NUMERIC,
					ArraySort.DESCENDING
				})
			end

			self._scrollList:reloadData(list)
			GameUtil.SetActive(self._empty, #list == 0)
		end
	end
end

function MimenglipetuseView:_onClickOk()
	if self._selectPetId == -1 then
		local list = self._scrollList:getData()

		if list == nil or #list == 0 then
			self:close()
		else
			TipsFacade.instance:openCommonTips("请选择一只精灵使用道具")
		end
	else
		local info = MiMengLiModel.instance:getInfo(self._activityId) or {}

		if not info.clgInfo then
			local clgInfo = {}

			self._shopDiscountFromStageId = checknumber(clgInfo.shopDiscountFromStageId)
			self._isDiscount = self._shopDiscountFromStageId > 0 and self._shopDiscountFromStageId < checknumber(clgInfo.curPassStageId)

			local data = self._data
			local fakeItemID = self._actCfg.fakeItemID
			local content = langPara("确认要购买此物品吗吗？\n效果：%s\n\n<color=#eb4642>***购买后立即使用***</color>", data.desc)

			TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, fakeItemID, (self._isDiscount or nil) and data.discountCostScore, content, function()
				MiMengLiController.instance:sendBuyShopGoods(self._activityId, false, data.goodsId, self._selectPetId)
				self:close()
			end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
		end
	end
end

function MimenglipetuseView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local select = goutil.findChild(cell, "select")
	local btn = goutil.findChild(cell, "btn")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	MaterialMgr.setCellByMo(data, con)

	local right = checknumber(self._hpMap[data.petId])
	local percent = 100

	if right == -1 then
		-- block empty
	else
		percent = Mathf.Clamp01(right / data._maxHp) * 100

		if percent > 0 and percent <= 1 then
			percent = 1
		end
	end

	if percent > 0 then
		if not ColorConst.Green2 then
			local colorStr = ColorConst.Red

			txtNum.text = string.format("<color=#%s>%d%%</color>", colorStr, percent)

			GameUtil.SetActive(select, data.petId == self._selectPetId)
			GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickItem, self, data))
		end
	end
end

function MimenglipetuseView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function MimenglipetuseView:_onClickItem(data)
	self._selectPetId = data.petId

	self._scrollList:refresh()
end

return MimenglipetuseView
