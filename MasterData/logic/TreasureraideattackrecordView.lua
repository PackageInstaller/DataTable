-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideattackrecordView.lua

module("logic.extensions.treasureraider.view.TreasureraideattackrecordView", package.seeall)

local TreasureraideattackrecordView = class("TreasureraideattackrecordView", ViewComponent)
local Tabs = {
	{
		index = 1,
		name = "入侵记录",
		serverType = 1
	},
	{
		index = 2,
		name = "被入侵记录",
		serverType = 2
	}
}

function TreasureraideattackrecordView:ctor()
	TreasureraideattackrecordView.super.ctor(self)
end

function TreasureraideattackrecordView:unbindEvents()
	TreasureraideattackrecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TreasureraideattackrecordView:bindEvents()
	TreasureraideattackrecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TreasureraideattackrecordView:buildUI()
	TreasureraideattackrecordView.super.buildUI(self)

	self._nodataGo = self:getGo("nodata")
	self._btnClose = self:getGo("Btn_close")
	self._tabCell = self:getGo("tabCell")
	self._tabTableView = self:getGo("tabTableView")
	self._recordCell = self:getGo("Cell")
	self._recordTableView = self:getGo("Scrl")
	self._rewardGo = self:getGo("reward")

	GameUtil.SetActive(self._buildingCell, false)
	GameUtil.SetActive(self._tabCell, false)
	GameUtil.SetActive(self._rewardGo, false)

	self._tabList = ScrollerList.create(self._tabTableView, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._recordList = ScrollerList.create(self._recordTableView, self._recordCell, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))
	self._cellToPrizeList = {}
end

function TreasureraideattackrecordView:onExit()
	TreasureraideattackrecordView.super.onExit(self)
	TreasureRaiderController.instance:unregisterLocalNotify(TreasureRaiderController.RecordAfterGetInfo, self._onRecordUpdated, self)
	self._tabList:dispose()
	self._recordList:dispose()

	self._recordMap = {}
end

function TreasureraideattackrecordView:onEnter()
	TreasureraideattackrecordView.super.onEnter(self)
	TreasureRaiderController.instance:registerLocalNotify(TreasureRaiderController.RecordAfterGetInfo, self._onRecordUpdated, self)

	self._activityId = checknumber(self:getFirstParam())
	self._recordMap = {}

	local myPlayerMo = TreasureRaiderModel.instance.myPlayerMo

	if myPlayerMo then
		myPlayerMo:setDefendNewNum(0)
	end

	self:_onSelectTab(Tabs[1])
end

function TreasureraideattackrecordView:_onSelectTab(data)
	self._curTabData = data

	RichManAgent.instance:sendPM_RichManGetRecordReq(self._activityId, data.serverType)
	self._tabList:reloadData(Tabs)
	self._tabList:refresh()
	self:_refreshRecord()
end

function TreasureraideattackrecordView:_onRecordUpdated(params)
	local recordType = params.type

	self._recordMap[recordType] = params

	if self._curTabData.serverType == recordType then
		self:_refreshRecord()
	end
end

function TreasureraideattackrecordView:_refreshRecord()
	if not self._recordMap[self._curTabData.serverType] then
		if not self._recordMap[self._curTabData.serverType].records then
			local array = {}

			self._recordList:reloadData(array)
			self._recordList:refresh()
			GameUtil.SetActive(self._nodataGo, #array == 0)
		end
	end
end

function TreasureraideattackrecordView:_updateTabCell(view, cell, data, tag)
	local txt1 = goutil.findChildTextComponent(cell, "txt")
	local txt2 = goutil.findChildTextComponent(cell, "selected/txt")
	local selected = goutil.findChild(cell, "selected")
	local redPointGo = goutil.findChild(cell, "dot")

	txt1.text = data.name
	txt2.text = data.name

	GameUtil.SetActive(selected, self._curTabData.index == data.index)

	if data.serverType == 2 then
		local myPlayerMo = TreasureRaiderModel.instance.myPlayerMo

		GameUtil.SetActive(redPointGo, ((myPlayerMo or nil) and myPlayerMo:getDefendNewNum()) > 0)
	else
		GameUtil.SetActive(redPointGo, false)
	end

	GameUtil.addClickHandler(cell.gameObject, function()
		self:_onSelectTab(data)
	end)
end

function TreasureraideattackrecordView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function TreasureraideattackrecordView:_updateRecordCell(view, cell, data, tag)
	local leftGo = goutil.findChild(cell, "Head_Left")
	local rightGo = goutil.findChild(cell, "Head_Right")
	local txtBuilding = goutil.findChildTextComponent(cell, "txtBuilding")
	local rewardView = goutil.findChild(cell, "rewardView")
	local btnRevenge = goutil.findChild(cell, "btnRevenge")
	local txtRewardEmpty = goutil.findChild(cell, "txtRewardEmpty")
	local list = ScrollerList.create(rewardView, self._rewardGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

	self._cellToPrizeList[cell] = list

	local prizes = {}

	if not string.nilorempty(data.item) then
		prizes = string.split(data.item, "#")
	end

	list:reloadData(prizes)
	list:refresh()

	if self._curTabData.index == 1 then
		self:_updatePlayerInfo(leftGo, data.mySide)
		self:_updatePlayerInfo(rightGo, data.targetSide)

		txtBuilding.text = langPara("资源建筑：Lv.%s", data.buildLevel)
	else
		self:_updatePlayerInfo(leftGo, data.targetSide)
		self:_updatePlayerInfo(rightGo, data.mySide)

		txtBuilding.text = langPara("资源建筑：Lv.%s", data.buildLevel)
	end

	GameUtil.SetActive(txtRewardEmpty, #prizes <= 0)
	GameUtil.SetActive(btnRevenge, self._curTabData.index == 2 and #prizes > 0)
	GameUtil.setUIImageSpriteIdx(goutil.findChild(cell, "Img_Tag"), data.win and 0 or 1)
	GameUtil.addClickHandler(btnRevenge, function()
		local myPlayerMo = TreasureRaiderModel.instance.myPlayerMo
		local remainRevengeCount = myPlayerMo:getRevengeCountRemain()

		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("本次复仇将消耗1次复仇次数，今日剩余复仇次数为：%s次", remainRevengeCount), function()
			if remainRevengeCount <= 0 then
				FloatWordMgr.instance:show(lang("复仇次数不足"))
			else
				self:_checkActionDone(data)
			end
		end)
	end)
end

function TreasureraideattackrecordView:_checkActionDone(data)
	local sceneMo = TreasureRaiderModel.instance:getCurSceneMo()

	if sceneMo:isCanDoActionIgnoreViewBuilding() then
		TipsFacade.instance:openPopupWindow(lang("tip"), lang("还有未操作的建筑，是否放弃操作并继续?"), function()
			self:close()
			TreasureRaiderController.instance:reqRevenge(self._activityId, data.targetSide.headInfo.userId)
		end)
	else
		self:close()
		TreasureRaiderController.instance:reqRevenge(self._activityId, data.targetSide.headInfo.userId)
	end
end

function TreasureraideattackrecordView:_updatePlayerInfo(container, info)
	local txtName = goutil.findChildTextComponent(container, "Txt_Name")
	local headGo = goutil.findChild(container, "Img_Head")
	local txtDetail = goutil.findChildTextComponent(container, "Txt_Detail")
	local txtZdl = goutil.findChildTextComponent(container, "Txt_Zdl")

	txtName.text = info.headInfo.userName
	txtDetail.text = langPara("大本营：Lv.%d", info.campLevel)
	txtZdl.text = langPara("战力：%d", info.ZDL)

	local proxy = HeadItemController.instance:setHeadCellByInfo(headGo, info.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(info.headInfo.userId, headGo)
		end)
	end
end

function TreasureraideattackrecordView:_clearRecordCell(cell)
	local btnRevenge = goutil.findChild(cell, "btnRevenge")

	HeadItemController.instance:resetHeadCell(goutil.findChild(cell, "Head_Left/Img_Head"))
	HeadItemController.instance:resetHeadCell(goutil.findChild(cell, "Head_Right/Img_Head"))

	if self._cellToPrizeList[cell] then
		self._cellToPrizeList[cell]:dispose()

		self._cellToPrizeList[cell] = nil
	end

	GameUtil.rmClickHandler(btnRevenge)
end

function TreasureraideattackrecordView:_clearCellToPrizeList()
	for _, v in pairs(self._cellToPrizeList) do
		v:dispose()
	end

	self._cellToPrizeList = {}
end

function TreasureraideattackrecordView:_updateRewardCell(view, goCell, data)
	MaterialMgr.resetAll(goCell)

	local proxy = MaterialMgr.setCellByCfg(data, goCell.gameObject)

	if proxy then
		local _, _, num = MaterialMgr.getMatParams(data or "")

		proxy:setNumStr(StringUtil.numberToString(num or 0))
	end
end

function TreasureraideattackrecordView:_clearRewardCell(goCell)
	MaterialMgr.resetAll(goCell)
end

return TreasureraideattackrecordView
