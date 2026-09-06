-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossRankView.lua

module("logic.extensions.worldboss.view.WorldBossRankView", package.seeall)

local WorldBossRankView = class("WorldBossRankView", TableViewComponent)

function WorldBossRankView:ctor()
	WorldBossRankView.super.ctor(self)
end

function WorldBossRankView:buildUI()
	WorldBossRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnClose2 = self:getBtn("btnClose2")
	self._txtMyRankValue = self:getGo("txtMyRank/value"):GetComponent("Text")
end

function WorldBossRankView:bindEvents()
	WorldBossRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnClose2:AddClickListener(self._onClickBtnClose, self)
end

function WorldBossRankView:unbindEvents()
	WorldBossRankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function WorldBossRankView:destroyUI()
	WorldBossRankView.super.destroyUI(self)
end

function WorldBossRankView:onEnter()
	WorldBossRankView.super.onEnter(self)

	self._worldBossRankPrize = WorldBossController.instance:getWorldBossRankPrize()

	local ret = WorldBossController.instance:sendWorldBossRankInfoReq()

	if ret == -1 then
		self:_updateView()
	end
end

function WorldBossRankView:onEnterFinished()
	WorldBossRankView.super.onEnterFinished(self)
end

function WorldBossRankView:onExit()
	WorldBossRankView.super.onExit(self)

	self._curViewDatas = nil
end

function WorldBossRankView:onExitFinished()
	WorldBossRankView.super.onExitFinished(self)
end

function WorldBossRankView:_onClickBtnClose()
	self:close()
end

function WorldBossRankView:_getPath()
	return {
		cellPath = "sv_item",
		viewPath = "sv_info"
	}
end

function WorldBossRankView:_cellSize()
	return 1100, 110
end

function WorldBossRankView:_updateCell(view, cell, data)
	local _imgRankIcon = goutil.findChildComponent(cell.gameObject, "bk/imgRankIcon", "UIImageSpriteChange")
	local _txtRankIcon = goutil.findChildComponent(cell.gameObject, "bk/txtRankIcon", "Text")
	local _rankInThree = data.rank < 4

	_imgRankIcon.gameObject:SetActive(_rankInThree)
	_txtRankIcon.gameObject:SetActive(not _rankInThree)
	_imgRankIcon:SetState(data.rank - 1)

	_txtRankIcon.text = data.rank

	local _imgKingIcon = goutil.findChild(cell.gameObject, "bk/imgKingIcon")

	HeadItemController.instance:setHeadCellByInfo(_imgKingIcon, data.headInfo)

	local _txt_lv = goutil.findChildComponent(cell.gameObject, "bk/txt_lv", "Text")

	_txt_lv.text = data.headInfo.playerLv or 0

	local _txtRankKingValue = goutil.findChildComponent(cell.gameObject, "bk/txtRankKingValue", "Text")

	_txtRankKingValue.text = data.zdl or 0

	local _txtRankKingName = goutil.findChildComponent(cell.gameObject, "bk/txtRankKingName", "Text")

	_txtRankKingName.text = data.headInfo.userName

	local _txtDamageValue = goutil.findChildComponent(cell.gameObject, "bk/txtDamageValue", "Text")

	_txtDamageValue.text = data.value

	local prize = self:_getPrizeByRank(data.rank)
	local _prizeArray = string.split(prize, "#")

	if _prizeArray then
		for i = 1, 4 do
			local _item = goutil.findChild(cell.gameObject, "bk/gridItem/item_" .. i)

			if i <= #_prizeArray then
				_item.gameObject:SetActive(true)
				MaterialMgr.resetAll(_item)

				if _prizeArray[i] ~= nil and _prizeArray[i] ~= "" and _prizeArray[i] ~= "nil" then
					local proxy = MaterialMgr.setCellByCfg(_prizeArray[i], _item)

					Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.7, 0.7, 1)
				end
			else
				_item.gameObject:SetActive(false)
			end
		end
	end
end

function WorldBossRankView:_getPrizeByRank(_rank)
	if not _rank then
		return
	end

	for i, v in ipairs(self._worldBossRankPrize) do
		if _rank >= v.startRank and _rank <= v.endRank then
			return v.prize
		end
	end
end

function WorldBossRankView:_updateView()
	local rankInfo = WorldBossController.instance:getWorldBossRankInfo()

	if not rankInfo then
		return
	end

	self._curViewDatas = {}

	if rankInfo.ranks then
		for i = 1, #rankInfo.ranks do
			local json = require("cjson")
			local rankInfo = json.decode(rankInfo.ranks[i])

			table.insert(self._curViewDatas, rankInfo)
		end

		self._tableview:ReloadData()
	end

	self._txtMyRankValue.text = rankInfo.myRank and rankInfo.myRank > 0 and rankInfo.myRank or lang("world_Boss_tip9")
end

return WorldBossRankView
