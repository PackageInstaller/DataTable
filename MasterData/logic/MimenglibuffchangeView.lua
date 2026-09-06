-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglibuffchangeView.lua

module("logic.extensions.mimengli.view.MimenglibuffchangeView", package.seeall)

local MimenglibuffchangeView = class("MimenglibuffchangeView", ViewComponent)

function MimenglibuffchangeView:ctor()
	MimenglibuffchangeView.super.ctor(self)
end

function MimenglibuffchangeView:unbindEvents()
	MimenglibuffchangeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnOk)

	for i, v in ipairs(self._topList) do
		local btn = goutil.findChild(v, "btn")

		GameUtil.rmClickHandler(btn)
	end

	for i, v in ipairs(self._downList) do
		local btn = goutil.findChild(v, "btn")

		GameUtil.rmClickHandler(btn)
	end
end

function MimenglibuffchangeView:bindEvents()
	MimenglibuffchangeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOK, self)

	for i, v in ipairs(self._topList) do
		local btn = goutil.findChild(v, "btn")

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickTopBtn, self, i))
	end

	for i, v in ipairs(self._downList) do
		local btn = goutil.findChild(v, "btn")

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickDownBtn, self, i))
	end
end

function MimenglibuffchangeView:buildUI()
	MimenglibuffchangeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnOk = self:getGo("btnOk")
	self._topList = {}
	self._downList = {}

	for i = 1, 4 do
		local topBuff = self:getGo("top/buff_" .. i)
		local downBuff = self:getGo("down/buff_" .. i)

		table.insert(self._topList, topBuff)
		table.insert(self._downList, downBuff)
	end
end

function MimenglibuffchangeView:onExit()
	MimenglibuffchangeView.super.onExit(self)
end

function MimenglibuffchangeView:onEnter()
	MimenglibuffchangeView.super.onEnter(self)

	self._data = self:getFirstParam() or {}
	self._activityId = checknumber(self._data.activityId)
	self._selectTopIdx = -1
	self._selectDownIdx = -1

	self:_onRefreshUI()
end

function MimenglibuffchangeView:_onRefreshUI()
	local info = MiMengLiModel.instance:getInfo(self._activityId) or {}

	if not info.clgInfo then
		local clgInfo = {}

		if not clgInfo.tagNumInfo then
			local tagNumInfo = {}

			self._buffMap = {}

			for i, v in ipairs(tagNumInfo) do
				self._buffMap[v.left] = v.right
			end

			self._shortNameMap = {}

			local list = MiMengLiConfig.instance:getBuffTagCfgList(self._activityId) or {}

			for i, v in ipairs(list) do
				self._shortNameMap[v.tagType] = v.shortName
			end

			self:_refreshTop()
			self:_refreshDown()
		end
	end
end

function MimenglibuffchangeView:_refreshTop()
	for i, v in ipairs(self._topList) do
		local select = goutil.findChild(v, "select")
		local txt = goutil.findChildTextComponent(v, "txt")
		local txtName = goutil.findChildTextComponent(v, "btn/txt")

		GameUtil.SetActive(select, self._selectTopIdx == i)

		txtName.text = self._shortNameMap[i]

		local num = checknumber(self._buffMap[i])
		local cfg = MiMengLiConfig.instance:getCloseBuffCfgById(self._activityId, i, num) or {}

		txt.text = langPara("%s/%s", num, checknumber(cfg.tagNum))
	end
end

function MimenglibuffchangeView:_refreshDown()
	for i, v in ipairs(self._downList) do
		local select = goutil.findChild(v, "select")
		local txtName = goutil.findChildTextComponent(v, "btn/txt")

		GameUtil.SetActive(select, self._selectDownIdx == i)

		txtName.text = self._shortNameMap[i]
	end
end

function MimenglibuffchangeView:_onClickOK()
	if self._selectTopIdx ~= self._selectDownIdx and self._selectTopIdx > 0 and self._selectDownIdx > 0 then
		local info = MiMengLiModel.instance:getInfo(self._activityId) or {}

		if not info.clgInfo then
			local clgInfo = {}

			self._shopDiscountFromStageId = checknumber(clgInfo.shopDiscountFromStageId)
			self._isDiscount = self._shopDiscountFromStageId > 0 and self._shopDiscountFromStageId < checknumber(clgInfo.curPassStageId)

			local data = self._data
			local cost = data.costScore

			if self._isDiscount then
				cost = data.discountCostScore
			end

			local actCfg = MiMengLiConfig.instance:getActivityCfgById(self._activityId) or {}
			local fakeItemID = checknumber(actCfg.fakeItemID)
			local cfgTop = MiMengLiConfig.instance:getBuffTagCfgById(self._activityId, self._selectTopIdx)
			local cfgDown = MiMengLiConfig.instance:getBuffTagCfgById(self._activityId, self._selectDownIdx)
			local content = langPara("是否确认将%s更改为%s吗", cfgTop.name, cfgDown.name)

			TipsFacade.instance:openPopupCostMatViewNew(MatType.Item_Fake, fakeItemID, cost, content, function()
				local pb = CommonStructDef_pb.PM_PairInt()

				pb.left = self._selectTopIdx
				pb.right = self._selectDownIdx

				MiMengLiController.instance:sendBuyShopGoods(self._activityId, false, data.goodsId, nil, pb)
				self:close()
			end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
		end
	else
		TipsFacade.instance:openCommonTips("请选择印记使用道具")
	end
end

function MimenglibuffchangeView:_onClickTopBtn(idx)
	local num = checknumber(self._buffMap[idx])

	if num > 0 then
		self._selectTopIdx = idx

		self:_refreshTop()

		if self._selectTopIdx == self._selectDownIdx then
			self._selectDownIdx = -1

			self:_refreshDown()
		end
	else
		TipsFacade.instance:openCommonTips("请选择一个已有的印记")
	end
end

function MimenglibuffchangeView:_onClickDownBtn(idx)
	local num = checknumber(self._buffMap[idx])

	if self._selectTopIdx > 0 then
		if self._selectTopIdx ~= idx then
			self._selectDownIdx = idx

			self:_refreshDown()
		else
			TipsFacade.instance:openCommonTips("不能选择相同印记替换")
		end
	else
		TipsFacade.instance:openCommonTips("请先选择一个已有的印记")
	end
end

return MimenglibuffchangeView
