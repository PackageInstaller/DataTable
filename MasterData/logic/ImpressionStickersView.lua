-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/impressionstickers/view/ImpressionStickersView.lua

module("logic.extensions.impressionstickers.view.ImpressionStickersView", package.seeall)

local ImpressionStickersView = class("ImpressionStickersView", ViewComponent)

ImpressionStickersView.SORT_UP_MAX_NUM = 5

function ImpressionStickersView:ctor()
	ImpressionStickersView.super.ctor(self)
end

function ImpressionStickersView:unbindEvents()
	ImpressionStickersView.super.unbindEvents(self)
	self._btnSortUp:RemoveClickListener()
	self._btnSortUp2:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnSelectAll:RemoveClickListener()
	self._btnShowInBtl:RemoveClickListener()
	GameUtil.rmClickHandler(self._btn_1)
	GameUtil.rmClickHandler(self._btn_2)
end

function ImpressionStickersView:bindEvents()
	ImpressionStickersView.super.bindEvents(self)
	self._btnSortUp:AddClickListener(self._onClickbtnSortUp, self)
	self._btnSortUp2:AddClickListener(self._onClickBtnSortUp2, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnSelectAll:AddClickListener(self._onClickbtnSelectAll, self)
	self._btnShowInBtl:AddClickListener(self._onClickbtnShowInBtl, self)
	GameUtil.addClickHandler(self._btn_1, GameUtil.handler(self._onClickRefreshInfo, self, 1))
	GameUtil.addClickHandler(self._btn_2, GameUtil.handler(self._onClickRefreshInfo, self, 2))
end

function ImpressionStickersView:buildUI()
	ImpressionStickersView.super.buildUI(self)

	self._txtOwn = self:getTxt("bg/jinglingGo/own/txt")
	self._goEmpty = self:getGo("bg/jinglingGo/goEmpty")
	self._goEmpty2 = self:getGo("bg/diancangGo/goEmpty")
	self._tablecell = self:getGo("bg/tablecell")
	self._tableview = self:getGo("bg/jinglingGo/tableview")
	self._tableview2 = self:getGo("bg/diancangGo/tableview2")
	self._jinglingGo = self:getGo("bg/jinglingGo")
	self._diancangGo = self:getGo("bg/diancangGo")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tablecell2 = self:getGo("bg/diancangGo/tablecell")
	self._scrollList = ScrollerList.create(self._tableview2, self._tablecell2, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	self._showinbtlGo = self:getGo("bg/jinglingGo/topbtns/showinbtl")
	self._gouSelectAllGo = self:getGo("bg/jinglingGo/topbtns/showinbtl/selectall/gou")
	self._btnSortUp = self:getBtn("bg/jinglingGo/topbtns/btnSortUp")
	self._btnTip = self:getBtn("bg/jinglingGo/topbtns/showinbtl/btnTip")
	self._btnSelectAll = self:getBtn("bg/jinglingGo/topbtns/showinbtl/selectall/btnSelectAll")
	self._btnShowInBtl = self:getBtn("bg/jinglingGo/topbtns/btnShowInBtl")
	self._btnSortUpChange = self:getGo("bg/jinglingGo/topbtns/btnSortUp"):GetComponent(ComponentType.UIImageSpriteChange)
	self._btnShowInBtlChange = self:getGo("bg/jinglingGo/topbtns/btnShowInBtl"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtShowIn = self:getTxt("bg/jinglingGo/topbtns/btnShowInBtl/txt")
	self._txtSortUp = self:getTxt("bg/jinglingGo/topbtns/btnSortUp/txt")
	self._topBtnsGo = self:getGo("bg/jinglingGo/topbtns")
	self._btn_1 = self:getGo("bg/fiters/btn_1")
	self._imgSelect1 = self:getGo("bg/fiters/btn_1/imgSelect")
	self._btn_2 = self:getGo("bg/fiters/btn_2")
	self._imgSelect2 = self:getGo("bg/fiters/btn_2/imgSelect")
	self._txtDiancangOwn = self:getTxt("bg/diancangGo/own/txt")
	self._clipGo = self:getGo("bg/diancangGo/tableview2/viewport")
	self._topBtnsGo2 = self:getGo("bg/diancangGo/topbtns")
	self._btnSortUpChange2 = self:getGo("bg/diancangGo/topbtns/btnSortUp"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtSortUp2 = self:getTxt("bg/diancangGo/topbtns/btnSortUp/txt")
	self._btnSortUp2 = self:getBtn("bg/diancangGo/topbtns/btnSortUp")
end

function ImpressionStickersView:onExit()
	ImpressionStickersView.super.onExit(self)
	self._tableList:dispose()
	self._scrollList:dispose()
end

function ImpressionStickersView:onEnter()
	ImpressionStickersView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ImpressionStickersRefresh, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.ImpressionStickersPinRes, self._onPinRes, self)
	self.addGEvent(self, GlobalNotify.UpdateUniquePropSetTop, self._showDiancangView, self)
	self.addGEvent(self, GlobalNotify.GetOtherUniquePropsRes, self._showDiancangView, self)

	self._sortUpId2 = 0
	self._isSortUpFold = true
	self._isShowInFold = true
	self._isSelectAll = false
	self._isSortUpFold2 = true
	self._isShowInFold2 = true
	self._otherUserId = self:getFirstParam()
	self._isShowOtherUser = false
	self._chooseSortUpList = {}

	if checknumber(self._otherUserId) > 0 and checknumber(self._otherUserId) ~= checknumber(RoleModel.instance:getUserId()) then
		self._isShowOtherUser = true
	end

	self:_onClickRefreshInfo(1)
	ImpressionStickersAgent.instance:sendPM_ImpressionStickersInfoReq(self._otherUserId)

	if self._isShowOtherUser then
		BattleStartAnimController.instance:sendPM_GetOtherUniquePropsReq(MatType.ImpressionPoster, self._otherUserId)
	end

	self:_showTopState()
end

function ImpressionStickersView:_onClickRefreshInfo(idx)
	GameUtil.SetActive(self._imgSelect1, false)
	GameUtil.SetActive(self._imgSelect2, false)
	GameUtil.SetActive(self._jinglingGo, false)
	GameUtil.SetActive(self._diancangGo, false)

	if idx == 2 then
		GameUtil.SetActive(self._imgSelect2, true)
		GameUtil.SetActive(self._jinglingGo, true)
		self:_showTopState()
	else
		GameUtil.SetActive(self._imgSelect1, true)
		GameUtil.SetActive(self._diancangGo, true)
		self:_showDiancangView()
	end
end

function ImpressionStickersView:_showDiancangView()
	local cfgList = ImpressionStickersConfig.instance:getPosterStickerCfgs().dataList or {}
	local list = {}

	if self._isShowOtherUser then
		for i, v in ipairs(cfgList) do
			if BattleStartAnimModel.instance:getOtherState(MatType.ImpressionPoster, v.id) ~= BattleStartAnimModel.Lock then
				table.insert(list, v)
			end
		end

		ArraySort.sortOn(list, {
			function(a)
				return BattleStartAnimModel.instance:getOtherSetTopMillis(MatType.ImpressionPoster, a.id)
			end,
			function(a)
				return checknumber(a.id)
			end
		}, {
			ArraySort.DESCENDING,
			ArraySort.NUMERIC
		})
	else
		for i, v in ipairs(cfgList) do
			if BattleStartAnimModel.instance:getState(MatType.ImpressionPoster, v.id) ~= BattleStartAnimModel.Lock then
				table.insert(list, v)
			end
		end

		ArraySort.sortOn(list, {
			function(a)
				return BattleStartAnimModel.instance:getSetTopMillis(MatType.ImpressionPoster, a.id)
			end,
			function(a)
				return checknumber(a.id)
			end
		}, {
			ArraySort.DESCENDING,
			ArraySort.NUMERIC
		})
	end

	self._scrollList:reloadData(list)

	self._txtDiancangOwn.text = #list

	GameUtil.SetActive(self._goEmpty2, #list == 0)
end

function ImpressionStickersView:_updateItemCell(view, cell, data, tag)
	local imgSticker = goutil.findChild(cell, "imgSticker")
	local txtDesc = goutil.findChildTextComponent(cell, "imgSticker/txtDesc")
	local selectGo = goutil.findChild(cell, "select")
	local gouGo = goutil.findChild(cell, "select/gou")
	local eff = goutil.findChild(cell, "imgSticker/eff")

	GameUtil.SetActive(selectGo, false)
	GameUtil.setAnchoredPos(imgSticker, 0, 0)

	local stickCfg = ImpressionStickersConfig.instance:getPosterSticker(data.id)
	local pathName = GameUrl.getImpressionStickersIconUrl(stickCfg.res)

	txtDesc.text = stickCfg.defaultDesc

	uGuiUtil.setSpriteToImage(imgSticker, uGuiUtil.LoaderType_BigBg, pathName)

	local effPath = "yinxiangtie/" .. stickCfg.animRes .. ".prefab"

	self:stopViewEffectUniGo(eff)

	local e = self:playViewEffectUniGo(effPath, eff, self._clipGo, true)

	if e then
		e.hideEffWhileNotOnTop = false
	end

	local btnSelect = Framework.ButtonAdapter.GetFrom(cell.gameObject, "select")
	local isShowSelect = not self._isSortUpFold2
	local posx = isShowSelect and -26 or 0

	Framework.TransformUtil.SetAnchoredPos(imgSticker.transform, posx, 0)
	goutil.setActive(btnSelect.gameObject, isShowSelect)

	if not self._isShowInFold2 then
		-- block empty
	elseif not self._isSortUpFold2 then
		goutil.setActive(gouGo, self._sortUpId2 == data.id)
	end

	btnSelect:AddClickListener(function()
		if not self._isSortUpFold2 then
			self._sortUpId2 = self._sortUpId2 == data.id and 0 or data.id
		end

		self._scrollList:refresh()
	end)
end

function ImpressionStickersView:_clearItemCell(cell)
	local imgSticker = goutil.findChild(cell, "imgSticker")

	uGuiUtil.clearImage(imgSticker)

	local eff = goutil.findChild(cell, "imgSticker/eff")

	self:stopViewEffectUniGo(eff)
end

function ImpressionStickersView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgSticker = goutil.findChild(go, "imgSticker")
	local txtDesc = goutil.findChildTextComponent(go, "imgSticker/txtDesc")
	local selectGo = goutil.findChild(go, "select")
	local gouGo = goutil.findChild(go, "select/gou")
	local txtNum = goutil.findChildTextComponent(go, "select/txtNum")
	local btnSelect = Framework.ButtonAdapter.GetFrom(go, "select")
	local stickCfg = ImpressionStickersConfig.instance:getSticker(data.id)
	local pathName = GameUrl.getImpressionStickersIconUrl(stickCfg.res)
	local petCfg = CharacterConfig.instance:getPetCo(stickCfg.raceId)

	txtDesc.text = data.rank <= 0 and stickCfg.defaultDesc or langPara("全服第%d只%s", data.rank, petCfg.name)

	local isShowSelect = not self._isShowInFold or not self._isSortUpFold
	local posx = isShowSelect and -26 or 0
	local curIdx = table.indexof(self._chooseSortUpList, data.id)

	txtNum.text = checknumber(curIdx)

	Framework.TransformUtil.SetAnchoredPos(imgSticker.transform, posx, 0)
	uGuiUtil.setSpriteToImage(imgSticker, nil, pathName)
	goutil.setActive(btnSelect.gameObject, isShowSelect)
	GameUtil.SetActive(gouGo, false)
	GameUtil.SetActive(txtNum.gameObject, curIdx and not self._isSortUpFold)

	if not self._isShowInFold then
		goutil.setActive(gouGo, self._showInMap[stickCfg.id] ~= false)
	elseif not self._isSortUpFold then
		-- block empty
	end

	btnSelect:AddClickListener(function()
		if not self._isShowInFold then
			self._showInMap[stickCfg.id] = not self._showInMap[stickCfg.id]

			self:_checkShowAll()
			self:_showTopState()
		elseif not self._isSortUpFold then
			if #self._chooseSortUpList < ImpressionStickersView.SORT_UP_MAX_NUM then
				local idx = table.indexof(self._chooseSortUpList, data.id)

				if idx then
					table.remove(self._chooseSortUpList, idx)
				else
					table.insert(self._chooseSortUpList, data.id)
				end
			else
				FloatWordMgr.instance:show(string.format(lang("已达上限%s个，请先取消置顶其他印象贴后再次选择"), ImpressionStickersView.SORT_UP_MAX_NUM))
			end
		end

		self._tableList:refresh()
	end)
end

function ImpressionStickersView:_clearCell(cell)
	local go = cell.gameObject
	local imgSticker = goutil.findChild(go, "imgSticker")

	uGuiUtil.clearImage(imgSticker)
end

function ImpressionStickersView:_refreshView()
	local list = ImpressionStickersModel.instance:getStickers()
	local newList = {}

	for i, v in ipairs(list) do
		table.insert(newList, v)
	end

	ArraySort.sortOn(newList, {
		function(a)
			return checknumber(a.setTopMillis)
		end,
		function(a)
			return checknumber(a.id)
		end
	}, {
		ArraySort.DESCENDING,
		ArraySort.NUMERIC
	})

	self._txtOwn.text = #newList

	self._tableList:reloadData(newList)
	GameUtil.SetActive(self._goEmpty, #newList <= 0)
end

function ImpressionStickersView:_onClickbtnSortUp()
	if not self._isSortUpFold then
		if #self._chooseSortUpList == 0 then
			FloatWordMgr.instance:show(lang("印象贴排序无变化"))
		else
			self:_saveSortUp()
		end
	end

	self._isSortUpFold = not self._isSortUpFold
	self._isShowInFold = true

	self:_showTopState()
	self._tableList:refresh()
end

function ImpressionStickersView:_onClickBtnSortUp2()
	if not self._isSortUpFold2 then
		self:_saveSortUp2()
	end

	self._isSortUpFold2 = not self._isSortUpFold2
	self._isShowInFold2 = true

	self:_showTopState()
	self._scrollList:refresh()
end

function ImpressionStickersView:_onClickbtnTip()
	CommonTipsMgr.instance:showTips("选中的印象贴将在战斗中显示", self._btnTip.gameObject)
end

function ImpressionStickersView:_onClickbtnSelectAll()
	local stickers = ImpressionStickersModel.instance:getStickers()

	for i, v in ipairs(stickers) do
		self._showInMap[v.id] = not self._isSelectAll
	end

	self._isSelectAll = not self._isSelectAll

	self:_showTopState()
	self._tableList:refresh()
end

function ImpressionStickersView:_onClickbtnShowInBtl()
	if self._isShowInFold then
		self._showInMap = ImpressionStickersModel.instance:copyShowInMap()

		self:_checkShowAll()
	else
		self:_saveShowIn()
	end

	goutil.setActive(self._showinbtlGo, not self._isShowInFold)

	self._isShowInFold = not self._isShowInFold
	self._isSortUpFold = true

	self:_showTopState()
	self._tableList:refresh()
end

function ImpressionStickersView:_checkShowAll()
	self._isSelectAll = true

	local stickers = ImpressionStickersModel.instance:getStickers()

	for i, v in ipairs(stickers) do
		if self._showInMap[v.id] == false then
			self._isSelectAll = false

			break
		end
	end
end

function ImpressionStickersView:_saveSortUp()
	ImpressionStickersAgent.instance:sendPM_ImpressionStickersPinReq(self._chooseSortUpList, true)
end

function ImpressionStickersView:_saveSortUp2()
	UniquePropAgent.instance:sendPM_UniquePropsSetTopReq(MatType.ImpressionPoster, self._sortUpId2, true)
end

function ImpressionStickersView:_saveShowIn()
	ImpressionStickersModel.instance:saveShowInMap(self._showInMap)
end

function ImpressionStickersView:_showTopState()
	local isOther = checknumber(self._otherUserId) > 0

	goutil.setActive(self._topBtnsGo, not isOther)
	goutil.setActive(self._topBtnsGo2, not isOther)

	if isOther then
		GameUtil.setHeight(self._tableview, 457)
		GameUtil.setHeight(self._tableview2, 457)
	else
		GameUtil.setHeight(self._tableview, 407)
		GameUtil.setHeight(self._tableview2, 407)
	end

	self._btnSortUpChange:SetState(self._isSortUpFold and 0 or 1)
	self._btnShowInBtlChange:SetState(self._isShowInFold and 0 or 1)
	goutil.setActive(self._showinbtlGo, not self._isShowInFold)
	goutil.setActive(self._gouSelectAllGo, self._isSelectAll)

	self._txtShowIn.text = self._isShowInFold and "战斗显示" or "<color=#692E0A>完成</color>"
	self._txtSortUp.text = self._isSortUpFold and "置顶" or "<color=#692E0A>完成</color>"
	self._txtSortUp2.text = self._isSortUpFold2 and "置顶" or "<color=#692E0A>完成</color>"

	self._scrollList:refresh()
end

function ImpressionStickersView:_onPinRes()
	self._chooseSortUpList = {}

	self:_refreshView()
end

return ImpressionStickersView
